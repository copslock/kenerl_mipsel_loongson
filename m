Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 13:08:04 +0100 (BST)
Received: from H42.C233.tor.velocet.net ([IPv6:::ffff:216.138.233.42]:59811
	"EHLO copper.vtnet.vjbtlw") by linux-mips.org with ESMTP
	id <S8225240AbTFLMIC>; Thu, 12 Jun 2003 13:08:02 +0100
Received: from silicon.vtint.vjbtlw (silicon.vtint.vjbtlw [192.168.141.14])
	by copper.vtnet.vjbtlw (Postfix) with ESMTP
	id 895D639AFE; Thu, 12 Jun 2003 08:07:59 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <mips081@vtnet.ca>
Reply-To: mips081@vtnet.ca
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 64-bit sysinfo
Date: Thu, 12 Jun 2003 08:07:59 -0400
User-Agent: KMail/1.4.3
Cc: linux-mips@linux-mips.org
References: <200306120659.26501.mips081@vtnet.ca> <20030612113520.GA8390@linux-mips.org>
In-Reply-To: <20030612113520.GA8390@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306120807.59346.mips081@vtnet.ca>
Return-Path: <mips081@vtnet.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips081@vtnet.ca
Precedence: bulk
X-list: linux-mips

On June 12, 2003 07:35 am, Ralf Baechle wrote:
> The kernel has a wrapper for 32-bit code (see sys32_sysinfo) and that
> one seems to look correct to me.
>
> Can you check that your program is actually using the right syscall,
> that is syscall number 4116?  If it's using 5097 it's using the
> native 64-bit syscall which obviously would explain your observation.

Thanks for your (and everyone's suggestions) I'll have a look at this 
today. I put a printk in kernel/proc.c:sys_sysinfo() so that's the one 
being called. I also put another printk in 
arch/mips64/mm/init.c:si_meminfo() (??? i think...) and it was being 
called from 'sys_info()'. I don't remember seeing sys32_sysinfo() but 
I'll look again.

	Trevor
