Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 07:44:40 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:61299 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903707Ab1LIGod (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2011 07:44:33 +0100
Received: by eaac10 with SMTP id c10so1871158eaa.36
        for <multiple recipients>; Thu, 08 Dec 2011 22:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yMmjZk3lJDxGN/zDeoK9iof7ArEnaB66jZ1dBxOdzB0=;
        b=KLihlJzyZ09SsE/GluPXBdxa0DgsThuIZrUNI2hKY59f65JwQTeZLPapL4WUwZC24H
         396UH7yrYm/RkfF/gNeCUDTPfn++v+dhR17KICzJTc3dUk9EYzgySEf3b57ZLPKpOkOg
         dptSbLyYKPRS9RQxXKeM+iul8v5coUXpx10N8=
MIME-Version: 1.0
Received: by 10.213.29.138 with SMTP id q10mr581387ebc.35.1323413067768; Thu,
 08 Dec 2011 22:44:27 -0800 (PST)
Received: by 10.14.37.15 with HTTP; Thu, 8 Dec 2011 22:44:27 -0800 (PST)
In-Reply-To: <20111208130835.GC10113@linux-mips.org>
References: <1322729078-6141-1-git-send-email-zhzhl555@gmail.com>
        <20111208130835.GC10113@linux-mips.org>
Date:   Fri, 9 Dec 2011 14:44:27 +0800
Message-ID: <CANY2MLLNVmmU_cDTTS-dYemt1CHQewHm=b87OafAB=kL6GHFmQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add RTC support for loongson1B
From:   zhao zhang <zhzhl555@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        keguang.zhang@gmail.com, wuzhangjin@gmail.com, r0bertz@gentoo.org
Content-Type: multipart/alternative; boundary=0015174be8facba57504b3a31d38
X-archive-position: 32065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhzhl555@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7420

--0015174be8facba57504b3a31d38
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Thanks for Ralf's replay.

Since the read address and the write address are different, so i am worry
about
the out-of-order execution. I just want make sure the read instruction
*not*
ahead of that write instruction.

I didn't know about the detail principle of out-of-order execution on this
SOC, and
i didn't know the read for different address will also complete after all
preceeding
writes have completed.




=D4=DA 2011=C4=EA12=D4=C28=C8=D5 =CF=C2=CE=E79:08=A3=ACRalf Baechle <ralf@l=
inux-mips.org>=D0=B4=B5=C0=A3=BA

> On Thu, Dec 01, 2011 at 04:44:38PM +0800, zhzhl555@gmail.com wrote:
>
> > +     writel(t, SYS_TOYWRITE1);
> > +     __asm__ volatile ("sync");
> > +     c =3D 0x10000;
> > +     while ((readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TS) && --c)
> > +             usleep_range(1000, 3000);
>
> Why the SYNC instruction?  This is an uncached write and on all MIPS CPUs
> the SYNC instruction will only make sure the write has left the CPU's
> write buffers.  There is no guarantee that by the time the SYNC has
> completed
> the write has actually reached its destination.  If that is what you want=
,
> read something from device.  Reads will only complete after all preceedin=
g
> writes have completed.
>
> In this driver all instances of SYNC instructions are followed by polling
> loops reading from the RTC which means all SYNCs should be unnecessary.
>
> Or?
>
>  Ralf
>

--0015174be8facba57504b3a31d38
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Thanks for Ralf&#39;s replay.<br>
<br>
Since the read address and the write address are different, so i am=20
worry about <br>
the <span class=3D"st">out-of-order execution. </span>I just want make=20
sure the read instruction *not* <br>
ahead of that write =20
instruction.<br>
<br>
I didn&#39;t know about the detail principle of <span class=3D"st">out-of-o=
rder
 execution</span> on this SOC, and<br>
i didn&#39;t know the read for different address will also complete after=
=20
all preceeding<br>

writes have completed.<br>

 <br><br><br><br><div class=3D"gmail_quote">=D4=DA 2011=C4=EA12=D4=C28=C8=
=D5 =CF=C2=CE=E79:08=A3=ACRalf Baechle <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;</span>=D0=B4=B5=C0=A3=
=BA<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex=
; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Thu, Dec 01, 2011 at 04:44:38PM +0800, <a href=3D"mail=
to:zhzhl555@gmail.com">zhzhl555@gmail.com</a> wrote:<br>
<br>
&gt; + &nbsp; &nbsp; writel(t, SYS_TOYWRITE1);<br>
&gt; + &nbsp; &nbsp; __asm__ volatile (&quot;sync&quot;);<br>
&gt; + &nbsp; &nbsp; c =3D 0x10000;<br>
&gt; + &nbsp; &nbsp; while ((readl(SYS_COUNTER_CNTRL) &amp; SYS_CNTRL_TS) &=
amp;&amp; --c)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; usleep_range(1000, 3000);<=
br>
<br>
</div>Why the SYNC instruction? &nbsp;This is an uncached write and on all =
MIPS CPUs<br>
the SYNC instruction will only make sure the write has left the CPU&#39;s<b=
r>
write buffers. &nbsp;There is no guarantee that by the time the SYNC has co=
mpleted<br>
the write has actually reached its destination. &nbsp;If that is what you w=
ant,<br>
read something from device. &nbsp;Reads will only complete after all precee=
ding<br>
writes have completed.<br>
<br>
In this driver all instances of SYNC instructions are followed by polling<b=
r>
loops reading from the RTC which means all SYNCs should be unnecessary.<br>
<br>
Or?<br>
<font color=3D"#888888"><br>
 &nbsp;Ralf<br>
</font></blockquote></div><br>

--0015174be8facba57504b3a31d38--
