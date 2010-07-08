Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 15:23:55 +0200 (CEST)
Received: from smtp.nokia.com ([192.100.105.134]:38898 "EHLO
        mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491782Ab0GHNXr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 15:23:47 +0200
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
        by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o68DNDnh015684;
        Thu, 8 Jul 2010 08:23:35 -0500
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 8 Jul 2010 16:22:58 +0300
Received: from mgw-sa01.ext.nokia.com ([147.243.1.47]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 8 Jul 2010 16:22:57 +0300
Received: from [172.21.41.123] (esdhcp041123.research.nokia.com [172.21.41.123])
        by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o68DMujn018098;
        Thu, 8 Jul 2010 16:22:56 +0300
Subject: Re: [PATCH v2 17/26] MTD: Nand: Add JZ4740 NAND driver
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <4C35D084.7050605@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
         <1276924111-11158-18-git-send-email-lars@metafoo.de>
         <1278569214.12733.38.camel@localhost>  <4C35D084.7050605@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 08 Jul 2010 16:19:02 +0300
Message-ID: <1278595142.20321.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.2 (2.30.2-1.fc13) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Jul 2010 13:22:58.0219 (UTC) FILETIME=[AE8BCFB0:01CB1EA0]
X-Nokia-AV: Clean
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-07-08 at 15:20 +0200, Lars-Peter Clausen wrote:
> On the other hand I'm wondering where on would put headers for non platform specific
> drivers?

If we are talking about MTD, then drivers/mtd ?

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
