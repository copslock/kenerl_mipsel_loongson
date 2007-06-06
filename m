Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:39:22 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:53531 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021454AbXFFGjU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 07:39:20 +0100
Received: by py-out-1112.google.com with SMTP id f31so80842pyh
        for <linux-mips@linux-mips.org>; Tue, 05 Jun 2007 23:38:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YxPou/KbM6EoOTJ8+yOXyz8wRC6SCF1dyFw+ViJgRjeNOR5yPVuK7aGzWb5poJg3KNlP1/glRjLRSCJsWPzdt+eYrirOVP5ax4gaRjb4gPF3hqTsPxtU2/ehlDbFU5V92Fo4T1XL4MitJlc5/rZYkH12B722e390wsVV/q1SFYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B90HNdjJCtF6a0tQtRcXOj+ZQVICBMdEmvdwMeC8b6E9B5hYcqF28nmfR1L1zwqYaYbiFgP4GPli3SqXTqNBvy4zIFzLoGI+u/pHFw1skjPqTPI9zYMwmV/x/azoLf2OkE20sK/5q96kBxtAqFafXW4F9D1G0B5Q3m1R14mjCAo=
Received: by 10.65.135.19 with SMTP id m19mr255177qbn.1181111899035;
        Tue, 05 Jun 2007 23:38:19 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Tue, 5 Jun 2007 23:38:18 -0700 (PDT)
Message-ID: <cda58cb80706052338y461f707fq790e204f55a23cc0@mail.gmail.com>
Date:	Wed, 6 Jun 2007 08:38:18 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"tiansm@lemote.com" <tiansm@lemote.com>
Subject: Re: [PATCH] cheat for support of more than 256MB memory
Cc:	linux-mips@linux-mips.org, "Fuxin Zhang" <zhangfx@lemote.com>
In-Reply-To: <11811049643791-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11811049622818-git-send-email-tiansm@lemote.com>
	 <11811049643791-git-send-email-tiansm@lemote.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 6/6/07, tiansm@lemote.com <tiansm@lemote.com> wrote:
> From: Fuxin Zhang <zhangfx@lemote.com>
>
> Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
> ---
>  arch/mips/kernel/setup.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4975da0..62ef100 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -509,6 +509,14 @@ static void __init resource_init(void)
>                 res->end = end;
>
>                 res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
> +               /* to keep memory continous, we tell system 0x10000000 - 0x20000000 is reserved
> +                * for memory, in fact it is io region, don't occupy it
> +                *
> +                * SPARSEMEM?

Definetly yes ! It has been designed for such issue and it should save
you some memory.

-- 
               Franck
