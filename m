Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7A351Rw030494
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 20:05:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7A351tC030493
	for linux-mips-outgoing; Fri, 9 Aug 2002 20:05:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gateway.total-knowledge.com (12-234-207-60.client.attbi.com [12.234.207.60])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7A34tRw030473
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 20:04:55 -0700
Received: (qmail 14166 invoked by uid 502); 10 Aug 2002 03:07:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Aug 2002 03:07:07 -0000
Date: Fri, 9 Aug 2002 20:07:01 -0700 (PDT)
From: ilya@theIlya.com
X-X-Sender: ilya@ns2.total-knowledge.com
To: Sander Wichers <wichers@usa.net>
cc: linux-mips@oss.sgi.com
Subject: Re: What cvs branch to use to compile mips64?
In-Reply-To: <20020809084304.20279.qmail@uwdvg002.cms.usa.net>
Message-ID: <Pine.LNX.4.44.0208092004090.9359-100000@ns2.total-knowledge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-6.0 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK,NO_REAL_NAME,PGP_SIGNATURE version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Am I doing something wrong? Do I have the correct branch? Or do I need
> some patches?
You are doing two things wrong:
1. Trying to compile cvs HEAD (it's really br0ken now)
2. Trying to compile for IP28. I don't think R10000 speculative execution
workarround esists already. Thus, even if you get kernel to compile,
you'll have very unstable environment.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: pgpenvelope 2.9.0 - http://pgpenvelope.sourceforge.net/

iD8DBQE9VINa84S94bALfyURAhomAJ96OWVFAdK6ZH2Rvl7N70ua2t8z6QCgz8Wh
4MfJJv4O+8HoWY9LqVuSjQo=
=8Rjq
-----END PGP SIGNATURE-----
