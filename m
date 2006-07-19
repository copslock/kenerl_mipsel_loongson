Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 16:58:33 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:51175 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133431AbWGSP6R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2006 16:58:17 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 055B85DFB3
	for <linux-mips@linux-mips.org>; Wed, 19 Jul 2006 17:58:05 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SO030LJDf7zR for <linux-mips@linux-mips.org>;
	Wed, 19 Jul 2006 17:58:04 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 845E35DF86; Wed, 19 Jul 2006 17:58:04 +0200 (CEST)
Date:	Wed, 19 Jul 2006 17:58:04 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: pseudo 32 bit physical addresses and the real 36 bit world
Message-ID: <20060719155804.GB5162@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k/A+UfywgnnvevLW"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--k/A+UfywgnnvevLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The AU1100 processor uses internally a 36-bit address bus. The
kernel (32 bits) is only able to work with 32-bit addresses.
Well, there must exist some sort of scheme for the kernel to work
with these 36-bit addresses, but I don't quiet get it yet. Is
anybody willing to give me some insight?

I'm looking at the pcmcia implementation at this moment and I
don't get it. If I look at drivers/pcmcia/au1000_generic.h I see
AU1X_SOCK0_IO defines as 0xF00000000 (note the 36 bit length).
This one is used in drivers/pcmcia/au1000_generic.c
au1x00_pcmcia_socket_probe() where it get cast to phys_t. phys_t
is a typedef from include/asm-mips/types.h as an unsigned long.
Of course the compiler warns us during compilation of
drivers/pcmcia/au1000_generic.c:

drivers/pcmcia/au1000_generic.c:403: warning: integer constant is too large=
 for "long" type
drivers/pcmcia/au1000_generic.c:406: warning: integer constant is too large=
 for "long" type
drivers/pcmcia/au1000_generic.c:414: warning: integer constant is too large=
 for "long" type

And this is where I'm sort of lost. How can this scheme work? I
must be missing something, but I don't understand it. I expect
=66rom reading the au1100 databook and 'See MIPS Run (chapter 6)
that the TLB is involved, but I'm not yet able to link it
altogether.

I also expect more is happening with the
AU1X_SOCK0_PSEUDO_PHYS_ATTR and AU1X_SOCK0_PSEUDO_PHYS_MEM, but
not that I can find any clue how this appears to work.

To end this email into a happy end I shall also explain what I
really want to do. We've built our own computer using the AU1100
processor. We've connected two SC16C652 dual UART's, one to RCS2
and one to RCS3. Now I want to map those UARTS at AE000000 and
AE040000. I've configured the mem_stcfg[23], mem_sttime[23] and
mem_staddr[23] registers in yamon:

  #define MEM_STCFG[23]   0x00000001
  #define MEM_STTIME[23]  0x03FFC7C7
  #define MEM_STADDR2     0x1AE03FFF
  #define MEM_STADDR3     0x1AE07FFF

But after that I'm sort of lost in the dark. What should I do
inside the kernel so that when I refer to AE000000 in my driver
the processor triggers chip select 2 (RCS2)?

Any hints would be appreciated.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--k/A+UfywgnnvevLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEvlaMbxf9XXlB0eERAgXLAJ9OyZ4SVt1jV08HHTqd75oIv+5pqwCgki1J
MgCSjlp348P9892I5u8Mkk4=
=gLxw
-----END PGP SIGNATURE-----

--k/A+UfywgnnvevLW--
