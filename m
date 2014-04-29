Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 19:36:26 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56658 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843081AbaD2RgYS03-- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 19:36:24 +0200
Received: by mail-lb0-f180.google.com with SMTP id w7so398277lbi.25
        for <linux-mips@linux-mips.org>; Tue, 29 Apr 2014 10:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/9Px+q0JXB9nMlqstFe7pA2OY5SYLBabSpx/ixZW11w=;
        b=PR2T4ur0TGxskVi7ltIAC1bhc+2TZ1GMe8bcccKPoZQ6My8xa19yoFuavHCfSLcugi
         JSN1PapV6NlNIeiEGI32zKmDOjNScXwTcE+iseG1EPgHhVGFD5BF0rTETD2vZ8HojnLQ
         WmNHVSDmihrjCn4aQztf5M3eynFQYGpV8eri5hiMKJBp9sZ7rJ18fXhnXRWzz+AugZZb
         /zHW013F7QnjUALFBYy3f0egDEGymkxF6zwrC2XI+tQeIwzEVe6RCoozWQoKSx1/e95N
         7qXejq7/DvKqKIv0hbP7S/cscEvjgtMRd6amU616v7q02w1kVvEPLlbpNN7hPEaGrdD/
         AyHw==
X-Gm-Message-State: ALoCoQk2b2Pvj0GndrOGA9+nRacWVaZu8IelPdqxvptlCUDWEm6R7tSyAK3gBzalAjm7fgEw2Foq
X-Received: by 10.112.77.166 with SMTP id t6mr251369lbw.53.1398792978524;
        Tue, 29 Apr 2014 10:36:18 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp85-140-129-131.pppoe.mtu-net.ru. [85.140.129.131])
        by mx.google.com with ESMTPSA id jp6sm23305173lbc.15.2014.04.29.10.36.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Apr 2014 10:36:17 -0700 (PDT)
Message-ID: <535FE312.50400@cogentembedded.com>
Date:   Tue, 29 Apr 2014 21:36:18 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org
Subject: Re: [PATCH 11/17] MIPS: Netlogic: Fix XLP9XX pic entry
References: <cover.1398780013.git.jchandra@broadcom.com> <db9d6d674a9fadeb7bad499ade3d66cc715fb6dd.1398780013.git.jchandra@broadcom.com>
In-Reply-To: <db9d6d674a9fadeb7bad499ade3d66cc715fb6dd.1398780013.git.jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39987
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

On 04/29/2014 06:37 PM, Jayachandran C wrote:

> Add the compatible property to the PIC entry. Also fix up the nodename
> to use the correct address.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/netlogic/dts/xlp_gvp.dts |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/netlogic/dts/xlp_gvp.dts b/arch/mips/netlogic/dts/xlp_gvp.dts
> index 047d27f..bb4ecd1 100644
> --- a/arch/mips/netlogic/dts/xlp_gvp.dts
> +++ b/arch/mips/netlogic/dts/xlp_gvp.dts
> @@ -26,11 +26,12 @@
>   			interrupt-parent = <&pic>;
>   			interrupts = <17>;
>   		};
> -		pic: pic@4000 {
> -			interrupt-controller;
> +		pic: pic@110000 {

    According to the ePAPR standard [1], the node name should be 
"interrupt-controller@110000".

> +			compatible = "netlogic,xlp-pic";
>   			#address-cells = <0>;
>   			#interrupt-cells = <1>;
>   			reg = <0 0x110000 0x200>;
> +			interrupt-controller;
>   		};

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
