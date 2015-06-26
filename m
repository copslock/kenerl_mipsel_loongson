Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2015 15:54:50 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33445 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009051AbbFZNyrhLCAa convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jun 2015 15:54:47 +0200
Received: by pdjn11 with SMTP id n11so75673790pdj.0;
        Fri, 26 Jun 2015 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=++i7Nc/hO9zntseZB8EtFTUeMSTBeDCztzOphDTk+Ik=;
        b=gPa06bTCKcTeALmyWohv183adu8l0GEJtNY2ScOef7VnYljOD5qvLXR+Kz6uymz9qD
         RvClP/sa/cpeFC2c7s8XCctlYn/mYZq8hsCSoVhhL4M2weyLvoeZv30GvSlW7Cl/RiHe
         VFA/t6m8Y99paPKuNfk0kklY2XcoEEn0h+n7Q/aicuxTLrj4E4cB+GSWM1iOT+Ij7xZn
         G/CXhLSbvA97gTTA/n2h8z9RSMfzXph9Ob7W2W0b+UT2D0NQgbo2p5/FOmZtrK/1YNca
         nSdqhBzbKyj3pOj7XBCjeFnf2+ctgkZBMMZ4v3t0wA7/nC1FgGxlmBR+I0KcIGUzTcb/
         yMoQ==
X-Received: by 10.66.100.233 with SMTP id fb9mr3613460pab.128.1435326881498;
        Fri, 26 Jun 2015 06:54:41 -0700 (PDT)
Received: from [192.168.0.104] ([59.12.167.210])
        by mx.google.com with ESMTPSA id vl1sm33639634pab.21.2015.06.26.06.54.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 06:54:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 1/4] MIPS: BMIPS: bcm7346: add nodes for NAND
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <558CC050.6040101@gmail.com>
Date:   Fri, 26 Jun 2015 22:54:35 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, computersforpeace@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D85A0C84-46BA-4F77-9A90-DE21EBED1887@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com> <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com> <558B05B7.8010401@gmail.com> <EFAFA0BE-CC2F-4342-9C89-DED8EC6CF377@gmail.com> <558CC050.6040101@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.2102)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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


> On Jun 26, 2015, at 12:00 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> Le 06/25/15 01:52, Jaedon Shin a écrit :
>> 
>>> On Jun 25, 2015, at 4:32 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> 
>>> +Brian,
>>> 
>>> On 23/06/15 23:08, Jaedon Shin wrote:
>>>> Add NAND device nodes to BMIPS based BCM7346 platform.
>>>> 
>>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>>> ---
>>> 
>>> [snip]
>>> 
>>>> +
>>>> +&nand0 {
>>>> +	status = "okay";
>>>> +
>>>> +	nandcs@1 {
>>>> +		compatible = "brcm,nandcs";
>>>> +		reg = <1>;
>>>> +		nand-ecc-step-size = <512>;
>>>> +		nand-ecc-strength = <8>;
>>>> +		nand-on-flash-bbt;
>>>> +
>>>> +		#size-cells = <2>;
>>>> +		#address-cells = <2>;
>>>> +
>>>> +		flash1.rootfs0@0 {
>>>> +			reg = <0x0 0x0 0x0 0x80000000>;
>>>> +		};
>>>> +
>>>> +		flash1.rootfs1@80000000 {
>>>> +			reg = <0x0 0x80000000 0x0 0x80000000>;
>>>> +		};
>>>> +	};
>>>> +};
>>> 
>>> Should we create something like brcmnand-cs1-512-8 to reduce the amount
>>> of duplication between DTS files?
>>> -- 
>>> Florian
>> 
>> I Think that is not duplication.
>> 
>> I have no reference boards, but this node is maybe explaining for hardware
>> description of the BCM97346DBSMB reference board. The nodes are changed by
>> EBI CS and ECC capabilities of NAND flash. I used brcmnand-cs2-512-4 and
>> brcmnand-cs1-512-4 for others.
> 

The *others* means BCM7346 based set-top box of manufacturer. they are not
bcm973XX{dbsmb,svmb} boards.

> Then I am confused, your 4 patches add identical NAND flash chip
> properties for 7346, 7358, 7360 and 7362: CS#1, 512 bytes of ECC step
> size and 8 bits of ECC strength, am I missing something?
> -- 
> Florian

The mips based reference boards have postfix of DBSMB, SVMB, SFF and others.
they have different properties of DDR, #CS, SPI-NOR, NOR, NAND. if we write
the DT of bcm97346sff.dts, therefore it has different fields.

Then I expected that mips 40nm based SVMB type reference boards have the same
properties. but, I don't have confidence. AISE I have no reference boards
unfortunately. if you can contact with people who have reference board, would
tell me information of #CS and NAND. 
From f.fainelli@gmail.com Fri Jun 26 18:34:16 2015
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2015 18:34:18 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34879 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009162AbbFZQeQgo530 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2015 18:34:16 +0200
Received: by pdbci14 with SMTP id ci14so77885021pdb.2;
        Fri, 26 Jun 2015 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YN9mvI/QpL6W3C1xuQY2Ig8kyV5aEUWPGLiamGWKM1w=;
        b=i5ag9SEldSZafsw2/yeWye7GoLeSLotgrkSoyg+UPU+RkEW0/BJ8S21be1OT2WUto4
         0DdpuGS1+f+W7IizBq7mBg9Ksme6BT258Q6yTKGpU/eJP7BbE9Yy4S8VhSMBm8+2XIfG
         rSxp1JmEuPO1KmaDwNRyNeNV0UpC4rULY0DmsgdQ+1aARX3iLY5aXFaeLBvc3ZzqpLTG
         n4HBlw1mc1s3Hs3C//zX9yqKFQL7tjQ+697gPu4ISUU9f8/9dwjuciqZyAvkclRmo2YV
         mqDgpRq6uccv5pgU+AhQQBQf76+8RtHQk7Z1VXO1RouRlcoAfqrjcmLHk0br+6jmskRa
         N3Hw==
X-Received: by 10.67.30.136 with SMTP id ke8mr4958612pad.79.1435336450410;
        Fri, 26 Jun 2015 09:34:10 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id fp3sm33900348pdb.52.2015.06.26.09.34.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2015 09:34:09 -0700 (PDT)
Message-ID: <558D7EA5.9030202@gmail.com>
Date:   Fri, 26 Jun 2015 09:32:37 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, computersforpeace@gmail.com
Subject: Re: [PATCH 1/4] MIPS: BMIPS: bcm7346: add nodes for NAND
References: <cover.1435124524.git.jaedon.shin@gmail.com> <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com> <558B05B7.8010401@gmail.com> <EFAFA0BE-CC2F-4342-9C89-DED8EC6CF377@gmail.com> <558CC050.6040101@gmail.com> <D85A0C84-46BA-4F77-9A90-DE21EBED1887@gmail.com>
In-Reply-To: <D85A0C84-46BA-4F77-9A90-DE21EBED1887@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48036
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
Content-Length: 2788
Lines: 87

On 26/06/15 06:54, Jaedon Shin wrote:
> 
>> On Jun 26, 2015, at 12:00 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Le 06/25/15 01:52, Jaedon Shin a écrit :
>>>
>>>> On Jun 25, 2015, at 4:32 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>> +Brian,
>>>>
>>>> On 23/06/15 23:08, Jaedon Shin wrote:
>>>>> Add NAND device nodes to BMIPS based BCM7346 platform.
>>>>>
>>>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>>>> ---
>>>>
>>>> [snip]
>>>>
>>>>> +
>>>>> +&nand0 {
>>>>> +	status = "okay";
>>>>> +
>>>>> +	nandcs@1 {
>>>>> +		compatible = "brcm,nandcs";
>>>>> +		reg = <1>;
>>>>> +		nand-ecc-step-size = <512>;
>>>>> +		nand-ecc-strength = <8>;
>>>>> +		nand-on-flash-bbt;
>>>>> +
>>>>> +		#size-cells = <2>;
>>>>> +		#address-cells = <2>;
>>>>> +
>>>>> +		flash1.rootfs0@0 {
>>>>> +			reg = <0x0 0x0 0x0 0x80000000>;
>>>>> +		};
>>>>> +
>>>>> +		flash1.rootfs1@80000000 {
>>>>> +			reg = <0x0 0x80000000 0x0 0x80000000>;
>>>>> +		};
>>>>> +	};
>>>>> +};
>>>>
>>>> Should we create something like brcmnand-cs1-512-8 to reduce the amount
>>>> of duplication between DTS files?
>>>> -- 
>>>> Florian
>>>
>>> I Think that is not duplication.
>>>
>>> I have no reference boards, but this node is maybe explaining for hardware
>>> description of the BCM97346DBSMB reference board. The nodes are changed by
>>> EBI CS and ECC capabilities of NAND flash. I used brcmnand-cs2-512-4 and
>>> brcmnand-cs1-512-4 for others.
>>
> 
> The *others* means BCM7346 based set-top box of manufacturer. they are not
> bcm973XX{dbsmb,svmb} boards.

Understood.

> 
>> Then I am confused, your 4 patches add identical NAND flash chip
>> properties for 7346, 7358, 7360 and 7362: CS#1, 512 bytes of ECC step
>> size and 8 bits of ECC strength, am I missing something?
>> -- 
>> Florian
> 
> The mips based reference boards have postfix of DBSMB, SVMB, SFF and others.
> they have different properties of DDR, #CS, SPI-NOR, NOR, NAND. if we write
> the DT of bcm97346sff.dts, therefore it has different fields.
> 
> Then I expected that mips 40nm based SVMB type reference boards have the same
> properties. but, I don't have confidence. AISE I have no reference boards
> unfortunately. if you can contact with people who have reference board, would
> tell me information of #CS and NAND.

I agree with you that outside of reference boards, these flash settings
will vary, however, Broadcom reference boards tend to follow the same
design from one chip/board to another, so instead of replicating 4 times
the same DT snippet in Device Tree, we could come up with differerent
sets of include files which abstract commonly found NAND flash types and
properties. Code might talk better, so I will try to submit something
that illustrates what I have in mind.

Thanks!
-- 
Florian
