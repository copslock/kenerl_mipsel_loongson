Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 12:48:38 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:51366 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491025Ab1GZKsd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jul 2011 12:48:33 +0200
Received: from dlep34.itg.ti.com ([157.170.170.115])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6QAmPCk028714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 26 Jul 2011 05:48:25 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
        by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6QAmPN4012173;
        Tue, 26 Jul 2011 05:48:25 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
        by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6QAmPb4000356;
        Tue, 26 Jul 2011 05:48:25 -0500 (CDT)
Received: from dlelxv22.itg.ti.com (172.17.1.197) by DLEE73.ent.ti.com
 (157.170.170.88) with Microsoft SMTP Server id 8.3.106.1; Tue, 26 Jul 2011
 05:48:24 -0500
Received: from [172.24.68.15] (h68-15.vpn.ti.com [172.24.68.15])        by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6QAmNZS027242;      Tue, 26 Jul
 2011 05:48:24 -0500
Message-ID: <4E2E9B77.4060602@ti.com>
Date:   Tue, 26 Jul 2011 11:48:23 +0100
From:   Liam Girdwood <lrg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 0/3] ASoC for Alchemy Au1000/1500/1100
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-archive-position: 30721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18512

On 25/07/11 12:44, Manuel Lauss wrote:
> Hello,
> 
> Here's V5 of the AC97/I2S ASoC patchset for early Alchemy
> chips and their respective evaluation boards. 
> The patches are largely based on the old mips/au1x00.c driver which
> they replace.
> 
> AC97 Tested on a Db1500 development board; I2S untested since none
> of the testboards I have actually have an I2S codec (just testpoints).
> 
> Changes since V4:
> - incorporate feedback from Liam Girdwood.
> - rediff against latest ASoC changes
> 
> Changes since V3:
> - dropped the hunk which removed the I2S constants from the au1000.h header
>   to avoid merge conflicts with other patches.
> - use the context structure declared in psc.h.  Follow-up patches for psc* code
>   depend on this.
> 
> Changes since V2:
> - implemented changes after feedback from Lars-Peter Clausen:
> * split patch 1 in two, one for the ASoC drivers, and a separate for
>   DB1000 machine code.
> * get rid of automatic dma device registration
> * tidied the I2S/AC97 sources
> - mark sound/mips/au1x00.c as DEPRECATED instead of removing it outright.
> 
> Changes since V1:
> - added untested I2S controller driver for completeness, removed the audio
>   defines from the au1000 header.
> 
> Manuel Lauss (3):
>   ASoC: Alchemy AC97C/I2SC audio support
>   ASoC: Add a DB1x00 AC97 machine driver
>   ALSA: deprecate MIPS AU1X00 AC97 driver
> 
>  arch/mips/alchemy/devboards/db1x00/platform.c |   48 ++++
>  sound/mips/Kconfig                            |    5 +-
>  sound/soc/au1x/Kconfig                        |   28 ++
>  sound/soc/au1x/Makefile                       |   10 +
>  sound/soc/au1x/ac97c.c                        |  365 ++++++++++++++++++++++++
>  sound/soc/au1x/db1000.c                       |   75 +++++
>  sound/soc/au1x/dma.c                          |  377 +++++++++++++++++++++++++
>  sound/soc/au1x/i2sc.c                         |  347 +++++++++++++++++++++++
>  sound/soc/au1x/psc.h                          |   19 +-
>  9 files changed, 1264 insertions(+), 10 deletions(-)
>  create mode 100644 sound/soc/au1x/ac97c.c
>  create mode 100644 sound/soc/au1x/db1000.c
>  create mode 100644 sound/soc/au1x/dma.c
>  create mode 100644 sound/soc/au1x/i2sc.c
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
