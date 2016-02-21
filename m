Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2016 12:28:02 +0100 (CET)
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38614 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007427AbcBUL2ArtPP5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Feb 2016 12:28:00 +0100
Received: by mail-wm0-f42.google.com with SMTP id a4so126715933wme.1;
        Sun, 21 Feb 2016 03:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=wWr5KG8TkWpApA6l7DA5OAzLl0o4ecI3qiovUcx32Io=;
        b=qey2HzxKKi8w78IWRXTBBmQwqDPuuZiWvwAwbGEbCTbZK9PAZXlsqvVculmqlj4l6h
         6SFk4W/y9GGsbxuIguewedVf6wF+0Pn2Nkb4qYrwePeeFB/uE9T4cyPHfWhwjMCeJcS5
         dgOWqMwYY3lN2PpDUJuUM49tENrj4DbTWjGdoCARPMkCR678IGSe23F5vDLTb3Y83axR
         Tnd5YenVV1VbbPnfyAJ3wwtTKths3X23ChViKZTAe5TO8bnVA6YR5barF73RmgV3Nuxv
         TfG4qZD5Mu7EH51cTt0VxlqBo3OPDre2jR3I13Ym+Z8JglvtDM/B5SR3Jvf4lDdgRmNi
         08/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wWr5KG8TkWpApA6l7DA5OAzLl0o4ecI3qiovUcx32Io=;
        b=Pw4Pna66B+JLpvmgTk8FLDrPchPlE+vLpj8GXy6Pa0tYUq0XKuIT9gpsQ9JCDn5l26
         k+GDKIBzuYkZ5F2aL6u3b4hCH9gY5B4zBSRXztGOk5pCet6UwPV3WMbSg0C2BZglr1Hb
         Vp1YI2rGmGU0Y2gvIgQrYtoXbRrvzQM7n2g3kQLkZH5bi4uS1FyUY7NsMcYbub3F8Sez
         J57K4uz8m34rUVx42mGYJ/6x/k3P7rJWNAG0aKMUn1B4LjOHja4RQfEfqUSja54Uo9gT
         nCiJXojOy6Q+jTegKhrG2dE1or4p/ZeKFgRF0y/15XU2uSfAxJ2t8d61jKCJCPdfUWye
         m/tA==
X-Gm-Message-State: AG10YOQf2KFWkv8q5OPnQtoHlAizlJvn6NsA+5CgHM3nfKIdSgg4CSyj3x+1tT431u/E9w==
X-Received: by 10.194.61.169 with SMTP id q9mr22214142wjr.77.1456054075589;
        Sun, 21 Feb 2016 03:27:55 -0800 (PST)
Received: from [192.168.1.10] (140.Red-83-35-232.dynamicIP.rima-tde.net. [83.35.232.140])
        by smtp.gmail.com with ESMTPSA id w66sm16051429wmd.2.2016.02.21.03.27.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Feb 2016 03:27:54 -0800 (PST)
Subject: Re: [PATCH 2/2] bmips: add device tree example for BCM6358
To:     Rob Herring <robh@kernel.org>
References: <1453030101-14794-2-git-send-email-noltari@gmail.com>
 <20160120165910.GA32520@rob-hp-laptop>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
From:   =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <56C99F38.2070709@gmail.com>
Date:   Sun, 21 Feb 2016 12:27:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160120165910.GA32520@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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


El 20/01/2016 a las 17:59, Rob Herring escribió:
> On Sun, Jan 17, 2016 at 12:28:21PM +0100, Álvaro Fernández Rojas wrote:
>> This adds a device tree example for SFR Neufbox4 (Sercomm version), which
>> also serves as a real example for brcm,bcm6358-leds.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> [...]
>
>> diff --git a/arch/mips/boot/dts/brcm/bcm6358.dtsi
> b/arch/mips/boot/dts/brcm/bcm6358.dtsi
>> new file mode 100644
>> index 0000000..b2d11da
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
>> @@ -0,0 +1,111 @@
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "brcm,bcm6358";
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		mips-hpt-frequency = <150000000>;
>> +
>> +		cpu@0 {
>> +			compatible = "brcm,bmips4350";
>> +			device_type = "cpu";
>> +			reg = <0>;
>> +		};
>> +
>> +		cpu@1 {
>> +			compatible = "brcm,bmips4350";
>> +			device_type = "cpu";
>> +			reg = <1>;
>> +		};
>> +	};
>> +
>> +	clocks {
>> +		periph_clk: periph_clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <50000000>;
>> +		};
>> +	};
>> +
>> +	aliases {
>> +		leds0 = &leds0;
> Why do we need alias for LEDs?
Okay, I will remove this, but you should know it was accepted for 
BCM6328 and BCM6368 too:
http://git.linux-mips.org/cgit/sjhill/linux-sjhill.git/commit/arch/mips/boot/dts/brcm?h=mips-for-linux-next&id=db66dbbbfd8ded204a97d090357aff582968fcf5
http://git.linux-mips.org/cgit/sjhill/linux-sjhill.git/commit/arch/mips/boot/dts/brcm?h=mips-for-linux-next&id=70ce14bfc9fdb9b6af84ac492e9d3311551618a5
>
>> +		uart0 = &uart0;
>> +		uart1 = &uart1;
>> +	};
> [...]
>
>> diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
>> new file mode 100644
>> index 0000000..ca95084
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
>> @@ -0,0 +1,47 @@
>> +/dts-v1/;
>> +
>> +/include/ "bcm6358.dtsi"
>> +
>> +/ {
>> +	compatible = "sfr,nb4-ser", "brcm,bcm6358";
>> +	model = "SFR Neufbox 4 (Sercomm)";
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x02000000>;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200";
>> +		stdout-path = &uart0;
> You shouldn't need both here. Just stdout-path.
Okay, I will use stdout-path only, but once again you should know that 
both are used on every bmips board:
https://github.com/torvalds/linux/tree/master/arch/mips/boot/dts/brcm
https://github.com/torvalds/linux/blob/master/arch/mips/boot/dts/brcm/bcm93384wvg.dts#L9
...
https://github.com/torvalds/linux/blob/master/arch/mips/boot/dts/brcm/bcm9ejtagprb.dts#L14
>
> Rob
Álvaro.
