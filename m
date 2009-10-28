Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:27:34 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.157]:51452 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492887AbZJ1T1S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:27:18 +0100
Received: by fg-out-1718.google.com with SMTP id 16so1914044fgg.6
        for <multiple recipients>; Wed, 28 Oct 2009 12:27:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zPF7s1OPVweiSZeic6McA93TdK06fIl0qn5M7bxWd6o=;
        b=jrtws4S2poiYM9UTaXh+eSKvBb/3AYZRub+ukLtwLAqkvo9QvaEmiraIiBW7Ire1MB
         8okkv5ySfHdll5WEPtKrD2w4OuPvume30rufGNtjEDYQIcMny7An3uInBY5tPzzri7dC
         w9UfoiIi+kmnEUCp6Rd6+BkX3BJkU1Fn69Y6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TBKf9HGtxOphY8AB9EtLwVs0vccp8zK94Isa0EztTb/9cWWRNYyYZcLFmC+hY9RLrg
         wyyEM0ziUOE334qOuHJ4Rr8zpGLwUxJuxesJi3SxP2wYWLD6zPV4BteI5LUB4sXyDS6A
         49H/E5iY3Pnwj1gNg6GJvheRdYLvyFbsEIFBo=
MIME-Version: 1.0
Received: by 10.223.127.198 with SMTP id h6mr88843fas.102.1256758036704; Wed, 
	28 Oct 2009 12:27:16 -0700 (PDT)
In-Reply-To: <20091028122430.f7670ae2.akpm@linux-foundation.org>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
	 <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
	 <20091028122430.f7670ae2.akpm@linux-foundation.org>
Date:	Wed, 28 Oct 2009 20:27:16 +0100
Message-ID: <f861ec6f0910281227t455a6f5cw9e492a9a1fc1b07e@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: multipart/alternative; boundary=00235453068c58acdd047703c8d2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

--00235453068c58acdd047703c8d2
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 28, 2009 at 8:24 PM, Andrew Morton <akpm@linux-foundation.org>wrote:

> On Wed, 28 Oct 2009 20:09:14 +0100
> Manuel Lauss <manuel.lauss@googlemail.com> wrote:
>
> > UART autodetection breaks on the Au1300 but the IP blocks are
> > identical, at least in the datasheets.
> >
> > Pass uart type on to the 8250 driver via platform data, and move
> > the MSR quirk to another place sind autoconf() is now no longer
> > called on init.
> >
> > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> > ---
> > Tested on DB1200 and DB1300.
> > The mips parts apply on top of Ralf's mips-queue tree.
> >
> >  arch/mips/alchemy/common/platform.c |    4 +++-
> >  drivers/serial/8250.c               |   13 +++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/mips/alchemy/common/platform.c
> b/arch/mips/alchemy/common/platform.c
> > index 195e5b3..3be14b0 100644
> > --- a/arch/mips/alchemy/common/platform.c
> > +++ b/arch/mips/alchemy/common/platform.c
> > @@ -26,7 +26,9 @@
> >               .irq            = _irq,                         \
> >               .regshift       = 2,                            \
> >               .iotype         = UPIO_AU,                      \
> > -             .flags          = UPF_SKIP_TEST | UPF_IOREMAP   \
> > +             .flags          = UPF_SKIP_TEST | UPF_IOREMAP | \
> > +                               UPF_FIXED_TYPE,               \
> > +             .type           = PORT_16550A,                  \
> >       }
>
> The kernel which you patched differs from current mainline here.


 I know, that's why I added "The mips parts apply on top of Ralf's
mips-queue tree" below
the patch description.
If it makes it easier to apply, I could split this one in a mips and in a
8250 patch?

Thank you!
     Manuel Lauss

--00235453068c58acdd047703c8d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Oct 28, 2009 at 8:24 PM, Andrew =
Morton <span dir=3D"ltr">&lt;<a href=3D"mailto:akpm@linux-foundation.org">a=
kpm@linux-foundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Wed, 28 Oct 2009 20:09:14 +0100<br>
Manuel Lauss &lt;<a href=3D"mailto:manuel.lauss@googlemail.com">manuel.laus=
s@googlemail.com</a>&gt; wrote:<br>
<br>
&gt; UART autodetection breaks on the Au1300 but the IP blocks are<br>
&gt; identical, at least in the datasheets.<br>
&gt;<br>
&gt; Pass uart type on to the 8250 driver via platform data, and move<br>
&gt; the MSR quirk to another place sind autoconf() is now no longer<br>
&gt; called on init.<br>
&gt;<br>
&gt; Signed-off-by: Manuel Lauss &lt;<a href=3D"mailto:manuel.lauss@gmail.c=
om">manuel.lauss@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Tested on DB1200 and DB1300.<br>
&gt; The mips parts apply on top of Ralf&#39;s mips-queue tree.<br>
&gt;<br>
&gt; =A0arch/mips/alchemy/common/platform.c | =A0 =A04 +++-<br>
&gt; =A0drivers/serial/8250.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 +++++++-=
-----<br>
&gt; =A02 files changed, 10 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/c=
ommon/platform.c<br>
&gt; index 195e5b3..3be14b0 100644<br>
&gt; --- a/arch/mips/alchemy/common/platform.c<br>
&gt; +++ b/arch/mips/alchemy/common/platform.c<br>
&gt; @@ -26,7 +26,9 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D _irq, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 2, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_AU, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_SKIP_TEST =
| UPF_IOREMAP =A0 \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_SKIP_TEST =
| UPF_IOREMAP | \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UPF_FIXE=
D_TYPE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D PORT_16550A, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; =A0 =A0 =A0 }<br>
<br>
</div></div>The kernel which you patched differs from current mainline here=
.=A0</blockquote><div>=A0</div></div>=A0I know, that&#39;s why I added &quo=
t;The mips parts apply on top of Ralf&#39;s mips-queue tree&quot; below<br>=
the patch description.<br>
If it makes it easier to apply, I could split this one in a mips and in a 8=
250 patch?<br><br>Thank you!<br>=A0=A0=A0=A0 Manuel Lauss<br><br>

--00235453068c58acdd047703c8d2--
