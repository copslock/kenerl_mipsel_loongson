Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 13:27:53 +0100 (BST)
Received: from p508B67B0.dip.t-dialin.net ([IPv6:::ffff:80.139.103.176]:47047
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225272AbTFLM1v>; Thu, 12 Jun 2003 13:27:51 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5CCRobY011317;
	Thu, 12 Jun 2003 05:27:50 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5CCRo76011316;
	Thu, 12 Jun 2003 14:27:50 +0200
Date: Thu, 12 Jun 2003 14:27:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Trevor Woerner <mips081@vtnet.ca>
Cc: linux-mips@linux-mips.org
Subject: Re: 64-bit sysinfo
Message-ID: <20030612122750.GB14965@linux-mips.org>
References: <200306120659.26501.mips081@vtnet.ca> <20030612113520.GA8390@linux-mips.org> <200306120807.59346.mips081@vtnet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306120807.59346.mips081@vtnet.ca>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2003 at 08:07:59AM -0400, Trevor Woerner wrote:

> Thanks for your (and everyone's suggestions) I'll have a look at this 
> today. I put a printk in kernel/proc.c:sys_sysinfo() so that's the one 
> being called. I also put another printk in 
> arch/mips64/mm/init.c:si_meminfo() (??? i think...) and it was being 
> called from 'sys_info()'. I don't remember seeing sys32_sysinfo() but 
> I'll look again.

sys32_sysinfo calls sys_sysinfo.  So if you see a direct call to
sys_sysinfo this might proof something is using the wrong syscall.
Strace is your friend ...  Oh, and verify that your kernel has Andrew's
patch from my previous mail applied.

  Ralf
