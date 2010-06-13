Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jun 2010 11:43:06 +0200 (CEST)
Received: from smtp.nokia.com ([192.100.122.230]:57847 "EHLO
        mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491889Ab0FMJnB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Jun 2010 11:43:01 +0200
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
        by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o5D9ghoJ025290;
        Sun, 13 Jun 2010 12:42:55 +0300
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.4675);
         Sun, 13 Jun 2010 12:42:43 +0300
Received: from mgw-da01.ext.nokia.com ([147.243.128.24]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Sun, 13 Jun 2010 12:42:42 +0300
Received: from [172.21.40.75] (esdhcp04075.research.nokia.com [172.21.40.75])
        by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o5D9gZ51010415;
        Sun, 13 Jun 2010 12:42:36 +0300
Subject: Re: [RFC][PATCH 17/26] MTD: Nand: Add JZ4740 NAND driver
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
In-Reply-To: <1275505950-17334-1-git-send-email-lars@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
         <1275505950-17334-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 13 Jun 2010 12:40:15 +0300
Message-ID: <1276422015.19028.204.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.1.2 (2.30.1.2-8.fc13) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Jun 2010 09:42:42.0693 (UTC) FILETIME=[C526D350:01CB0ADC]
X-Nokia-AV: Clean
X-archive-position: 27126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8819

On Wed, 2010-06-02 at 21:12 +0200, Lars-Peter Clausen wrote:
> This patch adds support for the NAND controller on JZ4740 SoCs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> ---
>  drivers/mtd/nand/Kconfig        |    6 +
>  drivers/mtd/nand/Makefile       |    1 +
>  drivers/mtd/nand/jz4740_nand.c  |  442 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/jz4740_nand.h |   34 +++
>  4 files changed, 483 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/jz4740_nand.c
>  create mode 100644 include/linux/mtd/jz4740_nand.h

I doubt "include/linux/" is the right place to define 'struct
jz_nand_platform_data' - it should instead live is somwhere in
arch/mips/

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
