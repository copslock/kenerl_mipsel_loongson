Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 13:09:21 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:59399 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903661Ab2FSLJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 13:09:14 +0200
Received: by bkwj4 with SMTP id j4so5617300bkw.36
        for <linux-mips@linux-mips.org>; Tue, 19 Jun 2012 04:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=eeHgDRx2XBBiWvUD8XJmH2np1a5Ux9AS+jDMc7pqJqI=;
        b=cJ4OILZvk0uwO7naKlTR1plao66ikVitazMlK7a+iJpQbnfearzyeDOW+P0DrOXcJj
         BSRgzbh6ZyQxRDMK0NHEho3moxik+idUpNvvMo0VePQN9Vy7fG7WuMmtDqCgz/gvJLmi
         zFYEdZcIyArkSChICjzAGit83xuZrMi31x8zjdFG9NQr5d8g495eKw8GyK/74hfV00ob
         1qxmkcKmtKQMJ+uRv6kopej97Ii3Y1QQIR0IahS7z0MTq0T8L5kxxKEXkq/iINKe3fUa
         iTJGYpc/5XOFmi7K51P7hgPJcYjKHeegvq5zw6OB1tbVz8W3WOWGQtFRRCHnp8kLIZP4
         I5JQ==
Received: by 10.152.48.37 with SMTP id i5mr17903215lan.36.1340104149112;
        Tue, 19 Jun 2012 04:09:09 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-76-168.pppoe.mtu-net.ru. [91.79.76.168])
        by mx.google.com with ESMTPS id jj5sm32931867lab.1.2012.06.19.04.09.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 04:09:07 -0700 (PDT)
Message-ID: <4FE05DAB.2070406@mvista.com>
Date:   Tue, 19 Jun 2012 15:08:27 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V2 03/16] MIPS: Loongson 3: Add Lemote-3A machtypes definition.
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com> <1340088624-25550-4-git-send-email-chenhc@lemote.com>
In-Reply-To: <1340088624-25550-4-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQn7QZDuqcPoCWYI0xnbaIJtXqkBAhpl48d/zi3P68Y7q45QhYUtJv2NZQcFdFb9thmLvu48
X-archive-position: 33720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 19-06-2012 10:50, Huacai Chen wrote:

> Add three Loongson 3 based machine types:
> MACH_LEMOTE_A1004 is laptop;
> MACH_LEMOTE_A1101 is mini-itx;
> MACH_LEMOTE_A1205 is all-in-one machine.

> The most significant differrent between A1004 and A1101/A1205 is
> the laptop has EC but others don't.

> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> Signed-off-by: Hua Yan<yanh@lemote.com>
[...]

> diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
> index 2efd5d9..e377b44 100644
> --- a/arch/mips/loongson/common/machtype.c
> +++ b/arch/mips/loongson/common/machtype.c
> @@ -25,8 +25,11 @@ static const char *system_types[] = {
>   	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
>   	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
>   	[MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
> -	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
> +	[MACH_LEMOTE_NAS]               "lemote-nas-2f",
>   	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
> +	[MACH_LEMOTE_A1004]             "lemote-3a-notebook-a1004",
> +	[MACH_LEMOTE_A1101]             "lemote-3a-itx-a1101",
> +	[MACH_LEMOTE_A1205]             "lemote-2gq-aio-a1205",
>   	[MACH_LOONGSON_END]             NULL,

    It's preferred that indentation is done with tabs, not spaces.

WBR, Sergei
