Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2015 05:00:45 +0200 (CEST)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36223 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006509AbbFZDAkfHks7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2015 05:00:40 +0200
Received: by obctg8 with SMTP id tg8so59129110obc.3;
        Thu, 25 Jun 2015 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EtTk4KRZR59DNWWDsb1g1gRT0U5Gg1xKYGzlUE574yk=;
        b=W3WlvS6o5wemO7Iv7m1o1lIVoWxO7N0qiz/Xpo6MZIrY++u4Fas8nnYJCWBat0d0rE
         XI6VhZIFReCc70hvOzcCrG65AzHEj5vqmr/viXMDX4IhEbABKcYlJHVFh6dR6jyxVe/N
         3pjpNtm2N+KzFModykctssaHHdT6Yi5dvjew3XDtL9YD563Y8DnbDpv7rHmbVT+BoYbZ
         rKkDAlwuFFsww0P26WQUGlezLS4Ov4LwK/iBTTpF64oYjEDin64TgXr5i7dQrBijdx+e
         UwIN0ZZlheOVV087EQNc+3fK8wvFIL3Ouxv7LYg4Ildy1ggWj0M5KLSZH4ic1IBISyr0
         F1mQ==
X-Received: by 10.60.84.42 with SMTP id v10mr5102218oey.43.1435287634612;
        Thu, 25 Jun 2015 20:00:34 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:7deb:fc0b:8933:b67c? ([2001:470:d:73f:7deb:fc0b:8933:b67c])
        by mx.google.com with ESMTPSA id f3sm17034799obm.18.2015.06.25.20.00.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 20:00:33 -0700 (PDT)
Message-ID: <558CC050.6040101@gmail.com>
Date:   Thu, 25 Jun 2015 20:00:32 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, computersforpeace@gmail.com
Subject: Re: [PATCH 1/4] MIPS: BMIPS: bcm7346: add nodes for NAND
References: <cover.1435124524.git.jaedon.shin@gmail.com> <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com> <558B05B7.8010401@gmail.com> <EFAFA0BE-CC2F-4342-9C89-DED8EC6CF377@gmail.com>
In-Reply-To: <EFAFA0BE-CC2F-4342-9C89-DED8EC6CF377@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 06/25/15 01:52, Jaedon Shin a écrit :
> 
>> On Jun 25, 2015, at 4:32 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> +Brian,
>>
>> On 23/06/15 23:08, Jaedon Shin wrote:
>>> Add NAND device nodes to BMIPS based BCM7346 platform.
>>>
>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>> ---
>>
>> [snip]
>>
>>> +
>>> +&nand0 {
>>> +	status = "okay";
>>> +
>>> +	nandcs@1 {
>>> +		compatible = "brcm,nandcs";
>>> +		reg = <1>;
>>> +		nand-ecc-step-size = <512>;
>>> +		nand-ecc-strength = <8>;
>>> +		nand-on-flash-bbt;
>>> +
>>> +		#size-cells = <2>;
>>> +		#address-cells = <2>;
>>> +
>>> +		flash1.rootfs0@0 {
>>> +			reg = <0x0 0x0 0x0 0x80000000>;
>>> +		};
>>> +
>>> +		flash1.rootfs1@80000000 {
>>> +			reg = <0x0 0x80000000 0x0 0x80000000>;
>>> +		};
>>> +	};
>>> +};
>>
>> Should we create something like brcmnand-cs1-512-8 to reduce the amount
>> of duplication between DTS files?
>> -- 
>> Florian
> 
> I Think that is not duplication.
> 
> I have no reference boards, but this node is maybe explaining for hardware
> description of the BCM97346DBSMB reference board. The nodes are changed by
> EBI CS and ECC capabilities of NAND flash. I used brcmnand-cs2-512-4 and
> brcmnand-cs1-512-4 for others.

Then I am confused, your 4 patches add identical NAND flash chip
properties for 7346, 7358, 7360 and 7362: CS#1, 512 bytes of ECC step
size and 8 bits of ECC strength, am I missing something?
-- 
Florian
