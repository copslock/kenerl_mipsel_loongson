Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 06:23:26 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:22428
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224898AbVBBGW6>; Wed, 2 Feb 2005 06:22:58 +0000
Received: from seriyu.infostations.net (seriyu.infostations.net [71.4.40.35])
	by mail-relay.infostations.net (Postfix) with ESMTP id 656229F7A4;
	Tue,  1 Feb 2005 22:23:18 -0800 (PST)
Received: from host-69-19-168-166.rev.o1.com ([69.19.168.166])
	by seriyu.infostations.net with esmtp (Exim 4.41 #1 (Gentoo))
	id 1CwDqX-00080l-Tm; Tue, 01 Feb 2005 22:18:38 -0800
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
From:	Josh Green <jgreen@users.sourceforge.net>
To:	ppopov@embeddedalley.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4200230A.6020002@embeddedalley.com>
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
	 <4200230A.6020002@embeddedalley.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Lb74te/O0h8S777a89OS"
Date:	Tue, 01 Feb 2005 22:23:44 -0800
Message-Id: <1107325424.15057.16.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-Lb74te/O0h8S777a89OS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-02-01 at 16:47 -0800, Pete Popov wrote:
> Josh Green wrote:
> > I'm using the latest Linux MIPS CVS (2.6.11-rc2) on an AMD Alchemy
> > DB1100 with a tool chain created with buildroot (gcc 3.4.3, binutils
> > 2.15.91.0.2) and found a bug in drivers/pcmcia/au1000_generic.c that wa=
s
> > causing the following error during initialization (not exact text, clos=
e
> > as I can remember), and subsequently the PCMCIA hardware was unavailabl=
e
> > (pcmcia_register_socket() was failing due to NULL resource_opts field).
> >=20
> > au1x00_pcmcia: probe of au1x00-pcmcia0 failed with error -22
>=20
> Interesting. I haven't seen this problem with a slightly older kernel.
>=20

http://www.linux-mips.org/cvsweb/linux/drivers/pcmcia/cs.c.diff?r1=3D1.51&r=
2=3D1.52&f=3Dh

The change around Line 212 looks like the reason.

<cut>

> Pete
>=20

I'm still looking into those other problems.  I found another issue
though, which I'm unsure of the exact cause (seems related to hostap
module).  I get this from time to time:

Badness in local_bh_enable at kernel/softirq.c:140
Call Trace:
 [<802482c4>] skb_clone+0x24/0x374
 [<8012c3c8>] local_bh_enable+0x74/0x9c
 [<80251048>] dev_queue_xmit+0x310/0x374
 [<80249884>] kfree_skbmem+0x14/0x30
 [<c0064438>] hostap_data_start_xmit+0x80c/0xac4 [hostap]
 [<8024866c>] alloc_skb+0x58/0xf4
 [<802a1240>] arp_constructor+0x28/0x274
 [<802a0000>] udp_rcv+0x368/0x938
 [<80250e14>] dev_queue_xmit+0xdc/0x374
 [<80360000>] ip_auto_config_setup+0x64/0x240
 [<802a2944>] arp_process+0x7f8/0xa6c
 [<c0062b20>] hostap_80211_rx+0x1034/0x1f04 [hostap]
 [<80251978>] netif_receive_skb+0x1c4/0x3d4
 [<80251978>] netif_receive_skb+0x1c4/0x3d4
 [<80251c98>] process_backlog+0x110/0x2f0
 [<80250000>] dev_change_name+0x34/0x2ec
 [<c003f96c>] hostap_rx_tasklet+0x228/0x2bc [hostap_cs]
 [<80251f44>] net_rx_action+0xcc/0x294
 [<8012c818>] tasklet_action+0xc4/0x194
 [<801479f4>] handle_IRQ_event+0x7c/0x134
 [<8012c1dc>] __do_softirq+0x8c/0x14c
 [<80147c40>] __do_IRQ+0x194/0x1b4
 [<80360000>] ip_auto_config_setup+0x64/0x240
 [<80360000>] ip_auto_config_setup+0x64/0x240
 [<8012c328>] do_softirq+0x8c/0xb8
 [<80360000>] ip_auto_config_setup+0x64/0x240
 [<80100e2c>] au1000_IRQ+0x16c/0x1a0
 [<80360000>] ip_auto_config_setup+0x64/0x240
 [<80104a90>] cpu_idle+0x48/0x50
 [<80104a60>] cpu_idle+0x18/0x50
 [<801f4980>] idr_cache_ctor+0x0/0xc
 [<80360000>] ip_auto_config_setup+0x64/0x240
 [<803437ac>] start_kernel+0x200/0x2c0
 [<803430fc>] unknown_bootoption+0x0/0x310

Might not be a MIPS related problem though.  Seems line 140 is
"WARN_ON(irqs_disabled());" which is at the beginning of
local_bh_enable.  Cheers.
	Josh Green


--=-Lb74te/O0h8S777a89OS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAHHuRoMuWKCcbgQRAjhuAKC5R4J5bvdBh0qmaZO15nuxKo/FAQCgvqlY
UyX7kVbVniTbDMVjWjZbgTA=
=rra8
-----END PGP SIGNATURE-----

--=-Lb74te/O0h8S777a89OS--
