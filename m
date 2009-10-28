Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:55:27 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:49477 "EHLO
	mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492921AbZJ1TzU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:55:20 +0100
Received: by bwz26 with SMTP id 26so1430883bwz.27
        for <multiple recipients>; Wed, 28 Oct 2009 12:55:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZM1oBuZ+dh3iw4sP8Q0cKjgY26ja2H/5zZ107TK8+a8=;
        b=iKXCW2vq2t6jBmgFyH1GY0kegKr69nTQ2eL+mqEgFHXlKnX0/TRPeuFNE+Y2d46Geg
         px75QDQ0VSxd/Q9puv+6nWm4mVu0NL+I69aoFUszWWvwVjYZA/CBpAvM9aD4Cg8LJeIS
         ookrsy/LZ1/tT6beQz5RzxJXSPTjuTvzM4CI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=P5RdiAr/ZySBQM6EVtaCxAMqdGmHTgYnulXUJPoIKB/21/yAv2fAOL6ZDuRSA2z2+E
         BNZirWFcLBNlllSZXcRn4Dv/XQChozqnQ4rwgsyb6hFH4amO6D4k9bLP+UIYQUNo/FSb
         6gdeSHdfrDqCMcPIIxn5cd2QsRw70IddYetyM=
MIME-Version: 1.0
Received: by 10.223.21.3 with SMTP id h3mr664830fab.39.1256759714433; Wed, 28 
	Oct 2009 12:55:14 -0700 (PDT)
In-Reply-To: <4AE89D2E.4060704@ru.mvista.com>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
	 <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
	 <4AE89D2E.4060704@ru.mvista.com>
Date:	Wed, 28 Oct 2009 20:55:14 +0100
Message-ID: <f861ec6f0910281255p1ca1de93x73bd94afe1bc8806@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: multipart/alternative; boundary=00151747609a58cb3a0477042cbf
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

--00151747609a58cb3a0477042cbf
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 28, 2009 at 8:36 PM, Sergei Shtylyov <sshtylyov@ru.mvista.com>wrote:

> Hello.
>
>
> Manuel Lauss wrote:
>
>  UART autodetection breaks on the Au1300 but the IP blocks are
>> identical, at least in the datasheets.
>>
>
>  Pass uart type on to the 8250 driver via platform data, and move
>> the MSR quirk to another place sind autoconf() is now no longer
>>
>
>   s/sind autoconf/since autoconfig/
>

Yeah, I suck at writing descriptions. Will fix.


 called on init.
>

 Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Tested on DB1200 and DB1300.
> The mips parts apply on top of Ralf's mips-queue tree.
>
>  arch/mips/alchemy/common/platform.c |    4 +++-
>  drivers/serial/8250.c               |   13 +++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/alchemy/common/platform.c
> b/arch/mips/alchemy/common/platform.c
> index 195e5b3..3be14b0 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -26,7 +26,9 @@
>                .irq            = _irq,                         \
>                .regshift       = 2,                            \
>                .iotype         = UPIO_AU,                      \
> -               .flags          = UPF_SKIP_TEST | UPF_IOREMAP   \
> +               .flags          = UPF_SKIP_TEST | UPF_IOREMAP | \
> +                                 UPF_FIXED_TYPE,               \
>

  Good to know this has been implemented.
>

David Daney implemented this recently for his Octeon port, it's a very handy
feature for sure.

Thank you !
      Manuel Lauss

--00151747609a58cb3a0477042cbf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Oct 28, 2009 at 8:36 PM, Sergei =
Shtylyov <span dir=3D"ltr">&lt;<a href=3D"mailto:sshtylyov@ru.mvista.com">s=
shtylyov@ru.mvista.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
Hello.<div class=3D"im"><br>
<br>
Manuel Lauss wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
UART autodetection breaks on the Au1300 but the IP blocks are<br>
identical, at least in the datasheets.<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Pass uart type on to the 8250 driver via platform data, and move<br>
the MSR quirk to another place sind autoconf() is now no longer<br>
</blockquote>
<br></div>
 =A0 s/sind autoconf/since autoconfig/<br><div class=3D"im"></div></blockqu=
ote><div class=3D"im"><br>Yeah, I suck at writing descriptions. Will fix. <=
br><br><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
called on init.<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Signed-off-by: Manuel Lauss &lt;<a href=3D"mailto:manuel.lauss@gmail.com" t=
arget=3D"_blank">manuel.lauss@gmail.com</a>&gt;<br>
---<br>
Tested on DB1200 and DB1300.<br>
The mips parts apply on top of Ralf&#39;s mips-queue tree.<br>
<br>
=A0arch/mips/alchemy/common/platform.c | =A0 =A04 +++-<br>
=A0drivers/serial/8250.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 +++++++------=
<br>
=A02 files changed, 10 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common=
/platform.c<br>
index 195e5b3..3be14b0 100644<br>
--- a/arch/mips/alchemy/common/platform.c<br>
+++ b/arch/mips/alchemy/common/platform.c<br>
@@ -26,7 +26,9 @@<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D _irq, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iotype =A0 =A0 =A0 =A0 =3D UPIO_AU, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_SKIP_TEST |=
 UPF_IOREMAP =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_SKIP_TEST |=
 UPF_IOREMAP | \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UPF_FIXED=
_TYPE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
</blockquote>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
 =A0 Good to know this has been implemented.<br></blockquote><div><br>David=
 Daney implemented this recently for his Octeon port, it&#39;s a very handy=
 feature for sure.<br></div></div><br>Thank you !<br>=A0=A0=A0=A0=A0 Manuel=
 Lauss<br>

--00151747609a58cb3a0477042cbf--
