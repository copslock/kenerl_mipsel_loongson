Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 06:24:26 +0100 (BST)
Received: from mail-qy0-f103.google.com ([209.85.221.103]:46571 "EHLO
	mail-qy0-f103.google.com") by ftp.linux-mips.org with ESMTP
	id S20026329AbZDVFYR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 06:24:17 +0100
Received: by qyk1 with SMTP id 1so5741069qyk.22
        for <multiple recipients>; Tue, 21 Apr 2009 22:24:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=sr5DyaUB8M9Lgf7rihRoqyNb7m/vciMMYFfHq6v60KI=;
        b=vuvaGYzVoddA2nucSvzVdeNOHJT4305N2QUk0He6Q04AeKwucYGzjmMbNVrPsmOK15
         YQSRLSNQ5fTj4Ja96kk8CprtzIRYmuOc6/aYrw1xBz7OWeQDhKSrQ9esIP3z7SL368T/
         V0GJ6AJ+LVqRvteWpSts5ty/g6tQJJtxb+FsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=P+FIg4S8TA9NdEW0VDwHbNP3AWplKakwaf0i4VFADHUMUcpePtTh4w6rqvz2+/4/Dn
         Tc6AwUP/8Aj89Riz3LD9P5WF9eoHaV3Y3SNhWxJg3w2pP0KdLYzE8LC61DCthgTczqTt
         vrbTnoGy6cvD8Vjq6qqncrZzw+Y2VifLLT9Lw=
MIME-Version: 1.0
Received: by 10.220.95.202 with SMTP id e10mr10169448vcn.12.1240377847803; 
	Tue, 21 Apr 2009 22:24:07 -0700 (PDT)
In-Reply-To: <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
References: <49EE3B0F.3040506@caviumnetworks.com>
	 <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
Date:	Tue, 21 Apr 2009 23:24:07 -0600
Message-ID: <b2b2f2320904212224l1223737en95bffec015f1907e@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64eacb401739c04681df9cc
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64eacb401739c04681df9cc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello David:

On Tue, Apr 21, 2009 at 3:33 PM, David Daney <ddaney@caviumnetworks.com>wrote:

> This is a preliminary patch to add a vdso to all user processes.
> Still missing are ELF headers and .eh_frame information.  But it is
> enough to allow us to move signal trampolines off of the stack.
>
> We allocate a single page (the vdso) and write all possible signal
> trampolines into it.  The stack is moved down by one page and the vdso
> is mapped into this space.


This patch fails to compile for me with an RM7035C-based system (out of
tree, sadly).  The error I see is:

  CC      arch/mips/kernel/syscall.o
arch/mips/kernel/syscall.c: In function 'arch_get_unmapped_area':
arch/mips/kernel/syscall.c:80: error: 'TASK_SIZE32' undeclared (first use in
this function)
arch/mips/kernel/syscall.c:80: error: (Each undeclared identifier is
reported only once
arch/mips/kernel/syscall.c:80: error: for each function it appears in.)
make[1]: *** [arch/mips/kernel/syscall.o] Error 1

I believe it is related to the following portion of the patch:

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index 955c5f0..491e5be 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -77,7 +77,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
> unsigned long addr,
>        int do_color_align;
>        unsigned long task_size;
>
> -       task_size = STACK_TOP;
> +       task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
> TASK_SIZE;
>
>        if (len > task_size)
>                return -ENOMEM;
>

On my system, CONFIG_32BIT is defined and CONFIG_64BIT is not -- looking at
arch/mips/include/asm/processor.h, it appears that TASK_SIZE32 is only
defined when CONFIG_64BIT is defined.

Shane McDonald

--0016e64eacb401739c04681df9cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello David:<br><br><div class=3D"gmail_quote">On Tue, Apr 21, 2009 at 3:33=
 PM, David Daney <span dir=3D"ltr">&lt;<a href=3D"mailto:ddaney@caviumnetwo=
rks.com">ddaney@caviumnetworks.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
This is a preliminary patch to add a vdso to all user processes.<br>
Still missing are ELF headers and .eh_frame information. =A0But it is<br>
enough to allow us to move signal trampolines off of the stack.<br>
<br>
We allocate a single page (the vdso) and write all possible signal<br>
trampolines into it. =A0The stack is moved down by one page and the vdso<br=
>
is mapped into this space.</blockquote><div><br>This patch fails to compile=
 for me with an RM7035C-based system (out of tree, sadly).=A0 The error I s=
ee is:<br><br>=A0 CC=A0=A0=A0=A0=A0 arch/mips/kernel/syscall.o<br>arch/mips=
/kernel/syscall.c: In function &#39;arch_get_unmapped_area&#39;:<br>
arch/mips/kernel/syscall.c:80: error: &#39;TASK_SIZE32&#39; undeclared (fir=
st use in this function)<br>arch/mips/kernel/syscall.c:80: error: (Each und=
eclared identifier is reported only once<br>arch/mips/kernel/syscall.c:80: =
error: for each function it appears in.)<br>
make[1]: *** [arch/mips/kernel/syscall.o] Error 1<br><br>I believe it is re=
lated to the following portion of the patch:<br><br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c<br>
index 955c5f0..491e5be 100644<br>
--- a/arch/mips/kernel/syscall.c<br>
+++ b/arch/mips/kernel/syscall.c<br>
@@ -77,7 +77,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,<br>
 =A0 =A0 =A0 =A0int do_color_align;<br>
 =A0 =A0 =A0 =A0unsigned long task_size;<br>
<br>
- =A0 =A0 =A0 task_size =3D STACK_TOP;<br>
+ =A0 =A0 =A0 task_size =3D test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 =
: TASK_SIZE;<br>
<br>
 =A0 =A0 =A0 =A0if (len &gt; task_size)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;<br>
</blockquote></div><br>On my system, CONFIG_32BIT is defined and CONFIG_64B=
IT is not -- looking at arch/mips/include/asm/processor.h, it appears that =
TASK_SIZE32 is only defined when CONFIG_64BIT is defined.<br><br>Shane McDo=
nald<br>

--0016e64eacb401739c04681df9cc--
