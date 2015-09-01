Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2015 19:00:09 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32994 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007845AbbIARAHWnviN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Sep 2015 19:00:07 +0200
Received: by lbcjc2 with SMTP id jc2so3422143lbc.0
        for <linux-mips@linux-mips.org>; Tue, 01 Sep 2015 10:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=stN46L7yQlfElJ2vFO7W6h4RjUQ2roakxSvUEOeB0k8=;
        b=MUZrR88w/KpvPIsZWSTypUzLVczqF9Mr/pZDVI+Tdsmu6q7oYAHhZapO0uSpoXk56k
         mk2/uitoqhE+0L2Xf4mhqtDWkxTZkBBf9vr0oKmEwNnhyk8qW3Hy09VdFEBOanLcyawh
         4IX10nXWMCNAxH5x/lYiRgqoFfStkUGRW0mJRNsrTcoW+883t4JJSyXbHS3337CINVzy
         O9xFra9XByggMp+9eUOV8xcgF0PNBpIPoA+9I4l734VhzKmFX/6ODawYrFFFAVNuIWfD
         6o8jRsOpdUQb6mAddzHxvbGXfkoeWNFMMPsvQap3hB+Xg8mHQ29nNbIeal7Cx0ovUF56
         yruA==
X-Gm-Message-State: ALoCoQlDbp5TtctHRWrO+lOETy79FOXDcYaTXsSjL9NxZpGDPjzQ/50WtonBs3DGAZFcnKwktT3d
X-Received: by 10.112.205.161 with SMTP id lh1mr13598280lbc.43.1441126801596;
        Tue, 01 Sep 2015 10:00:01 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp28-45.pppoe.mtu-net.ru. [81.195.28.45])
        by smtp.gmail.com with ESMTPSA id y6sm4597050lay.49.2015.09.01.09.59.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2015 10:00:00 -0700 (PDT)
Subject: Re: [PATCH 3/4] MIPS: ath79: Add the EHCI controller and USB phy to
 the AR9132 dtsi
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
References: <1441120994-31476-1-git-send-email-albeu@free.fr>
 <1441120994-31476-4-git-send-email-albeu@free.fr>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <55E5D98F.6060904@cogentembedded.com>
Date:   Tue, 1 Sep 2015 19:59:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1441120994-31476-4-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49079
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

On 09/01/2015 06:23 PM, Alban Bedel wrote:

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>   arch/mips/boot/dts/qca/ar9132.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
> index fb7734e..665ee84 100644
> --- a/arch/mips/boot/dts/qca/ar9132.dtsi
> +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> @@ -125,6 +125,21 @@
>   			};
>   		};
>
> +		ehci@1b000100 {

    Please name the node "usb", not "ehci" in order to comply to the ePAPR 
standard.

> +			compatible = "qca,ar7100-ehci", "generic-ehci";

MBR, Sergei
