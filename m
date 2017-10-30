Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 23:11:14 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:53041 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992215AbdJ3WLFWazZK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Oct 2017 23:11:05 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 30 Oct 2017 22:10:50 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Mon, 30 Oct 2017 15:10:23 -0700
Date:   Mon, 30 Oct 2017 15:11:12 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-kernel@vger.kernel.org>, <trivial@kernel.org>,
        <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Deng-Cheng Zhu <dengcheng.zhu@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [PATCH v3] Update MIPS email addresses
Message-ID: <20171030221112.zpp5rdb5ln7se4n6@pburton-laptop>
References: <20171026000433.26116-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20171026000433.26116-1-paul.burton@mips.com>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1509401450-637139-14744-287958-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186434
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hello all,

On Wed, Oct 25, 2017 at 05:04:33PM -0700, Paul Burton wrote:
> MIPS will soon not be a part of Imagination Technologies, and as such
> many @imgtec.com email addresses will no longer be valid.

The affected email addresses now only have one week of life left. Can
someone/anyone please merge or review this?

Thanks,
    Paul

> This patch updates the addresses for those who:
> 
>  - Have 10 or more patches in mainline authored using an @imgtec.com
>    email address, or any patches dated within the past year.
> 
>  - Are still with Imagination but leaving as part of the MIPS business
>    unit, as determined from an internal email address list.
> 
>  - Haven't already updated their email address (ie. JamesH) or expressed
>    a desire to be excluded (ie. Maciej).
> 
>  - Acked v2 or earlier of this patch, which leaves Deng-Cheng, Matt &
>    myself.
> 
> New addresses are of the form firstname.lastname@mips.com, and all
> verified against an internal email address list. An entry is added to
> .mailmap for each person such that get_maintainer.pl will report the new
> addresses rather than @imgtec.com addresses which will soon be dead.
> 
> Instances of the affected addresses throughout the tree are then
> mechanically replaced with the new @mips.com address.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> Cc: Deng-Cheng Zhu <dengcheng.zhu@mips.com>
> Acked-by: Dengcheng Zhu <dengcheng.zhu@mips.com>
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Acked-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: trivial@kernel.org
> ---
> Please could this go in ASAP? The affected email addresses now have less
> than 2 weeks of life remaining. I've dropped entries for all those who
> haven't acked the patch which I hope should make it easy to merge.
> 
> Changes in v3:
> - Drop everyone who hasn't responded in the ~2.5 weeks since v2.
> - Copy linux-mips list for visibility.
> - Copy Andrew as the documented maintainer of last resort.
> 
> Changes in v2:
> - Remove Maciej at his request.
> - Cc @imgtec.com addresses too.
> - Update authorship to my @mips.com address.
> ---
>  .mailmap                                         | 3 +++
>  Documentation/ABI/testing/sysfs-class-remoteproc | 4 ++--
>  MAINTAINERS                                      | 6 +++---
>  arch/mips/generic/Makefile                       | 2 +-
>  arch/mips/generic/Platform                       | 2 +-
>  arch/mips/generic/board-sead3.c                  | 2 +-
>  arch/mips/generic/init.c                         | 2 +-
>  arch/mips/generic/irq.c                          | 2 +-
>  arch/mips/generic/proc.c                         | 2 +-
>  arch/mips/generic/yamon-dt.c                     | 2 +-
>  arch/mips/include/asm/dsemul.h                   | 2 +-
>  arch/mips/include/asm/maar.h                     | 2 +-
>  arch/mips/include/asm/mach-malta/malta-dtshim.h  | 2 +-
>  arch/mips/include/asm/mach-malta/malta-pm.h      | 2 +-
>  arch/mips/include/asm/machine.h                  | 2 +-
>  arch/mips/include/asm/mips-cm.h                  | 2 +-
>  arch/mips/include/asm/mips-cpc.h                 | 2 +-
>  arch/mips/include/asm/mips-cps.h                 | 2 +-
>  arch/mips/include/asm/mips-gic.h                 | 2 +-
>  arch/mips/include/asm/msa.h                      | 2 +-
>  arch/mips/include/asm/pm-cps.h                   | 2 +-
>  arch/mips/include/asm/smp-cps.h                  | 2 +-
>  arch/mips/include/asm/yamon-dt.h                 | 2 +-
>  arch/mips/kernel/cmpxchg.c                       | 2 +-
>  arch/mips/kernel/cps-vec-ns16550.S               | 2 +-
>  arch/mips/kernel/cps-vec.S                       | 2 +-
>  arch/mips/kernel/elf.c                           | 2 +-
>  arch/mips/kernel/mips-cm.c                       | 2 +-
>  arch/mips/kernel/mips-cpc.c                      | 2 +-
>  arch/mips/kernel/pm-cps.c                        | 2 +-
>  arch/mips/kernel/relocate.c                      | 2 +-
>  arch/mips/kernel/smp-cps.c                       | 2 +-
>  arch/mips/mm/sc-debugfs.c                        | 2 +-
>  arch/mips/mti-malta/malta-dt.c                   | 2 +-
>  arch/mips/mti-malta/malta-dtshim.c               | 2 +-
>  arch/mips/mti-malta/malta-pm.c                   | 2 +-
>  arch/mips/pci/pci-generic.c                      | 2 +-
>  arch/mips/tools/generic-board-config.sh          | 2 +-
>  drivers/auxdisplay/img-ascii-lcd.c               | 2 +-
>  drivers/clk/imgtec/clk-boston.c                  | 2 +-
>  drivers/clk/ingenic/cgu.c                        | 2 +-
>  drivers/clk/ingenic/cgu.h                        | 2 +-
>  drivers/clk/ingenic/jz4740-cgu.c                 | 2 +-
>  drivers/clk/ingenic/jz4780-cgu.c                 | 2 +-
>  drivers/cpuidle/cpuidle-cps.c                    | 2 +-
>  drivers/power/reset/piix4-poweroff.c             | 4 ++--
>  46 files changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index c7b10caecc4e..a32879a9f970 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -43,6 +43,7 @@ Corey Minyard <minyard@acm.org>
>  Damian Hobson-Garcia <dhobsong@igel.co.jp>
>  David Brownell <david-b@pacbell.net>
>  David Woodhouse <dwmw2@shinybook.infradead.org>
> +Deng-Cheng Zhu <dengcheng.zhu@mips.com> <dengcheng.zhu@imgtec.com>
>  Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>  Domen Puncer <domen@coderock.org>
>  Douglas Gilbert <dougg@torque.net>
> @@ -114,6 +115,7 @@ Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@s-opensource.com>
>  Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedalley.com>
>  Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
>  Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
> +Matt Redfearn <matt.redfearn@mips.com> <matt.redfearn@imgtec.com>
>  Mayuresh Janorkar <mayur@ti.com>
>  Michael Buesch <m@bues.ch>
>  Michel Dänzer <michel@tungstengraphics.com>
> @@ -127,6 +129,7 @@ Mythri P K <mythripk@ti.com>
>  Nguyen Anh Quynh <aquynh@gmail.com>
>  Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>  Patrick Mochel <mochel@digitalimplant.org>
> +Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
>  Peter A Jonsson <pj@ludd.ltu.se>
>  Peter Oruba <peter@oruba.de>
>  Peter Oruba <peter.oruba@amd.com>
> diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
> index d188afebc8ba..c3afe9fab646 100644
> --- a/Documentation/ABI/testing/sysfs-class-remoteproc
> +++ b/Documentation/ABI/testing/sysfs-class-remoteproc
> @@ -1,6 +1,6 @@
>  What:		/sys/class/remoteproc/.../firmware
>  Date:		October 2016
> -Contact:	Matt Redfearn <matt.redfearn@imgtec.com>
> +Contact:	Matt Redfearn <matt.redfearn@mips.com>
>  Description:	Remote processor firmware
>  
>  		Reports the name of the firmware currently loaded to the
> @@ -11,7 +11,7 @@ Description:	Remote processor firmware
>  
>  What:		/sys/class/remoteproc/.../state
>  Date:		October 2016
> -Contact:	Matt Redfearn <matt.redfearn@imgtec.com>
> +Contact:	Matt Redfearn <matt.redfearn@mips.com>
>  Description:	Remote processor state
>  
>  		Reports the state of the remote processor, which will be one of:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc42c838ab4f..257a0a79f032 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6732,7 +6732,7 @@ S:	Maintained
>  F:	drivers/usb/atm/ueagle-atm.c
>  
>  IMGTEC ASCII LCD DRIVER
> -M:	Paul Burton <paul.burton@imgtec.com>
> +M:	Paul Burton <paul.burton@mips.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
>  F:	drivers/auxdisplay/img-ascii-lcd.c
> @@ -8992,7 +8992,7 @@ F:	Documentation/mips/
>  F:	arch/mips/
>  
>  MIPS BOSTON DEVELOPMENT BOARD
> -M:	Paul Burton <paul.burton@imgtec.com>
> +M:	Paul Burton <paul.burton@mips.com>
>  L:	linux-mips@linux-mips.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/img,boston-clock.txt
> @@ -9002,7 +9002,7 @@ F:	drivers/clk/imgtec/clk-boston.c
>  F:	include/dt-bindings/clock/boston-clock.h
>  
>  MIPS GENERIC PLATFORM
> -M:	Paul Burton <paul.burton@imgtec.com>
> +M:	Paul Burton <paul.burton@mips.com>
>  L:	linux-mips@linux-mips.org
>  S:	Supported
>  F:	arch/mips/generic/
> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index 56b3ea565ed9..874967363dbb 100644
> --- a/arch/mips/generic/Makefile
> +++ b/arch/mips/generic/Makefile
> @@ -1,6 +1,6 @@
>  #
>  # Copyright (C) 2016 Imagination Technologies
> -# Author: Paul Burton <paul.burton@imgtec.com>
> +# Author: Paul Burton <paul.burton@mips.com>
>  #
>  # This program is free software; you can redistribute it and/or modify it
>  # under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
> index f5312dfa8184..b51432dd10b6 100644
> --- a/arch/mips/generic/Platform
> +++ b/arch/mips/generic/Platform
> @@ -1,6 +1,6 @@
>  #
>  # Copyright (C) 2016 Imagination Technologies
> -# Author: Paul Burton <paul.burton@imgtec.com>
> +# Author: Paul Burton <paul.burton@mips.com>
>  #
>  # This program is free software; you can redistribute it and/or modify it
>  # under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/generic/board-sead3.c b/arch/mips/generic/board-sead3.c
> index f109a6b9fdd0..10cf93d97346 100644
> --- a/arch/mips/generic/board-sead3.c
> +++ b/arch/mips/generic/board-sead3.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
> index 15a7fb8e2a2e..cf409ba358a1 100644
> --- a/arch/mips/generic/init.c
> +++ b/arch/mips/generic/init.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
> index 5322d09dd51b..394f8161e462 100644
> --- a/arch/mips/generic/irq.c
> +++ b/arch/mips/generic/irq.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/generic/proc.c b/arch/mips/generic/proc.c
> index 42b33250a4a2..199fb2cc57ee 100644
> --- a/arch/mips/generic/proc.c
> +++ b/arch/mips/generic/proc.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
> index 6077bca9b364..b408dac722ac 100644
> --- a/arch/mips/generic/yamon-dt.c
> +++ b/arch/mips/generic/yamon-dt.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/dsemul.h b/arch/mips/include/asm/dsemul.h
> index a6e067801f23..b47a97527673 100644
> --- a/arch/mips/include/asm/dsemul.h
> +++ b/arch/mips/include/asm/dsemul.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
> index e10f78befbd9..1e0da80bba13 100644
> --- a/arch/mips/include/asm/maar.h
> +++ b/arch/mips/include/asm/maar.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/mach-malta/malta-dtshim.h b/arch/mips/include/asm/mach-malta/malta-dtshim.h
> index cfd777663c64..d696a7598ea7 100644
> --- a/arch/mips/include/asm/mach-malta/malta-dtshim.h
> +++ b/arch/mips/include/asm/mach-malta/malta-dtshim.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/mach-malta/malta-pm.h b/arch/mips/include/asm/mach-malta/malta-pm.h
> index c2c2e201013d..347b53dbc88f 100644
> --- a/arch/mips/include/asm/mach-malta/malta-pm.h
> +++ b/arch/mips/include/asm/mach-malta/malta-pm.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machine.h
> index ecb6c7335484..e0d9b373d415 100644
> --- a/arch/mips/include/asm/machine.h
> +++ b/arch/mips/include/asm/machine.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> index f6231b91b724..3708b8ccc0b4 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
> index f885051a8378..b55e335cfba4 100644
> --- a/arch/mips/include/asm/mips-cpc.h
> +++ b/arch/mips/include/asm/mips-cpc.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
> index bf02b5070a98..8ad4a85eed0c 100644
> --- a/arch/mips/include/asm/mips-cps.h
> +++ b/arch/mips/include/asm/mips-cps.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2017 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
> index a2badf572632..558059a8f218 100644
> --- a/arch/mips/include/asm/mips-gic.h
> +++ b/arch/mips/include/asm/mips-gic.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2017 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
> index 8967b475ab10..b1845102f8f9 100644
> --- a/arch/mips/include/asm/msa.h
> +++ b/arch/mips/include/asm/msa.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/pm-cps.h b/arch/mips/include/asm/pm-cps.h
> index 89d58d80b77b..bb0616967342 100644
> --- a/arch/mips/include/asm/pm-cps.h
> +++ b/arch/mips/include/asm/pm-cps.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
> index 2ae1f61a4a95..16b4ee3feb98 100644
> --- a/arch/mips/include/asm/smp-cps.h
> +++ b/arch/mips/include/asm/smp-cps.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/include/asm/yamon-dt.h b/arch/mips/include/asm/yamon-dt.h
> index 485cfe3e45e1..10a073e6877a 100644
> --- a/arch/mips/include/asm/yamon-dt.h
> +++ b/arch/mips/include/asm/yamon-dt.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
> index 7730f1d3434f..0b9535bc2c53 100644
> --- a/arch/mips/kernel/cmpxchg.c
> +++ b/arch/mips/kernel/cmpxchg.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2017 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/cps-vec-ns16550.S b/arch/mips/kernel/cps-vec-ns16550.S
> index 6d246ad05638..b37af23a5358 100644
> --- a/arch/mips/kernel/cps-vec-ns16550.S
> +++ b/arch/mips/kernel/cps-vec-ns16550.S
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> index d173b49f212d..c7ed26029cbb 100644
> --- a/arch/mips/kernel/cps-vec.S
> +++ b/arch/mips/kernel/cps-vec.S
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 0828d6d963b7..731325a61a78 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> index e91c8c4e2eb5..dd5567b1e305 100644
> --- a/arch/mips/kernel/mips-cm.c
> +++ b/arch/mips/kernel/mips-cm.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index f66b05ebf637..19c88d770054 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
> index 4655017f2377..9dd624c2fe56 100644
> --- a/arch/mips/kernel/pm-cps.c
> +++ b/arch/mips/kernel/pm-cps.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
> index 2d1a0c438771..cbf4cc0b0b6c 100644
> --- a/arch/mips/kernel/relocate.c
> +++ b/arch/mips/kernel/relocate.c
> @@ -6,7 +6,7 @@
>   * Support for Kernel relocation at boot time
>   *
>   * Copyright (C) 2015, Imagination Technologies Ltd.
> - * Authors: Matt Redfearn (matt.redfearn@imgtec.com)
> + * Authors: Matt Redfearn (matt.redfearn@mips.com)
>   */
>  #include <asm/bootinfo.h>
>  #include <asm/cacheflush.h>
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 0063122c85da..7d6af41888e8 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
> index 7e945e310b44..2e2132d3f5c7 100644
> --- a/arch/mips/mm/sc-debugfs.c
> +++ b/arch/mips/mm/sc-debugfs.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/mti-malta/malta-dt.c b/arch/mips/mti-malta/malta-dt.c
> index 4822943100f3..b397117033aa 100644
> --- a/arch/mips/mti-malta/malta-dt.c
> +++ b/arch/mips/mti-malta/malta-dt.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
> index a6699c15277d..7859b6e49863 100644
> --- a/arch/mips/mti-malta/malta-dtshim.c
> +++ b/arch/mips/mti-malta/malta-dtshim.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/mti-malta/malta-pm.c b/arch/mips/mti-malta/malta-pm.c
> index c1e456c01a44..efbd659fb602 100644
> --- a/arch/mips/mti-malta/malta-pm.c
> +++ b/arch/mips/mti-malta/malta-pm.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> index dce304dc3d62..676348164027 100644
> --- a/arch/mips/pci/pci-generic.c
> +++ b/arch/mips/pci/pci-generic.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * pcibios_align_resource taken from arch/arm/kernel/bios32.c.
>   *
> diff --git a/arch/mips/tools/generic-board-config.sh b/arch/mips/tools/generic-board-config.sh
> index 5c4f93687039..82b09af5c144 100755
> --- a/arch/mips/tools/generic-board-config.sh
> +++ b/arch/mips/tools/generic-board-config.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  #
>  # Copyright (C) 2017 Imagination Technologies
> -# Author: Paul Burton <paul.burton@imgtec.com>
> +# Author: Paul Burton <paul.burton@mips.com>
>  #
>  # This program is free software; you can redistribute it and/or modify it
>  # under the terms of the GNU General Public License as published by the
> diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
> index 25306fa27251..a9020f82eea7 100644
> --- a/drivers/auxdisplay/img-ascii-lcd.c
> +++ b/drivers/auxdisplay/img-ascii-lcd.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> index f18f10351785..15af423cc0c9 100644
> --- a/drivers/clk/imgtec/clk-boston.c
> +++ b/drivers/clk/imgtec/clk-boston.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016-2017 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index e8248f9185f7..ab393637f7b0 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -2,7 +2,7 @@
>   * Ingenic SoC CGU driver
>   *
>   * Copyright (c) 2013-2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> index 09700b2c555d..e78b586536ea 100644
> --- a/drivers/clk/ingenic/cgu.h
> +++ b/drivers/clk/ingenic/cgu.h
> @@ -2,7 +2,7 @@
>   * Ingenic SoC CGU driver
>   *
>   * Copyright (c) 2013-2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
> index 510fe7e0c8f1..32fcc75f6f77 100644
> --- a/drivers/clk/ingenic/jz4740-cgu.c
> +++ b/drivers/clk/ingenic/jz4740-cgu.c
> @@ -2,7 +2,7 @@
>   * Ingenic JZ4740 SoC CGU driver
>   *
>   * Copyright (c) 2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
> index b35d6d9dd5aa..ac3585ed8228 100644
> --- a/drivers/clk/ingenic/jz4780-cgu.c
> +++ b/drivers/clk/ingenic/jz4780-cgu.c
> @@ -2,7 +2,7 @@
>   * Ingenic JZ4780 SoC CGU driver
>   *
>   * Copyright (c) 2013-2015 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
> index 72b5e47286b4..dac8ff6391fa 100644
> --- a/drivers/cpuidle/cpuidle-cps.c
> +++ b/drivers/cpuidle/cpuidle-cps.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
> index bacfc95783f0..20ce3ff5e039 100644
> --- a/drivers/power/reset/piix4-poweroff.c
> +++ b/drivers/power/reset/piix4-poweroff.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2016 Imagination Technologies
> - * Author: Paul Burton <paul.burton@imgtec.com>
> + * Author: Paul Burton <paul.burton@mips.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> @@ -109,5 +109,5 @@ static struct pci_driver piix4_poweroff_driver = {
>  };
>  
>  module_pci_driver(piix4_poweroff_driver);
> -MODULE_AUTHOR("Paul Burton <paul.burton@imgtec.com>");
> +MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
>  MODULE_LICENSE("GPL");
> -- 
> 2.14.3
> 
