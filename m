Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 12:17:00 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35039 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011139AbcBOLQzmC1wj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 12:16:55 +0100
Received: by mail-lb0-f177.google.com with SMTP id bc4so76186600lbc.2
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 03:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=Ax1aEywxktPYaqXf4Jnn1FBsGevv++U+2qPTppGKVD8=;
        b=OYuqSpwqQc597E9D+efVB/75nUksY5MsuwQJPK8qBhvub3ZOyY3uIuVNfrfi2WYS8W
         U9MQBNW21iVoa+24E49EiutzHqg8YuvSlQnXq/5iyTGMawBg7Kxed71UhkFLC3104X9b
         YuScsRWHJ6Yej03IfQ5qHSx76yhtiO2SHnx7IK/Gc6oAbgbuyS0SaaD3Xyr4O+68qd9M
         c5Oam+B3X/KnyRURmBvUVTiKENn0+6P93BOzbtuKYyt75jcviURXJPH7xROXcICIo8zQ
         Z0uWZ8QVGTN14K0N5SB3S+uMbEH6M7CsQ0B/AMgEk7+eIC8ILFY1qh2RbU1tODKcbUYe
         3k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ax1aEywxktPYaqXf4Jnn1FBsGevv++U+2qPTppGKVD8=;
        b=bpGQZ0ju2be+eiGJr/pEZXTMwbp5abHkwOuEwjn3CChZw/wJMUzcp+DXRpoN93zY7z
         wgbxaCH7KyyvpgZ1A0KmbJQfrOVTmnWG1tJaDqY0caNw8oH4LRtPdy6b7KAtTctBsr4o
         0LPNol+gNa6MbnnOuyPXCL1S8jBjOLFld1yUV9SY6UQux0vmI8hkmhkeHVP3oHL9eJZC
         rK6jO3T5HEwdC8RaXAapBjTa7oaCF6tKbkLfuhDphc5Nmb5VmsqyScyv4V3+yhLbXvMA
         /IFoZtFl7PGKLSrmrAJc1bnCdhNJAfyKPW6sxH+TfONZ2prWNgvUh/Ef3cRSlE0Dgd0l
         heiQ==
X-Gm-Message-State: AG10YOSZ89qK+D5+uV+MkwQFn0C1IRyienXB3JujsSLKLBpggWVTRojPt0goBTmFUDpqMg==
X-Received: by 10.112.89.36 with SMTP id bl4mr6409783lbb.37.1455535010171;
        Mon, 15 Feb 2016 03:16:50 -0800 (PST)
Received: from [192.168.4.126] ([195.16.111.125])
        by smtp.gmail.com with ESMTPSA id jb5sm850725lbc.8.2016.02.15.03.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Feb 2016 03:16:49 -0800 (PST)
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56C1B3A0.4090301@cogentembedded.com>
Date:   Mon, 15 Feb 2016 14:16:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 2/15/2016 8:26 AM, Heinrich Schuchardt wrote:

> Downstream packages like Debian flash-kernel rely on
> /proc/device-tree/model
> to determine how to install an updated kernel image.
>
> Most dts files provide this property.
> It is suggested by IEEE Std 1275-1994.
>
> This patch adds a model attribute for Octeon CPUs.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts | 1 +
>   arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> index 9c48e05..a746678 100644
> --- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> @@ -8,6 +8,7 @@
>    */
>   / {
>   	compatible = "cavium,octeon-3860";
> +	model = "Cavium Octeon 3XXX";
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   	interrupt-parent = <&ciu>;
> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> index 79b46fc..c8a292a 100644
> --- a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> @@ -8,6 +8,7 @@
>    */
>   / {
>   	compatible = "cavium,octeon-6880";
> +	model = "Cavium Octeon 68XX";
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   	interrupt-parent = <&ciu2>;

     The ePAPR 1.1 standard says:

2.3.2 model

Property: model
Value type: <string>
Description:
	The model property value is a <string> that specifies the
  	manufacturer’s model number of the device.

	The recommended format is: “manufacturer,model”, where manufacturer
	is a string describing the name of the manufacturer (such as a stock
	ticker symbol), and model specifies the model number.

Example:
	model = “fsl,MPC8349EMITX”;

MBR, Sergei
