Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Apr 2006 13:59:48 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:19863 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133387AbWDMM7j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Apr 2006 13:59:39 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id EB52B5DF46
	for <linux-mips@linux-mips.org>; Thu, 13 Apr 2006 15:11:17 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05285-01-3 for <linux-mips@linux-mips.org>;
	Thu, 13 Apr 2006 15:11:17 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 8D6845DF41; Thu, 13 Apr 2006 15:11:17 +0200 (CEST)
Date:	Thu, 13 Apr 2006 15:11:17 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: UART trouble on the DBAu1100
Message-ID: <20060413131117.GP11097@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJjS+Ds6jmpBvWv0"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--xJjS+Ds6jmpBvWv0
Content-Type: multipart/mixed; boundary="z87VqPJ/HsYrR2WM"
Content-Disposition: inline


--z87VqPJ/HsYrR2WM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have a problem and yet am not sure where to look. It's a
problem in the serial driver for the internal UART's of the
AU1100. It appeared ever since 2.6.15. 2.6.14 is working like a
charm, but 2.6.15 gives me the trouble.

When I open a tty with the open(2) system call (see attached open.c)
I see that the UART sends a 0x36 byte on the line.

But that's not the only trouble. I also do not receive any
bytes received by the UART. All the received bytes stay
in the input buffer of the UART only to be send up to userland
as soon as the UART is asked to send a byte on the line itself.
Then in one take all the bytes are received by the application
listening.

Reproducing is easy with a program like picocom. Just start it on
both ends (one called 'a' and the other called 'b') and type on
one (a) end. You will see nothing at the other (b) end. Then type
1 or more characters on the other (b) end and you will see that
character appear at the one (a) end and all the other previously
types at the one (a) end appear on the other (b) end.

I am currently looking into the source to see what's changed,
but any help would be greatly appreciated :-)

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--z87VqPJ/HsYrR2WM
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="open.c"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc,char **argv) {
	int fd;
	char *tty;
	tty=argc>1?argv[1]:"/dev/ttyS0";
	fd=open(tty,O_RDWR);
	if(fd==-1) {
		perror("Can't open tty");
	} else {
		if(argc>2) {
			/* Closing or not doesn't matter, it's the open() system call. */
			close(fd);
		} else {
			/* Nice sleep so you see the character is sent by the open and
			 * not by whatever else one can think of. */
			sleep(2);
		}
	}
	return(0);
}

--z87VqPJ/HsYrR2WM--

--xJjS+Ds6jmpBvWv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEPk31bxf9XXlB0eERAnfMAKDW9Oc8Olo8qEolnsELgJU4Y9M+EwCcD2Wr
lYI7iR2FuCczMh7566TLGcg=
=J9uQ
-----END PGP SIGNATURE-----

--xJjS+Ds6jmpBvWv0--
