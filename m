Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 10:49:49 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:52297 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992128AbcJMItl4jslc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2016 10:49:41 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 87F8053258D81;
        Thu, 13 Oct 2016 09:49:33 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL03.hh.imgtec.org (10.44.0.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 13 Oct 2016 09:49:35 +0100
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Thu, 13 Oct 2016 09:49:34 +0100
From:   James Hartley <James.Hartley@imgtec.com>
To:     Rahul Bedarkar <Rahul.Bedarkar@imgtec.com>,
        Rob Herring <robh@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] MIPS: DTS: img: add device tree for Marduk board
Thread-Topic: [PATCH 2/2] MIPS: DTS: img: add device tree for Marduk board
Thread-Index: AQHSH83MFJLEHIy+xEmmOrinu3/Ha6ChsusAgAQ8JACAAC050A==
Date:   Thu, 13 Oct 2016 08:49:34 +0000
Message-ID: <72BC0C8BD7BB6F45988A99382E5FBAE5889ED617@HHMAIL01.hh.imgtec.org>
References: <1475757094-31089-1-git-send-email-rahul.bedarkar@imgtec.com>
 <1475757094-31089-2-git-send-email-rahul.bedarkar@imgtec.com>
 <20161010142152.GA7920@rob-hp-laptop> <57FF3172.4010709@imgtec.com>
In-Reply-To: <57FF3172.4010709@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.7.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Hartley@imgtec.com
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

Hi Rahul,

> -----Original Message-----
> From: Rahul Bedarkar
> Sent: 13 October 2016 08:02
> To: Rob Herring
> Cc: Ralf Baechle; Mark Rutland; James Hartley; linux-mips@linux-mips.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] MIPS: DTS: img: add device tree for Marduk board
> 
> Hi,
> 
> On Monday 10 October 2016 07:51 PM, Rob Herring wrote:
> >> +
> >> +	memory {
> >
> > Is 0 the actual base, or that gets filled in by bootloader? If the
> > formet, add unit address.
> >
> 
> Bootloader (uboot) can override or fixup memory node. But with version of
> bootloader I tested with, base address is hardcoded to 0 and only size may
> get changed. But since booloader can override or fixup memory node, I
> assume we don't add unit address in this case.
> 
> >> +		device_type = "memory";
> >> +		reg =  <0x00000000 0x08000000>;
> 
> I now realized that size is incorrectly specified in memory node. It should be
> 256MB and not 128MB. I will fix this in v2.

This is board dependent, and since you have already explained that the boot loader is expected to configure this, I would recommend leaving it at 128MB (which I believe is the size of the smallest DDR part in use on existing boards). This would mean that if for some reason the boot loader did not adjust the settings, it would still boot on all currently known boards.

James.

> 
> Thanks,
> Rahul
