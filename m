Received:  by oss.sgi.com id <S42229AbQG1L6h>;
	Fri, 28 Jul 2000 04:58:37 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:52598 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42218AbQG1L6P>;
	Fri, 28 Jul 2000 04:58:15 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA16252
	for <linux-mips@oss.sgi.com>; Fri, 28 Jul 2000 04:50:50 -0700 (PDT)
	mail_from (wichert@cistron.nl)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA26324 for <linux-mips@oss.sgi.com>; Fri, 28 Jul 2000 04:56:36 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA95643
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Jul 2000 04:55:03 -0700 (PDT)
	mail_from (wichert@cistron.nl)
Received: from fog.mors.wiggy.net (dhcp137.hw.cistron-internet.nl [195.64.65.137]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA02395
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jul 2000 04:54:59 -0700 (PDT)
	mail_from (wichert@cistron.nl)
Received: (from wichert@localhost)
	by fog.mors.wiggy.net (8.11.0.Beta1/8.10.1/Debian 8.10.1-1) id e6SBpe504923;
	Fri, 28 Jul 2000 13:51:40 +0200
Date:   Fri, 28 Jul 2000 13:51:39 +0200
From:   Wichert Akkerman <wichert@cistron.nl>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>,
        Keith M Wesolowski <wesolows@chem.unr.edu>,
        linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
Message-ID: <20000728135139.A4903@cistron.nl>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>,
	Jun Sun <jsun@mvista.com>,
	Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@fnet.fr,
	linux@cthulhu.engr.sgi.com
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu> <3980C9F0.96B48253@mvista.com> <20000728021137.B1328@bacchus.dhis.org> <3980EC1C.AEF173D2@mvista.com> <20000728042109.C1981@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000728042109.C1981@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Jul 28, 2000 at 04:21:09AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Previously Ralf Baechle wrote:
> Looks like strace is still tryping to copy mmap_arg_struct like on Intel
> but on MIPS we don't use that?

Could be, I think MIPS and i386 use the same codepath there. Patches
are appreciated so I can include them in strace 4.3 (eta 3 weeks from
now)

Wichert.

--=20
  _________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjmBc8sACgkQPLiSUC+jvC3GqgCdHqxyqwjxx7x8Hg3WLMmbE5nl
XrMAoJD8GA1rPcnpFhbhN+gvDXZqAVK9
=axEH
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
