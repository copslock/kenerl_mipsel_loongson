Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 01:22:22 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36552 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025234AbbDCXWUAi0as (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 01:22:20 +0200
Received: by lbbug6 with SMTP id ug6so86461131lbb.3
        for <linux-mips@linux-mips.org>; Fri, 03 Apr 2015 16:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YKQH7EGkROi7QcetVxMgUjOZfZ1XwhS5yfMz7Dvzjfw=;
        b=F2yPtg767ZCUTkFsJgKFmrHEN+YW4wzTqRGV/8Hl/3w7DmgM/nX9BOG7f/cv0kprFC
         pdwNh3NWCLZNmxAotScKWk/8K1JOT8cEA/42+AqGciWlK6Smi+5uq/zsjbPj4Kkm1tr8
         ZRmLUqVXiWy/gHQmGRArupwHGIhOLiEa1CS+nDMkfBunvacpchndlPwFidhK1T8T3tuL
         jyZHNEsKYCPPg2Y9EVh5kKVgr0Vt6TvlxeyyjivX6hIPvPtQwWjbyUGI1g1LZNzE2Slm
         e1y0SZBxc177H5CPLyVgvFOJaq1Y0Dyf5W0p3A1uUx1kU0jpyhgashkT8CVWtCMICD1L
         BprQ==
X-Gm-Message-State: ALoCoQl4QscYxjcrEp8MbpiltBCnT9WOtAGAZKe3TKNVNVBCu/92N70hoznUTGUxHa/nrmOxVmoy
X-Received: by 10.112.8.76 with SMTP id p12mr3918853lba.29.1428103335813;
        Fri, 03 Apr 2015 16:22:15 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp24-62.pppoe.mtu-net.ru. [81.195.24.62])
        by mx.google.com with ESMTPSA id ls10sm1322292lac.14.2015.04.03.16.22.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 16:22:14 -0700 (PDT)
Message-ID: <551F20A5.60908@cogentembedded.com>
Date:   Sat, 04 Apr 2015 02:22:13 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 29/48] MIPS: math-emu: Make NaN classifiers static
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504031614470.21028@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1504031614470.21028@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46769
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

On 04/04/2015 01:25 AM, Maciej W. Rozycki wrote:

> The `ieee754sp_isnan' and `ieee754dp_isnan' NaN classifiers are now no
> longer externally referred, remove their header prototypes and make them
> local to the two only respective places still making use of them.

> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> linux-mips-emu-isnan.diff
> Index: linux/arch/mips/math-emu/ieee754dp.c
> ===================================================================
> --- linux.orig/arch/mips/math-emu/ieee754dp.c	2015-04-02 20:27:55.587207000 +0100
> +++ linux/arch/mips/math-emu/ieee754dp.c	2015-04-02 20:27:56.032207000 +0100
> @@ -30,7 +30,7 @@ int ieee754dp_class(union ieee754dp x)
>   	return xc;
>   }
>
> -int ieee754dp_isnan(union ieee754dp x)
> +static inline int ieee754dp_isnan(union ieee754dp x)

    I think the current trend is to let gcc figure out whether to inline or not.

[...]

WBR, Sergei
