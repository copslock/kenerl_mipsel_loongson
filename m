Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2002 09:16:15 +0200 (CEST)
Received: from 12-234-207-60.client.attbi.com ([12.234.207.60]:1731 "HELO
	gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S1123927AbSJHHQO>; Tue, 8 Oct 2002 09:16:14 +0200
Received: (qmail 16835 invoked by uid 502); 8 Oct 2002 07:16:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Oct 2002 07:16:04 -0000
Date: Tue, 8 Oct 2002 00:15:58 -0700 (PDT)
From: ilya@theIlya.com
X-X-Sender: ilya@ns2.total-knowledge.com
To: Petko Manolov <petkan@dce.bg>
cc: linux-mips@linux-mips.org
Subject: Re: cvs problem
In-Reply-To: <Pine.LNX.4.44.0210080957010.877-100000@mastika.dce.bg>
Message-ID: <Pine.LNX.4.44.0210080014280.14851-100000@ns2.total-knowledge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ilya@theIlya.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 8 Oct 2002, Petko Manolov wrote:

> 	Hi there,
Hello.
> is it just me or the cvs repository is out of order?
It is both of you :)
CVS have moved to ftp.linux-mips.org

> When i try to
> checkout the linux kernel with:
> 	cvs -d:pserver:cvs@oss.sgi.com:/cvs co linux
cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co linux
it should be.

> I get:
> 	cvs server: cannot find module `linux' - ignored
> 	cvs [checkout aborted]: cannot expand modules
>
> Other modules (such as gdb) are working.  Any ideas?..
>
>
> 		Petko
>
>
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: pgpenvelope 2.9.0 - http://pgpenvelope.sourceforge.net/

iD8DBQE9ooYz84S94bALfyURAopRAJ9b7j9MKAzBKXkI5nepuCv2GoCwMwCfUseA
CRaQMfO3X4GsYvDVGn4T/Ns=
=Jt7C
-----END PGP SIGNATURE-----
