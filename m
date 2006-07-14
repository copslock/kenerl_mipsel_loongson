Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 10:33:56 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:64917 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133769AbWGNJdq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 10:33:46 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1G1IVV-0002We-00; Fri, 14 Jul 2006 09:54:41 +0200
Date:	Fri, 14 Jul 2006 09:54:41 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems after merge to 2.6.18-rc1
Message-ID: <20060714075441.GE7186@gundam.enneenne.com>
References: <20060713163200.GA7186@gundam.enneenne.com> <20060714.103521.25910483.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20060714.103521.25910483.nemoto@toshiba-tops.co.jp>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2006 at 10:35:21AM +0900, Atsushi Nemoto wrote:
>=20
> Two "Determined physycal RAM map:" line here.  If both were printed in
> parse_cmdline_early() (i.e. parse_cmdline_early was called twice),
> something is seriously broken.

Yes, you was right. I fixed it! :)

However now I have another (strange) problem.

Attached you can find my patch to add power managament to the new
version of file "drivers/net/au1000_eth.c" that implements the
PHY-layer support.

Please, note the hack after the function mii_probe() called by
au1000_lowlevel_probe().

Kernel messages during suspend are:

   hostname:~# apm --suspend
   Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
   au1xxx_pm_prepare: state =3D 3
    usbdev1.1_ep81: PM: suspend 0->2, parent 1-0:1.0 already 1
   warning! Serial console ttyS0 is not disabled in debug kernel mode
   au1xxx_pm_enter: state =3D 3
   au_sleep: reason -3 force 0 wakeup 100 ticks 3000
   au_sleep: Zzz...
   au_sleep: Yep!
   kobject_add failed for 0:1f with -EEXIST, don't try to register things w=
ith the same name in the same directory.
   Call Trace:
    [<80252ca8>] kobject_add+0x17c/0x1e0
    [<80252b98>] kobject_add+0x6c/0x1e0
    [<80292008>] device_add+0xc0/0x464
    [<80291ff4>] device_add+0xac/0x464
    [<802a2e64>] mdiobus_register+0x134/0x198
    [<802a3ac0>] au1000_lowlevel_probe+0x104/0x4b4
    [<802a58a4>] au1000_drv_resume+0x3c/0xc8
    [<80138978>] process_timeout+0x0/0x8
    [<80298610>] platform_resume+0x34/0x40
    [<8029bf7c>] resume_device+0x19c/0x200
    [<802528e4>] kobject_get+0x20/0x34
    [<8029391c>] __sysdev_resume+0xf0/0xf8
    [<80291da4>] get_device+0x20/0x34
    [<8029c1c4>] dpm_resume+0x1e4/0x3c0
    [<8029c3fc>] device_resume+0x5c/0x174
    [<80153848>] enter_state+0x290/0x314
    [<80153840>] enter_state+0x288/0x314
    [<8010e824>] apm_suspend+0x1c/0xa0
    [<80219750>] nfs_getattr+0x88/0xf8
    [<80219708>] nfs_getattr+0x40/0xf8
    [<8010eca8>] apm_ioctl+0x198/0x22c
    [<80110e84>] do_page_fault+0x364/0x3d0
    [<80110c24>] do_page_fault+0x104/0x3d0
    [<801a0d24>] do_ioctl+0x54/0x90
    [<801a0f6c>] vfs_ioctl+0x20c/0x394
    [<801b7950>] sync_inodes+0x20/0x54
    [<801a1144>] sys_ioctl+0x50/0x9c
    [<8010f66c>] stack_done+0x20/0x40
    [<8010f66c>] stack_done+0x20/0x40

   phy 31 failed to register
   au1000_eth_mii: probed
   eth0: 0:1f already attached
   eth0: Could not attach to PHY
   usb usb1: root hub lost power or was reset
   Restarting tasks... done
   au1xxx_pm_finish: state =3D 3
   hostname:~#

The first strange thing is that this time the kernel messages stop
after "au1xxx_pm_prepare: state =3D 3" and not after "au_sleep: Zzz..."
as before the merge! Maybe something as changed in serial console
magement?

The second strange thing is that _only_ calling the mii_probe()
the resume works correctly, otherwise the CPU loops forever
calling the au1000_lowlevel_probe() without showing the printk()
messages through the serial console. =3D:-o

Suggestions?

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEt03BQaTCYNJaVjMRAv0vAJ9Sc54wxXRcxL1ySlM1JcxMqpAatQCfU3ss
dTUEhUVllcl2cHUi/QVa04w=
=/HXw
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
