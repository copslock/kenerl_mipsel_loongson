Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0B2uFm05818
	for linux-mips-outgoing; Thu, 10 Jan 2002 18:56:15 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0B2u8g05811
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 18:56:08 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DC48B7FB; Fri, 11 Jan 2002 02:55:55 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 61F633F3F; Fri, 11 Jan 2002 02:55:55 +0100 (CET)
Date: Fri, 11 Jan 2002 02:55:55 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: "linux-mips @ oss. sgi. com" <linux-mips@oss.sgi.com>
Subject: Re: LTP tests / Crash :)
Message-ID: <20020111015555.GB18469@paradigm.rfc822.org>
References: <20020111010058.EB5C47FB@noose.gt.owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20020111010058.EB5C47FB@noose.gt.owl.de>
User-Agent: Mutt/1.3.25i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2002 at 08:58:15AM +0800, Zhang Fuxin wrote:
> hi,Florian Lohoff??

Flo shortform :)

>  i have noticed that a while ago and send ralf and fix,he
> make his own fix in current cvs.

The current cvs is stable for me :)

>  My ltp runs turns out a number of failures,the one worry me
> most are the filesystem corrupts(mmap write?),but i had no time
> to follow them currently.

Havent seen those yet - This sounds like cache issues or probably
disk controller stuff - I am not running plain cvs - I am running
with some r4k cache wback/inv modifications i tried in connection
with my sgiwd93.c cleanup/fix.

Most annoying i guess is the still not perfect fpu emulation which
also causes the "sleep" bug where sleeps sometime return after 22 years
(strace output) as there are fpu problems within librt=20

And at least i know of one real-world app which had problems with=20
message passing/shared memory - The Xfree server garbles xbitmaps
within the server in shared segments - The happens with Gnome on
XFree 4 on the Indy.

shmat01     2  FAIL  :  shared memory address is not correct
shmdt02     1  FAIL  :  call succeeded unexpectedly

These are also interesting:

fcntl05     1  BROK  :  Unexpected signal 15 received.
pipe05      1  BROK  :  Unexpected signal 11 received.
sched_getscheduler01    1  BROK  :  Unexpected signal 11 received.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8PkYrUaz2rXW+gJcRAjdVAJ9myTkOJVMs2NVXvo8KXpw1AG4d+gCgyX99
bLVzfbYc0/Yp+0zwsgMQ29A=
=ODWy
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
