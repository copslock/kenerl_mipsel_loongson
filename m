Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 12:51:52 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35669 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992970AbcHPKvpYi0va convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 12:51:45 +0200
Received: by mail-pf0-f196.google.com with SMTP id h186so5314546pfg.2;
        Tue, 16 Aug 2016 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gLxypnG6IRR5+McOMf7f2GbZkyTUbxYZ6vBcgwFu5Yg=;
        b=ZejFu2QWDy6lB+dAHJT9DB5TQCACHMJFb8q8TTp/rdRybdf/hStHt+EDg4dQG3d85P
         DZYt87CRRg6Iy9Vm3ZlMyliODi31wauiHjWprenQOtwyTAHFrz0HHH2oWeX+8oNDOnzl
         GO5X8FkvFiVexZ3eAkmh1mjAdjR0kZw/ZpS7KT+PtIZ3Qfz276mX3kL9mMFaH/XD+Yq0
         PStZr12AEkMRtknLnMCB63e0bIWbQfoi2DH792im5rVDhE88VsoD7Yb094KyG6M69Icv
         hbFw+Jui1Is32oJ2YmPLT4eeCvDa3PiQ4mA5sr93oWAGsBEDBdUQL8n/jMH8g0I3FYwb
         f5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gLxypnG6IRR5+McOMf7f2GbZkyTUbxYZ6vBcgwFu5Yg=;
        b=LXaDlR550vWrdYPwY/2SerS2x3q+y9q4LCdbI8McM532mWfAJ9dj+3PlIV9iGuxTKx
         Q8/zanmUj/iPO46omObSEYRJ/mCnZVlBC3s1cDAKzyxYh4GjFW3B3Sxx34E2SqYnUPGR
         vsGvkE+Sbl3jyUNTPgZYnnFta5QbCNKCUPPJN/iplTEfzFY5naiC819FdQqaNbOQAkgQ
         FqS79fGUP4YCWa6kt9ZSJOiDDV4wy9Mp0heYWzaVgV0xyJCHI9bLZrad7C7v5kDHoA3A
         w/jVnberFm3684UwZJcA5KduwGPyTb5yfzFRPBv3qtF20usp/wcXKSrrwQs6CNBfvfaG
         VZsQ==
X-Gm-Message-State: AEkoouu0zOfK+qrfzFaFlcyYaICPHAwjlrA0iKL0bXoWg669Ja0Xy/aqEWgD59kvHluvFQ==
X-Received: by 10.98.102.221 with SMTP id s90mr62877323pfj.69.1471344698771;
        Tue, 16 Aug 2016 03:51:38 -0700 (PDT)
Received: from [172.16.1.101] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id fj19sm38341629pab.37.2016.08.16.03.51.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Aug 2016 03:51:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [v3 4/5] MIPS: BMIPS: Add support NAND device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <947152ab-0a28-365d-4fd9-eb84cdfd2147@gmail.com>
Date:   Tue, 16 Aug 2016 19:51:34 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <89CBA8CF-E399-4CA1-9493-E9310A978CC6@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com> <20160812085231.53290-5-jaedon.shin@gmail.com> <947152ab-0a28-365d-4fd9-eb84cdfd2147@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54567
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

Hi Florian,

On Aug 13, 2016, at 8:17 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 08/12/2016 01:52 AM, Jaedon Shin wrote:
>> Adds NAND device nodes to BCM7xxx MIPS based SoCs.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
> 
> I did not check all the reference boards, but for 7425 and 7435 here is
> what you should have:
> 
>> diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
>> index 1c6b74daef56..3b917cac7efe 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
>> @@ -1,6 +1,7 @@
>> /dts-v1/;
>> 
>> /include/ "bcm7425.dtsi"
>> +/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
>> 
>> / {
>> 	compatible = "brcm,bcm97425svmb", "brcm,bcm7425";
>> @@ -95,6 +96,10 @@
>> 	status = "okay";
>> };
>> 
>> +&nand {
>> +	status = "okay";
>> +};
> 
> Here are the correct properties for our BCM97425SVMB board:
> 
> &nand {
>        status = "okay";
> 
>        nandcs@1 {
>                #size-cells = <0x2>;
>                #address-cells = <0x2>;
>                compatible = "brcm,nandcs";
>                reg = <0x1>;
>                nand-on-flash-bbt;
> 
>                nand-ecc-strength = <24>;
>                nand-ecc-step-size = <1024>;
>                brcm,nand-oob-sector-size = <27>;
> 
>> +
>> &sdhci0 {
>> 	status = "okay";
>> };
>> diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>> index 64bb1988dbc8..54351e54ff68 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>> @@ -1,6 +1,7 @@
>> /dts-v1/;
>> 
>> /include/ "bcm7435.dtsi"
>> +/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
> 
> And here are those for the BCM97435SVMB:
> 
> &nand {
>        status = "okay";
> 
>        nandcs@1 {
>                #size-cells = <0x2>;
>                #address-cells = <0x2>;
>                compatible = "brcm,nandcs";
>                reg = <0x1>;
>                nand-on-flash-bbt;
> 
>                nand-ecc-strength = <24>;
>                nand-ecc-step-size = <1024>;
>                brcm,nand-oob-sector-size = <27>;
> 
> -- 
> Florian

I found sample boot logs on CFE.

BCM7346, BCM7425 and BCM7435 have 32Gb (MT29F32G08CBCA) or 16Gb NAND flash, this is
  nand-ecc-strength = <24>;
  nand-ecc-step-size = <1024>;
  brcm,nand-oob-sector-size = <27>;

BCM7358 and BCM7362 have 8Gb(MT29F8G08ABABA) or 2Gb NAND flash, this is
  nand-ecc-strength = <4>;
  nand-ecc-step-size = <512>;
  brcm,nand-oob-sector-size = <16>;

BCM7360 hasn't NAND flash.

So, I will split into two files like bellow,
  bcm97xxx-nand-cs1-bch24.dtsi
  bcm97xxx-nand-cs1-bch4.dtsi

Please let me know if you have better way.

Thanks,
Jaedon
