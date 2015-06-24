Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 21:33:48 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33909 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006583AbbFXTdqfuNBd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 21:33:46 +0200
Received: by pdbep18 with SMTP id ep18so14951383pdb.1;
        Wed, 24 Jun 2015 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6roA4JwMyg+P/1O/2IuZRgjCkV/fJmdglYG06Uazqpw=;
        b=aONWhJa55sNOOwTZfxc3vQOkKhLHDzODQaYXMiu2Rh4qYL4Z1twlRqDaIjfXmcET4p
         7R7GrWySr+tjQF7gfZxsZLqUIAWs9WdMrNfrK4tQhUct4LNZasFZQbrDP1ZCv2gGZ2VI
         +6pSnASZwy4gGSEXoeE1eBGGj5Kum8YRAmEq21YB6hWqDnVDiMIH6xUn4gpJOfn9Ku28
         6jeCP9jkSQvysG11icXP/gEtcZDv99JePmRRSPDP+pBMXaNNcgNz4PFmykppjXY7G8Qa
         QDV+sPH8y+jRNAI7YMUEwkqi/m4UeBq0zTyfWQfXhaTQ3+uDtvpWVbe6X+H1j+LBwAvr
         u9qg==
X-Received: by 10.68.142.42 with SMTP id rt10mr82936347pbb.27.1435174420301;
        Wed, 24 Jun 2015 12:33:40 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id zx1sm27553801pbb.73.2015.06.24.12.33.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 12:33:39 -0700 (PDT)
Message-ID: <558B05B7.8010401@gmail.com>
Date:   Wed, 24 Jun 2015 12:32:07 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, computersforpeace@gmail.com
Subject: Re: [PATCH 1/4] MIPS: BMIPS: bcm7346: add nodes for NAND
References: <cover.1435124524.git.jaedon.shin@gmail.com> <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com>
In-Reply-To: <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48025
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

+Brian,

On 23/06/15 23:08, Jaedon Shin wrote:
> Add NAND device nodes to BMIPS based BCM7346 platform.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---

[snip]

> +
> +&nand0 {
> +	status = "okay";
> +
> +	nandcs@1 {
> +		compatible = "brcm,nandcs";
> +		reg = <1>;
> +		nand-ecc-step-size = <512>;
> +		nand-ecc-strength = <8>;
> +		nand-on-flash-bbt;
> +
> +		#size-cells = <2>;
> +		#address-cells = <2>;
> +
> +		flash1.rootfs0@0 {
> +			reg = <0x0 0x0 0x0 0x80000000>;
> +		};
> +
> +		flash1.rootfs1@80000000 {
> +			reg = <0x0 0x80000000 0x0 0x80000000>;
> +		};
> +	};
> +};

Should we create something like brcmnand-cs1-512-8 to reduce the amount
of duplication between DTS files?
-- 
Florian
