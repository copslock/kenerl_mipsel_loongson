Return-Path: <SRS0=HboV=W5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9173C3A5A4
	for <linux-mips@archiver.kernel.org>; Mon,  2 Sep 2019 01:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE9B216C8
	for <linux-mips@archiver.kernel.org>; Mon,  2 Sep 2019 01:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="KohG0Y3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfIBBCi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 21:02:38 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:43375 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729206AbfIBBCi (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 21:02:38 -0400
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id BA1611C80DF3;
        Mon,  2 Sep 2019 04:02:35 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback14o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4VViQMERzj-2Z0idO2P;
        Mon, 02 Sep 2019 04:02:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567386155;
        bh=cJSwOXpoDZTDErYZuuUV7dnctwQYPt06/PzDUOwGKJM=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=KohG0Y3D4UX3AYpLpONZwkpVlH9pn91lPmLT49TkV8YbUsWEEB8NvZfld7BWYIdoY
         0kI/e2e+FLCHOxTMcq+Io4wPU9NsQjbtLNdUd+9QjNwNWbqH1BLv8orcTK+qDmTwrK
         vYp/NZpnDfTS4QohX8LHOESYdlbmZ+fPLiZuRWvg=
Authentication-Results: mxback14o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QVwgxZ5278-2L80vFlR;
        Mon, 02 Sep 2019 04:02:23 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 120/120] MIPS: Fix name of BOOT_MEM_ROM_DATA
To:     Fredrik Noring <noring@nocrew.org>, linux-mips@vger.kernel.org
References: <cover.1567326213.git.noring@nocrew.org>
 <54a08fcb41b12e715529148a6bc11bcb3e2adb4d.1567326213.git.noring@nocrew.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <d88ab711-b8b6-a04f-6f19-82ecbb758398@flygoat.com>
Date:   Mon, 2 Sep 2019 09:02:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <54a08fcb41b12e715529148a6bc11bcb3e2adb4d.1567326213.git.noring@nocrew.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


在 2019/9/2 0:37, Fredrik Noring 写道:
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>   arch/mips/kernel/setup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index ab349d2381c3..7d5bf8cb513b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -870,14 +870,16 @@ static void __init resource_init(void)
>   		switch (boot_mem_map.map[i].type) {
>   		case BOOT_MEM_RAM:
>   		case BOOT_MEM_INIT_RAM:
> -		case BOOT_MEM_ROM_DATA:
>   			res->name = "System RAM";
>   			res->flags |= IORESOURCE_SYSRAM;
>   			break;
> +		case BOOT_MEM_ROM_DATA:
> +			res->name = "System ROM";
> +			break;

Hi Fredik,

ROM_DATA meant memory used by ROM(Bootloader) to store data in some 
machines, is that name right?

Btw, boot_mem_map had been droped recently, see mips-next tree, please 
rebase.

Thanks

--

Jiaxun Yang

>   		case BOOT_MEM_RESERVED:
>   		case BOOT_MEM_NOMAP:
>   		default:
> -			res->name = "reserved";
> +			res->name = "Reserved";
>   		}
>   
>   		request_resource(&iomem_resource, res);
