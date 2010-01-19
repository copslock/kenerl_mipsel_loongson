Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 11:28:07 +0100 (CET)
Received: from mail-pz0-f172.google.com ([209.85.222.172]:36420 "EHLO
        mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491966Ab0ASK2E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2010 11:28:04 +0100
Received: by pzk2 with SMTP id 2so1312152pzk.21
        for <multiple recipients>; Tue, 19 Jan 2010 02:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZMYwqbMVs1386mM1fARsthMo2UgWYtR7AvWSQmaa+sM=;
        b=iQOu4tz+wiAtlHo34HlrPPLYsbqmqRctLqtfyLevI2Dywvz93WLR9O00OWlX7TWLVZ
         0HoHVnNVchx7TRYDNerxDKqkNHz8zuTt8UJK0OeNwkXxUFFf7weeEqNXjBDtOizYZfKR
         eAFIN0+m+xTo6diD8k4QAQd9DTh2dcamGnVic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=MSTTrKLnnpfi4jdndZviE/m5MHOyi7q3Ppo+BqegbV8p3L1At5oy1iGXs7bh7SwOyv
         cmHIzbaMHIkMWH9bSOG5onI19QMuL4BFFKlAESEsPslS1oDl0yvfiLU/1lupt2gTcNp3
         Unv3EoogZSX7Bx+tnQ3EGlTbmzsqf2KFnT6BM=
Received: by 10.142.59.16 with SMTP id h16mr5081103wfa.161.1263896875997;
        Tue, 19 Jan 2010 02:27:55 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5008955pzk.2.2010.01.19.02.27.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 02:27:55 -0800 (PST)
Subject: Re: [PATCH v1] MIPS: fix vmlinuz build when only 32bit math shell
 is available
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100119095556.GF32413@chipmunk>
References: <42fa29d2007a40a31a0bb8fbf1091e11eb9b5ac2.1263893871.git.wuzhangjin@gmail.com>
         <20100119095556.GF32413@chipmunk>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 19 Jan 2010 18:27:29 +0800
Message-ID: <1263896850.29352.23.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12427

Hi,

On Tue, 2010-01-19 at 09:55 +0000, Alexander Clouter wrote:
[...]
> >
> As a passing query, why do we have the high 32bit (0xffffffff....) spiel 
> if later we can just make VMLINU[XZ]_LOAD_ADDRESS the low half?  I see 
> the output of 'nm' shows:
> ----
> alex@berk:/usr/src/wag54g/linux$ nm vmlinux | head -n1
> 941019e4 t .ex0
> alex@berk:/usr/src/wag54g/linux$ nm vmlinuz | head -n1
> 944abb50 B .heap
> ----
> 

Mine:

$ mips64el-unknown-linux-gnu-nm vmlinux | head -n1
ffffffff80202304 t .ex0
$ mips64el-unknown-linux-gnu-nm vmlinuz | head -n1
ffffffff80b174e0 B .heap

and exactly, here is why we need to reserve the high 32bit:

$ cat arch/mips/Makefile | grep ^load | grep -v 0xffffffff
load-$(CONFIG_MIPS_SIM)		+= 0x80100000
load-$(CONFIG_SGI_IP27)		+= 0xc00000004001c000
load-$(CONFIG_SGI_IP27)		+= 0xa80000000001c000
load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000

(Hi, Ralf, can we use the low 32bit directly?)

> However I am guessing it's some 64bit CPU requirement as my x86_64 
> kernel seems to have 0xffffffff....  Which raises the question, why is 
> AR7 not just using VMLINUX_LOAD_ADDRESS=0x94100000?
> 
> > 1. Append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it
> > exists.
> > 
> > 2. Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
> > with printf "%08x" (08 herein is used to prefix the result with 0...)
> > 
> > The corresponding shell script is:
> > 
> >   A=$VMLINUX_LOAD_ADDRESS;
> >   # Append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it exists.
> >   [ "${A:0:10}" != "${A}" ] && echo -n ${A:2:8};
> >   # Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
> >   printf "%08x" $(($VMLINUX_SIZE + 0x${A:(-8)}))
> > 
> Eugh, bash-ism's...
> ----
> alex@berk:/usr/src/wag54g/linux$ bash -c 'A=1234567890; echo ${A:0:5}'
> 12345
> alex@berk:/usr/src/wag54g/linux$ dash -c 'A=1234567890; echo ${A:0:5}'
> dash: Bad substitution
> ----

Ooh! really forget to test it with the dash, dash.... So, this revision
is also broken ;(

> 
> Your 'punishment', use Plan9 for a period of no less than a week! :)
>

I have never played with Plan9, but ubuntu, archlinux, gentoo... and
created my user with "useradd -s /bin/bash ....", so, I only work with
bash ;)

> You have to use the pattern matching approach I used in my original 
> patch, that's portable.  Look at 'man 1 dash' and search for 'substr' 
> for more details.

To consider "portable" and "good-looking", Perhaps it's better to use C
language here ;)

Thanks!

Regards,
	Wu Zhangjin
