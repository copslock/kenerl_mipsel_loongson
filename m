Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 19:40:52 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:46278
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdK1SkoPcgqi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 19:40:44 +0100
Received: by mail-qt0-x244.google.com with SMTP id r39so1089321qtr.13;
        Tue, 28 Nov 2017 10:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dKW5Eh0uwLv8fkakNuGUIllDyIsV1d+zPFlIsnZ+Tn0=;
        b=JD5TWP8oE31uWqwOkc4ONUOaY6FTy2v3re/VZNtpb91pGG16Cru2a40UzqJOsrmT5m
         Su6vBD3gpa1hhe976UjBHbxUT6ejuAzS7z0VvMZ3gGVj5vPAD7ueJB+fI4saWtdRfg/E
         I1xCJ2N2szlLlAUyNnLAyH/O94EviQKk0edPOeOrCs7p5HMBMetySH7Z1lZkH/WpMsRr
         45ZnUDg+4R/ppWCQh+Gj6bu7XxGztUBV9dtu6BTUJsXaco45oIljzxt/CeBQnlon1q2y
         YA5OM92eSUp9y1F3LLLu3uszjq9s3cXjqswc0VF5BLCDwcRaRCeVnMt/kXCv4KMHrue2
         Mpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dKW5Eh0uwLv8fkakNuGUIllDyIsV1d+zPFlIsnZ+Tn0=;
        b=GcaUybX7iW1O58AC90uxR+ffFAWwOADLcv24p+uVUM2G3zbnCHr9ahHgM7Ejv7X5C/
         /kO1clsRZqbMQB6Fn3YeE9q7tF9WKojk02wgXjjYkQlXUuxQ2fUJXoJNgdaSALD3LpEe
         kKOBIzbAkuO8qJG35SXA7Lnsq2yCOA/IhP+Rt3sY2DDWhraEqNKI3IAqT3pur+Ed8F2K
         8ZKginSZbRXCCYWNHn5+c5JGaIgsBreOnP7bWCF/xhtrylliclpJ5OG1Z+L4Sm9lPQ7w
         yoZyI3dJXr/u0RuPEA2/c2bsSE4PXTxdTgvr1C2FVjBDG9BuGQ39OcexeijlpjBhO4qb
         TKpQ==
X-Gm-Message-State: AJaThX6RIMuGd6jfnnDDepJj/lvD20ZsMiUo+HmPvrusAHJ0iednLukh
        OMaTmy71neyzIyZMsCBlaJo=
X-Google-Smtp-Source: AGs4zMZNuuubxYW+gctfcDb9Yy0XW2Faeib882xAFWfqx13IQXek/2dYZ7OcefsO+ymEXffb9uAOUA==
X-Received: by 10.200.45.168 with SMTP id p37mr156036qta.247.1511894437547;
        Tue, 28 Nov 2017 10:40:37 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id d205sm21703522qke.21.2017.11.28.10.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 10:40:36 -0800 (PST)
Subject: Re: [PATCH 10/13] MIPS: mscc: add ocelot dtsi
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-11-alexandre.belloni@free-electrons.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0596b316-f3a3-6d06-75f4-acad4fde3b5f@gmail.com>
Date:   Tue, 28 Nov 2017 10:40:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171128152643.20463-11-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61161
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

On 11/28/2017 07:26 AM, Alexandre Belloni wrote:
> Add a device tree include file for the Microsemi Ocelot SoC.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

> +	ahb {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

You could provide the base address and size of the bus range, such that
your nodes all become relative to that base address, e.g:

		ranges = <0 0x70000000 0x10000>;

What a strange physical address to place registers on a MIPS system
though...

> +
> +		interrupt-parent = <&intc>;
> +
> +		cpu_ctrl: syscon@70000000 {
> +			compatible = "syscon";
> +			reg = <0x70000000 0x2c>;
> +		};

Then this becomes:

		syscon@0 {
			compatible = "syscon";
			reg = <0x0 0x2c>;
		};

etc.

> +
> +		intc: interrupt-controller@70000070 {
> +			compatible = "mscc,ocelot-icpu-intr";
> +			reg = <0x70000070 0x70>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupt-parent = <&cpuintc>;
> +			interrupts = <2>;
> +		};
> +
> +		uart0: serial@70100000 {
> +			pinctrl-0 = <&uart_pins>;
> +			pinctrl-names = "default";
> +			compatible = "ns16550a";
> +			reg = <0x70100000 0x20>;
> +			interrupts = <6>;
> +			clocks = <&ahb_clk>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@70100800 {
> +			pinctrl-0 = <&uart2_pins>;
> +			pinctrl-names = "default";
> +			compatible = "ns16550a";
> +			reg = <0x70100800 0x20>;
> +			interrupts = <7>;
> +			clocks = <&ahb_clk>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +
> +			status = "disabled";
> +		};
> +
> +		chip_regs: syscon@71070000 {
> +			compatible = "simple-mfd", "syscon";
> +			reg = <0x71070000 0x1c>;
> +
> +			reset {
> +				compatible = "mscc,ocelot-chip-reset";
> +				mscc,cpucontrol = <&cpu_ctrl>;
> +			};
> +		};
> +
> +		gpio: pinctrl@71070034 {
> +			compatible = "mscc,ocelot-pinctrl";
> +			reg = <0x71070034 0x28>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&gpio 0 0 22>;
> +
> +			uart_pins: uart-pins {
> +				pins = "GPIO_6", "GPIO_7";
> +				function = "uart";
> +			};
> +
> +			uart2_pins: uart2-pins {
> +				pins = "GPIO_12", "GPIO_13";
> +				function = "uart2";
> +			};
> +		};
> +	};
> +};
> 


-- 
Florian
