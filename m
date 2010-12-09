Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2010 18:07:54 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40910 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491814Ab0LIRHv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Dec 2010 18:07:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB9H7oV2017266;
        Thu, 9 Dec 2010 17:07:50 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB9H7nkY017264;
        Thu, 9 Dec 2010 17:07:49 GMT
Date:   Thu, 9 Dec 2010 17:07:48 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips@linux-mips.org,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: SMTC support status in latest git head.
Message-ID: <20101209170748.GC30923@linux-mips.org>
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 08, 2010 at 05:48:48AM -0800, Anoop P.A. wrote:

> Any body is aware of SMTC support status in latest git sources?. I have tried testing SMTC kernel for malta in qemu / OVP without any success ( emulators not working for 34k). 

Correct.  MTI's MIPSsim is the only simulator that supports multithreading
afaik.

SMTC is not terribly popular so doesn't receive the regular testing it should
because it's also a complex beast.

> I am trying to bring up SMTC Linux support for an mips34K based soc ( MSP71xx family).
> 
> While booting , kernel getting hung on calibrate loop delay. I am getting only one interrupt from timer. With similar smtc platform support file (  changed to map smp_ops structure)  2.6.24-stable branch kernel ( where latest timer structure introduced) boots fine. 

Timer interrupts work differently in SMTC.  Each CPU needs a clock event
device, that is an interrupt timer but the CPU core is restricted to just
one per VPE so in typical SMTC setup multiple CPUs aka TCs will have to
share an interrupt timer.  The way this works is that one of the TCs
associated with a VPE will take the timer interrupt and forward it to
the other TCs associated with the same VPE (if any) through a software
IPI mechanism.  The race conditions that need to handled to make this
work are ...  interesting.  Your problem seems to be simpler as you only
get a single timer interrupt.

  Ralf
