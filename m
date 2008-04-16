Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 20:40:22 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:41900 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20030142AbYDPTkU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Apr 2008 20:40:20 +0100
Received: by nf-out-0910.google.com with SMTP id b11so758404nfh.14
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 12:40:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=LeU4640JuXOAT3alpUq4Dlf3VUA2GyhCHU9wHSqaM2g=;
        b=KnPUDvoxbuP6LdL1l7S3xI2lmAaPzXCIfaqjFMmsP5Kza9IXjbTmgS85JF64tC3BhsNz3gZDqekD9qB3IIE3R1oWTtmoUppfzamz9hTZvQCNrX6cSVGdMD9feor6se/WPdPFMi32d9QLiJf2plgTKf6f63SsSRY3m43Hgn+rdzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WLp8gMTRHhY2RUld/XToVJfOZt84n7OFrWfp85w4iTSrM2T4hZEFt6hjg0KTMK9z7gxrHj3Xf58VqYsPoJUZDabuUg8gq25kcJggayby7ZT341cKk/CDt3UH6D0GzB3rhFSHPSMDp9fTgVqD99Y8OiCz9D8tnkVUfmltjGLB5gk=
Received: by 10.78.100.2 with SMTP id x2mr709796hub.52.1208374813223;
        Wed, 16 Apr 2008 12:40:13 -0700 (PDT)
Received: from @ ( [91.94.225.201])
        by mx.google.com with ESMTPS id d25sm14166788nfh.33.2008.04.16.12.40.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 12:40:12 -0700 (PDT)
Date:	Wed, 16 Apr 2008 21:39:44 +0200
From:	Marcin Slusarz <marcin.slusarz@gmail.com>
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] MIPS: irixelf: fix test unsigned var < 0
Message-ID: <20080416193941.GB6264@joi>
References: <480558CA.7090800@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480558CA.7090800@tiscali.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <marcin.slusarz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.slusarz@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 03:39:22AM +0200, Roel Kluin wrote:
> v is unsigned, cast to signed to evaluate the do_brk() return value,
>     
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/mips/kernel/irixelf.c b/arch/mips/kernel/irixelf.c
> index 290d8e3..fad2a2a 100644
> --- a/arch/mips/kernel/irixelf.c
> +++ b/arch/mips/kernel/irixelf.c
> @@ -583,15 +583,15 @@ static void irix_map_prda_page(void)
>  	unsigned long v;
>  	struct prda *pp;
>  
>  	down_write(&current->mm->mmap_sem);
>  	v =  do_brk(PRDA_ADDRESS, PAGE_SIZE);
>  	up_write(&current->mm->mmap_sem);
>  
> -	if (v < 0)
> +	if ((long) v < 0)
maybe cast it earlier (to struct prda *) and check error with IS_ERR?

>  		return;
>  
>  	pp = (struct prda *) v;
>  	pp->prda_sys.t_pid  = task_pid_vnr(current);
>  	pp->prda_sys.t_prid = read_c0_prid();
>  	pp->prda_sys.t_rpid = task_pid_vnr(current);
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
