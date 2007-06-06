Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 09:02:33 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:32790 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021575AbXFFICb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 09:02:31 +0100
Received: by py-out-1112.google.com with SMTP id f31so109873pyh
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2007 01:01:30 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XsRr3fLqOLtlW/d0TG68Kn0IqrajI0XGXrqtsKXfPFpws1k/O0vhy16CvwT5bjJccSFYc1J+RGC2HbtPyJLg8n10nSFfNAqhNJguDUHxRzvYkz/nW2akzJTwtA1EK95kCibxGDOhE4cYng6o7cpUBN0FP7SQu6CK5cNse47s8Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aMDpmvlzR1ABFsjRnNx2BfELCHQQxtzT0/F4IXFiydAH9uZMF0hc68NE7pw9a+B4Sch96smFfTHCYr4YVizo8QPJWHPRkyQ5w5qsfhqiQ5zjelV6vfxiiMZgYmSe0fw4nSisDgYpg7agdjb0ljOrghntfQ0j52xXg+CfLqY9VMI=
Received: by 10.65.219.20 with SMTP id w20mr396497qbq.1181116889831;
        Wed, 06 Jun 2007 01:01:29 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Wed, 6 Jun 2007 01:01:29 -0700 (PDT)
Message-ID: <cda58cb80706060101n64dd973fxdd282379595c0b1@mail.gmail.com>
Date:	Wed, 6 Jun 2007 10:01:29 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"tiansm@lemote.com" <tiansm@lemote.com>
Subject: Re: [PATCH 15/15] work around for more than 256MB memory support
Cc:	linux-mips@linux-mips.org, "Fuxin Zhang" <zhangfx@lemote.com>
In-Reply-To: <11811127744038-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11811127722019-git-send-email-tiansm@lemote.com>
	 <11811127744038-git-send-email-tiansm@lemote.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/6/07, tiansm@lemote.com <tiansm@lemote.com> wrote:
> From: Fuxin Zhang <zhangfx@lemote.com>
>
> Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
> ---
>  drivers/char/mem.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index cc9a9d0..a19b46a 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -82,8 +82,12 @@ static inline int uncached_access(struct file *file, unsigned long addr)
>          */
>         if (file->f_flags & O_SYNC)
>                 return 1;
> +#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
> +       return (addr >= __pa(high_memory)) || ((addr >=0x10000000) && (addr < 0x20000000));
> +#else
>         return addr >= __pa(high_memory);
>  #endif
> +#endif
>  }

That would be nice to have a nice log to justify such a hack....

Thanks
-- 
               Franck
