Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 14:04:51 +0100 (BST)
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023921AbZEZNEW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 14:04:22 +0100
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5FFF1AC36;
	Tue, 26 May 2009 09:04:19 -0400 (EDT)
Received: from [102.117.138.10] (unknown [66.92.78.210]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 16F131AC34;
 Tue, 26 May 2009 09:04:04 -0400 (EDT)
Message-ID: <4A1BE8AA.4060502@pobox.com>
Date:	Tue, 26 May 2009 09:03:38 -0400
From:	Daniel Clark <dclark@pobox.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
Newsgroups: gmane.linux.ports.mips.general,gmane.linux.distributions.gnewsense.devel
To:	yanh@lemote.com
CC:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>, rms@gnu.org
Subject: Re: [loongson-support 00/27] linux PATCHes of loongson-based  
 machines
References: <cover.1242851584.git.wuzhangjin@gmail.com>	
 <4A14846A.3080006@pobox.com> <1243303900.9819.68.camel@localhost.localdomain>
In-Reply-To: <1243303900.9819.68.camel@localhost.localdomain>
X-Enigmail-Version: 0.95.0
OpenPGP: id=AA95C349;
 url=https://www.fsf.org/about/staff/fsf-sysadmin-keyring.asc/download
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig219612DA0B17A976B4AA8E0B"
X-Pobox-Relay-ID: B99946EC-49F5-11DE-B9BF-B4FDD46C8AFF-17709350!a-sasl-quonix.pobox.com
Return-Path: <dclark@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips
Message-ID: <20090526130338.jtesgjYOGnBCrO3f8-EyVFqNN_Xbuq6dMt8tCZWLLx0@z>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig219612DA0B17A976B4AA8E0B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

yanh wrote:

> The rtl8187b is included in 2.6.27 kernel, however, there are many
> issues in it(even in the 2.6.29 or 2.6.30). Some known isuses are below=
:
> 1. very hard to connect, and very poor performance.
> 2. may cause system crash(now this can be fixed)
>  issue 1 is the main reason that we stick to use the realtek providing
> driver.

Is the code at:

http://www.lemote.com/upfiles/wifi/rtl8187B_linux_26.1049.1215.2008_relea=
se2.tar.gz

The latest driver provided by realtek?

If not, where is the latest driver kept?

Thanks,
--=20
Daniel JB Clark   | Sys Admin, Free Software Foundation
pobox.com/~dclark | http://www.fsf.org/about/staff#danny


--------------enig219612DA0B17A976B4AA8E0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKG+itJNMr+aqVw0kRAkSiAKC2Y7G+TzfPDyzSbY/GwoOafxfyVACfSnNP
y2bAGqBtIaOcIcMQot7ziyU=
=/CSY
-----END PGP SIGNATURE-----

--------------enig219612DA0B17A976B4AA8E0B--
