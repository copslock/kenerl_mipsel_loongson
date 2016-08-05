Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Aug 2016 00:58:03 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38125 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992843AbcHEW546stfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Aug 2016 00:57:56 +0200
Received: from [2a05:e201:0:1224:f87e:2ae4:6385:7b44] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bVo3t-0001ad-US; Fri, 05 Aug 2016 23:57:54 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bVo3t-0005ZF-KV; Fri, 05 Aug 2016 23:57:53 +0100
Message-ID: <1470437868.4189.6.camel@decadent.org.uk>
Subject: [stable] MIPS page-table fixes
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        stable <stable@vger.kernel.org>
Date:   Fri, 05 Aug 2016 23:57:48 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-0W9S1Fh8cqK9CLEsJaX5"
X-Mailer: Evolution 3.20.4-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a05:e201:0:1224:f87e:2ae4:6385:7b44
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-0W9S1Fh8cqK9CLEsJaX5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks like the following commits should be backported to all stable
branches:

commit 6d037de90a1fd7b4879b48d4dd5c4839b271be98
Author: Ralf Baechle <ra
lf@linux-mips.org>
Date:=C2=A0=C2=A0=C2=A0Fri Jul 1 15:01:01 2016 +0200

=C2=A0=C2=A0=C2=A0=C2=A0MIPS: Fix possible corruption of cache mode by mpro=
tect.

commit 88d02a2ba6c52350f9a73ff1b01a5be839c3ca17
Author: David Daney <david.daney@cavium.com>
Date:=C2=A0=C2=A0=C2=A0Thu Jun 16 15:50:31 2016 -0700

=C2=A0=C2=A0=C2=A0=C2=A0MIPS: Fix page table corruption on THP permission c=
hanges.

The second seems to depend on the first, and the first seems to depend on:

commit 77a5c59332aa75e66f0d95f9eeb69baf3c68970d
Author: Steven J. Hill <Steven.Hill@imgtec.com>
Date:=C2=A0=C2=A0=C2=A0Thu Nov 13 09:52:01 2014 -0600

=C2=A0=C2=A0=C2=A0=C2=A0MIPS: Cosmetic cleanups of page table headers.

Does it make sense to pick all of these for stable? =C2=A0Are=20
there additional dependencies?

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.
--=-0W9S1Fh8cqK9CLEsJaX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpRntAAoJEOe/yOyVhhEJxYMP/iWQsX8cOjdaQF8/zX9p59Um
vOytIuQyft+iO3i0J2p927R3ZyjV3ZEhGUGypllyWqHub2B1BfHyMTN2psFO06+e
zI/HPa3jOzjZfrF/G3WEF2QzVZT+IgUZKP/LF0c//JwV8zk3+ByorRZKJ+wha7Qy
6fjCbNnFcI55KPA+BeuxWvXKAdOMZZYVTUo2M2q3kHudabm5Uf3xGplcME7USX0G
oUu29aCMp0LdH1WVz4PNOawOYNxRIBsr72wGJhU0X2NRUI7H9ZmTajgK+7DmT9W/
8YmKM4KHT+ee/oxS9nso+WxRdu6XYR8seTPEG2Ry0/DaY9ErzOyp9t4U+VyJq2Gh
J5pt5WLL110j+oUF4gHqt1KE8i6XhgQAaZ6CCschBG9J+N5TsicdTloljleLBwzF
Qr3HGViJIWPkUJDlVtqhypnn3HeaQ6hJIuyd4fGCtS4oYVUZB1B49Rm6SMf9oTYN
t9IqNxGe7UP+o+QIIn7Uvyiqc+XE0gt2+FFch4BmF/DQC5okFYocBrx66UnxdhqF
n6waM2rhFhYKz/NpGB9bp4LZTt2BKbFhAWgFScCEetyaM9swN60q7yFgoosQbVTt
SdR59GnYWYxov1GbD/cPeeaVr76/PqY9z/2IxSwASP++oWfW5Vg7ks5gYnlQHqJ5
xy+xo27PgDZMzsKz8Qa2
=jaRh
-----END PGP SIGNATURE-----

--=-0W9S1Fh8cqK9CLEsJaX5--
