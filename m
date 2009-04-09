Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 21:02:04 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:25991 "EHLO ciao.gmane.org")
	by ftp.linux-mips.org with ESMTP id S20023053AbZDIUB5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 21:01:57 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ls0Re-0001Jh-H5
	for linux-mips@linux-mips.org; Thu, 09 Apr 2009 20:01:54 +0000
Received: from gate-ca119.motorola.com ([144.189.100.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 09 Apr 2009 20:01:54 +0000
Received: from dave+gmane by gate-ca119.motorola.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 09 Apr 2009 20:01:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	David Wuertele <dave+gmane@wuertele.com>
Subject:  Re: What is the right way to setup MIPS timer irq in 2.6.29?
Date:	Thu, 9 Apr 2009 20:01:43 +0000 (UTC)
Message-ID:  <loom.20090409T195344-317@post.gmane.org>
References:  <loom.20090408T165537-312@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 144.189.100.25 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.8) Gecko/2009032608 Firefox/3.0.8)
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave+gmane@wuertele.com
Precedence: bulk
X-list: linux-mips

I wrote:

> Has the system timer paradigm changed between 2.6.18 and 2.6.29?
> I'm trying to update my Broadcom-based embedded system to 2.6.29,
> and I'm running into problems getting the system timer to run.

I solved my problem, though I'm still a little unclear about the reasoning.

The solution was to enable these:
CONFIG_CEVT_R4K=y
CONFIG_CSRC_R4K=y

I also had to define get_c0_compare_int() to return the system timer
interrupt.  Once I had done these things, start_kernel() calls time_init(),
which calls mips_clockevent_init() and init_mips_clocksource().
init_mips_clocksource() calls the init_r4k_clocksource() that was
enabled with the new config options.  Now my system clock runs like I think it
should.

I think I might not need the CEVT components... I'm going to look into that
next.  But I wish there was some easy to find documentation about why this
code had to be moved into the arch/mips/cevt-*.c and arch/mips/csrc-*.c
libraries.

Dave
