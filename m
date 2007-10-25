Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 17:04:04 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:40894 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20022854AbXJYQDz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2007 17:03:55 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l9PG2lLV015338;
	Thu, 25 Oct 2007 09:02:47 -0700 (PDT)
Received: from Ulysses (vpn92 [192.168.3.92])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l9PG3DtF028687;
	Thu, 25 Oct 2007 09:03:13 -0700 (PDT)
Message-ID: <007b01c81720$9f46f8c0$5c03a8c0@Ulysses>
From:	"Kevin D. Kissell" <KevinK@mips.com>
To:	"Markus Gothe" <markus.gothe@27m.se>, "kaka" <share.kt@gmail.com>
Cc:	<directfb-users@directfb.org>, <directfb-dev@directfb.org>,
	<linux-mips@linux-mips.org>, <uclinux-dev@uclinux.org>,
	<linux-fbdev-users@lists.sourceforge.net>
References: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com> <4720BCAE.1030209@27m.se>
Subject: Re: Updated:Error opening framebuffer device/Unknown symbol
Date:	Thu, 25 Oct 2007 09:03:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

He's been told this at least 3 times.  I'm starting to think that he's a troll.

----- Original Message ----- 
From: "Markus Gothe" <markus.gothe@27m.se>
To: "kaka" <share.kt@gmail.com>
Cc: <directfb-users@directfb.org>; <directfb-dev@directfb.org>; <linux-mips@linux-mips.org>; <uclinux-dev@uclinux.org>;
<linux-fbdev-users@lists.sourceforge.net>
Sent: Thursday, October 25, 2007 8:56 AM
Subject: Re: Updated:Error opening framebuffer device/Unknown symbol


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> You cannot use libc-stuff for the kernel, use the kernel equalients...
>
> //Markus
>
> kaka wrote:
> > Hi All,
> >
> > Thanks for the overhelming responses.
> > I was able to remove the problem of Unknown symbols by linking the
> > proper libraries. Now the problem got reduced to the following messages.
> >
> > # insmod brcmstfb.ko
> > brcmstfb: Unknown symbol printf
> > brcmstfb: Unknown symbol malloc
> > brcmstfb: Unknown symbol free
> > insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2):
> > No such file or directory
> > #
> >
> > for the above problem i had tried to link "libgcc.a " but those
> > symbols are also undefined in it also.
> > RECAP:
> > While running  the cross compiled directFB example on MIPS chip,*
> > We tried to install the framebuffer driver(command given
> > above) after creating the node fb0.
> > APPROACH:
> > Actually the code of frambuffer driver consists of usual kernel
> > framebuffer code and properitiary graphics lib code.
> > The properitiary graphics lib code is using malloc,print and free
> > from <stdlib.h> and that is why those symbols are coming undefined.
> >
> > Could anybody help in this regard?
> > Thanks in advance.
> >
> > kaka
> >
> >
> >
> > ---------- Forwarded message ----------
> > From: *kaka* < share.kt@gmail.com <mailto:share.kt@gmail.com>>
> > Date: Oct 12, 2007 6:33 PM
> > Subject: Error opening framebuffer device/Unknown symbol
> > register_framebuffer
> > To: directfb-users@directfb.org
> > <mailto:directfb-users@directfb.org>, directfb-dev@directfb.org
> > <mailto:directfb-dev@directfb.org>.
> >
> >
> >
> >     * Hi All, *
> >
> >     * While running  the cross compiled directFB example on MIPS chip, *
> >
> >     *
> >
> >
> >
> >     We tried to install the framebuffer driver(command given at the
> bottom) and we have already created the node fb0. *
> >
> >     * We are getting the following error,  *
> >
> >
> >
> >     * Can anybody help in this regard ? *
> >
> >     * Thanks in Advance. *
> >
> >     # ../../cross_directfb/simple_mips
> >
>
> >          =======================|  DirectFB 1.0.0  |=======================
> >               (c) 2001-2007  The DirectFB Organization (directfb.org
> <http://directfb.org/>)
> >               (c) 2000-2004  Convergence (integrated media) GmbH
> >             ------------------------------------------------------------
> >
>
> >     (*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
> >     (!) Direct/Util: opening '/dev/fb0' failed
> >         --> No such device or address
> >     (!) DirectFB/FBDev: Error opening framebuffer device!
> >     (!) DirectFB/FBDev: Use 'fbdev' option or set FRAMEBUFFER
> environment variable.
> >     (!) DirectFB/Core: Could not initialize 'system' core!
> >         --> Initialization error!
> >     simple.c <96>:
> >             (#) DirectFBError [DirectFBCreate (&dfb)]: Initialization
> error!
> >     #
> >
> >     * While running the following command in MIPS chip, we are getting
> the following error. *
> >
> >     # insmod brcmstfb.ko
> >     brcmstfb: Unknown symbol unregister_framebuffer
> >     brcmstfb: Unknown symbol printf
> >     brcmstfb: Unknown symbol malloc
> >     brcmstfb: Unknown symbol fb_find_mode
> >     brcmstfb: Unknown symbol fb_dealloc_cmap
> >     brcmstfb: Unknown symbol fb_alloc_cmap
> >     brcmstfb: Unknown symbol framebuffer_release
> >     brcmstfb: Unknown symbol free
> >     insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2):
> No such file or directory
> >     #
> >     #
> >
> >
> >
> >
> >
> >
> > --
> > Thanks & Regards,
> > kaka
> >
> > --
> > Thanks & Regards,
> > kaka
>
>
> - --
> _______________________________________
>
> Mr Markus Gothe
> Software Engineer
>
> Phone: +46 (0)13 21 81 20 (ext. 1046)
> Fax: +46 (0)13 21 21 15
> Mobile: +46 (0)73 718 72 80
> Diskettgatan 11, SE-583 35 Linköping, Sweden
> www.27m.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFHILyr6I0XmJx2NrwRCDF2AJ9eZIGLy2mPEiUn6bz4+oX7pclzWACfQBn8
> pv3s3/Hpkhhau69I7NZLCJ0=
> =0zSq
> -----END PGP SIGNATURE-----
>
>
>
