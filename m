Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2016 23:12:27 +0100 (CET)
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34996 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbcL0WMUSC1An (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2016 23:12:20 +0100
Received: by mail-pg0-f67.google.com with SMTP id i5so13563642pgh.2;
        Tue, 27 Dec 2016 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wQUXVqeNn87Epf53NB7/NhpN3wt8tr7ixoNzDCeXm9c=;
        b=JMRQf9shNLZzvsfQsme5MJ8xvnkmp/ZuxlN97dklmlNzjNpIHM55jfQbOXrDwGsCDp
         LK17EU2SqPhCNOdfBaO+p9oR3ELFgpTRbKrTqz7VG6e9DKADx6BgRJMh0GzNxLmdktzv
         fHbObsRSRjxZlcVXUbxQjh4WOAyE/kCcHOvLXxGaVHrNyEcGOW9Xf3SfS1KNcocGhjY/
         FzXfK8I5Y/2IjrpAavE3kDqav9o4lbHXSJvQzkoQ1fWujYpFyAiv3KVuWRDtA49dx7A6
         Afeva2VxXaML27Q1tmWt8i0v76+T6CHLxFEf9Ei2RtCnaxDx6r+1TdKXi8Qljgx2Nx58
         LtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wQUXVqeNn87Epf53NB7/NhpN3wt8tr7ixoNzDCeXm9c=;
        b=GbVeexSCwQML/AF7J5UHdZ+nta5jUgs/48RecsAwdgacNNi7GCViOWlCZxxLxkfUF0
         DuCdjHfDezADTv4xv5N6y1mZqtDiYMsLrmxxexemO2rkD3CKj9rc3K/1i7iLk9Bp3FBP
         0eXsQDFmJH5JW0ewgeKtFGEw7cy0iroEPWtpESyxrtEC8WGyrCao2jIcPQ2hxOot/dB+
         1n+DjyCU6rB90+DiQCa4jvZBKdEbv5zs3xfecm7adXZ277mUpU/x1TjCdjoYPsmCY7ao
         WxpFlRVeLTG3relwPHwTQLfzw11K8kJVq1Qir67xyCv7CXilTfRixWd6OvWwk1CPWbbp
         h9KA==
X-Gm-Message-State: AIkVDXKh67PfNL2lfOLRaf/xXF0DfO2DZx0cwQZRhhVEOtpFy3hG+bJvYZ0HQnXY0gyDxg==
X-Received: by 10.99.226.3 with SMTP id q3mr62738299pgh.37.1482876734007;
        Tue, 27 Dec 2016 14:12:14 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 64sm91848991pfu.17.2016.12.27.14.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 14:12:13 -0800 (PST)
Subject: Re: [PATCH 2/2] MIPS: BMIPS: Add support SPI device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20161227015923.882-1-jaedon.shin@gmail.com>
 <20161227015923.882-3-jaedon.shin@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0dffeca2-68bf-bacd-7eff-8b966c721dde@gmail.com>
Date:   Tue, 27 Dec 2016 14:12:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161227015923.882-3-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56128
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

On 12/26/2016 05:59 PM, Jaedon Shin wrote:
> Adds SPI device nodes to BCM7xxx MIPS based SoCs.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm7125.dtsi      | 55 +++++++++++++++++++++++++++++--
>  arch/mips/boot/dts/brcm/bcm7346.dtsi      | 49 +++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7358.dtsi      | 49 +++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7360.dtsi      | 49 +++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7362.dtsi      | 49 +++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7420.dtsi      | 55 +++++++++++++++++++++++++++++--
>  arch/mips/boot/dts/brcm/bcm7425.dtsi      | 49 +++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7435.dtsi      | 49 +++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
>  arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
>  arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 ++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 ++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
>  arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
>  arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 ++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
>  16 files changed, 526 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
> index bbd00f65ce39..c1e19e57f64a 100644
> --- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
> @@ -46,6 +46,12 @@
>  			#clock-cells = <0>;
>  			clock-frequency = <27000000>;
>  		};
> +
> +		spi_clk: spi_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <27000000>;
> +		};

Nit, this should actually be upg_clk, since this is the clock that the
SPI controller uses, and it is a fixed-clock with a 27Mhz frequency.

Other than that, the rest looks good to me, thanks!
-- 
Florian
