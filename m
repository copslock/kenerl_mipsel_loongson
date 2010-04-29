Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 14:12:05 +0200 (CEST)
Received: from mail-gx0-f228.google.com ([209.85.217.228]:37350 "EHLO
        mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492653Ab0D2MMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 14:12:02 +0200
Received: by gxk28 with SMTP id 28so122227gxk.7
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ThHS8s6gA32y3a9aa4KbaIkvF3vT3kbws7cKAuHJlto=;
        b=Wr1g+WiBXg10UQe/X12GLHDv7++hbmsHAXuc4e8hsc83sIJgET1m1Iw0QB9T1hucc/
         okb/4z3Cx03rGcx1jSQERcLRkCpVjmBJep4g55guxl4cV/X82i0RKk9qv4kAWTGP66Sk
         WUWRZdmnxgBVRI18hVX4yBGuslsUBH05GmEzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Op8STf5Gw5WSSVlZqqzfaFyePOUAIdKO0SIHzGkpKRCncECPBhXspVigSxkj++WPvh
         kDC1YbBjhKyJcJ+rIJHZRzNLfiPeTvtKBaKRUm4zyI2+yaK9QjorO1GcnEDuyX6y3vyL
         +LpasvW0QCfwKMG5OyhGSd6itquLER1fHZODI=
Received: by 10.101.162.19 with SMTP id p19mr4209011ano.267.1272543114828;
        Thu, 29 Apr 2010 05:11:54 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id y6sm8535911ana.5.2010.04.29.05.11.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Apr 2010 05:11:54 -0700 (PDT)
Subject: Re: [PATCH] loongson 2f: Add gpio/gpioilb support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <m3sk6ewpep.fsf@anduin.mandriva.com>
References: <m3sk6ewpep.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 29 Apr 2010 20:11:42 +0800
Message-ID: <1272543102.30655.138.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-04-29 at 11:58 +0200, Arnaud Patard wrote:
> This patch is adding support for the 4 GPIO availables on the ST LS2F
> cpus.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
> ---
[...]
> Index: linux-2.6/arch/mips/loongson/common/gpio.c
[...]
> +
> +static int __init ls2f_gpio_setup(void)
> +{
> +	return gpiochip_add(&ls2f_chip);
> +}
> +arch_initcall(ls2f_gpio_setup);
> +

The above blank line is at the end of the file, we can remove it,
otherwise, "git am" will complain about it.

Regards,
	Wu Zhangjin
