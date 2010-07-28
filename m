Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 20:57:52 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:65311 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492189Ab0G1S5r convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jul 2010 20:57:47 +0200
Received: by yxj4 with SMTP id 4so1290344yxj.36
        for <multiple recipients>; Wed, 28 Jul 2010 11:57:41 -0700 (PDT)
Received: by 10.151.132.18 with SMTP id j18mr10299489ybn.217.1280343461165; 
        Wed, 28 Jul 2010 11:57:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.84.4 with HTTP; Wed, 28 Jul 2010 11:57:21 -0700 (PDT)
In-Reply-To: <20100727215337.GA29365@dediao-lnx2.corp.sa.net>
References: <20100727215337.GA29365@dediao-lnx2.corp.sa.net>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 28 Jul 2010 12:57:21 -0600
X-Google-Sender-Auth: ZIJ8xz5QMwWSXXROIeqKx_jJ8eA
Message-ID: <AANLkTi=dRVrXdvF3e8h7kbF0AruBLpqRYbBLJcg2wMpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: PowerTV: Add device tree support
To:     Dezhong Diao <dediao@cisco.com>
Cc:     devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, dvomlehn@cisco.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

Hi Dezhong,

I can't comment too much on this patch since I don't know the platform
or MIPS very well, but it seems to be good.  Can you post a sample of
your device tree, and your binding documentation?

Thanks,
g.

On Tue, Jul 27, 2010 at 3:53 PM, Dezhong Diao <dediao@cisco.com> wrote:
> V2:
>    Synchronize with test-devicetree branch of device tree.
>
> V1:
>    Add device tree support for PowerTV.
>    Customize user-defined memory scan function.
>
> Signed-off-by: Dezhong Diao <dediao@cisco.com>
> ---
>  arch/mips/configs/powertv_defconfig        |  293 +++++++++++++++++++++-------
>  arch/mips/include/asm/mach-powertv/asic.h  |    8 +-
>  arch/mips/include/asm/mach-powertv/mdesc.h |   51 +++++
>  arch/mips/powertv/Makefile                 |    2 +-
>  arch/mips/powertv/asic/asic_devices.c      |   22 --
>  arch/mips/powertv/mdesc.c                  |  224 +++++++++++++++++++++
>  arch/mips/powertv/memory.c                 |  242 ++++++++++++++---------
>  7 files changed, 649 insertions(+), 193 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-powertv/mdesc.h
>  create mode 100644 arch/mips/powertv/mdesc.c
