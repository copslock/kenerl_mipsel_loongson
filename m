Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 15:27:43 +0100 (BST)
Received: from adsl-72-19.38-151.net24.it ([IPv6:::ffff:151.38.19.72]:2758
	"EHLO zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225421AbVEFO13>; Fri, 6 May 2005 15:27:29 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DU3nT-0003gM-00; Fri, 06 May 2005 16:27:19 +0200
Date:	Fri, 6 May 2005 16:27:19 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: USB hangs on AU1100
Message-ID: <20050506142719.GA13148@enneenne.com>
References: <20050505155435.GA28227@enneenne.com> <1115311361.1614.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1115311361.1614.6.camel@localhost.localdomain>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2005 at 09:42:41AM -0700, Pete Popov wrote:
> It sounds like this is a custom Au1100 based board? What boot code are
> you running?  I'm guessing the SOC isn't setup correctly or you have a
> HW problem.

Yes, you was right, I missing to setup USB clock... I just added this
code to the board init function (board_setup() function) and now USB
works:

    #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_AU1X00_USB_DEVICE)
	    /* zero and disable FREQ2 */
	    sys_freqctrl =3D au_readl(SYS_FREQCTRL0);
	    sys_freqctrl &=3D ~0xFFF00000;
	    au_writel(sys_freqctrl, SYS_FREQCTRL0);
   =20
	    /* zero and disable USBH/USBD/IrDA clock */
	    sys_clksrc =3D au_readl(SYS_CLKSRC);
	    sys_clksrc &=3D ~0x0000001F;
	    au_writel(sys_clksrc, SYS_CLKSRC);
   =20
	    sys_freqctrl =3D au_readl(SYS_FREQCTRL0);
	    sys_freqctrl &=3D ~0xFFF00000;
   =20
	    sys_clksrc =3D au_readl(SYS_CLKSRC);
	    sys_clksrc &=3D ~0x0000001F;
   =20
	    /* FREQ2 =3D aux/2 =3D 48 MHz */
	    sys_freqctrl |=3D ((0<<22) | (1<<21) | (1<<20));
	    au_writel(sys_freqctrl, SYS_FREQCTRL0);
   =20
	    /* Route 48MHz FREQ2 into USBH/USBD/IrDA */
	    sys_clksrc |=3D ((4<<2) | (0<<1) | 0 );
	    au_writel(sys_clksrc, SYS_CLKSRC);
   =20
	    /* setup the static bus controller */
	    au_writel(0x00000002, MEM_STCFG3);  /* type =3D PCMCIA */
	    au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
	    au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
   =20
	    /* Get USB Functionality pin state (device vs host drive pins) */
	    pin_func =3D au_readl(SYS_PINFUNC) & (u32)(~0x8000);
    #ifndef CONFIG_AU1X00_USB_DEVICE
	    /* 2nd USB port is USB host */
	    pin_func |=3D 0x8000;
    #endif
	    au_writel(pin_func, SYS_PINFUNC);
    #endif /* defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_D=
EVICE) */

But don't you think is better to put this code into USB driver (file
ohci-au1xxx.c) during probing stage? In this manner each platforms may
don't worry about clock initialization...

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCe37HQaTCYNJaVjMRAmhHAJ9uPoekZdNWgNLi+Vjw+AmE5DyWSACeLsJk
K1jMXXbknQC2CmQZQE9jn4k=
=1YpV
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
