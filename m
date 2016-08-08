Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 00:35:47 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34297 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992481AbcHHWfkovitf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 00:35:40 +0200
Received: by mail-pf0-f194.google.com with SMTP id g202so25783828pfb.1;
        Mon, 08 Aug 2016 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yG4UvfxTahgNMnyi3TIlwYEKin0zVsNMF22jImofE5M=;
        b=loeGDee2hrY0ZPSI7BM8NeohvgnEkHD7xGQuDuYYLN7riN4OOpJtf6H89h9CDfRvQM
         nW/PpKYsG9h7aOx4YLir7OJJ8tXIWzw++sRAcqRh9+m+6a8mETQc0RQQTPpquhdjJuH3
         CXMWDiF9mAszOQ3Z/I46X3lKuIInjy3H19CyatiBGEQlldzwFp4dek5Ld8fvF/830xJT
         DK6bFM1zpCxC+upX9lDr0UvjACmmrvisdmOvobeFs98IngUTjWT6XKna5AC8RDJ9kavF
         DUEZuOrVx+DRX8ogZaqZLQclqplS8o0tI1ZNoXF+ODsPe9ZLjU9See+TqnGoTKxSi/nd
         Gn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yG4UvfxTahgNMnyi3TIlwYEKin0zVsNMF22jImofE5M=;
        b=kHCUgXGIWfH9ItJ3ad29KGLTCe/hjZISYgquTkYKsBwx/6Ur8qfEK8XT+TUqIJx/bK
         qHJS2OYTO8YpHhCZjEckA3fXTQxxVnYUuOUy/FAtlyknRW3oO4AREDECVMhodySpZxMx
         jFIWiyZcQaP4efWks1gHRK2c6yc+//Sj10fCyZAyJD5aPniB9mUJrBouedPRRCcSsKmn
         rd0gWie4DGQKbvXMSgA6iKPIjEcKGeF3b4qUa3LMsUEAYQPDikYplMH3yw/3kbJ18BEC
         zJx9JC80IPdU7nb/Nj7EniDwv3CeCv55IIabWnZASNlmlUdYdBOJ+UUGjn5kByofP78T
         6L9w==
X-Gm-Message-State: AEkoousdRVOtW/Yh94DW95e6hyxGzdvLrQKWQhO2wjoknFTaA2Yq23ETrLr7pEY9Ycad/A==
X-Received: by 10.98.86.154 with SMTP id h26mr166536408pfj.22.1470695734733;
        Mon, 08 Aug 2016 15:35:34 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id g13sm50496338pfb.7.2016.08.08.15.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 15:35:33 -0700 (PDT)
Subject: Re: [PATCH 4/4] MIPS: BMIPS: Add support NAND device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com>
 <20160808021719.4680-5-jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bbc4731f-7d67-435b-0249-c823b8d158bb@gmail.com>
Date:   Mon, 8 Aug 2016 15:35:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160808021719.4680-5-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54426
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

On 08/07/2016 07:17 PM, Jaedon Shin wrote:
> Adds NAND device nodes to BCM7xxx MIPS based SoCs.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm7125.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7346.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7358.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7360.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7362.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7420.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7425.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7435.dtsi               | 20 ++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi | 24 ++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97420c.dts              |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  5 +++++
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  5 +++++
>  17 files changed, 224 insertions(+)
>  create mode 100644 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi
> 
> diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
> index 746ed06c85de..8642631a8451 100644
> --- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
> @@ -226,5 +226,25 @@
>  			interrupts = <61>;
>  			status = "disabled";
>  		};
> +
> +		hif_l2_intc: hif_l2_intc@411000 {
> +			compatible = "brcm,l2-intc";
> +			reg = <0x411000 0x30>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <0>;
> +		};
> +
> +		nand: nand@412800 {
> +			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg-names = "nand";
> +			reg = <0x412800 0x400>;
> +			interrupt-parent = <&hif_l2_intc>;
> +			interrupts = <24>;
> +			status = "disabled";
> +		};

This is a NAND v3.3 controller here not a v5.0 and it uses the EDU
registers for DMA transfers which is not supported in the mainline
driver, so with that dropped, the series looks fine. At any rate this
would require additional brcmnand changes to be supported.
-- 
Florian
