Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2011 15:31:35 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:49830 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903702Ab1KLOb2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2011 15:31:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 57E41339A96;
        Sat, 12 Nov 2011 15:31:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b0bLzRxs5JgV; Sat, 12 Nov 2011 15:31:28 +0100 (CET)
Received: from lenovo.localnet (fbx.mimichou.net [82.247.4.1])
        by zmc.proxad.net (Postfix) with ESMTPSA id 156AC339A05;
        Sat, 12 Nov 2011 15:31:28 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
To:     Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 8/8] MIPS: BMIPS: Add SMP support code for BMIPS43xx/BMIPS5000
Date:   Sat, 12 Nov 2011 15:31:31 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-rc7-amd64; KDE/4.6.5; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <5f9666eb295ce196b2a9688afab07dea@localhost> <3989f772f7fef3b4937ab01fd3af192e@localhost>
In-Reply-To: <3989f772f7fef3b4937ab01fd3af192e@localhost>
Organization: Freebox
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201111121531.31483.ffainelli@freebox.fr>
X-archive-position: 31589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10888

Hello Kevin,

Le vendredi 11 novembre 2011 07:30:31, Kevin Cernekee a écrit :
> Initial commit of BMIPS SMP support code.  Smoke-tested on a variety of
> BMIPS4350, BMIPS4380, and BMIPS5000 platforms.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
> 
> V2:
> 
> Move XKS01 option into this patch.
> 
> Remove dependency on local_flush_tlb_all_mm(), per the discussion
> earlier this week.
> 
> Allow platform-configurable variables to be accessed in !CONFIG_SMP
> mode, so the platform code does not need unnecessary #ifdefs.
> 
> Remove the code that clears the FPU registers.
> 
> Fix the jump to the NMI vector.
> 
> Add bmips_cpu_offset.

I have two questions regarding this patchset:

- considering that BMIPS4350 has a shared TLB, is it still working fine? I must 
say that I have not yet tested on e.g: BCM6358

- there a couple of places in the code where we have:

#if defined (CONFIG_BMIPS_4350) || defined (CONFIG_BMIPS_4380)
 ... do something
#elif defined(CONFIG_BMIPS_4380)

can we turn this into a #if BMIPS43xx case .. #endif  #if BMIPS5000 ... #endif 
to allow a single image supporting both BMIPS43xx and BMIPS5000?

By the time we are initializing the CPUs for SMP, we should be able to use 
runtime checks on the BMIPS CPU variant.

Thanks.
-- 
Florian
