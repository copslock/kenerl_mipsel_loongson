Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 19:48:33 +0100 (CET)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35861 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009964AbcAOSsa58b9d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 19:48:30 +0100
Received: by mail-ig0-f171.google.com with SMTP id z14so17845108igp.1
        for <linux-mips@linux-mips.org>; Fri, 15 Jan 2016 10:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EZcXw+TQZ684wUJVRw6l3aNRQdauEPtcp10ZI5bm9tk=;
        b=kTf4c4nXJfNKOqzXYE+jifB+LvDGQXkY93HqbC9eMM9hCupes4aBNX+V2ijQAy7EBI
         EzWwBxhbuIUZbOex9ubPZHy+lTs9kzvJHAQZXifi+JYifVq8GpSHqZzxKp97Fb7bZj3m
         dBdWuDEnnlLU/PcnXkzuvZhWFBvqV6qi1Guqrn1X3WfH0LbpRLYVhWYJ4nERNieD/u2v
         nMte1i0Rat+jPa+icTivHVMdOXzGT2UpKCKR8t+U9uakc6cUl8RkjHRZKTYxjvZJylWv
         CnObtmjnmZLSPf4+xZRdZzJK/mN+1F9mm2dg2wj+Un4FrCXrTKA2dBhrELckaAaRJo8I
         jCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EZcXw+TQZ684wUJVRw6l3aNRQdauEPtcp10ZI5bm9tk=;
        b=dQInVAr612tyEpS8lQhcsS8+AYkqpcdRmC8Eg4KnVkSHyxeveyAC62Kw2+MbJcehhg
         0VmQti1Ka/HMHrFawmvPTHX4bNvVgpNiO8pI0D/Jwq42gvDfoKHyecG5DwvuItm0mLmf
         Ci3LX2fnYUv88SV1+DAQGSvhXTh5EDrumow/F44tD3LHgHivDy9MuGxgIj4Z2/Nh4tGU
         /3nT5v4CX2Fsnk2TP5swBZZ1JxVup7CKgMPCaVL3bd88g8M5Ba1HM+WZ202BPAFPmvgT
         qgiRXP38VHZbY3lYkyM0SBY16Ew/RRb+h1GwoWosdV7uYec+Ob/PtScvXJ8clJCL8I5a
         gS5g==
X-Gm-Message-State: AG10YOSrdYxnqMfewBKbHMwHpJQackLDHGnvYI7q3VIw11YdS9nKjMyPw6UWsZe33DmllA==
X-Received: by 10.50.78.169 with SMTP id c9mr53630igx.29.1452883705120;
        Fri, 15 Jan 2016 10:48:25 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id p8sm4650700ioe.38.2016.01.15.10.48.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jan 2016 10:48:23 -0800 (PST)
Message-ID: <56993EF5.9040008@gmail.com>
Date:   Fri, 15 Jan 2016 10:48:21 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>
CC:     linux-mips@linux-mips.org, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: tl_wr1043nd_v1: fix "aliases" node name
References: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51158
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

On 01/14/2016 12:20 AM, Antony Pavlov wrote:
> The correct name for aliases node is "aliases" not "alias".
>
> An overview of the "aliases" node usage can be found
> on the device tree usage page at devicetree.org [1].
>
> Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].
>
> [1] http://devicetree.org/Device_Tree_Usage#aliases_Node
> [2] https://www.power.org/documentation/epapr-version-1-1/
>
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> index 003015a..4b6d38c 100644
> --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -9,7 +9,7 @@
>   	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
>   	model = "TP-Link TL-WR1043ND Version 1";
>
> -	alias {
> +	aliases {
>   		serial0 = "/ahb/apb/uart@18020000";
>   	};

What uses this alias?  If the answer is nothing (likely, as it was 
broken and nobody seems to have noticed), just remove the whole thing.

>
>
