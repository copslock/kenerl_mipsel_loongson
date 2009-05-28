Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 18:07:12 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:64445 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024540AbZE1RHG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 18:07:06 +0100
Received: by pxi17 with SMTP id 17so4982873pxi.22
        for <multiple recipients>; Thu, 28 May 2009 10:06:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=I+dYxgftUY82ppR7HJq9jof8X+RATLbZgs16eOZoCXk=;
        b=lXa75mLhfEsZnZGFSlMj9PtkwZPppn/vASWkBll/FKJXrJ1rM1xMEKnU2i/QmfsI9f
         GUltNxWOlEOcAhVvOjaCuTJBA/h6XxG3ul403BeZCddqWYHaWnwPfTs0J91Gc5BOanFX
         vbmwt0WMPq23Kwc8F2/TeGbZVZJg6AR736gew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wNpQW0PAE0IMoVZEI0h7Z1DURRNkp7qytJaipTZALwOlhKxL0iTAaEtDxMkiCQ/2sx
         5h63BeJjnP4yT5QC0gO6DPLUwo6SQyyvIkeBM6PfWaVBIMG/8NiybGZfgQM4F1Y7C5ID
         dtA1GKSiLhHXdqSrHtQj/7zsRUlD+3WPDXkwg=
Received: by 10.114.148.1 with SMTP id v1mr1795967wad.46.1243530418807;
        Thu, 28 May 2009 10:06:58 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id v39sm381091wah.27.2009.05.28.10.06.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 10:06:55 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	apatard@mandriva.com, huhb@lemote.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, yanh@lemote.com, philippe@cowpig.ca,
	r0bertz@gentoo.org, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, der.herr@hofr.at, liujl@lemote.com,
	erwan@thiscow.com
In-Reply-To: <20090529.004452.242161110.anemo@mba.ocn.ne.jp>
References: <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
	 <m3my8yoovk.fsf@anduin.mandriva.com> <1243450339.11263.125.camel@falcon>
	 <20090529.004452.242161110.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 29 May 2009 01:06:39 +0800
Message-Id: <1243530399.19464.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-05-29 at 00:44 +0900, Atsushi Nemoto wrote:
> On Thu, 28 May 2009 02:52:19 +0800, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
> > index 9dbe48e..1f06fd5 100644
> > --- a/arch/mips/power/hibernate.S
> > +++ b/arch/mips/power/hibernate.S
> ...
> > @@ -39,6 +47,16 @@ LEAF(swsusp_arch_resume)
> >         bne t1, t3, 1b
> >         PTR_L t0, PBE_NEXT(t0)
> >         bnez t0, 0b
> > +       /* flush caches to make sure context is in memory */
> > +       PTR_LA t1, flush_cache_all
> > +       PTR_L t0, 0(t1)
> > +       jalr t0
> > +       nop
> 
> flush_cache_all is cache_noop on r4k.  Maybe __flush_cache_all ?
> 
> Also, you can write this like:
> 
> 	PTR_L t0, flush_cache_all
> 	jalr t0
> 
> The nop just after the jalr is not needed since or are in "reorder"
> mode here.
> 

Applied.

Thanks!
Wu Zhangjin
