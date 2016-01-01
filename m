Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jan 2016 08:16:29 +0100 (CET)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33664 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006601AbcAAHQ2Tt9Ic convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Jan 2016 08:16:28 +0100
Received: by mail-pf0-f179.google.com with SMTP id q63so129171720pfb.0
        for <linux-mips@linux-mips.org>; Thu, 31 Dec 2015 23:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=8/ZjlnlooYJoWTKbhvc7eHXT9jyM8bcP2nCMuS2X1FU=;
        b=oZgU3uuMyYLCGuOJlsxQRGSaqtpUVbaGiOWnnisNlei9l/k/Ld8udtvpNiLFpbbCwW
         o7YvZS5tmahJpS71m1y2+/WS8yHqJl0GyVQo8USw0bkzLzb12dVDlt2DozZbHW41RCCT
         4kUGha51HHaxUARc4tj7pvEF5QLJ8TnubOPeEiMDnLSmnMXbweKouDgkQQdoyH+3dSu9
         9DZdENMazkbz2s+7H0bWxD10xq9rb34CJhzcf90QMWzkNcl9e0JUqL+0dUMtThxJAgQL
         Tsb3FOZshM4mZ3eGd/Eu82mZ/RDG1xxHkrak2mmlZ0P8AhAQTBQEYFKxNnbVDb2Nfgq2
         L/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=8/ZjlnlooYJoWTKbhvc7eHXT9jyM8bcP2nCMuS2X1FU=;
        b=Fo2D/Iy9VFJmVfS7UZ0AKX6jlCQbS5FJQJ5ioSUPiAlMW6RYgH/JyKxQDoGTY6KICQ
         F3KPBzU2AhN776sNk9IVwLigUzYoA+NV6jAgs0upPpsudqCHhEBRtP540FTQBhe74Vlw
         b8i4XLDmSlOMBO5BWQXhpj6/GBNsyodu2Vgmws9c4/NdKu7fG5d/FiDvgkjETMdRPsDq
         7KbMlhJQyyC3AZozWved/w6CMe22p9i1eeGHdZLQmtueySo5bNSSfBHw2xJWQ15LVamM
         67PxBcWcFTsRIpRn0gie0O0r0dm8lPMec3gKOBWA1dfr5i6q0i5fRtH1bWIofU8o/jOs
         MrAQ==
X-Gm-Message-State: ALoCoQmTlPj+8HU9EYEa95EgVGB3YgtXQBKXlUYqH3oJwKkeztBTJn357DmVZWP6DDojXqycKMNGP5qKSeOOlHaiCInjBJIyzg==
X-Received: by 10.98.68.85 with SMTP id r82mr49368989pfa.143.1451632581405;
        Thu, 31 Dec 2015 23:16:21 -0800 (PST)
Received: from localhost (cpe-172-248-200-249.socal.res.rr.com. [172.248.200.249])
        by smtp.gmail.com with ESMTPSA id x3sm38866984pfi.21.2015.12.31.23.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 23:16:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Simon Arlott <simon@fire.lp0.eu>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <5669F361.60405@simon.arlott.org.uk>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "Jonas Gorski" <jogo@openwrt.org>
References: <5669F361.60405@simon.arlott.org.uk>
Message-ID: <20160101071619.7140.40854@quark.deferred.io>
User-Agent: alot/0.3.6
Subject: Re: [PATCH linux-next (v2) 1/2] clk: Add brcm,
 bcm6345-gate-clk device tree binding
Date:   Thu, 31 Dec 2015 23:16:19 -0800
Return-Path: <mturquette@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@baylibre.com
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

Hi Simon,

Quoting Simon Arlott (2015-12-10 13:49:21)
> +periph_clk: periph_clk {
> +       compatible = "brcm,bcm63168-gate-clk", "brcm,bcm6345-gate-clk";
> +       regmap = <&periph_cntl>;
> +       offset = <0x4>;
> +
> +       #clock-cells = <1>;
> +       clock-indices =
> +               <1>,          <2>,        <3>,       <4>,     <5>,
> +               <6>,          <7>,        <8>,       <9>,     <10>,
> +               <11>,         <12>,       <13>,      <14>,    <15>,
> +               <16>,         <17>,       <18>,      <19>,    <20>,
> +               <27>,         <31>;
> +       clock-output-names =
> +               "vdsl_qproc", "vdsl_afe", "vdsl",    "mips",  "wlan_ocp",
> +               "dect",       "fap0",     "fap1",    "sar",   "robosw",
> +               "pcm",        "usbd",     "usbh",    "ipsec", "spi",
> +               "hsspi",      "pcie",     "phymips", "gmac",  "nand",
> +               "tbus",       "robosw250";

Why is clock-output-names required? Because you don't have any clock
data in your driver? Or is there another reason?

FYI, I'm not a fan of clock-output-names, and prefer for the clk
consumer devices to specify the clock-names property.

Another question, is it correct that this binding requires a DT node for
every register that contains clock control bits? If so, I'm skeptical of
that approach. What if you have a clock controller IP block on a future
soc that has several registers worth of clock controls?

Regards,
Mike

> +};
> +
> +timer_clk: timer_clk {
> +       compatible = "brcm,bcm63168-gate-clk", "brcm,bcm6345-gate-clk";
> +       regmap = <&timer_cntl>;
> +       offset = <0x4>;
> +
> +       #clock-cells = <1>;
> +       clock-indices = <17>, <18>;
> +       clock-output-names = "uto_extin", "usb_ref";
> +};
> +
> +ehci0: usb@10002500 {
> +       compatible = "brcm,bcm63168-ehci", "brcm,bcm6345-ehci", "generic-ehci";
> +       reg = <0x10002500 0x100>;
> +       big-endian;
> +       interrupt-parent = <&periph_intc>;
> +       interrupts = <10>;
> +       clocks = <&periph_clk 13>, <&timer_clk 18>;
> +       phys = <&usbh>;
> +};
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
