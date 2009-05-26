Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 14:04:27 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:42272 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022482AbZEZNEV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 14:04:21 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M8wKH-0001kE-5V
	for linux-mips@linux-mips.org; Tue, 26 May 2009 13:04:17 +0000
Received: from terminus-est.gnu.org ([66.92.78.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 26 May 2009 13:04:17 +0000
Received: from dclark by terminus-est.gnu.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 26 May 2009 13:04:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Daniel Clark <dclark@pobox.com>
Subject:  Re: [loongson-support 00/27] linux PATCHes of loongson-based   machines
Date:	Tue, 26 May 2009 09:03:38 -0400
Message-ID:  <4A1BE8AA.4060502@pobox.com>
References:  <cover.1242851584.git.wuzhangjin@gmail.com>	 <4A14846A.3080006@pobox.com> <1243303900.9819.68.camel@localhost.localdomain>
Mime-Version:  1.0
Content-Type:  multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig219612DA0B17A976B4AA8E0B"
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: terminus-est.gnu.org
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <1243303900.9819.68.camel@localhost.localdomain>
X-Enigmail-Version: 0.95.0
OpenPGP: id=AA95C349;
	url=https://www.fsf.org/about/staff/fsf-sysadmin-keyring.asc/download
Cc:	gnewsense-dev@nongnu.org
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips

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
