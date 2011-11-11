Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 17:57:53 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:48405 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903984Ab1KKQ5r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 17:57:47 +0100
Received: by yenl9 with SMTP id l9so4021634yen.36
        for <multiple recipients>; Fri, 11 Nov 2011 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GpHGqlMLrl+/OiXmzaEdQUYNHWO4L4aAh0/XZ21LZsE=;
        b=RjxlnSBAbFy6PWpEcZDv4YI9D2xtC1bB88QOIg2G5ZjeDNmvldpu0h6LMq5sEUbC+f
         ovFwnggFJsLyyaWOyVGAchgm+WEkgHtx555pkChDu23v12WLHtUQf+5cLWJJY9eCzkKY
         afAPIXWYrkGSAV6KurS5mia3MibUPPhlVoAF8=
MIME-Version: 1.0
Received: by 10.68.42.227 with SMTP id r3mr7911545pbl.70.1321030660803; Fri,
 11 Nov 2011 08:57:40 -0800 (PST)
Received: by 10.68.62.169 with HTTP; Fri, 11 Nov 2011 08:57:39 -0800 (PST)
In-Reply-To: <20111111125832.GE28303@linux-mips.org>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
        <f130d5d9c038f61fa3176b971526cd5f@localhost>
        <20111111125832.GE28303@linux-mips.org>
Date:   Fri, 11 Nov 2011 08:57:39 -0800
Message-ID: <CAJiQ=7B=BkptJ9YGkEKpA9uXU1ydaGZeQTUrEd=E0Y_QR8_Z1g@mail.gmail.com>
Subject: Re: [PATCH V2 3/8] MIPS: BMIPS: Add CFLAGS, Makefile entries for BMIPS
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10454

On Fri, Nov 11, 2011 at 4:58 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> If BMIPS is just a MIPS32 with no relevant extensions to the instruction
> set, why don't you just call it a MIPS32 processor and use something
> like CPU_MIPS32_R2?
>
> It's small things like that which can sometimes avoid many unnecessary
> recompilations which really saves times when rebuilding all defconfigs
> on a way to slow machine :)

At a high level, the CONFIG_CPU_BMIPS* settings are used to make
compile-time decisions that differentiate BMIPS from standard MIPS32,
and that differentiate the BMIPS CPUs from one another.


Present and future uses include:

Figuring out which set of proprietary BMIPS CP0 registers / core
registers to use, where they are located, bit fields, etc.

Per-BMIPS SMP operations and capabilities

Per-BMIPS performance counter access

cpu-feature-overrides.h

HIGHMEM, SMP, and other basic features

eDSP instruction set (different on each BMIPS, and BMIPS-specific)

Cache architecture and BMIPS-specific cache optimizations


Some of these could potentially be replaced with a "switch
(current_cpu_type())" but others are a little trickier (i.e. they show
up in low-level PM resume code, exception vectors, or other sensitive
places).


It is true that BMIPS uses -mips32 for compilation.  If the criteria
for adding a new CONFIG_CPU_* choice is whether it selects a new
instruction set or compilation flags, do you think it makes sense to
remove BMIPS* from the "CPU selection" menu, enable
CONFIG_CPU_MIPS32_R1 for BMIPS platforms, and call our options
something different?  e.g.

CONFIG_BMIPS
CONFIG_BMIPS3300
CONFIG_BMIPS4350
CONFIG_BMIPS4380
CONFIG_BMIPS5000
