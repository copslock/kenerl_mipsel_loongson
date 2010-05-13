Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2010 04:19:56 +0200 (CEST)
Received: from mail-yx0-f199.google.com ([209.85.210.199]:35519 "EHLO
        mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490953Ab0EMCTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 May 2010 04:19:52 +0200
Received: by yxe37 with SMTP id 37so155446yxe.21
        for <multiple recipients>; Wed, 12 May 2010 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=E6gT98Hl8O0bARMF8yjrD78H4HVwIWEZGrmunNonFiA=;
        b=ZN+cAm29EypYxoVmpceTOvRhpelarNgki04zohW8CKxznASKBrAKuQcIKv+jlvOGLp
         Phw+iEtM1W6CtsWDVocWL7JSs2dYxQVBDW2Qk+QuEFHHx22TN/yRvkxlWeVNtP0l583h
         fUKKmVQtgfw826qyPx5PYvTxvyh/jF9uAFEAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=PK+qnEMYzyNhLRZElrHxJgavnmmBsXetk69BT4K3Uw+cNzUlUwFFBxB64scmH31xZk
         7JOdDKmRrPqrGrycXKZC+YaujnMKjugiyQJ+rpkT/2PI0TChu7Bkn2Qi+JY0jUkq+fHk
         jdCBtUVssMUciNTqj5krhh6JeAFpg+MD1sa88=
Received: by 10.101.29.16 with SMTP id g16mr5550298anj.245.1273717183971;
        Wed, 12 May 2010 19:19:43 -0700 (PDT)
Received: from [192.168.2.222] ([202.201.14.140])
        by mx.google.com with ESMTPS id t2sm1423327ani.8.2010.05.12.19.19.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 19:19:42 -0700 (PDT)
Subject: Re: [PATCH 9/9] tracing: MIPS: cleanup of the address space
 checking
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <david.s.daney@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <4BEAE19D.40502@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
         <86404e31ca5c4c33b785bad7f6223ac775f4f879.1273669419.git.wuzhangjin@gmail.com>
         <4BEAE19D.40502@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 13 May 2010 10:19:36 +0800
Message-ID: <1273717176.26290.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-05-12 at 10:13 -0700, David Daney wrote:
> On 05/12/2010 06:23 AM, Wu Zhangjin wrote:
> > From: Wu Zhangjin<wuzhangjin@gmail.com>
> >
> > This patch adds an inline function in_module() to check which space the
> > instruction pointer in, kernel space or module space.
> >
> > Note: This may not work when the kernel is compiled with -msym32.
> >
> 
> The kernel is always compiled with -msym32, so the patch is a bit pointless.
> 
> 

In reality, with -msym32, it works well on my machine, but seems you and
some other people told me that it may not work when the kernel and
module space are the same with -msym32 and some other options. perhaps I
need to change the comments to just:

Note: This will not work when the kernel and module space are the same.

If the kernel and module space are the same, We just need to modify the
recording of the calling site to _mcount in scripts/recordmcount.pl and
tune the related address handling in
ftrace_make_nop()/ftrace_make_call().

But I have no such situation to test, how can I simply let the module
has the same address space as the kernel. without -mlong-calls? and
should we change arch/mips/kernel/vmlinux.lds.S and
arch/mips/kernel/module.c?

If the module space and kernel space are the same, we may remove the
long call from the module space to kernel space to speedup the function
call.

> >
> > diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> > index 628e90b..37f15b6 100644
> > --- a/arch/mips/kernel/ftrace.c
> > +++ b/arch/mips/kernel/ftrace.c
> > @@ -17,6 +17,17 @@
> >   #include<asm/cacheflush.h>
> >   #include<asm/uasm.h>
> >
> > +/*
> > + * If the Instruction Pointer is in module space (0xc0000000), return true;
> > + * otherwise, it is in kernel space (0x80000000), return false.
> > + *
> > + * FIXME: This may not work when the kernel is compiled with -msym32.
> > + */
> > +static inline int in_module(unsigned long ip)
> > +{
> > +	return ip&  0x40000000;
> > +}
> > +
> 
> How about (untested):
> 
> 
> static inline int in_module(unsigned long ip)
> {
> 	return ip < _text || ip > _etext;
> }
> 

It may work, thanks!

> 
> But why do we even care?  Can't we just probe the function prologue and 
> determine from that what needs to be done?

Yes, it should work via checking the instructions in the memory before
the ip but I think a lighter solution is better.

Thanks & Regards,
	Wu Zhangjin
