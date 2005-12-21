Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 09:03:38 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.204]:24947 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133718AbVLUJDU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 09:03:20 +0000
Received: by wproxy.gmail.com with SMTP id 36so84336wra
        for <linux-mips@linux-mips.org>; Wed, 21 Dec 2005 01:04:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YGb/Vfq/HfErvxbhntQxCWaMxS/VjTLbquU67w8ZPvUlPAHcQzcJGKwA6JYVYuyqjetp78JiFB9W50OYGoCMGj0CzHpwPKdlLHo55hguPtew5/mZe1dPqyDrM5UnR0o1xiVe9ezcg726FZGDMF9KW53TOYpLBFzGxV99U5bMA7s=
Received: by 10.54.105.7 with SMTP id d7mr561138wrc;
        Wed, 21 Dec 2005 01:04:26 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Wed, 21 Dec 2005 01:04:25 -0800 (PST)
Message-ID: <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
Date:	Wed, 21 Dec 2005 17:04:25 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
In-Reply-To: <20051221085539.GS13985@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

sorry to not describle clearly
i want to know how to build the cross-compile toolchain

On 12/21/05, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Wed, 2005-12-21 16:51:35 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> > i want to compile a 2.6.14 kernel for mips 4kec, does someone compile
> > the 2.6 kernel with self-build toolchain? how to select the gcc,
> > gdb,glibc,linux head and binutils version?
> > and where to get the guide doc?
>
> After you've built your toolchain, it's either an additional native
> one (gcc-4.1), or you've build some kind of cross-toolchain that got a
> prefix (mips-linux-gcc).
>
> In the former case, you'd be able to "make CC=gcc-4.1" a kernel, in
> the later case you call make like "make CROSS_COMPILE=vax-linux-".
>
> MfG, JBG
>
> --
> Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
> "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
>  für einen Freien Staat voll Freier Bürger"  | im Internet! |   im Irak!   O O O
> ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
>
> iD8DBQFDqRiLHb1edYOZ4bsRArKbAKCH4JLwRjHur6/JQ8oufY7+N/4/QwCeJ5hI
> wDSqqScrhupXQYHxdhzGtiA=
> =yOYf
> -----END PGP SIGNATURE-----
>
>
>

Best regards
zhuzhenhua
