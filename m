Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 05:17:20 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:42336 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491017Ab0CMERR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 05:17:17 +0100
Received: by gyg10 with SMTP id 10so201796gyg.36
        for <multiple recipients>; Fri, 12 Mar 2010 20:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=CF5NZPK+KByhp9+exGmuk7yn2/+85SqPK8ZdRIHrrD0=;
        b=g76Zqyt/0fpapKtiQve03R94WSEQz+gavTsKP7beS2kLjP6jDAzPF7NEMNxCHjX7l5
         Kmp36DRTf6xn4jsvW2DQXXLkmwb5pQUCL105tQeguOc67ruFMHt+KWDRrVhbt9h39hrg
         zQ/fc69ToYySDc+uFJ67kZYfxyYa6Ses6sUbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=cSJlg/C+PKaU0+ciqKQluBJNkpRaoIWPKcIFQDZ1dYQeMK5Z9LQJ2SlgpZLzFjWrB9
         MBZVT8w+0H0uyRDqADSd0jtHlXGShfrwnmx+IL5lkCS3e5y61upurdewHS5E+srVnTi0
         KCNa9HyLhn9PUEc1ewOJ4+e1v7me0VuvZMxV8=
Received: by 10.101.90.7 with SMTP id s7mr2591703anl.176.1268453830927;
        Fri, 12 Mar 2010 20:17:10 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 23sm1409637iwn.10.2010.03.12.20.17.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:17:10 -0800 (PST)
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
In-Reply-To: <1268394209.6447.94.camel@falcon>
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
         <4B993B32.7000006@caviumnetworks.com>  <1268394209.6447.94.camel@falcon>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 13 Mar 2010 12:10:36 +0800
Message-ID: <1268453436.21443.10.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-03-12 at 19:43 +0800, Wu Zhangjin wrote:
[...]
> > > + * otherwise, it is in kernel space (0x80000000), return false.
> > > + */
> > > +#define in_module(ip) (unlikely((ip)&  0x40000000))
> > > +
> > 
> > This isn't universally true, but it does hold for most configurations I 
> > think.
> 
> Although I'm not sure who is the exception, we always need an universal
> solution, what about this:
> 
> Compare module with kernel:
> 
> module:
> 
>         <saving registers>
> 
>         lui     v1, hi16_mcount                <--- ip
>         addiu   v1, v1, lo16_mcount
>         move    at, ra
>         jalr    v1
>          nop
> 
> kernel:
> 
>         <saving registers>
> 
>          move    at, ra
>          jal     _mcount                       <--- ip
> 
> The above _ip_ is the address have been recorded into the __mcount_loc
> section of the kernel by scripts/recordmcount.pl, as we can see, for
> kernel, the *(ip - 4) is "move at, ra": 03e0082d, a certain instruction,
> but for module, there is no possibility(?) of existing a "move at, ra"
> at *(ip -4) but a register saving operation("s {d,w} rs, offset(sp)",
> prefixed by 0xffb0 for 64bit and 0xafb0 for 32bit. ), and reversly, for
> kernel, there is no such instruction there.
> 
> And consider the new option -mmcount-ra-address of gcc, some more
> instructions will be inserted between "move at, ra" and the calling site
> to mcount, so, *(ip-4) will not always be "move at, ra", then we need to
> check if there is a "s {d,w} rs, offset(sp)" there, if yes, it is in
> module, otherwise, it should be in kernel.
> 
> #define S_RS_SP          0xafb00000      /* s{d,w} rs, offset(sp) */
> 
> static inline int in_module(ip)
> {
> 	insn = *(ip - 4); /* need to use safe_load_code instead, what about big
> endian? */
> 
> 	return ((insn & S_RS_SP) == S_RS_SP)
> }

The above method is not available for some cases, to avoid bring Ftrace
with extra overhead, currently, I will keep using the original version
although it may not work for some cases either.

And to let ftrace_make_nop/ftrace_make_call be lightweight, I will also
keep using the "b 1f" method in the old version.

Regards,
	Wu Zhangjin
