Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 08:11:24 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:49087 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133394AbWECHLM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 May 2006 08:11:12 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 7A3195E584;
	Wed,  3 May 2006 09:11:04 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06440-03; Wed, 3 May 2006 09:11:04 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 06AFF5DF61; Wed,  3 May 2006 09:11:03 +0200 (CEST)
Date:	Wed, 3 May 2006 09:11:03 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Ratin <mrahman@sypixx.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: changing IP address on mipsel-linux
Message-ID: <20060503071103.GC11097@dusktilldawn.nl>
References: <4456960D.70403@telus.net> <20060502193838.GA3474@linux-mips.org> <007e01c66e2e$8008f720$2300a8c0@ratin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YOiw+WO4Gc95oc3L"
Content-Disposition: inline
In-Reply-To: <007e01c66e2e$8008f720$2300a8c0@ratin>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--YOiw+WO4Gc95oc3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ratin,

On Tue, May 02, 2006 at 02:22:21PM -0700, Ratin wrote:
> I am not sure if this is the right mailing list (new here) but
> how would you change the IP address parmanently on a box having
> IDT C32H434 CPU ?
Changing the ip address permanently does not depend on the cpu
used, but more on the GNU/Linux distribution used.

> There seems to be no /etc/init.d/network on this box. I could
> do it with ifconfig but I need to make parmanent change as well
> as effective right away.
You should first tell me which GNU/Linux distribution you use and
then I can give you a clue on where to change it permanently. Say
for instance Debian uses /etc/network/interfaces . S.u.S.E has a
thing called YaST if I remember correctly and Red Hat and the
likes use a directory called /etc/sysconfig/network-scripts/

But you tell me there does exist no /etc/init.d/network. So maybe
you are running BusyBox or something and then you are completely
on your own how to do things. Althought conforming to well known
practice will not hurt you. :-)

The best thing to do is check out /etc/inittab and learn how it
works ($ man inittab). Then you will be able to find out how your
GNU/Linux system boots and after some thorough searching you will
find where the ip address is set.
Then there is also the possibility that the ip address is set
using the command to boot the kernel. Well, then you know where
to permanently change it :-)

As you can see, lot's of possibilities. Good luck!

> The other question is when I change the IP address on the fly
> with ifconfig, is there a way to make the inet listener apps
> (that are running in the background) to autometically listen on
> the new IP address?
This depends completely on the application used. If the
application listens on a specific ip address, then you should
probably restart the application to make it listen to the new ip
address. But than you would in between the restart also have to
configure the application to listen on the new ip address. If you
have the application listen to INADDR_ANY (0.0.0.0) then you
don't have to do anything.

Again, good luck!

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--YOiw+WO4Gc95oc3L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEWFeHbxf9XXlB0eERAvSUAKDkbA0Q33vpKwvqRdc0sVvYyTr8awCgnkxp
YQmJDQqafDah1S8DhNdDet8=
=W9SC
-----END PGP SIGNATURE-----

--YOiw+WO4Gc95oc3L--
