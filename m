Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 14:11:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59887 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006868AbaHZMLacqSKP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Aug 2014 14:11:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7QCBTBg024743;
        Tue, 26 Aug 2014 14:11:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7QCBTM8024742;
        Tue, 26 Aug 2014 14:11:29 +0200
Date:   Tue, 26 Aug 2014 14:11:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
Message-ID: <20140826121129.GC24146@linux-mips.org>
References: <53FC5300.4070902@gentoo.org>
 <20140826102004.GA22221@linux-mips.org>
 <alpine.LFD.2.11.1408261126000.18483@eddie.linux-mips.org>
 <20140826114925.GA24146@linux-mips.org>
 <53FC7790.80602@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53FC7790.80602@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42258
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

On Tue, Aug 26, 2014 at 08:03:28AM -0400, Joshua Kinard wrote:

> Yeah, coherency shouldn't be a problem for the Octane.  hardware-coherent
> like IP27.
> 
> The icache snooping fix is already enabled in
> arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h:
> 
> #define cpu_icache_snoops_remote_store 1
> 
> SMP is not working yet on IP30, though.  I gave up on that for now, because
> I can't get the second CPU to start ticking properly.

Are you running a preemptible kernel?

You could also change the definition of cpu_icache_snoops_remote_store to 0
for testing.  That should make things just a bit slower but otherwise have
not impact.  Would be interesting to see if that makes the SIGs go away.

  Ralf
