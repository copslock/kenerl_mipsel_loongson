Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CNVUX24514
	for linux-mips-outgoing; Thu, 12 Jul 2001 16:31:30 -0700
Received: from dea.waldorf-gmbh.de (u-43-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.43])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CNVNV24494
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 16:31:23 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6CNUsA24937;
	Fri, 13 Jul 2001 01:30:54 +0200
Date: Fri, 13 Jul 2001 01:30:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Moving from old-irq.c
Message-ID: <20010713013054.A24695@bacchus.dhis.org>
References: <54045BFDAD47D5118A850002A5095CC30AC548@exchange1.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC548@exchange1.cam.pace.co.uk>; from Phil.Thompson@pace.co.uk on Wed, Jul 11, 2001 at 01:16:56PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 11, 2001 at 01:16:56PM +0100, Phil Thompson wrote:

> Is there any documentation around that describes how to move from interrupt
> code based on old-irq.c to the new code? Or any other hints or suggestions.

First disable CONFIG_ROTTEN_IRQ if you were using that and enable
CONFIG_NEW_IRQ.  You'll probably have to hack arch/mips/config.in to do
that.

Next you have to rewrite your systems irq code.  You'll have to provide
an init_IRQ() function to initialize the interrupt system.  As the
absolute minimum it'll have to do something like:

        set_except_vector(0, myasmirqhandler);
        init_generic_irq();

and initialize the entries for all interrupts used by your system in the
irq_desc array like:

        for (i = 0; i < NUM_MY_INTS; i++) {

                irq_desc[i].status      = IRQ_DISABLED;
                irq_desc[i].action      = 0;
                irq_desc[i].depth       = 1;
                irq_desc[i].handler     = handler;
        }

where handler is a pointer to struct like this one:

static struct hw_interrupt_type ip22_my_irq_type = {
        "My interrupt controller",
        startup_my_irq,
        shutdown_my_irq,
        enable_my_irq,
        disable_my_irq,
        mask_and_ack_my_irq,
        end_my_irq,
        NULL
};

All that's left now is to write the function references in above struct
initialization:

static void enable_my_irq(unsigned int irq)
{
	/* enable the interrupt in the controller  */
}

static unsigned int startup_my_irq(unsigned int irq)
{
        enable_my_irq(irq);

        return 0;               /* Never anything pending  */
}

static void disable_my_irq(unsigned int irq)
{
	/* Disable function in the interrupt controller  */
}

static void shutdown_my_irq(unsigned int irq)
{
	/*
	 * Disable interrupt in the interrupt controller.  Often this function
	 * is identical to disable_my_irq.
	 */
}

static void mask_and_ack_my_irq(unsigned int irq)
{
	/*
	 * Mask and acknowledge interrupt.  Often this function is identical
	 * to disable_my_irq.  Exception is for example the i8259 PICs.
	 */
}

static void end_my_irq (unsigned int irq)
{
        if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
                enable_my_irq(irq);
}

Take a look at arch/mips/sgi/indy_int.c but there are more examples.

The plan is to nuke old-irq.c early in 2.5; at the same time also something
like arch/{i386,mips}/kernel/irq.c will become kernel/irq.c.

  Ralf
