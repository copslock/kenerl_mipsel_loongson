Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 01:20:34 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33490 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010964AbcBQAUcObkHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 01:20:32 +0100
Received: by mail-pa0-f42.google.com with SMTP id fl4so567353pad.0;
        Tue, 16 Feb 2016 16:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PVY8pfBg1JB8/rTzjxsrNUawUIFcyOLKFXPRlYF37Yo=;
        b=jLeeSsBhedENm+1mlYlVUJeqqIa8cc9Vim9ZRXhQ4sCuRDnqfJvfktoL0FYaYXH0/C
         tZPIq9ZHQWhF2rlHziITeBmEvea5aRT2RMGZap1tWyi30RtqNNgP6rXubXN/k22D5ib9
         JBCIsNbNbm5epYqNIPLIK4ELOjVKLW6FanCc2R5s9CJncIvXj5zuKf/wANItEucAuN2Y
         kIGClNiFBGTjvw63/kOextMiBzqqCe0oZZOOpcz1AIAWdD5E5iF4aERrAiitXFA8ydlY
         GE8N3qiwSofoTwML4zGkYP7ZPHmbaXzzw29t8UJ6HxVimb6KGKoPYz3q7Et0ADekiorN
         QxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=PVY8pfBg1JB8/rTzjxsrNUawUIFcyOLKFXPRlYF37Yo=;
        b=BcfANrI5+wQmYonKrYPMkMvwC5VryDVzu6yoi35A6Tq46FtvT8ZX86yAH5OeEYaYXS
         nbRrv4tEAc8KkFETvC4d1okDX4/UQyzE7lcGlvFI3sve9iztxR5ugU2Y+rwiqOn50Ih8
         cPPANEq8y+nZLJYuDTlLPRP2nAJRJIEMUPmXN609LVO/B6oze0aqsJy70gG+L1/dTYN7
         KZVZ2VUnREqFAIOcb30RWtIjozv0DdkxwLIG0rLUfkY1botvT5Z/0qy6f6vR3zJbnYWH
         lPSO8igs8zkVEd2rzTfnvKNCafrxnqcap9fm5CYum3Nkwe+0nTNW5vzmVDRahB07CmIc
         +3Jw==
X-Gm-Message-State: AG10YORBEQEiXGPZPqZ/FgxYA7TuwZMlfyTuFiGy3Gn01qIf7TGuZCVB5IwnBhYOgVbQyA==
X-Received: by 10.66.164.39 with SMTP id yn7mr35165029pab.107.1455668423003;
        Tue, 16 Feb 2016 16:20:23 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id sm8sm48362139pac.43.2016.02.16.16.20.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Feb 2016 16:20:20 -0800 (PST)
Message-ID: <56C3BCC3.5020109@gmail.com>
Date:   Tue, 16 Feb 2016 16:20:19 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 v2] MIPS: DTS: cavium-octeon: provide model attribute
References: <56C214EE.5050200@cogentembedded.com> <1455561341-2071-1-git-send-email-xypron.glpk@gmx.de>
In-Reply-To: <1455561341-2071-1-git-send-email-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/15/2016 10:35 AM, Heinrich Schuchardt wrote:
> Downstream packages like Debian flash-kernel rely on
> /proc/device-tree/model
> to determine how to install an updated kernel image.
>
> Most dts files provide this property.
>
> This patch adds a model attribute Octeon CPUs.
>
> v2:
> 	Use vendor prefix defined in vendor-prefixes.txt.
> 	Separate model from vendor by comma.
> 	Avoid wildcards.
>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


NAK.

These device tree templates are only used on systems with archaic 
versions of u-boot.  For all modern OCTEON systems, the device tree is 
provided by the firmware and is not under the control of the authors of 
the Linux kernel.

Whatever problem you are attempting to solve, almost by definition, 
cannot be solved by modifying these files.

We are worse off changing these, and giving people false hope that you 
are fixing something, than doing nothing.

David Daney



> ---
>   arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts | 1 +
>   arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> index 9c48e05..f70cd58 100644
> --- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> @@ -8,6 +8,7 @@
>    */
>   / {
>   	compatible = "cavium,octeon-3860";
> +	model = "cavium,Octeon 3860";
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   	interrupt-parent = <&ciu>;
> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> index 79b46fc..0b40899 100644
> --- a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> @@ -8,6 +8,7 @@
>    */
>   / {
>   	compatible = "cavium,octeon-6880";
> +	model = "cavium,Octeon 6880";
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   	interrupt-parent = <&ciu2>;
>
