Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 00:40:48 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36384 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992481AbcHHWklYauwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 00:40:41 +0200
Received: by mail-pa0-f68.google.com with SMTP id ez1so24675877pab.3;
        Mon, 08 Aug 2016 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=I3hhdN06/tqI/FT0cLemYz/xmhqYe8aGYxO6BClNpxY=;
        b=NpVXPGVNCwrevoKX+VtizCZUqAgu1X4eAGS3nGRFiYgOO6vFGhrbVd3atf8bT1+fBE
         29Zhs+U9vdWzviKLUPYqBbqjmLGpEcgLtrvfbzB+x5sevyHZYuTujZYLgeaIutDBrqnF
         XiIM5qdM0fQg+8KkIWthEVlxREq4ZeNAvugEKXBg+yko26JGk/39O2F4zhnOgMIjjyWX
         +CksK2WU5FE7oHlgVGF503GWYvQ0zwg0IPK7VqKnFFRVknojc2xyitAjGmb9umZE21UP
         eBNdXt+qNY+RTEmHURSasQhpbSVSx9uoO8p1wfG2HJpyOt2WDyy+Ov9FkxINeVCesPFN
         9oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I3hhdN06/tqI/FT0cLemYz/xmhqYe8aGYxO6BClNpxY=;
        b=lH9Y/E/QGKU0kK3U26upOr9/M402Z+4vqrEe5yZGjrrpHpqajiRxuDoLERYwUOH7hM
         1hehOHGQlwnWF/keOoBlgHgx8aY14uLgt1Q+GcMknxO5Duj7GGDgwzOpW40RWLOtxN5m
         MSLvvU6sFRb17zPknty+UUm4+n9k4S83gWgdCYMYJslbZV+SbmNcJ+eY9uEwm0xNpWEn
         JopOTtI9qjU2vMHBXPoXSZ0lUUtQHMX7XPiodvrDU8EGaXC5vey6yUYXqrRvdkRKuaA/
         0htR6fn6y96UTY4s+owsVkyI4NfVm1AzjcA+xHzYGqCuG+tYJ/+bBx0AA539O7rc4qFd
         zqmw==
X-Gm-Message-State: AEkoouv5MEUra+LdcLMepr9mA0mtTnkNTGifH+6UG43dX3pugbLSHvHrb+eaMbfurQD6yw==
X-Received: by 10.66.222.202 with SMTP id qo10mr165822392pac.76.1470696035365;
        Mon, 08 Aug 2016 15:40:35 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id x66sm50497118pfb.86.2016.08.08.15.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 15:40:34 -0700 (PDT)
Subject: Re: [PATCH 4/4] MIPS: BMIPS: Add support NAND device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com>
 <20160808021719.4680-5-jaedon.shin@gmail.com>
 <bbc4731f-7d67-435b-0249-c823b8d158bb@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b6df94ac-9e29-f52d-c44e-f096a8735901@gmail.com>
Date:   Mon, 8 Aug 2016 15:40:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <bbc4731f-7d67-435b-0249-c823b8d158bb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54427
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

On 08/08/2016 03:35 PM, Florian Fainelli wrote:
> On 08/07/2016 07:17 PM, Jaedon Shin wrote:
>> Adds NAND device nodes to BCM7xxx MIPS based SoCs.
>>
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>>  arch/mips/boot/dts/brcm/bcm7125.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7346.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7358.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7360.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7362.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7420.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7425.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7435.dtsi               | 20 ++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi | 24 ++++++++++++++++++++++
>>  arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97420c.dts              |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  5 +++++
>>  arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  5 +++++
>>  17 files changed, 224 insertions(+)
>>  create mode 100644 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi
>>
>> diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> index 746ed06c85de..8642631a8451 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> @@ -226,5 +226,25 @@
>>  			interrupts = <61>;
>>  			status = "disabled";
>>  		};
>> +
>> +		hif_l2_intc: hif_l2_intc@411000 {
>> +			compatible = "brcm,l2-intc";
>> +			reg = <0x411000 0x30>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +			interrupt-parent = <&periph_intc>;
>> +			interrupts = <0>;
>> +		};
>> +
>> +		nand: nand@412800 {
>> +			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg-names = "nand";
>> +			reg = <0x412800 0x400>;
>> +			interrupt-parent = <&hif_l2_intc>;
>> +			interrupts = <24>;
>> +			status = "disabled";
>> +		};
> 
> This is a NAND v3.3 controller here not a v5.0 and it uses the EDU
> registers for DMA transfers which is not supported in the mainline
> driver, so with that dropped, the series looks fine. At any rate this
> would require additional brcmnand changes to be supported.

The same applies to the 7420 DTS, it's also a v3.3 NAND controller
-- 
Florian
