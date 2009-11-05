Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 12:00:42 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:60240 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492306AbZKELAg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 12:00:36 +0100
Received: by pzk32 with SMTP id 32so5542115pzk.21
        for <multiple recipients>; Thu, 05 Nov 2009 03:00:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=6Evv75u8IcigLRiZzwe7eQnrurGzgfgEc+JVowntnjA=;
        b=wZcpTwxVyLmOV5FTkdGHHBKyHlG5qN1ZOawIzR84tMXvFMKc5PJsNitucUqbzyefGZ
         QPHWkE6z7EfLB+YuohEqeBhn1FsWwrrsu/CUbznpdSj1UETqgHchQOsDLBTbFEWBQeYG
         kfwGLJZJCNswpJM435hqcbXUDFA1wuUGnETMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=A96k0644QFIW7fu/LVrJpXom+9PmlIr1qXcqr5blYY4/wxEfxz6TrVUybH1NIUyn46
         lzWTAFTjbPPZyAEJQz7lL+ykelc9c+/KHrSv40geklWBlxZdmec0H9aVX+D4d0O9Olrg
         MwZES9X5uZQGTvMHgIiFHShBS2UQK3KjNREiU=
Received: by 10.115.149.4 with SMTP id b4mr4797712wao.18.1257418826457;
        Thu, 05 Nov 2009 03:00:26 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm613625pxi.3.2009.11.05.03.00.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 03:00:25 -0800 (PST)
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	huhb@lemote.com, yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <20091105102838.GF12582@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com>
	 <20091105091841.GC12582@linux-mips.org>
	 <1257414523.1824.11.camel@falcon.domain.org>
	 <20091105102838.GF12582@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 05 Nov 2009 19:00:16 +0800
Message-ID: <1257418816.3067.8.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

> > > You're ifdefing on Loongson 2F - doesn't that mean that you can't have a
> > > kernel that supports both Loongson 2E and 2F?
> > > 
> > 
> > Currently, not consider it yet;) It's a little hard to cope with, should
> > we consider it at this moment? if yes, I will try it with the help of
> > exisiting machtype asap. but I think it's better to let it be the future
> > job ;)
> 
> Fair enough - though I'm sure Linux distributions would be happy to have
> one kernel variant less to ship.
> 

Yup, linux distributions will like it.

but just remembered that: the instruciton set of loongson2e and
loongson2f is different, -march=loongson2e, -march=loongson2f. so it
will be not possible to merge them together, but I will try to merge the
2f support, so please wait for me merging fuloong2f & yeeloon2f, I will
do it tonight, it is really an interesting job to do ;)

Regards,
	Wu Zhangjin
