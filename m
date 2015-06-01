Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 22:17:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47156 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026889AbbFAUQ60yfD4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jun 2015 22:16:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t51KGsei004176;
        Mon, 1 Jun 2015 22:16:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t51KGsp1004175;
        Mon, 1 Jun 2015 22:16:54 +0200
Date:   Mon, 1 Jun 2015 22:16:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in
 cpu_set_fpu_fcsr_mask()
Message-ID: <20150601201653.GC29986@linux-mips.org>
References: <556943D9.7020502@gentoo.org>
 <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org>
 <556BCA01.1070208@gentoo.org>
 <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jun 01, 2015 at 12:27:52PM +0100, Maciej W. Rozycki wrote:

> > >  Can you please try this diagnostic patch and report the value of FCSR 
> > > printed ("FCSR is:"), and also tell me if the exception has now gone too?  
> > > 
> > >  I'll submit the final fix, properly annotated, if your testing confirms 
> > > my diagnosis.
> > 
> > That got it to boot again.  I added CPU ID to the printk as well, and got some
> > odd output from one of the CPUs:
> > 
> > # dmesg | grep FCSR
> > [    0.000000] CPU0: FCSR is: 00000000
> > [    0.319158] CPU1: FCSR is: 00000000
> > [    0.364971] CPU2: FCSR is: ffffffffa8000000
> > [    0.404854] CPU3: FCSR is: 00000000
> 
>  The value reported for CPU2 merely shows FCC[7,5,3] bits set, nothing 
> really odd about that, the CPU may well have come out of reset like this.  
> Neither of the values reported though actually corresponds to the symptom 
> you saw, can you double-check you didn't make a typo in your modification 
> to `printk'?

Maciej, I don't see why the code is so careful about not trampeling
over any bits that may be set on bootup.  I think we should rather fully
initialize all the exception bits to zero to have the FPU in a known good
state.

  Ralf
