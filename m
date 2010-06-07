Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jun 2010 15:27:13 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36027 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492432Ab0FGN1H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Jun 2010 15:27:07 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o57DR3Ut017708;
        Mon, 7 Jun 2010 14:27:04 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o57DR15D017706;
        Mon, 7 Jun 2010 14:27:01 +0100
Date:   Mon, 7 Jun 2010 14:27:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     linux-mips@linux-mips.org, kernelnewbies@nl.linux.org
Subject: Re: info needed for check_bugs
Message-ID: <20100607132701.GC728@linux-mips.org>
References: <AANLkTimKPVhpBzKehbm9MAzYJ4rewsQ1kSRrw8Bw8B7i@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimKPVhpBzKehbm9MAzYJ4rewsQ1kSRrw8Bw8B7i@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4762

On Mon, Jun 07, 2010 at 06:22:47PM +0530, naveen yadav wrote:

> I am porting 2.6.30.9 to MIPS target. The target boot well, but when
> it reaches to check_bugs() function.
> static inline void check_bugs(void)
> {
> 	unsigned int cpu ;
> 	cpu = smp_processor_id();
> 	cpu_data[cpu].udelay_val = loops_per_jiffy;
> 	check_bugs32();
> #ifdef CONFIG_64BIT
> 	check_bugs64();
> #endif
> }
> 
> the debug outupt print to screen become very slow. kernel boots but it
> print one char in 1 min.
> 
> When i change above function as
> 
> static inline void check_bugs(void)
> {
> 	unsigned int cpu ;
> 	cpu = smp_processor_id();
> 	//cpu_data[cpu].udelay_val = loops_per_jiffy;
> 	check_bugs32();
> #ifdef CONFIG_64BIT
> 	check_bugs64();
> #endif
> }
> 
> it works fine. Is there any side effect with this. ?

I suggest to check that the value of cpu_data[cpu].udelay_va and of
loops_per_jiffy make sense.  It would appear that loops_per_jiffy is zero
on your system which would cause __delay() to loop 2^32 times.  If that
is the case, checkout the timer interrupt's frequency and the BogoMIPS
calibration.

You may also want to verify that your platform actually needs mdelay(),
udelay() or ndelay().  These calls should be considered a kludge for
broken hardware and avoided if possible.

  Ralf
