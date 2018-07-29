Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 23:59:30 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz ([IPv6:2001:df5:b000:5::4]:46084 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993029AbeG2V70BoRr0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 23:59:26 +0200
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BB5E4806AC;
        Mon, 30 Jul 2018 09:59:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532901554;
        bh=+87Z3l4ZlvJC7RyQLWNin71ISj3o3HgMB1PGL+RLtK4=;
        h=From:To:CC:Subject:Date:References;
        b=pzIJuyEtZSJLOj5zstE8L+Owe5B6h7MwPHf79gY5IZSKAT6Me9Z9Ovy6htv3MWbvs
         nohEOUXEM7oRDCrB3zvrJPFnEbs8KNWTUk1o67m4Z45JTvIwd93h/j+mRbbif5s0NK
         fI3pKZY1uyFiltc3c+yxmShxwTydBxNo4SCl1WnU=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5e38b30000>; Mon, 30 Jul 2018 09:59:15 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Mon, 30 Jul 2018 09:59:14 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 30 Jul 2018 09:59:14 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Paul Burton <paul.burton@mips.com>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Marley <michael@michaelmarley.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for
 PCIe erratum"
Thread-Topic: [PATCH] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for
 PCIe erratum"
Thread-Index: AQHUJZruE1onc8Mrpk+Z2Euh91s5Yg==
Date:   Sun, 29 Jul 2018 21:59:13 +0000
Message-ID: <b5462369811a4371b870ccae3a0b0533@svr-chch-ex1.atlnz.lc>
References: <20180727111339.17895-1-zajec5@gmail.com>
 <20180727171238.ybtoxddx2xulspu5@pburton-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Chris.Packham@alliedtelesis.co.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Chris.Packham@alliedtelesis.co.nz
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

On 28/07/18 05:13, Paul Burton wrote:
> Hi Rafa³,
> 
> On Fri, Jul 27, 2018 at 01:13:39PM +0200, Rafa³ Mi³ecki wrote:
>> From: Rafa³ Mi³ecki <rafal@milecki.pl>
>>
>> This reverts commit 2a027b47dba6b77ab8c8e47b589ae9bbc5ac6175.
>>
>> Enabling ExternalSync caused a regression for BCM4718A1 (used e.g. in
>> Netgear E3000 and ASUS RT-N16): it simply hangs during PCIe
>> initialization. It's likely that BCM4717A1 is also affected.
>>
>> I didn't notice that earlier as the only BCM47XX devices with PCIe I
>> own are:
>> 1) BCM4706 with 2 x 14e4:4331
>> 2) BCM4706 with 14e4:4360 and 14e4:4331
>> it appears that BCM4706 is unaffected.
>>
>> While BCM5300X-ES300-RDS.pdf seems to document that erratum and its
>> workarounds (according to quotes provided by Tokunori) it seems not even
>> Broadcom follows them.
>>
>> According to the provided info Broadcom should define CONF7_ES in their
>> SDK's mipsinc.h and implement workaround in the si_mips_init(). Checking
>> both didn't reveal such code. It *could* mean Broadcom also had some
>> problems with the given workaround.
>>
>> Reported-by: Michael Marley <michael@michaelmarley.com>
>> Cc: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Cc: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Cc: stable@vger.kernel.org
>> Cc: James Hogan <jhogan@kernel.org>
>> Signed-off-by: Rafa³ Mi³ecki <rafal@milecki.pl>
>> ---
>> This has been reported by Michael as OpenWrt bug at:
>> https://bugs.openwrt.org/index.php?do=details&task_id=1688
>> ---
>>   arch/mips/bcm47xx/setup.c        | 6 ------
>>   arch/mips/include/asm/mipsregs.h | 3 ---
>>   2 files changed, 9 deletions(-)
> 
> Thanks - I've applied this to mips-fixes, and will send to Linus before
> v4.18 final so this regression shouldn't appear in a stable kernel.
> 
> Tokunori - if this breaks your system then we'll need to look at
> applying the workaround more selectively.

I wonder if the Erratum really is specific to the 5300X SoC (which isn't 
supported in upstream Linux). It's a little hard to get any useful 
information out of Broadcom, especially for an older chip.
