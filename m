Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 14:21:04 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:57228
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225322AbUBMOVE>; Fri, 13 Feb 2004 14:21:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 4F9C82BC44; Fri, 13 Feb 2004 15:21:02 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 19570-30;
 Fri, 13 Feb 2004 15:20:39 +0100 (CET)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id DF6102BC3E; Fri, 13 Feb 2004 15:20:39 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 7ECB64341; Fri, 13 Feb 2004 15:17:07 +0100 (CET)
Date: Fri, 13 Feb 2004 15:17:07 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Joost <Joost@stack.nl>
Cc: linux-mips@linux-mips.org
Subject: Re: indy r4000FPC kernel?
Message-ID: <20040213141707.GB960@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Joost <Joost@stack.nl>, linux-mips@linux-mips.org
References: <Pine.LNX.4.58.0402121652410.24037@brilsmurf.chem.tue.nl> <20040212174822.GD1280@bogon.ms20.nix> <Pine.LNX.4.58.0402121943180.3067@brilsmurf.chem.tue.nl> <20040212201020.GA942@bogon.ms20.nix> <Pine.LNX.4.58.0402130928570.15140@brilsmurf.chem.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402130928570.15140@brilsmurf.chem.tue.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 13, 2004 at 09:37:00AM +0100, Joost wrote:
> On Thu, 12 Feb 2004, Guido Guenther wrote:
> > On Thu, Feb 12, 2004 at 07:46:36PM +0100, Joost wrote:
> > > On Thu, 12 Feb 2004, Guido Guenther wrote:
> > > > On Thu, Feb 12, 2004 at 05:12:58PM +0100, Joost wrote:
> > > > > seems to be as far as it will go. The 2.4.22 that comes with
> > > > > debian testing gives an error while booting so i decided
> > > > What kind of error?
> > > It might have been the "can't load elf" problem. I'm very new
> > > to all of this so at the time (yesterday :-) I didn't know a
> > > solution existed. If it's important to you I could check again
> > > tomorow?
> > Yes please do. Thanks.
> After running elf2ecoff on it, the kernel from debian testing
> (kernel-image-2.4.22-r4k-ip22) seems to run just fine.
> The linux_2_4 cvs that compiled this night also works ok.
Thanks a lot for testing this. BTW you can avoid elf2ecoff by using
arcboot.
Cheers,
 -- Guido

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALNxjn88szT8+ZCYRAu5AAJ92wT/ola9eEkuRU5hbx6S9El9jhACfTdDf
EIB5oEjRay/+zR7jvbsHrs4=
=j1st
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
