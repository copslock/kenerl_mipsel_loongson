Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 17:14:09 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.234]:38280 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023784AbXEIQOH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 May 2007 17:14:07 +0100
Received: by nz-out-0506.google.com with SMTP id x7so262359nzc
        for <linux-mips@linux-mips.org>; Wed, 09 May 2007 09:14:03 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FMh2jAzqrwDrntDbFakZ4OvXftuZRbgXll864JFCpMzgmoaGUidzdtW88j4bniHos+KwXGLo9z66iikbvMkpDL1XFgpfVTtKKrfXkOXA7hcxRGxSCXlNYxuig+fRhSN4sBZ1is2vsCY/IAwTLVrvFMy/MOz4LwjAWASg/cm8d6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=grLDDWaHcAgX218Zo+TdZfCogFLz1ftRz+zS66FPBViojYVeMKLMz99QaevcgJwVgvtmyanSd0EQgYODhVqovSKFULKobPgq5feFtY8vqa/jWVwd92Hq/31HEqCMqqFykLdqvRrfmhGSvUgp04ha1NgwwYiis8HJ519LihrO5Co=
Received: by 10.114.166.1 with SMTP id o1mr96974wae.1178727243413;
        Wed, 09 May 2007 09:14:03 -0700 (PDT)
Received: by 10.114.134.16 with HTTP; Wed, 9 May 2007 09:14:03 -0700 (PDT)
Message-ID: <cda58cb80705090914g12d0356fld67d75b35bd44b5e@mail.gmail.com>
Date:	Wed, 9 May 2007 18:14:03 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] Remove LIMITED_DMA support
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
In-Reply-To: <20070509131607.GC25192@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11785537132378-git-send-email-fbuihuu@gmail.com>
	 <11785537142626-git-send-email-fbuihuu@gmail.com>
	 <20070509131607.GC25192@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/9/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, May 07, 2007 at 06:01:53PM +0200, Franck Bui-Huu wrote:
>
> > Subject: [PATCH 3/3] Remove LIMITED_DMA support
>
> Pleased to say goodbye to this one also,
>

Thanks !
-- 
               Franck
