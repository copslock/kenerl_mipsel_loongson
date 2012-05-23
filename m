Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 10:17:31 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:44667 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903599Ab2EWIR1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 10:17:27 +0200
Received: by yenr9 with SMTP id r9so7024428yen.36
        for <linux-mips@linux-mips.org>; Wed, 23 May 2012 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mtzBsZT7O6PhFEgDzAFMBCMKTX3lJfDLDyWFyBQapAw=;
        b=CQ6m3MR6553TjKFm1DxUwpq9U2zb22icj58wYqQ0a4v3MS2dK+TwidZBBfICsMcOdM
         s5U7zEopc5y5w22MZCb7gWw9OnbOxr8znveATsPRmyOVnk5BL07D53fQldSSkEsLSdPa
         n4zIBa9/Llo6TC4P2+8U62P4SXMB1LTO4so6paLPifhwU/sFPggXsKBPbaI83vtXtVpM
         p4auWhmmyxH7+L8bcYmmOTnDWKaFv9Y5kxq9fdnu9/IMyj0eI2660CDYiBhwhW026FJh
         U5m0WCEDQk+Q1DuyCpjMNPhXuo2unobOcn7JHOmG/Qe2zcCfoRHozQcdXs+L4RLxSzXT
         u20A==
MIME-Version: 1.0
Received: by 10.50.149.170 with SMTP id ub10mr12095207igb.38.1337761041021;
 Wed, 23 May 2012 01:17:21 -0700 (PDT)
Received: by 10.231.243.4 with HTTP; Wed, 23 May 2012 01:17:21 -0700 (PDT)
In-Reply-To: <4FBBED1F.5010307@cavium.com>
References: <CADSewLWvfVsQob-y5Q9mc31JpecHFd6=5dRhKxdH3VvT0HXJZQ@mail.gmail.com>
        <4FBBED1F.5010307@cavium.com>
Date:   Wed, 23 May 2012 16:17:21 +0800
Message-ID: <CADSewLVXToTws06sH5CMXec_nAH-c+OCTN5-XvOKbAQdJHtLKg@mail.gmail.com>
Subject: Re: handle_sys question
From:   Songmao Tian <kingkongmao@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=e89a8f3ba309a4f93a04c0afc36e
X-archive-position: 33434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kingkongmao@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--e89a8f3ba309a4f93a04c0afc36e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

OK, I find the usage. continue to read the code:-), thanks.

587 static int handle_signal(unsigned long sig, siginfo_t *info,
588     struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)
589 {
590     int ret;
=85=85
602     /* fallthrough */
603     case ERESTARTNOINTR:        /* Userland will reload $v0.  */
604         regs->regs[7] =3D regs->regs[26];
605         regs->cp0_epc -=3D 8;
606     }



2012/5/23 David Daney <david.daney@cavium.com>

> On 05/22/2012 02:40 AM, Songmao Tian wrote:
>
>> Hello all:
>>    In handle_sys there's a
>> 50
>> <http://git.kernel.org/?p=3D**linux/kernel/git/torvalds/**
>> linux-2.6.git;a=3Dblob;f=3Darch/**mips/kernel/scall32-o32.S;h=3D**
>> a632bc144efa1b9ca977a582864530**e33ee039cb;hb=3D**
>> 72c04af9a2d57b7945cf3de8e71461**bd80695d50#l50<http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/kernel/sc=
all32-o32.S;h=3Da632bc144efa1b9ca977a582864530e33ee039cb;hb=3D72c04af9a2d57=
b7945cf3de8e71461bd80695d50#l50>
>> >
>>
>>         sw      a3, PT_R26(sp)          # save a3 for syscall restarting
>>
>> I woner why it need to save  a3 in R26(k0) slot in the stack?
>>
>>
> It has to go somewhere.  The K0 and K1 slots aren't used to save other
> things.
>
> David Daney
>

--e89a8f3ba309a4f93a04c0afc36e
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

OK, I find the usage. continue to read the code:-), thanks.<br><br>587 stat=
ic int handle_signal(unsigned long sig, siginfo_t *info,<br>588=A0=A0=A0=A0=
 struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)<br>589 {=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>

590=A0=A0=A0=A0 int ret;<br>=85=85<br>602=A0=A0=A0=A0 /* fallthrough */<br>=
603=A0=A0=A0=A0 case ERESTARTNOINTR:=A0=A0=A0=A0=A0=A0=A0 /* Userland will =
reload $v0.=A0 */<br>604=A0=A0=A0=A0=A0=A0=A0=A0 regs-&gt;regs[7] =3D regs-=
&gt;regs[26];<br>605=A0=A0=A0=A0=A0=A0=A0=A0 regs-&gt;cp0_epc -=3D 8;<br>60=
6=A0=A0=A0=A0 }=A0=A0 <br>
<br><br><br><div class=3D"gmail_quote">2012/5/23 David Daney <span dir=3D"l=
tr">&lt;<a href=3D"mailto:david.daney@cavium.com" target=3D"_blank">david.d=
aney@cavium.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On 05/22/2012 02:40 AM, Songmao Tian wrote:<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div class=3D"im">
Hello all:<br>
 =A0 =A0In handle_sys there&#39;s a<br>
50<br></div>
&lt;<a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2=
.6.git;a=3Dblob;f=3Darch/mips/kernel/scall32-o32.S;h=3Da632bc144efa1b9ca977=
a582864530e33ee039cb;hb=3D72c04af9a2d57b7945cf3de8e71461bd80695d50#l50" tar=
get=3D"_blank">http://git.kernel.org/?p=3D<u></u>linux/kernel/git/torvalds/=
<u></u>linux-2.6.git;a=3Dblob;f=3Darch/<u></u>mips/kernel/scall32-o32.S;h=
=3D<u></u>a632bc144efa1b9ca977a582864530<u></u>e33ee039cb;hb=3D<u></u>72c04=
af9a2d57b7945cf3de8e71461<u></u>bd80695d50#l50</a>&gt;<div class=3D"im">
<br>
 =A0 =A0 =A0 =A0 sw =A0 =A0 =A0a3, PT_R26(sp) =A0 =A0 =A0 =A0 =A0# save a3 =
for syscall restarting<br>
<br>
I woner why it need to save =A0a3 in R26(k0) slot in the stack?<br>
<br>
</div></blockquote>
<br>
It has to go somewhere. =A0The K0 and K1 slots aren&#39;t used to save othe=
r things.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
David Daney<br>
</font></span></blockquote></div><br>

--e89a8f3ba309a4f93a04c0afc36e--
