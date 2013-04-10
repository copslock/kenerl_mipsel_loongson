Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:50:30 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:49401 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835012Ab3DJNu2p4t3u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 15:50:28 +0200
Received: by mail-la0-f52.google.com with SMTP id ej20so449891lab.25
        for <linux-mips@linux-mips.org>; Wed, 10 Apr 2013 06:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=hhjc3taNXzbQHEWe0juh5naOWIwkFPV+SW+1jdo1Mw8=;
        b=fc9BhofehCewpJNdCNIIlPsyYjONgScJUORKthxUO28H4d9MuTAzn6VPB5omGbcqMn
         Vd8S0ns9V0uNrHBZvnw2QcVarcc8m2XgACtoF1WMgH72aPW+l9sLyyeymEYQOAGMmL2T
         PdVeNuKL6MxGCgrLy6Crh4weIbqPStFsPd9AQ3WUMWhdU6xVTrJV4tr1cCvU6PRO8nsM
         bNvw6qTY3tfnAwYEHVDJXoJ8WKwum7fJfH1Drw/IyVtIopvk3YPz9iIE4R4fUpqR6cBw
         XC2C/Uu5xkd521LPvE0lsjZYr3k1DMutQ3SSletNkzxhJsZYq1UEt1nLZCCsk/MHWDbG
         a2SA==
X-Received: by 10.112.156.102 with SMTP id wd6mr1268421lbb.82.1365601822973;
        Wed, 10 Apr 2013 06:50:22 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-90-157.pppoe.mtu-net.ru. [91.79.90.157])
        by mx.google.com with ESMTPS id m9sm228659lbm.3.2013.04.10.06.50.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 06:50:21 -0700 (PDT)
Message-ID: <51656DE2.4000300@cogentembedded.com>
Date:   Wed, 10 Apr 2013 17:49:22 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 02/18] MIPS: ralink: fix RT305x clock setup
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365594447-13068-3-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmtTKgjDS/AY+mqCtU9/HdRGFGWMK/66hLZeYZ/UZDhQFlg0VymIF9jNp/L4uFZZB1va82f
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36059
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

On 10-04-2013 15:47, John Crispin wrote:

> Add a few missing clocks and remove the unused sys clock.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/rt305x.c |   14 ++++++++++++++
>   1 file changed, 14 insertions(+)

> diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
> index 0a4bbdc..856ebff 100644
> --- a/arch/mips/ralink/rt305x.c
> +++ b/arch/mips/ralink/rt305x.c
[...]
> @@ -176,11 +177,24 @@ void __init ralink_clk_init(void)
>   		BUG();
>   	}
>
> +	if (soc_is_rt3352() || soc_is_rt5350()) {
> +		u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);

    Empty line wouldn't hurt here...

> +		if ((val & RT3352_CLKCFG0_XTAL_SEL) == 0)

    Using ! would make this shorter.

WBR, Sergei
