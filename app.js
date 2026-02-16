// Initialize Supabase client
const supabase = window.supabase.createClient(
    window.DIVINE_CONFIG.SUPABASE_URL,
    window.DIVINE_CONFIG.SUPABASE_ANON_KEY
);

// Form submission handler
document.getElementById('applicationForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    
    const submitButton = this.querySelector('.submit-button');
    submitButton.disabled = true;
    submitButton.textContent = 'Submitting...';
    
    try {
        // Collect form data
        const formData = new FormData(this);
        
        // Get selected tasks (checkboxes)
        const tasks = [];
        document.querySelectorAll('input[name="tasks"]:checked').forEach(checkbox => {
            tasks.push(checkbox.value);
        });
        
        // Prepare data for Supabase
        const applicationData = {
            full_name: formData.get('fullName'),
            email: formData.get('email'),
            phone: formData.get('phone'),
            company_name: formData.get('companyName') || null,
            website: formData.get('website') || null,
            industry: formData.get('industry'),
            company_size: formData.get('companySize'),
            revenue: formData.get('revenue'),
            challenge: formData.get('challenge'),
            tasks: tasks,
            hear_about: formData.get('hearAbout'),
            budget: formData.get('budget'),
            status: 'new',
            notes: null
        };
        
        // Insert into Supabase
        const { data, error } = await supabase
            .from('divine_teams_applications')
            .insert([applicationData])
            .select();
        
        if (error) {
            throw error;
        }
        
        // Success! Show modal and prepare WhatsApp redirect
        const name = formData.get('fullName');
        const industry = formData.get('industry');
        const whatsappMessage = encodeURIComponent(`Hi! I just applied for Divine AI Teams. My name is ${name} and I'm in ${industry}.`);
        const whatsappLink = `https://wa.me/${window.DIVINE_CONFIG.WHATSAPP_NUMBER}?text=${whatsappMessage}`;
        
        // Show success modal
        const modal = document.getElementById('successModal');
        const whatsappLinkElement = document.getElementById('whatsappLink');
        whatsappLinkElement.href = whatsappLink;
        modal.classList.add('active');
        
        // Countdown and auto-redirect
        let countdown = 5;
        const countdownElement = document.getElementById('countdown');
        
        const timer = setInterval(() => {
            countdown--;
            countdownElement.textContent = countdown;
            
            if (countdown <= 0) {
                clearInterval(timer);
                window.location.href = whatsappLink;
            }
        }, 1000);
        
        // Reset form
        this.reset();
        
    } catch (error) {
        console.error('Error submitting application:', error);
        alert('There was an error submitting your application. Please try again or contact us directly via WhatsApp.');
        submitButton.disabled = false;
        submitButton.textContent = 'Submit Application';
    }
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Close modal on click outside
document.getElementById('successModal').addEventListener('click', function(e) {
    if (e.target === this) {
        this.classList.remove('active');
    }
});
