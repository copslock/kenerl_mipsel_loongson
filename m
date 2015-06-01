Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 13:27:55 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006879AbbFAL1wgkKH4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 13:27:52 +0200
Date:   Mon, 1 Jun 2015 12:27:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in
 cpu_set_fpu_fcsr_mask()
In-Reply-To: <556BCA01.1070208@gentoo.org>
Message-ID: <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org>
References: <556943D9.7020502@gentoo.org> <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org> <556BCA01.1070208@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 31 May 2015, Joshua Kinard wrote:

> >  Can you please try this diagnostic patch and report the value of FCSR 
> > printed ("FCSR is:"), and also tell me if the exception has now gone too?  
> > 
> >  I'll submit the final fix, properly annotated, if your testing confirms 
> > my diagnosis.
> 
> That got it to boot again.  I added CPU ID to the printk as well, and got some
> odd output from one of the CPUs:
> 
> # dmesg | grep FCSR
> [    0.000000] CPU0: FCSR is: 00000000
> [    0.319158] CPU1: FCSR is: 00000000
> [    0.364971] CPU2: FCSR is: ffffffffa8000000
> [    0.404854] CPU3: FCSR is: 00000000

 The value reported for CPU2 merely shows FCC[7,5,3] bits set, nothing 
really odd about that, the CPU may well have come out of reset like this.  
Neither of the values reported though actually corresponds to the symptom 
you saw, can you double-check you didn't make a typo in your modification 
to `printk'?

 Thanks,

  Maciej
