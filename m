Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 10:43:34 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:35849 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab2B2Jna (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 10:43:30 +0100
Received: by werp11 with SMTP id p11so2341338wer.36
        for <linux-mips@linux-mips.org>; Wed, 29 Feb 2012 01:43:25 -0800 (PST)
Received-SPF: pass (google.com: domain of anoop.pa@gmail.com designates 10.180.101.37 as permitted sender) client-ip=10.180.101.37;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of anoop.pa@gmail.com designates 10.180.101.37 as permitted sender) smtp.mail=anoop.pa@gmail.com; dkim=pass header.i=anoop.pa@gmail.com
Received: from mr.google.com ([10.180.101.37])
        by 10.180.101.37 with SMTP id fd5mr18077181wib.1.1330508605492 (num_hops = 1);
        Wed, 29 Feb 2012 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=b7Av3XqmpTnXBW0jNo+I1tZU8Ydc0DFx3gidTW1RhTc=;
        b=dSm3X5P2U+jy01hfAHeOpfw1RFWM65tOpV18YoTioZJvhdH58seMmb5trk0UVwFJca
         i62szniLmlnauFUOKo78nR56HmZwdF8fl11+5BG+q+K14EuXa/uxoTqMf8PzhTGwHSGg
         NHkN54OJr1575JPRwuC9+/N81yhxtB0CuzMRo=
MIME-Version: 1.0
Received: by 10.180.101.37 with SMTP id fd5mr14388531wib.1.1330508605364; Wed,
 29 Feb 2012 01:43:25 -0800 (PST)
Received: by 10.223.151.14 with HTTP; Wed, 29 Feb 2012 01:43:25 -0800 (PST)
In-Reply-To: <CAF1ZMEc-44kBhC=zRaT3Kskgc5LdAtki-fZe7tGf8BgGvQqCOw@mail.gmail.com>
References: <4ED3483E.60204@gmail.com>
        <CAF1ZMEc-44kBhC=zRaT3Kskgc5LdAtki-fZe7tGf8BgGvQqCOw@mail.gmail.com>
Date:   Wed, 29 Feb 2012 15:13:25 +0530
X-Google-Sender-Auth: gNzfP43NGwnstNRC3Dc0zg0Zzxw
Message-ID: <CAK9+9Tzp3-s6N5_ttBQhh+nV3KVafTzgDUcX=VJUfsv89Cc=og@mail.gmail.com>
Subject: Re: Using NFS with HIGHMEM support
From:   Ans_linu <an4linu@gmail.com>
To:     "Dennis.Yxun" <dennis.yxun@gmail.com>
Cc:     Jacky Lam <lamshuyin@gmail.com>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=f46d04428158cb182c04ba172cd4
X-archive-position: 32578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: an4linu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--f46d04428158cb182c04ba172cd4
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

I have faced similar issues before.

Not sure this will help. But please take a look at.

http://www.linux-mips.org/archives/linux-mips/2010-08/msg00075.html

Thanks
Ans

On Mon, Feb 27, 2012 at 3:34 PM, Dennis.Yxun <dennis.yxun@gmail.com> wrote:

> HI:
>  I'm encountered pretty much the same problem here
>  I'm tracing with current 3.3-rc4 branch(from ralf's tree)
>  If I put rootfs at nand flash + highmem enabled, then execute problem may
> give
> illegal instruction error, bus error, try it again may run success.
>  but if I don't enable highmem, then problem is gone.
>  any hints? thanks
>
> Dennis
>
>
> On Mon, Nov 28, 2011 at 4:37 PM, Jacky Lam <lamshuyin@gmail.com> wrote:
>
>> Hi,
>>
>>    I am using mips-linux-3.0.4 with HIGHMEM enabled. Everything is
>> working fine, but I find something strange that when I execute a
>> statically-linked binary through NFS mounted directory. It will gives me an
>> illegal instruction error or  SIGSEGV. If I run it again, the binary can
>> run without problem. I have to reboot or drop all the vm cache in order to
>> reproduce the error again.
>>
>>   Also, if I run the binary in harddisk or dynamically link the binary,
>> no problem will be found.
>>
>>    Any suggestion to debug this problem? Thanks.
>>
>> Jacky
>>
>>
>

--f46d04428158cb182c04ba172cd4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi ,</div>
<div>=A0</div>
<div>I have faced similar issues before. </div>
<div>=A0</div>
<div>Not sure this will help. But please take a look at.</div>
<div>=A0</div>
<div><a href=3D"http://www.linux-mips.org/archives/linux-mips/2010-08/msg00=
075.html">http://www.linux-mips.org/archives/linux-mips/2010-08/msg00075.ht=
ml</a></div>
<div>=A0</div>
<div>Thanks</div>
<div>Ans<br><br></div>
<div class=3D"gmail_quote">On Mon, Feb 27, 2012 at 3:34 PM, Dennis.Yxun <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:dennis.yxun@gmail.com">dennis.yxun@gma=
il.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">HI:<br>=A0I&#39;m encountered pretty =
much the same problem here<br>=A0I&#39;m tracing with current 3.3-rc4 branc=
h(from ralf&#39;s tree)<br>
=A0If I put rootfs at nand flash + highmem enabled, then execute problem ma=
y give<br>illegal instruction error, bus error, try it again may run succes=
s.<br>=A0but if I don&#39;t enable highmem, then problem is gone.<br>=A0any=
 hints? thanks<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>Dennis</font></span>=20
<div class=3D"HOEnZb">
<div class=3D"h5"><br><br>
<div class=3D"gmail_quote">On Mon, Nov 28, 2011 at 4:37 PM, Jacky Lam <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:lamshuyin@gmail.com" target=3D"_blank">l=
amshuyin@gmail.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">Hi,<br><br>=A0 =A0I am using mips-lin=
ux-3.0.4 with HIGHMEM enabled. Everything is working fine, but I find somet=
hing strange that when I execute a statically-linked binary through NFS mou=
nted directory. It will gives me an illegal instruction error or =A0SIGSEGV=
. If I run it again, the binary can run without problem. I have to reboot o=
r drop all the vm cache in order to reproduce the error again.<br>
<br>=A0 Also, if I run the binary in harddisk or dynamically link the binar=
y, no problem will be found.<br><br>=A0 =A0Any suggestion to debug this pro=
blem? Thanks.<span><font color=3D"#888888"><br><br>Jacky<br><br></font></sp=
an></blockquote>
</div><br></div></div></blockquote></div><br>

--f46d04428158cb182c04ba172cd4--
