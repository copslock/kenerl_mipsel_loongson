Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 09:34:41 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.195]:16020 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133562AbVL3JeW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2005 09:34:22 +0000
Received: by xproxy.gmail.com with SMTP id s19so1051150wxc
        for <linux-mips@linux-mips.org>; Fri, 30 Dec 2005 01:36:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=QTtfqt4IHcNcaZ7bM7I4LIhfjut69o6C6bSNZtWF/dr5kWuUx/BXWbssmk/RYStrf6W2OunNNhqlxDkquNBBYMMymfgmGKkJfY2ZXPC2BS26AvBylqF80o/Jbqfyf2nylvIP0JIc/mFW1BNYhbZVF6n77pyIKD5n1vrQUqgcNjY=
Received: by 10.70.97.9 with SMTP id u9mr10190202wxb;
        Fri, 30 Dec 2005 01:36:22 -0800 (PST)
Received: by 10.70.94.10 with HTTP; Fri, 30 Dec 2005 01:36:22 -0800 (PST)
Message-ID: <82e4189c0512300136w5112edf2kf3d243ddbc9313d@mail.gmail.com>
Date:	Fri, 30 Dec 2005 14:36:22 +0500
From:	Adil Hafeez <adilhafeez80@gmail.com>
To:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Fixed kernel entry point suggestion
Cc:	linux-mips@linux-mips.org
In-Reply-To: <06af7c9f9f82dd2b306e02997869e709@embeddedalley.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18434_15657856.1135935382945"
References: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com>
	 <06af7c9f9f82dd2b306e02997869e709@embeddedalley.com>
Return-Path: <adilhafeez80@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adilhafeez80@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_18434_15657856.1135935382945
Content-Type: multipart/alternative; 
	boundary="----=_Part_18435_27731220.1135935382945"

------=_Part_18435_27731220.1135935382945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dan,

Here is the patch.

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index eebdaa2..a5e6d4e 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -28,6 +28,7 @@
#include <asm/mipsregs.h>
#include <asm/stackframe.h>

+        j kernel_entry
.text
/*
* Reserved space for exception handlers.

On 12/28/05, Dan Malek <dan@embeddedalley.com> wrote:

>
> On Dec 28, 2005, at 2:36 AM, Adil Hafeez wrote:
>
> > Everytime we add/remove a feature from kernel location of entry_point
> > symbol changes.
>
> If you "wrap" the kernel image with a simple header and have a boot
> loader
> that understands this, or even understands the ELF header, or download
> S-records (yuk) as most systems do, I guess it isn't necessary to fix
> this.
> I've been providing the compressed zImage patches for a long time that
> solves
> this, as well as the u-boot uImage patches.  The process of building
> these
> images not only locates the proper entry point, but it provides
> advantages
> for embedded systems by creating smaller images and faster boot times.
>
> >  .....   Adding a simply jump instruction to kernel_entry point in
> > head.S can solve this problem. Why dont we make this change permanent
> > in kernel.
>
> :-)  It seems MIPS likes to be different from other architectures that
> have
> solved these irritating little details years ago :-)  Submit a patch
> and see
> what happens, as just complaining on the list isn't likely to make it
> happen.
>
> Thanks.
>
>        -- Dan
>
>

------=_Part_18435_27731220.1135935382945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Dan,</div>
<div>&nbsp;</div>
<div>Here is the patch.</div>
<div>&nbsp;</div>
<div>diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S<br>inde=
x eebdaa2..a5e6d4e 100644<br>--- a/arch/mips/kernel/head.S<br>+++ b/arch/mi=
ps/kernel/head.S<br>@@ -28,6 +28,7 @@<br>#include &lt;asm/mipsregs.h&gt;
<br>#include &lt;asm/stackframe.h&gt;<br><br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; j kernel_entry<br>.text<br>/*<br>* Reserved space for excepti=
on handlers.<br><br><span class=3D"gmail_quote">On 12/28/05, <b class=3D"gm=
ail_sendername">Dan Malek</b> &lt;<a href=3D"mailto:dan@embeddedalley.com">
dan@embeddedalley.com</a>&gt; wrote:</span></div>
<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Dec 28, 2005, at 2:36 AM,=
 Adil Hafeez wrote:<br><br>&gt; Everytime we add/remove a feature from kern=
el location of entry_point
<br>&gt; symbol changes.<br><br>If you &quot;wrap&quot; the kernel image wi=
th a simple header and have a boot<br>loader<br>that understands this, or e=
ven understands the ELF header, or download<br>S-records (yuk) as most syst=
ems do, I guess it isn't necessary to fix
<br>this.<br>I've been providing the compressed zImage patches for a long t=
ime that<br>solves<br>this, as well as the u-boot uImage patches.&nbsp;&nbs=
p;The process of building<br>these<br>images not only locates the proper en=
try point, but it provides
<br>advantages<br>for embedded systems by creating smaller images and faste=
r boot times.<br><br>&gt;&nbsp;&nbsp;.....&nbsp;&nbsp; Adding a simply jump=
 instruction to kernel_entry point in<br>&gt; head.S can solve this problem=
. Why dont we make this change permanent
<br>&gt; in kernel.<br><br>:-)&nbsp;&nbsp;It seems MIPS likes to be differe=
nt from other architectures that<br>have<br>solved these irritating little =
details years ago :-)&nbsp;&nbsp;Submit a patch<br>and see<br>what happens,=
 as just complaining on the list isn't likely to make it
<br>happen.<br><br>Thanks.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- D=
an<br><br></blockquote></div><br>

------=_Part_18435_27731220.1135935382945--

------=_Part_18434_15657856.1135935382945
Content-Type: text/plain; name="kernel_entry-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kernel_entry-fix.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwvaGVhZC5TIGIvYXJjaC9taXBzL2tlcm5lbC9o
ZWFkLlMKaW5kZXggZWViZGFhMi4uYTVlNmQ0ZSAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2tlcm5l
bC9oZWFkLlMKKysrIGIvYXJjaC9taXBzL2tlcm5lbC9oZWFkLlMKQEAgLTI4LDYgKzI4LDcgQEAK
ICNpbmNsdWRlIDxhc20vbWlwc3JlZ3MuaD4KICNpbmNsdWRlIDxhc20vc3RhY2tmcmFtZS5oPgog
CisgICAgICAgIGoga2VybmVsX2VudHJ5CiAJCS50ZXh0CiAJCS8qCiAJCSAqIFJlc2VydmVkIHNw
YWNlIGZvciBleGNlcHRpb24gaGFuZGxlcnMuCg==
------=_Part_18434_15657856.1135935382945--
