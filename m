Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 23:02:18 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:54794
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225779AbUERWCQ>; Tue, 18 May 2004 23:02:16 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 145CA38212C; Tue, 18 May 2004 23:02:14 +0100 (BST)
Date: Tue, 18 May 2004 23:02:14 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518220214.GA29793@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org> <20040518211246.GA11722@skeleton-jack> <20040518211810.GA29636@getyour.pawsoff.org> <20040518213810.GA11885@skeleton-jack>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20040518213810.GA11885@skeleton-jack>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2004 at 10:38:10PM +0100, Peter Horton wrote:

>=20
> Does this patch fix it ?
>=20
> P.
>=20
> --- linux.cvs/arch/mips/cobalt/irq.c	2003-11-13 14:30:45.000000000 +0000
> +++ linux.pdh/arch/mips/cobalt/irq.c	2004-05-18 22:35:32.000000000 +0100
> @@ -82,11 +83,15 @@
>  	}
> =20
>  	if (pending & CAUSEF_IP7) {			/* int 23 */
> -		do_IRQ(COBALT_QUBE_SLOT_IRQ, regs);
> +		do_IRQ(23, regs);
>  		return;
>  	}
>  }

Aha. that seems to work now. i can certainly now tune the card in and do=20
stuff [tm] with it. thanks for the help.

 cat /proc/interrupts
           CPU0
  2:          0          XT-PIC  cascade
  9:       4134          XT-PIC  saa7146 (0)
 14:      27964          XT-PIC  ide0
 18:     711618            MIPS  timer
 19:      11311            MIPS  eth0
 21:        288            MIPS  serial
 22:          0            MIPS  cascade

0000:00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev=20
01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 1011
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at 12080800 (32-bit, non-prefetchable)


cheers,
Kieran.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqofmOWPbH1PXZ18RAhNIAJ0TE5dq44ZsL3cMOqHuREkIxSWbyQCgnEZU
blkZfeAo9KIofitnIPvpXgM=
=NPM5
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
