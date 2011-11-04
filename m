Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 10:51:45 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41217 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904081Ab1KDJvl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 10:51:41 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA49peQe002615
        for <linux-mips@linux-mips.org>; Fri, 4 Nov 2011 09:51:40 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA49petW002613
        for linux-mips@linux-mips.org; Fri, 4 Nov 2011 09:51:40 GMT
Date:   Fri, 4 Nov 2011 09:51:40 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [ADMIN] Git repositories on linux-mips.org have moved
Message-ID: <20111104095140.GA2197@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3440


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To simplify some admin chores on linux-mips.org I've moved some of the
git repositories into a subdirectory named by the owner.  The intent
is that all future repositories will also be created in subdirectories.

The following URLs are the new locations of the repositories that have moved:

  git://git.linux-mips.org/pub/scm/ralf/linux-dt.git/
  git://git.linux-mips.org/pub/scm/ralf/linux.git/
  git://git.linux-mips.org/pub/scm/ralf/linux-i8253.git/
  git://git.linux-mips.org/pub/scm/ralf/linux-ip35.git/
  git://git.linux-mips.org/pub/scm/ralf/linux-malta.git/
  git://git.linux-mips.org/pub/scm/ralf/linux-queue.git/
  git://git.linux-mips.org/pub/scm/ralf/upstream-akpm.git/
  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git/
  git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git/
  git://git.linux-mips.org/pub/scm/ralf/zmailer.git/

Replace git:// with http:// or https:// for http or https transport.

As a reminder, rsync:// as a transport is no longer supported by
linux-mips.org because its abuse by the not so git savy has caused
excessive load on the linux-mips.org machine.

There is no need to reclone your old repository; you can update the
repository's URL by editing .git/config or if you're using a very old
git version, in one of the files in .git/remotes/, probably
.git/remotes/origin.

Cheers,

  Ralf

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOs7WjAAoJECY38MwAtnaCdXoP/1GLD1GitWhGn4Kfiw0nytv1
r2V1Q+vkC0l94XheqmjU0I65LxdkqP6Rs80//ieM/A9+LNfoH4VHMN5avQbr44kk
owhqcFGjWLc1O/QDJflMQdTKNvItU1dNitPMMHza0IBwlLXec4mvS7h5sqhJ4QlI
zbYRcm9el5/ygLEb7kW6hWLygKjv5DBqUzlSVD21CRV4KLS9oPQY9YrxhwFRuxH4
jXUdxv4sRLTvZvpwly/LhsiJJKCOjNkcbjnnnOl6jxTyWS2ZL+98gcObqzrQc3HB
hxuSepRyDjwuXlkmaR7jUxtGwebUr6uIofEmL07XNMGNNGfftJxeRRDgzuylkyFn
sxz4TpnQQ9RaqN6E9pdpaPNQDR9wXu7Q755hfQzLM6O+LKvQfFkNfIq+qvE0mWRJ
5s1papUfcMzNEL+JsYDawJks/CUwKZMEsPfUvo7jXzVvSHe6cIohNFGQDXJ649h/
Z5SGbHS7tluHpMdYiS2gNriFVt1LuL2k67BoS8FP35ESpfGIMvYB4gmvZiH4dRF1
YA59AHB0E18QwuY1WiDhHgN5qUyszVrPu6EUIG895qsxAIToBALlbAFZZisJPFuI
gMQVKqQGrV06/W+c6IDWMgOjojaEnf6N7y4z78dZOXoMTiVj4zDd6xyzgGSeyOoP
Yd6D/YnuKKaDeZuDvBCE
=ZL86
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
