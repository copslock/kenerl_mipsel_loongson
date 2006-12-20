Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 14:43:15 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:2954 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S28583249AbWLTOnL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 14:43:11 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id kBKEiCl9001962;
	Wed, 20 Dec 2006 06:44:12 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id kBKEgwR8027093;
	Wed, 20 Dec 2006 06:42:59 -0800 (PST)
Message-ID: <056f01c72446$31687b30$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Daniel Laird" <danieljlaird@hotmail.com>
Cc:	<linux-mips@linux-mips.org>, "Vitaly Wool" <vwool@ru.mvista.com>
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <20061220.000113.59033093.anemo@mba.ocn.ne.jp> <7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp> <7987092.post@talk.nabble.com> <458944B9.1050204@ru.mvista.com>
Subject: Re: 2.6.19 timer API changes
Date:	Wed, 20 Dec 2006 15:50:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > The 32-bit register is both readable and writable through the MTC0 and MFC0
> > instructions as CP0 register 9. Upon reset, the Count register is set to 0.
> > Count and Compare together make up Timer_1 in the PR4450 (see Section 3.12).
> > The timer is active by default. When active, Count register contains a free
> > running counter; on each processor clock-tick, the value in the register increments
> > by one. However, when bit ST1 bit[3] in the CP0 Configuration register is enabled,
> > the timer is stopped. When the ST1 bit is disabled, the timer returns to its default
> > state. Timer_1 is active when the PR4450 is in Sleep mode, but is switched off when
> > the PR4450 is in Coma mode.
> > When active, the register can be reset with the assertion of the TerminalCount
> > (TC_1) signal, which is asserted when the values in the Count and Compare
> > registers match. After the Count register is reset, it restarts its count on the next
> > processor clock-tick.
> > In the PR4450, the TC_1 signal is fed to the external hardware interrupt
> > signal to invoke an interrupt handler e.g., the timer interrupt. The TC_1 signal can
> > only be reset to 0 when the interrupt handler performs a write to the Compare
> > register.
> > Consecutive writes to Count will result in undefined contents. At least one
> > instruction must be inserted between consecutive writes to Count.
> 
> > This seems to suggest that writing to the compare register does in fact
> > clear count.
> 
>     It actually doesn't suggest anything alike.  All it says is that "the 
> register *can* be reset with the assertion of the Terminal Count (TC_1) signal 
> which is asserted when the values in the Count and Compare registers match".
> Whtat it doesn't say is what determines if it's really reset by TC_1 assertion 
> or not.

In all fairness, the spec can be read to state that the assertion of TC_1 clears
the Count register.  Or rather that it "can" - there seems to be some assumed
mode of behavior that's not otherwise described.  I wonder if they're not 
talking about behavior specifc to "Coma mode", which was perhaps what
they are referring to when they begin the next sentence with "When active".
I can see how someone might think it advantageous to have a mode where
the Count register auto-resets on a timer tick, so that there's no need to
recalcuate Compare values.  But I've never seen that implemented on a
MIPS processor. Free-running Count registers have other uses that can
be shared with the timer interrupts, so long as it's Compare and not Count
that gets reprogrammed on an interrupt. I have a hard time believing that
the 8550 has the auto-reset as default behavior.

> > If I do the following:
> > static void __init c0_hpt_timer_init(void)
> > {
> > #ifdef CONFIG_SOC_PNX8550 /* pnx8550 resets to zero */
> >     expirelo = cycles_per_jiffy;
> > #else
> >     expirelo = read_c0_count() + cycles_per_jiffy;
> > #endif
> >     write_c0_compare(expirelo);
> >     write_c0_count(cycles_per_jiffy); //Added DJL
> > }

First of all, I think the conditional code is broken, even if you
believe that Count is reset to zero on every interrupt.  This is
the *init* code, that's getting called once at boot time to set
up the clock.  It's not a clock interrupt handler.

It is highly likely that the Count register has already gone
beyond the value of cycles_per_jiffy by the time this code
gets hit.  If that's true, programming Compare to zero+delta
means waiting for the counter to wrap around before the first
interrupt is delivered - a 10-second-ish hang.  Writing the same
value to Count that you just wrote to Compare will, on many
cores, cause a Count=Compare state and a prompt interrupt.

But the real fix is almost certainly to get rid of the conditional.

            Regards,

            Kevin K.
