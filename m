Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2012 11:04:39 +0100 (CET)
Received: from mail-tul01m020-f177.google.com ([209.85.214.177]:33574 "EHLO
        mail-tul01m020-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901172Ab2B0KEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2012 11:04:35 +0100
Received: by obcuz6 with SMTP id uz6so6202409obc.36
        for <linux-mips@linux-mips.org>; Mon, 27 Feb 2012 02:04:29 -0800 (PST)
Received-SPF: pass (google.com: domain of dennis.yxun@gmail.com designates 10.182.216.101 as permitted sender) client-ip=10.182.216.101;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of dennis.yxun@gmail.com designates 10.182.216.101 as permitted sender) smtp.mail=dennis.yxun@gmail.com; dkim=pass header.i=dennis.yxun@gmail.com
Received: from mr.google.com ([10.182.216.101])
        by 10.182.216.101 with SMTP id op5mr4609893obc.54.1330337069143 (num_hops = 1);
        Mon, 27 Feb 2012 02:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mXoxL2GBjrcHD6mD5sMylTWgDDiYPkffcbLVEKgPfCE=;
        b=vJL2wTG7taoA+mP2RhRYkpDWe5EREAAZqCO8MIzBP2DnJI8qgcZ7UJmjb++bQRw9+D
         E157lYSd+BvlQcNxJ/6ES9DJ22/O2h9SXFUIsa5RWA9IrEDYNqwkGYdlnLbT1w704M4y
         bJbmxIE+Q56PJzD+Eb/bP2cb4FWLScNsxSD58=
MIME-Version: 1.0
Received: by 10.182.216.101 with SMTP id op5mr4130930obc.54.1330337069090;
 Mon, 27 Feb 2012 02:04:29 -0800 (PST)
Received: by 10.182.220.68 with HTTP; Mon, 27 Feb 2012 02:04:29 -0800 (PST)
In-Reply-To: <4ED3483E.60204@gmail.com>
References: <4ED3483E.60204@gmail.com>
Date:   Mon, 27 Feb 2012 18:04:29 +0800
Message-ID: <CAF1ZMEc-44kBhC=zRaT3Kskgc5LdAtki-fZe7tGf8BgGvQqCOw@mail.gmail.com>
Subject: Re: Using NFS with HIGHMEM support
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     Jacky Lam <lamshuyin@gmail.com>
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=f46d0447864b6f46e604b9ef3c89
X-archive-position: 32554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--f46d0447864b6f46e604b9ef3c89
Content-Type: text/plain; charset=UTF-8

HI:
 I'm encountered pretty much the same problem here
 I'm tracing with current 3.3-rc4 branch(from ralf's tree)
 If I put rootfs at nand flash + highmem enabled, then execute problem may
give
illegal instruction error, bus error, try it again may run success.
 but if I don't enable highmem, then problem is gone.
 any hints? thanks

Dennis

On Mon, Nov 28, 2011 at 4:37 PM, Jacky Lam <lamshuyin@gmail.com> wrote:

> Hi,
>
>    I am using mips-linux-3.0.4 with HIGHMEM enabled. Everything is working
> fine, but I find something strange that when I execute a statically-linked
> binary through NFS mounted directory. It will gives me an illegal
> instruction error or  SIGSEGV. If I run it again, the binary can run
> without problem. I have to reboot or drop all the vm cache in order to
> reproduce the error again.
>
>   Also, if I run the binary in harddisk or dynamically link the binary, no
> problem will be found.
>
>    Any suggestion to debug this problem? Thanks.
>
> Jacky
>
>

--f46d0447864b6f46e604b9ef3c89
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

HI:<br>=C2=A0I&#39;m encountered pretty much the same problem here<br>=C2=
=A0I&#39;m tracing with current 3.3-rc4 branch(from ralf&#39;s tree)<br>=C2=
=A0If I put rootfs at nand flash + highmem enabled, then execute problem ma=
y give<br>illegal instruction error, bus error, try it again may run succes=
s.<br>
=C2=A0but if I don&#39;t enable highmem, then problem is gone.<br>=C2=A0any=
 hints? thanks<br><br>Dennis<br><br><div class=3D"gmail_quote">On Mon, Nov =
28, 2011 at 4:37 PM, Jacky Lam <span dir=3D"ltr">&lt;<a href=3D"mailto:lams=
huyin@gmail.com">lamshuyin@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
 =C2=A0 =C2=A0I am using mips-linux-3.0.4 with HIGHMEM enabled. Everything =
is working fine, but I find something strange that when I execute a statica=
lly-linked binary through NFS mounted directory. It will gives me an illega=
l instruction error or =C2=A0SIGSEGV. If I run it again, the binary can run=
 without problem. I have to reboot or drop all the vm cache in order to rep=
roduce the error again.<br>

<br>
 =C2=A0 Also, if I run the binary in harddisk or dynamically link the binar=
y, no problem will be found.<br>
<br>
 =C2=A0 =C2=A0Any suggestion to debug this problem? Thanks.<span class=3D"H=
OEnZb"><font color=3D"#888888"><br>
<br>
Jacky<br>
<br>
</font></span></blockquote></div><br>

--f46d0447864b6f46e604b9ef3c89--
