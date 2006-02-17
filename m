Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 18:25:33 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:55460 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133359AbWBQSZR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 18:25:17 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id DC6055DF5B;
	Fri, 17 Feb 2006 19:31:55 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31047-02; Fri, 17 Feb 2006 19:31:55 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 600EA5DF4D; Fri, 17 Feb 2006 19:31:55 +0100 (CET)
Date:	Fri, 17 Feb 2006 19:31:55 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: replaced io_remap_page_range() with io_remap_pfn_range()
Message-ID: <20060217183155.GH14066@dusktilldawn.nl>
References: <20060217145352.GD14066@dusktilldawn.nl> <20060217173448.GB30429@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <20060217173448.GB30429@cosmic.amd.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jordan,

On Fri, Feb 17, 2006 at 10:34:48AM -0700, Jordan Crouse wrote:
> I do believe that this fix is already upstream.  Are you playing
> with the latest kernel?
I played with the latest git repository which I did got from:

	$ git clone rsync://ftp.linux-mips.org/pub/scm/linux.git linux.git

and which I today updated using:

	$ git pull git://ftp.linux-mips.org/pub/scm/linux.git

And just to make sure it's not upstream I checked out:

	$ cg-clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.=
6.git

and just to be 100% sure linux-2.6.15.4.tar.bz2 with
patch-2.6.16-rc3.bz2 too.

I now think I covered it all, or am I still missing something?
Anyway, I did not find the problem fixed in any of these
repositories or tarballs so hence I shall send the patch to
Antonino Daplas later tonight or tomorrow.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9habbxf9XXlB0eERAk3MAJ4pLnlv0q9M5uV+zPEoQJMQLbQF7QCfVwck
JHGGzKidECPtmXMEMOxRV1I=
=gx2M
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
