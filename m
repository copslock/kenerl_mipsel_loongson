Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 16:19:14 +0200 (CEST)
Received: from smtp.nokia.com ([192.100.105.134]:43222 "EHLO
        mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491114Ab0GHOTK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 16:19:10 +0200
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
        by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o68EI5qc030036;
        Thu, 8 Jul 2010 09:19:05 -0500
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 8 Jul 2010 17:18:52 +0300
Received: from mgw-sa01.ext.nokia.com ([147.243.1.47]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 8 Jul 2010 17:18:52 +0300
Received: from [172.21.41.123] (esdhcp041123.research.nokia.com [172.21.41.123])
        by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o68EIpFN016387;
        Thu, 8 Jul 2010 17:18:51 +0300
Subject: Re: [PATCH v2 17/26] MTD: Nand: Add JZ4740 NAND driver
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <4C35DA6C.2060405@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
         <1276924111-11158-18-git-send-email-lars@metafoo.de>
         <1278569214.12733.38.camel@localhost>  <4C35D084.7050605@metafoo.de>
         <1278595142.20321.26.camel@localhost>  <4C35DA6C.2060405@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 08 Jul 2010 17:14:57 +0300
Message-ID: <1278598497.20321.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.2 (2.30.2-1.fc13) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Jul 2010 14:18:52.0419 (UTC) FILETIME=[7DCE1D30:01CB1EA8]
X-Nokia-AV: Clean
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-07-08 at 16:02 +0200, Lars-Peter Clausen wrote:
> Artem Bityutskiy wrote:
> > On Thu, 2010-07-08 at 15:20 +0200, Lars-Peter Clausen wrote:
> >> On the other hand I'm wondering where on would put headers for non platform specific
> >> drivers?
> > 
> > If we are talking about MTD, then drivers/mtd ?
> > 
> No, what I meant was header defining platform data structs and such.
> And what I wanted to get at is an answer to why driver header files are put in
> different directories while the driver files themselves are all keep in the same
> directory. (drivers of the same subsystem that is)

To be frank I do not know, I did not look at the whole picture, just at
the MTD part :-)

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
