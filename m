Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 10:40:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35401 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007617AbcAGJkUlKOfI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 10:40:20 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C024ECB8C713C;
        Thu,  7 Jan 2016 09:40:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 7 Jan 2016 09:40:14 +0000
Received: from [192.168.154.40] (192.168.154.40) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 7 Jan
 2016 09:40:13 +0000
Subject: Re: [PATCH v11 3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
To:     Brian Norris <computersforpeace@gmail.com>
References: <1451910884-18710-1-git-send-email-harvey.hunt@imgtec.com>
 <1451910884-18710-4-git-send-email-harvey.hunt@imgtec.com>
 <20160107012903.GX109450@google.com>
CC:     <linux-mtd@lists.infradead.org>,
        <boris.brezillon@free-electrons.com>, <alex@alex-smith.me.uk>,
        Alex Smith <alex.smith@imgtec.com>,
        "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <robh@kernel.org>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <568E327D.8040905@imgtec.com>
Date:   Thu, 7 Jan 2016 09:40:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160107012903.GX109450@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.40]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50957
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

Hi Brian,

On 07/01/16 01:29, Brian Norris wrote:
> On Mon, Jan 04, 2016 at 12:34:44PM +0000, Harvey Hunt wrote:
>> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
>> index 9fcb9e7..782258c 100644
>> --- a/arch/mips/boot/dts/ingenic/ci20.dts
>> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>
> As I noted on patch 1, you need to send this to linux-mips + Ralf.

I forgot to CC Ralf on this version, but he took v9 (no change between 
v9 and v11) through linux-mips as can be seen here: 
http://patchwork.linux-mips.org/patch/11695/

>
>> @@ -42,3 +42,66 @@
>>   &uart4 {
>>   	status = "okay";
>>   };
>> +
>> +&nemc {
>> +	status = "okay";
>> +
>> +	nandc: nand-controller@1 {
>> +		compatible = "ingenic,jz4780-nand";
>> +		reg = <1 0 0x1000000>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ingenic,bch-controller = <&bch>;
>> +
>> +		ingenic,nemc-tAS = <10>;
>> +		ingenic,nemc-tAH = <5>;
>> +		ingenic,nemc-tBP = <10>;
>> +		ingenic,nemc-tAW = <15>;
>> +		ingenic,nemc-tSTRV = <100>;
>> +
>> +		nand@1 {
>> +			reg = <1>;
>> +
>> +			nand-ecc-step-size = <1024>;
>> +			nand-ecc-strength = <24>;
>> +			nand-ecc-mode = "hw";
>> +			nand-on-flash-bbt;
>> +
>> +			partitions {
>> +				#address-cells = <2>;
>> +				#size-cells = <2>;
>
> This binding was updated, so you need:
>
> 				compatible = "fixed-partitions";

This has been fixed in mips-linux here: 
http://patchwork.linux-mips.org/patch/11914/

Thanks,

Harvey

>
> Brian
>
>> +
>> +				partition@0 {
>> +					label = "u-boot-spl";
>> +					reg = <0x0 0x0 0x0 0x800000>;
>> +				};
>> +
>> +				partition@0x800000 {
>> +					label = "u-boot";
>> +					reg = <0x0 0x800000 0x0 0x200000>;
>> +				};
>> +
>> +				partition@0xa00000 {
>> +					label = "u-boot-env";
>> +					reg = <0x0 0xa00000 0x0 0x200000>;
>> +				};
>> +
>> +				partition@0xc00000 {
>> +					label = "boot";
>> +					reg = <0x0 0xc00000 0x0 0x4000000>;
>> +				};
>> +
>> +				partition@0x8c00000 {
>> +					label = "system";
>> +					reg = <0x0 0x4c00000 0x1 0xfb400000>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&bch {
>> +	status = "okay";
>> +};
>
> Brian
>
