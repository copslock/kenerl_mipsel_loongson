Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Feb 2016 11:33:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3290 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007282AbcB2Kd4fpyTE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Feb 2016 11:33:56 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 31E96F5D6D769;
        Mon, 29 Feb 2016 10:33:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 29 Feb 2016 10:33:49 +0000
Received: from [192.168.154.40] (192.168.154.40) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 29 Feb
 2016 10:33:49 +0000
Subject: Re: [PATCH v3 07/52] mtd: nand: core: use mtd_ooblayout_xxx() helpers
 where appropriate
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
 <1456448280-27788-8-git-send-email-boris.brezillon@free-electrons.com>
 <56D0629C.9080805@imgtec.com> <20160226161054.3477cd4b@bbrezillon>
 <56D06C88.9080608@imgtec.com> <20160226193325.2d84a8c8@bbrezillon>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        "Krzysztof Kozlowski" <k.kozlowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "punnaiah choudary kalluri" <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        "Kamal Dasu" <kdasu.kdev@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-api@vger.kernel.org>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <56D41E8D.1010901@imgtec.com>
Date:   Mon, 29 Feb 2016 10:33:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160226193325.2d84a8c8@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.40]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Hi Boris,

On 26/02/16 18:33, Boris Brezillon wrote:
> Hi Harvey,
>
> On Fri, 26 Feb 2016 15:17:28 +0000
> Harvey Hunt <harvey.hunt@imgtec.com> wrote:
>
>> Hi Boris,
>>
>> On 26/02/16 15:10, Boris Brezillon wrote:
>>> Hi Harvey,
>>>
>>> On Fri, 26 Feb 2016 14:35:08 +0000
>>> Harvey Hunt <harvey.hunt@imgtec.com> wrote:
>>>
>>>> [...]
>>>> I'll look into this more later today, but wanted to run it by you in
>>>> case you have any thoughts.
>>>
>>> Can you apply this patch [1], and let me know if you see the additional
>>> trace?
>>
>> I applied the patch, the following is the (unchanged) output:
>>
>> [    0.256375] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x88
>> [    0.262887] nand: Micron MT29F64G08CBAAAWP
>> [    0.266995] nand: 8192 MiB, MLC, erase size: 2048 KiB, page size:
>> 8192, OOB size: 448
>> [    0.274881] jz4780-nand 1b000000.nand-controller: using hardware BCH
>> (strength 24, size 1024, bytes 42)
>> [    0.289046] Bad block table not found for chip 0
>> [    0.297769] Bad block table not found for chip 0
>> [    0.302425] Scanning device for bad blocks
>> [    0.320239] Bad eraseblock 90 at 0x00000b400000
>> [    0.324934] Bad eraseblock 91 at 0x00000b600000
>> [    0.931054] Bad eraseblock 4092 at 0x0001ff800000
>> [    0.935917] Bad eraseblock 4093 at 0x0001ffa00000
>> [    0.944660] nand_bbt: error while writing bad block table -34
>> [    0.950448] jz4780-nand: probe of 1b000000.nand-controller failed
>> with error -34
>> [    0.958079] UBI error: cannot open mtd 3, error -19
>> [    0.962788] UBI error: cannot open mtd 4, error -19[    0.970229]
>> clk: Not disabling unused clocks
>>
>
> Can you test with this one [1]?
>
> [1]http://code.bulix.org/36oytz-91960

With that patch applied, my Ci20 successfully boots again.

Thanks for looking into it :-)

Harvey
