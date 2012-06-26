Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 11:28:38 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:46975 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903784Ab2FZJ2a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 11:28:30 +0200
Received: by eekd17 with SMTP id d17so1602086eek.36
        for <multiple recipients>; Tue, 26 Jun 2012 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=ywFg2gv8W02sgBw99/mNUTdggeDY7bxI1NSu+FNeLsE=;
        b=L55QebX9zMbhY6V4Ceonvvt82c5ImfHalhihUOp0DIzta9RTbk3xe5zsQGh+r4nIjJ
         527P3MnwRYYt188Ed+JPm2JCqSIRN5AOn4jOEVsJ0ze4dJqACCXyypdU0lTtSVTh0scm
         LivJVGrDhz2XYvA90HxS1hwluO0hGe2slZP1UlcINQBtf2Y0PfFVZIaF82Xg28ps7rwD
         uGqeibwI2KGSmWLGVH9z8QFJhDXaRNaOf4J2Cn2B9+ARVDUGsDBKCVXPI2vSj/8EMstB
         Y4oY+whR1xF4r2bMlOBhTxPxmttKRpr0qszBYu3PG3chxQsZ/3hDnAdK/hKDy6yglugt
         Z5BQ==
Received: by 10.14.28.66 with SMTP id f42mr3081330eea.63.1340702905217;
        Tue, 26 Jun 2012 02:28:25 -0700 (PDT)
Received: from flexo.localnet ([2a01:e33:e937:e020:712a:388a:486a:7c16])
        by mx.google.com with ESMTPS id u44sm3427053eeb.7.2012.06.26.02.28.22
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 02:28:23 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: Re: [PATCH 00/33] Cleanup firmware support across multiple platforms.
Date:   Tue, 26 Jun 2012 11:25:51 +0200
Message-ID: <5495290.ISdeCM85M9@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 33843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Steven,

On Monday 25 June 2012 23:41:15 Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> This is actually the second version of the firmware cleanup. It is two
> patches less than first after incorporating all the review comments
> and changes requested. The original patch set is now rejected.

One of the comment to your initial serie was to make sure the cleanups and 
functionnal changes were splitted in two separate patch series.

Sergei also expressed concerned about your checkpatch changes adding MTI 
copyright to the concerned files. I share that concern and do not think that it 
is worth adding it for such minor changes, or if you do, better do it in the 
"Cleanup firmware" patch instead.

> 
> Steven J. Hill (33):
>   MIPS: Add environment variable processing code to firmware library.
>   MIPS: Alchemy: Cleanup firmware support for Alchemy platforms.
>   MIPS: Alchemy: Cleanup files effected by firmware changes.
>   MIPS: AR7: Cleanup firmware support for the AR7 platform.
>   MIPS: AR7: Cleanup files effected by firmware changes.
>   MIPS: ath79: Cleanup firmware support for the ath79 platform.
>   MIPS: Cobalt: Cleanup firmware support for the Cobalt platform.
>   MIPS: Cobalt: Cleanup files effected by firmware changes.
>   MIPS: Emma: Cleanup firmware support for the Emma platform.
>   MIPS: Emma: Cleanup files effected by firmware changes.
>   MIPS: jz4740: Cleanup firmware support for the JZ4740 platform.
>   MIPS: jz4740: Cleanup files effected by firmware changes.
>   MIPS: lantiq: Cleanup firmware support for the lantiq platform.
>   MIPS: lantiq: Cleanup files effected by firmware changes.
>   MIPS: Lasat: Cleanup firmware support for the Lasat platform.
>   MIPS: Lasat: Cleanup files effected by firmware changes.
>   MIPS: Loongson: Cleanup firmware support for the Loongson platform.
>   MIPS: Loongson: Cleanup files effected by firmware changes.
>   MIPS: Malta: Cleanup firmware support for the Malta platform.
>   MIPS: Malta: Cleanup files effected by firmware changes.
>   MIPS: Netlogic: Cleanup firmware support for the XLR platform.
>   MIPS: MSP71xx, Yosemite: Cleanup firmware support for PMC platforms.
>   MIPS: MSP71xx, Yosemite: Cleanup files effected by firmware changes.
>   MIPS: PNX83xx, PNX8550: Cleanup firmware support for PNX platforms.
>   MIPS: PNX83xx, PNX8550: Cleanup files effected by firmware changes.
>   MIPS: PowerTV: Cleanup firmware support for PowerTV platform.
>   MIPS: PowerTV: Cleanup files effected by firmware changes.
>   MIPS: RB532: Cleanup firmware support for RB532 platform.
>   MIPS: RB532: Cleanup files effected by firmware changes.
>   MIPS: txx9: Cleanup firmware support for txx9 platforms.
>   MIPS: txx9: Cleanup files effected by firmware changes.
>   MIPS: vr41xx: Cleanup firmware support for vr41xx platforms.
>   MIPS: vr41xx: Cleanup files effected by firmware changes.
> 
>  arch/mips/alchemy/board-gpr.c                      |   45 ++---
>  arch/mips/alchemy/board-mtx1.c                     |   45 ++---
>  arch/mips/alchemy/board-xxs1500.c                  |   44 ++---
>  arch/mips/alchemy/common/platform.c                |   30 ++-
>  arch/mips/alchemy/common/prom.c                    |   73 +------
>  arch/mips/alchemy/devboards/db1000.c               |    1 -
>  arch/mips/alchemy/devboards/db1300.c               |    1 -
>  arch/mips/alchemy/devboards/db1550.c               |    1 -
>  arch/mips/alchemy/devboards/pb1100.c               |    1 -
>  arch/mips/alchemy/devboards/pb1500.c               |    1 -
>  arch/mips/alchemy/devboards/prom.c                 |   53 ++---
>  arch/mips/ar7/memory.c                             |   21 +-
>  arch/mips/ar7/platform.c                           |   63 +++---
>  arch/mips/ar7/prom.c                               |   59 ++----
>  arch/mips/ar7/setup.c                              |   23 +--
>  arch/mips/ath79/prom.c                             |   38 ++--
>  arch/mips/cobalt/setup.c                           |   42 ++--
>  arch/mips/emma/common/prom.c                       |   42 +---
>  arch/mips/fw/lib/Makefile                          |    2 +
>  arch/mips/fw/lib/cmdline.c                         |  101 ++++++++++
>  arch/mips/include/asm/fw/fw.h                      |   47 +++++
>  arch/mips/include/asm/mach-ar7/prom.h              |   25 ---
>  arch/mips/include/asm/mach-au1x00/au1xxx_eth.h     |    1 +
>  arch/mips/include/asm/mach-au1x00/prom.h           |   12 --
>  arch/mips/include/asm/mach-loongson/loongson.h     |   54 +++---
>  arch/mips/include/asm/mips-boards/generic.h        |   30 +--
>  arch/mips/include/asm/mips-boards/prom.h           |   47 -----
>  .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |   46 +----
>  arch/mips/include/asm/txx9/generic.h               |    1 -
>  arch/mips/jz4740/prom.c                            |   48 +----
>  arch/mips/lantiq/prom.c                            |   31 +--
>  arch/mips/lasat/prom.c                             |   20 +-
>  arch/mips/loongson/common/Makefile                 |    2 +-
>  arch/mips/loongson/common/cmdline.c                |   48 -----
>  arch/mips/loongson/common/env.c                    |   40 ++--
>  arch/mips/loongson/common/init.c                   |   16 +-
>  arch/mips/mti-malta/Makefile                       |    2 +-
>  arch/mips/mti-malta/malta-cmdline.c                |   59 ------
>  arch/mips/mti-malta/malta-display.c                |   40 ++--
>  arch/mips/mti-malta/malta-init.c                   |  153 +++------------
>  arch/mips/mti-malta/malta-memory.c                 |  106 ++++------
>  arch/mips/mti-malta/malta-setup.c                  |   58 ++----
>  arch/mips/mti-malta/malta-time.c                   |   66 +++----
>  arch/mips/netlogic/xlr/setup.c                     |   48 +----
>  arch/mips/pmc-sierra/msp71xx/msp_prom.c            |  205 
+++++---------------
>  arch/mips/pmc-sierra/msp71xx/msp_serial.c          |   68 +++----
>  arch/mips/pmc-sierra/msp71xx/msp_setup.c           |   43 ++--
>  arch/mips/pmc-sierra/msp71xx/msp_time.c            |   67 ++-----
>  arch/mips/pmc-sierra/msp71xx/msp_usb.c             |   42 +---
>  arch/mips/pmc-sierra/yosemite/prom.c               |   45 +----
>  arch/mips/pnx833x/common/Makefile                  |    2 +-
>  arch/mips/pnx833x/common/prom.c                    |   64 ------
>  arch/mips/pnx833x/common/setup.c                   |   36 ++--
>  arch/mips/pnx833x/stb22x/board.c                   |   68 +++----
>  arch/mips/pnx8550/common/Makefile                  |    2 +-
>  arch/mips/pnx8550/common/prom.c                    |  128 ------------
>  arch/mips/pnx8550/common/setup.c                   |   66 +++----
>  arch/mips/pnx8550/jbs/init.c                       |   43 +---
>  arch/mips/pnx8550/stb810/prom_init.c               |   34 +---
>  arch/mips/powertv/asic/asic_int.c                  |   43 +---
>  arch/mips/powertv/init.c                           |   81 ++------
>  arch/mips/powertv/memory.c                         |   36 +---
>  arch/mips/powertv/powertv_setup.c                  |   24 +--
>  arch/mips/rb532/prom.c                             |   67 +++----
>  arch/mips/txx9/generic/setup.c                     |   84 ++------
>  arch/mips/vr41xx/common/init.c                     |   36 +---
>  drivers/mtd/maps/pmcmsp-flash.c                    |   57 ++----
>  drivers/net/ethernet/amd/au1000_eth.c              |    1 -
>  68 files changed, 854 insertions(+), 2174 deletions(-)
>  create mode 100644 arch/mips/fw/lib/cmdline.c
>  create mode 100644 arch/mips/include/asm/fw/fw.h
>  delete mode 100644 arch/mips/include/asm/mach-ar7/prom.h
>  delete mode 100644 arch/mips/include/asm/mach-au1x00/prom.h
>  delete mode 100644 arch/mips/include/asm/mips-boards/prom.h
>  delete mode 100644 arch/mips/loongson/common/cmdline.c
>  delete mode 100644 arch/mips/mti-malta/malta-cmdline.c
>  delete mode 100644 arch/mips/pnx833x/common/prom.c
>  delete mode 100644 arch/mips/pnx8550/common/prom.c
> 
> -- 
> 1.7.10.3
> 
> 
