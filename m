Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2011 15:11:35 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:44935 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903702Ab1KLOL3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2011 15:11:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id DB9403650CD;
        Sat, 12 Nov 2011 15:11:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iYMXcTsdH4hv; Sat, 12 Nov 2011 15:11:28 +0100 (CET)
Received: from lenovo.localnet (fbx.mimichou.net [82.247.4.1])
        by zmc.proxad.net (Postfix) with ESMTPSA id 2D8E3358033;
        Sat, 12 Nov 2011 15:11:28 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2 3/8] MIPS: BMIPS: Add CFLAGS, Makefile entries for BMIPS
Date:   Sat, 12 Nov 2011 15:11:19 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-rc7-amd64; KDE/4.6.5; x86_64; ; )
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
References: <5f9666eb295ce196b2a9688afab07dea@localhost> <CAJiQ=7B=BkptJ9YGkEKpA9uXU1ydaGZeQTUrEd=E0Y_QR8_Z1g@mail.gmail.com> <20111111172039.GA5200@linux-mips.org>
In-Reply-To: <20111111172039.GA5200@linux-mips.org>
Organization: Freebox
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201111121511.21175.ffainelli@freebox.fr>
X-archive-position: 31588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10878

Le vendredi 11 novembre 2011 18:20:39, Ralf Baechle a écrit :
> On Fri, Nov 11, 2011 at 08:57:39AM -0800, Kevin Cernekee wrote:
> > At a high level, the CONFIG_CPU_BMIPS* settings are used to make
> > compile-time decisions that differentiate BMIPS from standard MIPS32,
> > and that differentiate the BMIPS CPUs from one another.
> > 
> > 
> > Present and future uses include:
> > 
> > Figuring out which set of proprietary BMIPS CP0 registers / core
> > registers to use, where they are located, bit fields, etc.
> > 
> > Per-BMIPS SMP operations and capabilities
> > 
> > Per-BMIPS performance counter access
> > 
> > cpu-feature-overrides.h
> > 
> > HIGHMEM, SMP, and other basic features
> > 
> > eDSP instruction set (different on each BMIPS, and BMIPS-specific)
> > 
> > Cache architecture and BMIPS-specific cache optimizations
> > 
> > 
> > Some of these could potentially be replaced with a "switch
> > (current_cpu_type())" but others are a little trickier (i.e. they show
> > up in low-level PM resume code, exception vectors, or other sensitive
> > places).
> > 
> > 
> > It is true that BMIPS uses -mips32 for compilation.  If the criteria
> > for adding a new CONFIG_CPU_* choice is whether it selects a new
> > instruction set or compilation flags, do you think it makes sense to
> > remove BMIPS* from the "CPU selection" menu, enable
> > CONFIG_CPU_MIPS32_R1 for BMIPS platforms, and call our options
> > something different?  e.g.
> > 
> > CONFIG_BMIPS
> > CONFIG_BMIPS3300
> > CONFIG_BMIPS4350
> > CONFIG_BMIPS4380
> > CONFIG_BMIPS5000
> 
> Fair enough; sorting that kind of thing will need some effort across
> the tree at some point in the future.
> 
> I notice there seems to be only CPU core support; are you planning
> to submit board support code as well?

BCM63xx and BCM47xx use BMIPS CPUs and can already take advantage of this core 
CPU support code. 
-- 
Florian
