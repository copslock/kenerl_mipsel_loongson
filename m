Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 22:13:16 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:51697 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039006AbXBMWNL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 22:13:11 +0000
Received: (qmail 6404 invoked by uid 101); 13 Feb 2007 22:11:21 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 13 Feb 2007 22:11:21 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1DMBKWp027771;
	Tue, 13 Feb 2007 14:11:20 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7YAJL>; Tue, 13 Feb 2007 14:11:20 -0800
Message-ID: <45D23785.6060502@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date:	Tue, 13 Feb 2007 14:11:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 13 Feb 2007 22:11:18.0467 (UTC) FILETIME=[E2BA0930:01C74FBB]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> On Mon, 12 Feb 2007 12:04:08 -0600 Marc St-Jean 
> <stjeanma@pmc-sierra.com> wrote:
> 
>  > There are three different fixes:
>  > 1. Fix for DesignWare THRE errata
>  > - Dropped our fix since the "8250-uart-backup-timer.patch" in the "mm"
>  > tree also fixes it. This patch needs to be applied on top of "mm" patch.
>  >
>  > 2. Fix for Busy Detect on LCR write
>  > - No changes since last patch.
>  >
>  > 3. Workaround for interrupt/data concurrency issue
>  > - No changes since last patch.
> 
> A couple of things.
> 
> - When preparing a changelog, please just tell us what the patch does.
>   The information about how this patch differes from a previous version of
>   the patch is irrelevant when the patch hits the mainline repository hence
>   I must edit it all.
> 
>   It's OK to add the what-i-changed-since-last-time details, but please 
> make
>   that separate and remember that it will be removed for when the patch 
> goes
>   upstream.
> 
> - When fixing a bug, please tell us in detail what that bug *is*.  None
>   of the above three items tell us any of this, which is essential
>   information for those who are to review the change.

Understood, I'm adding the original description here and I'll add to the
next patch update.

1. Fix for DesignWare APB THRE errata:
In brief, this is a non-standard 16550 in that the THRE interrupt
will not re-assert itself simply by disabling and re-enabling the
THRI bit in the IER, it is only re-enabled if a character is actually
sent out.
It appears that the "8250-uart-backup-timer.patch" in the "mm" tree also
fixes it so we have dropped our initial workaround.
This patch now needs to be applied on top of that "mm" patch.

2. Fix for Busy Detect on LCR write:
The DesignWare APB UART has a feature which causes a new Busy Detect
interrupt to be generated if it's busy when the LCR is written. This
fix saves the value of the LCR and rewrites it after clearing the
interrupt.

3. Workaround for interrupt/data concurrency issue:
The SoC needs to ensure that writes that can cause interrupts to be
cleared reach the UART before returning from the ISR. This fix reads
a non-destructive register on the UART so the read transaction
completion ensures the previously queued write transaction has
also completed.


>  > 
>  > +     case UPIO_DWAPB:
>  > +             /* Save the LCR value so it can be re-written when a
>  > +              * Busy Detect interrupt occurs. */
>  > +             if (save_offset == UART_LCR)
>  > +                     up->lcr = value;
>  > +             writeb(value, up->port.membase + offset);
>  > +             /* Read the IER to ensure any interrupt is cleared before
>  > +              * returning from ISR. */
>  > +             if ((save_offset == UART_TX || save_offset == UART_IER) 
> && in_irq())
> 
> The in_irq() is a worry.  If the serial driver is used as the system
> console, then it can be called from _any_ interrupt handler.  eg a printk()
> in the sata code.
> 
> What happens then?

The in_irq() is there to improve performance. The logic being that
writing to registers outside the interrupt context will not require
the fix for issue 3.
There should be no issues if called from other interrupt context
as the read is non-destructive. I can remove the call to in_irq() if
you prefer.


>  > @@ -1383,6 +1399,19 @@ static irqreturn_t serial8250_interrupt(
>  >                       handled = 1;
>  > 
>  >                       end = NULL;
>  > +             } else if (up->port.iotype == UPIO_DWAPB &&
>  > +                       (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
>  > +                     /* The DesignWare APB UART has an Busy Detect 
> (0x07)
>  > +                      * interrupt meaning an LCR write attempt 
> occured while the
>  > +                      * UART was busy. The interrupt must be cleared 
> by reading
>  > +                      * the UART status register (USR) and the LCR 
> re-written. */
>  > +                     unsigned int status;
>  > +                     status = *(volatile u32 *)up->port.private_data;
> 
> Are you sure this is right?  The use of volatile is generally discouraged
> and is a sign that something is wrong.  What is the driver attempting to
> read here?  Should it be using readl()?

The driver is reading the UART's USR (UART Status Register) which is
a non-standard register at a non-fixed offset, hence the need for
private_data. This was discussed in detail in the patch thread and the
goal was to avoid using platform specific #ifdefs as part of the fix

The register is accessed in kseg1 (unmapped on the mips architecture) so
readl is not needed. The register definitions in this space are all marked
volatile but since it's now accessed through private_data, the read had
to be made explicitly volatile.


> Also, the newly-added private_data field is not being initialised to
> anything anywhere in this patch.

private_data is initialized in the platform specific initialization code
which will be submitted to the l-m.o That patch contains only code which
lives in arch/mips and include/asm-mips so I was not planning on
submitting to the main kernel list. This level of procedural detail is
not in the maillist FAQ, I'm assuming that is normal procedure?

Marc
