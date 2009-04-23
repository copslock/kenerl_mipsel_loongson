Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 11:00:13 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.154]:44966 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28601683AbZDWJBg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 10:01:36 +0100
Received: by yw-out-1718.google.com with SMTP id 9so274605ywk.24
        for <linux-mips@linux-mips.org>; Thu, 23 Apr 2009 02:01:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=olxp8AnY50Jf9rkh5wxc2w4S1aWbr1xM6bgDsbEUuQU=;
        b=v5IfqcguupRbdxsAVoYpRV48owQBv115MbWpNSvSXjQV7h7A/qqP8rWx6VkhR4PV57
         SGrM+3G36m0GVZo6KGZEfE1kJrtiz5V4L1enC0g1klXU7bXCXiCIWSz09ejiEtSZep3x
         zRj+55Ek5wI+vA/iM2XWYZzWQkNHETz1r8vWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=cL9n/ASQYdfya1mOI0lNSlD+wxzTWbNgzblQzpLMVq6fqQpgyWkmTo3QTMGpq9uEz+
         Q4UKwnQ35V47YalLZ+H2IGb8F2Tl5gGVoD01bFDMNSQ6Pk/w8Jpz4mCSkLXeY0T8aZCP
         aHlOBTFW4sGvhs7ADLDqkkKIUG00stTMAyP68=
Received: by 10.90.94.12 with SMTP id r12mr979597agb.13.1240477292954;
        Thu, 23 Apr 2009 02:01:32 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 9sm1961398agc.22.2009.04.23.02.01.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:01:32 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
Subject: Re: in mips how to change the start address to the new second boot  loader ?
Date:	Thu, 23 Apr 2009 11:01:25 +0200
User-Agent: KMail/1.9.9
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Kevin D. Kissell" <kevink@paralogos.com>,
	"M. Warner Losh" <imp@bsdimp.com>, linux-mips@linux-mips.org
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com> <10f740e80904210710sdc9e5c2ic310e689ca6677b5@mail.gmail.com> <d77cedf30904210720m1a5862ccx220fea16f3a0f01a@mail.gmail.com>
In-Reply-To: <d77cedf30904210720m1a5862ccx220fea16f3a0f01a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1832054.krIcP2f73W";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904231101.27780.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart1832054.krIcP2f73W
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Le Tuesday 21 April 2009 16:20:48 nagalakshmi veeramallu, vous avez =C3=A9c=
rit=C2=A0:
> Hi,
> will this approach work? if i used "start" environmental variable will it
> go to new boot loader address directly.

Yamon also has a start environnment variable which is used to do something=
=20
without user-intervention. I do not know cmon, but assuming it behaves=20
similarly, you might want to set the start variable to something like: "go=
=20
0xdeadbeef". And make sure your code starts at 0xdeadbeef for instance.

That way, you keep cmon on the flash and use it to jump to an arbitrary=20
location, which is anyway, what would be done if you used cmon to boot Linu=
x=20
for instance.

>
> Regards,
> Lucky
>
> On Tue, Apr 21, 2009 at 7:40 PM, Geert Uytterhoeven=20
<geert@linux-m68k.org>wrote:
> > On Tue, Apr 21, 2009 at 15:46, nagalakshmi veeramallu
> >
> > <lucky.veeramallu@gmail.com> wrote:
> > > hi,
> > >          --          if we set environmental variable =E2=80=9Cstart=
=E2=80=9D as =E2=80=9Cgo
> > > new_address=E2=80=9D, will it go directly to the new bootloader in th=
e next
> > > power-on.
> > > what about using system environmental "start" ,can you tell me at whi=
ch
> > > context after power on environmental variables come onto picture.
> >
> > Environment variables are parsed by the boot loader, whose code resides
> > at, guess what, 0x1fc00000...
> >
> > > On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell
> > > <kevink@paralogos.com>
> > >
> > > wrote:
> > >> nagalakshmi veeramallu wrote:
> > >>
> > >> -           Mips atlas board has jumper  which will redirect accesses
> >
> > from
> >
> > >> =E2=80=9CBootcode=E2=80=9D range to either =E2=80=9CMonitor flash=E2=
=80=9D (0x1e000000) or the upper
> > >> 4MB
> >
> > of
> >
> > >> =E2=80=9CSystem flash=E2=80=9D (0x1dc00000) based on jumper settings=
=2E if my kmc board
> >
> > have
> >
> > >> some jumper like this, can I redirect the start address.
> > >>
> > >> Of course, what is really happening there is that the Atlas boot ROM
> > >> has
> >
> > a
> >
> > >> vector at 0x1fc00000 which reads the jumper and jumps to one address
> > >> or
> >
> > the
> >
> > >> other depending on the jumper setting. If you control what is in ROM
> > >> at 0x1fc00000 and you have a software-readable jumper on your KMC
> > >> board,
> >
> > you
> >
> > >> can do the same thing.
> > >>
> > >>           Regards,
> > >>
> > >>           Kevin K.
> >
> > --
> > Gr{oetje,eeting}s,
> >
> >                                                Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> > geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker.
> > But
> > when I'm talking to journalists I just say "programmer" or something li=
ke
> > that.
> >                                                            -- Linus
> > Torvalds



=2D-=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
=2D------------------------------

--nextPart1832054.krIcP2f73W
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknwLmYACgkQlyvkmBGtjyYAbACeOvvQ3HuthpztD1bX/lSEhFjH
j1AAn0GwCq+Gq0YtT7y9rcqj0ToL0xES
=vjtB
-----END PGP SIGNATURE-----

--nextPart1832054.krIcP2f73W--
