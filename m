Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C7s0Rw015708
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 00:54:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C7s05b015707
	for linux-mips-outgoing; Fri, 12 Jul 2002 00:54:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.gmx.net (sproxy.gmx.net [213.165.64.20])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C7rqRw015698
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 00:53:53 -0700
Received: (qmail 30946 invoked by uid 0); 12 Jul 2002 07:58:23 -0000
Received: from unknown (HELO bogon.ms20.nix) (134.34.147.122)
  by mail.gmx.net (mp001-rz3) with SMTP; 12 Jul 2002 07:58:23 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 9C2C43646B; Fri, 12 Jul 2002 09:55:50 +0200 (CEST)
Date: Fri, 12 Jul 2002 09:55:50 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Michael Hill <mikehill@hgeng.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: X server blanking out virtual consoles?
Message-ID: <20020712075549.GA1569@bogon.ms20.nix>
Mail-Followup-To: Michael Hill <mikehill@hgeng.com>,
	linux-mips@oss.sgi.com
References: <1025794188.10696.205.camel@dilbert> <1026416316.1138.59.camel@dilbert>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1026416316.1138.59.camel@dilbert>
User-Agent: Mutt/1.3.28i
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Micheal,
On Thu, Jul 11, 2002 at 03:38:36PM -0400, Michael Hill wrote:
> /usr/bin/WindowMaker warning: could not allocate color "rgb:93/0d/29"
> /usr/bin/WindowMaker warning: could not get color for key
> "CClipTitleColor"
> /usr/bin/WindowMaker warning: using default "#454045" instead
> /usr/bin/WindowMaker warning: could not allocate color "#454045"
> /usr/bin/WindowMaker warning: could not get color for key
> "CClipTitleColor"
> /usr/bin/WindowMaker warning: could not allocate color "#73091d"
> /usr/bin/WindowMaker warning: could not get color for key
> "IconTitleBack"
> /usr/bin/WindowMaker warning: using default "black" instead
This is possibly as close as one can get with 8bpp. You can try to edit
GNUstep/defaults/WindowMaker to reduce the needed colors further.
thanks a lot for the report,
 -- Guido

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9LouFn88szT8+ZCYRAvQZAJ4s+2uNoKG+5pXAH10cQWssDQ1LWwCfTXN5
EGknYQsHOegpYy+0Jf8BiXk=
=xezG
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
