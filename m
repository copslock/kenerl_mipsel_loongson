Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 16:10:44 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:6530
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8224861AbTDQPKn>; Thu, 17 Apr 2003 16:10:43 +0100
Received: (qmail 14428 invoked by uid 502); 17 Apr 2003 15:10:38 -0000
Date: Thu, 17 Apr 2003 08:10:38 -0700
From: ilya@theIlya.com
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: R5000 Linux
Message-ID: <20030417151038.GE4485@gateway.total-knowledge.com>
References: <200304170912.55096.donath@hks.com> <20030417145650.GJ22768@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
In-Reply-To: <20030417145650.GJ22768@bogon.ms20.nix>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2003 at 04:56:50PM +0200, Guido Guenther wrote:
> You'll also find a cross toolchain there. The major show stopper for me
> is currently the "do_cpu invoked from kernel context!" problem which I
> didn't find any time to look into yet. I wonder wether I'm the only
> person seeing this?
I was able to reproduce it with following simple sequence of events:
#(while true; do true; done)>/dev/zero
As soon as I interrupt this, do_cpu oops happened. Problem occurs
somewhere in signeal handlin code. I didn't investoigate further yet, as
for what I am doing at the moment it is not a problem.

What is a problem, is memory leak in 2.5.47. Every time *any* process is forked,
system permenently looses few K of memory. Modifying above loop to run
cat</proc/meminfo will bring down system to its knees in about 5-10 minutes.


--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+nsPu7sVBmHZT8w8RAnX7AJ0at6yYCijKwBSyPqWb57z4s+UwLACfXIwV
2SgFIIslp4XENFjHl2wLsHI=
=4uka
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
