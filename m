Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 12:58:11 +0200 (CEST)
Received: from arroyo.ext.ti.com ([192.94.94.40]:48984 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491025Ab1GZK6G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jul 2011 12:58:06 +0200
Received: from dlep33.itg.ti.com ([157.170.170.112])
        by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6QAw3Uj000374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 26 Jul 2011 05:58:03 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
        by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6QAw3Zq002249;
        Tue, 26 Jul 2011 05:58:03 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
        by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6QAw3NJ008968;
        Tue, 26 Jul 2011 05:58:03 -0500 (CDT)
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dlee74.ent.ti.com
 (157.170.170.8) with Microsoft SMTP Server id 8.3.106.1; Tue, 26 Jul 2011
 05:58:03 -0500
Received: from [172.24.68.15] (h68-15.vpn.ti.com [172.24.68.15])        by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6QAw113028603;      Tue, 26 Jul
 2011 05:58:02 -0500
Message-ID: <4E2E9DB9.5090007@ti.com>
Date:   Tue, 26 Jul 2011 11:58:01 +0100
From:   Liam Girdwood <lrg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 0/3] ASoC: au1x: update PSC AC97/I2S code
References: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-archive-position: 30722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18517

On 25/07/11 12:45, Manuel Lauss wrote:
> The following two patches depend on patchset "ASoC for Alchemy Au1000/1500/1100"
> to apply and work.
> Patch #1 moves the DBDMA (PCM) device registration from the AC97/I2S drivers
>   into the board code.
> Patch #2 changes use of "soc-audio" platform device int db1200 machine code to
>   the new way.
> Patch #3 removes the use of custom PCM_TX/RX constants in favour of the
>   established SNDRV_PCM_SUBTREAM_PLAYBACK/CAPTURE.
> 
> Changes since V1:
> - added patch #3
> - tidied patch #1 a bit more.
> 
> Run-tested on DB1200, DB1300 and DB1550 boards.
> 
> Manuel Lauss (3):
>   ASoC: au1x: remove automatic DMA device registration from PSC drivers
>   ASoC: au1x: update db1200 machine to the new way of things
>   ASoC: au1x: use substream stream info directly
> 
>  arch/mips/alchemy/devboards/db1200/platform.c |   16 +++++
>  sound/soc/au1x/db1200.c                       |   64 ++++++++++++------
>  sound/soc/au1x/dbdma2.c                       |   91 +++++--------------------
>  sound/soc/au1x/psc-ac97.c                     |   48 +++++++++-----
>  sound/soc/au1x/psc-i2s.c                      |   42 +++++++----
>  sound/soc/au1x/psc.h                          |   11 ---
>  6 files changed, 133 insertions(+), 139 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
