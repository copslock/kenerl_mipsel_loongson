Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 12:05:19 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35259 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902755Ab2FOKFM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 12:05:12 +0200
Received: by lbbgg6 with SMTP id gg6so2870695lbb.36
        for <linux-mips@linux-mips.org>; Fri, 15 Jun 2012 03:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=YbRW9N7R8PShqBjG6UJUJbeNfy2rJg3lDNRcP0osyzY=;
        b=UolxORP0+5EwOFPoS20S+nNbzbIYZV+mWVfl4lTDLYuD6pAzEOnMMlyzJWOTnNd193
         EFqaMxAAm3LacdJzUhP4iXOm76RtqWNlLk4OS133U3ob9zfkTYk7q7vDKDhRrhuEx/OV
         AfGP1Do7iShJnE7PayFHLoZwKNDAyESTIBGYb0joZDhRo5o7VxnbdKvgo/RcYIa7NEMT
         qqPStHfZtusDc/Oxsq9H9qG5WhUxIY2npseuirPIJyTqf08Zr3ejpbABNJ2UzoxV+TzB
         BiHLczQkuN4Jy1oYf+Wuve067qwx6/Ty224GOLERJ/KtMbilCXUL1I/yjInLvP6f+SOz
         YSHQ==
Received: by 10.112.30.41 with SMTP id p9mr2422863lbh.26.1339754706588;
        Fri, 15 Jun 2012 03:05:06 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-93-154.pppoe.mtu-net.ru. [91.79.93.154])
        by mx.google.com with ESMTPS id j3sm5981722lbh.0.2012.06.15.03.05.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 03:05:04 -0700 (PDT)
Message-ID: <4FDB08AC.8010208@mvista.com>
Date:   Fri, 15 Jun 2012 14:04:28 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com> <1339747801-28691-10-git-send-email-chenhc@lemote.com>
In-Reply-To: <1339747801-28691-10-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnFMqwIR7o+YKzi+ZjLqbVlWqk9eDDLSYsgLjIENXrYSUdxmv2+TKJJLCEre2QfvJsgaAXc
X-archive-position: 33654
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

On 15-06-2012 12:09, Huacai Chen wrote:

> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> Signed-off-by: Hua Yan<yanh@lemote.com>

    You  should have CCed the 'linux-ide' mailing list.

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ebaf67e..3e3cfd8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] = {
>   	},
>   	[board_ahci_sb700] =	/* for SB700 and SB800 */
>   	{
> +#ifndef CONFIG_CPU_LOONGSON3
>   		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
> +#else
> +		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
> +						AHCI_HFLAG_32BIT_ONLY),
> +#endif

    No, this #ifdef'ery won't do. You should add a new board type.

MBR, Sergei
