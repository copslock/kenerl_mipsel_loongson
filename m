Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 16:26:46 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:8625 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024197AbZE0P0d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 16:26:33 +0100
Received: by wa-out-1112.google.com with SMTP id n4so782242wag.0
        for <multiple recipients>; Wed, 27 May 2009 08:26:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=NPnAld2woOwg+3BA80hwfEgh30bx5IFxkZsb8k9dNrc=;
        b=JoAjQiu09VJUfGJj3SIZKK7v9dsA4A5gGTML4zKmlXW3Rdw6oiR4XV9MSkrA8uKUDE
         f1kyZAzpaW6DTI2udzyjgbTl5uDFPhoAQzzaxJT7cn9C/7NUbt+diOGeATPCKtPss4BB
         9iTwM17843joeYxIp/4BV5yQKi+BLlenNhOKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=vYRnTzFnccH/2TyE7XiITS8fwi0zQQAJSwC81nXiTVsNcBXWO29AI2HVz+QDhrt0cA
         uj44ag8S4opobvihP8ViFqB+4qz2A9eVbOKkppho5bGiq979Sp0mAVtz7sreEYnC5PMM
         m6eTtLFD2vzUi/o7Ju+7AWN+4BaCHFL04BrSA=
Received: by 10.114.124.1 with SMTP id w1mr178639wac.135.1243437991195;
        Wed, 27 May 2009 08:26:31 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id v9sm2586845wah.1.2009.05.27.08.26.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 08:26:26 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 06/23] replace tons of magic numbers by
 understandable symbols
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <m3y6siopy9.fsf@anduin.mandriva.com>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <943d884878d1e8ccec9c11732669c5ec35913314.1243362545.git.wuzj@lemote.com>
	 <m3y6siopy9.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 27 May 2009 23:26:17 +0800
Message-Id: <1243437977.11263.7.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-05-27 at 11:27 +0200, Arnaud Patard wrote:
> wuzhangjin@gmail.com writes:
> Hi,
> 
> [...]
> 
> > diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
> > new file mode 100644
> > index 0000000..5f2cd3a
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-loongson/machine.h
> > @@ -0,0 +1,27 @@
> > +/*
> > + * board-specific header file
> > + *
> > + * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
> > + *
> > + * This program is free software; you can redistribute it
> > + * and/or modify it under the terms of the GNU General
> > + * Public License as published by the Free Software
> > + * Foundation; either version 2 of the License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#ifndef __MACHINE_H
> > +#define __MACHINE_H
> > +
> > +#define MACH_NAME			"lemote-fuloong(2e)"
> > +
> > +#define LOONGSON_UART_BASE		0x1fd003f8
> 
> Why not using LOONGSON_PCIIO_BASE+0x3f8 ?
> 

yes, i just tuned arch/mips/include/asm/mach-loongson/machine.h and the
relative file arch/mips/loongson/common/serial.c as above.

thx!
Wu Zhangjin
