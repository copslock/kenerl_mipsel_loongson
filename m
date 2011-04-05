Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 14:18:39 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:36507 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab1DEMSg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2011 14:18:36 +0200
Received: by ewy3 with SMTP id 3so93030ewy.36
        for <multiple recipients>; Tue, 05 Apr 2011 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=RGHgL3kQDTp2+D+kmn3Zx/UboP5IlQeXckXgKk3Lv0M=;
        b=r+wsWTwCJEhGHzHGnmZZLx5GvPji8stZj4aIFw0NSLk/mMuetvfvf/x/TncdJQ3FII
         bC1pS0zBvcqtvAe6McSn/S9N5V6v638p4NFH74qORevGQmjArj29MhbUQC5uUFSkcueb
         xB/ar+3Z4Dy+4vCcRPKAsy4ERdyufoirwJja0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Bwn3AwzjlxWHeYc9mR23Gdfo4HoSPkdhD4UCMk/41sERd/PZNjLoUV1mUXeOaHi9Un
         oYdXe/40Blt1jsebkJhjoUHLSbhClEdQuIXsfLbyvyrOPygRaTqdqsGo2ZiCqbbZ8S7o
         L6IThc94dbOQdyAYUitwQu6wWXpm9JC14brWY=
Received: by 10.213.100.197 with SMTP id z5mr2100451ebn.111.1302005910655;
        Tue, 05 Apr 2011 05:18:30 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id q53sm3953987eeh.18.2011.04.05.05.18.28
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 05:18:29 -0700 (PDT)
Subject: Re: [PATCH V6] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1302005720-8508-1-git-send-email-blogic@openwrt.org>
References: <1302005720-8508-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 05 Apr 2011 15:15:51 +0300
Message-ID: <1302005751.2760.116.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-04-05 at 14:15 +0200, John Crispin wrote:
> +int __init
> +init_ltq_mtd(void)
> +{
> +	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
> +
> +	if (ret)
> +		pr_err(KERN_INFO "ltq_nor: error registering platfom driver");

Sorry, but pr_err is defined as follows:

#define pr_err(fmt, ...) \
        printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)

You should not add KERN_INFO.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
