Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 02:59:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52981 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8226016AbUD0B7g>;
	Tue, 27 Apr 2004 02:59:36 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3R1xWx6028466;
	Mon, 26 Apr 2004 18:59:32 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3R1xWHN028464;
	Mon, 26 Apr 2004 18:59:32 -0700
Date: Mon, 26 Apr 2004 18:59:32 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org,
	high-res-timers-discourse@lists.sourceforge.net
Cc: jsun@mvista.com
Subject: [EXPERIMENTAL] 2.6 high resolution timer (HRT) support for MIPS
Message-ID: <20040426185932.L19558@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


This set of patches add high resolution posix timer support.  
You need to apply patches in the following order:

http://linux.junsun.net/patches/oss.sgi.com/experimental/040419.a-cpu-timer.patch
http://linux.junsun.net/patches/oss.sgi.com/experimental/040420.a-cpu-timer-for-smp.patch
http://linux.junsun.net/patches/oss.sgi.com/experimental/040426.a-hrtimers-2.6.5-1.0.patch
http://linux.junsun.net/patches/oss.sgi.com/experimental/040426.b-mips-hrt-2.6.patch

These patches are tested on NEC Rockhopper boards and Broadcom
bcm1250 boards (in SMP mode) against linux-mips.org CVS tree
around April 20, 2004 (kernel 2.6.5).

If you want HRT working on other boards, you need

        a) make sure the board is uing cpu timer as system timer
        b) enable CONFIG_CPU_TIMER for the board

Jun
