export class EmailService {
  async sendEmail(to: string, subject: string, body: string): Promise<void> {
    console.log('Sending email:', { to, subject, body });
    // Email sending implementation will go here
  }
} 