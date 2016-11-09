Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 23:12:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36819 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993076AbcKIWL4A1-S1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 23:11:56 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8EA2241F8E08;
        Wed,  9 Nov 2016 22:10:41 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 09 Nov 2016 22:10:41 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 09 Nov 2016 22:10:41 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0290C2975FBF;
        Wed,  9 Nov 2016 22:11:46 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 9 Nov
 2016 22:11:49 +0000
Date:   Wed, 9 Nov 2016 22:11:49 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Jiri Slaby <jslaby@suse.cz>
CC:     <stable@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [BACKPORT PATCH 3.10..3.16 1/2] MIPS: KVM: Fix unused variable
 build warning
Message-ID: <20161109221149.GB7075@jhogan-linux.le.imgtec.org>
References: <2e791b20c24570339d15118a55e174f5b2d63ac1.1478707766.git-series.james.hogan@imgtec.com>
 <dc526766-4588-52df-6cee-f7a6121e3468@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <dc526766-4588-52df-6cee-f7a6121e3468@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2016 at 10:28:58PM +0100, Jiri Slaby wrote:
> On 11/09/2016, 05:13 PM, James Hogan wrote:
> > From: Nicholas Mc Guire <hofrat@osadl.org>
> >=20
> > commit 5f508c43a7648baa892528922402f1e13f258bd4 upstream.
>=20
> Both applied now to 3.12, albeit the latter didn't apply cleanly.

/me digs in terminal log

Sorry, I used patch -p1 intentionally when testing 3.12 to try to spot
unclean stable patches, expecting it to reject it, but didn't spot the
fuzz:

$ git show 4.9/kvm/fixes_rc3/stable/3.16 | patch -p1                       =
                                                         =20
patching file arch/mips/include/asm/kvm_host.h
Hunk #1 succeeded at 375 with fuzz 2 (offset -28 lines).
=2E..

Thanks
James

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYI58lAAoJEGwLaZPeOHZ6an4P/A5AamVXmzHgc8Z09thZlH2v
wFPM88qd9Ju3flvL7O+9moPBYBpIJWCKn8Y85buWepo2HAbFwIBf0utYFWURmvV0
cD6v1dIYecAcmbY9sz0+YQKXEQNxNiftW7iCVzi0dVsUv4Gm+9eoizYlv8/af63r
Advj3pR7q0bX6Q8L7Q0uobLjcIqJIhpbKPORnKbasnD63C7RUvT/iatf5dZ8x0gL
es7g7Rohxx/8R/F40ze8RghxVv3u1IB1rchdVZ5ZQ5t81LcpjeGhx1U1/WZ9YOM9
H853sOji8SbM5h4pP4txILnKDvnrrvifTMZoJwxFPn7Xw1HBY1lxfcYiMCIXpnY0
aqWFIbb7ubbfyUjx+nbW3HvdefFMUC7sdRVznh6Ikdsd6KItOfad//ddUPS4jbv+
HRZuZdNAn2gV7fHmz8Jlkcc/v3tq8wy/+DxLkwUXWVdG1VdY+kdmDSoH48FzPONA
sosZa6LNyaNJm+tuc8K24zq1Itn6/s5l4TrgGnSKfoCDRn8k+8drvLMOn3LQ303u
KUa2+xez4wNhd4tq5JZMR5fnefGomSyY6A9z7+rXQxFatjn+D8tgGtXqtLjDaJDB
6qkeTKbXCi7BwHxCKS4U4vI+0abSi22NOPOBdbabSsHMZUVVWPBH/i2yLB/AIla1
ObxCZKCtho+qbDEKSb7U
=84+T
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
