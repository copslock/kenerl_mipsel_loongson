Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Sep 2004 13:20:19 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:36578 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8225241AbUINMUP>;
	Tue, 14 Sep 2004 13:20:15 +0100
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hydra.gt.owl.de (Postfix) with ESMTP id 8E652199066;
	Tue, 14 Sep 2004 14:20:12 +0200 (CEST)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1859925DA9; Tue, 14 Sep 2004 14:20:12 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B9291138065; Tue, 14 Sep 2004 14:03:47 +0200 (CEST)
Date: Tue, 14 Sep 2004 14:03:47 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Peter Fuerst <pf@net.alphadv.de>
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 2.95 patch for IP28
Message-ID: <20040914120347.GA12570@paradigm.rfc822.org>
References: <Pine.LNX.3.96.1040902040502.14047A-100000@indigo2.Peter>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1040902040502.14047A-100000@indigo2.Peter>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Peter,

On Thu, Sep 02, 2004 at 04:11:25AM +0200, Peter Fuerst wrote:
> Hello !
> A patch to gcc 2.95.4 to make it insert the necessary cache barriers
> in (kernel-)code for SGI Indigo2 R10k (IP28) is available at
> http://home.alphastar.de/fuerst/download.html

I could build all the stuff.

I see the mentioned problem about 2.6 grinding to a halt too. Also i
have problems getting output on the serial console. its compiled in and
i see all kernel messages. Once into userspace i only see error messages
like this:

[...]
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 195.71.97.193, my address is 195.71.97.214
IP-Config: Complete:
      device=3Deth0, addr=3D195.71.97.214, mask=3D255.255.255.224, gw=3D195=
=2E71.97.193,
     host=3D195.71.97.214, domain=3Dhome.rfc822.org, nis-domain=3D(none),
     bootserver=3D195.71.97.193, rootserver=3D195.71.97.193, rootpath=3D/da=
ta/nfsroot/mips
Looking up port of RPC 100003/2 on 195.71.97.193
Looking up port of RPC 100005/1 on 195.71.97.193
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
Ivemount: wrong fs type, bad option, bad superblock on tmpfs,
       or

the I looks like "INIT:". I cant explain the "ve" which comes some seconds

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBRt4jUaz2rXW+gJcRAikYAKCcQte0H9SOQ6cM+phXwgf3gaW22ACg5/gb
yOAAmlUW8O6/9KWP8j+OFMY=
=ur3A
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
