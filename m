Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Mar 2013 21:51:55 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46313 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827427Ab3CBUvyi0aFe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Mar 2013 21:51:54 +0100
Received: from [2001:470:1f08:1539:a11:96ff:fec6:70c4] (helo=deadeye.wl.decadent.org.uk)
        by shadbolt.decadent.org.uk with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.72)
        (envelope-from <ben@decadent.org.uk>)
        id 1UBtPL-0001KY-Qq; Sat, 02 Mar 2013 20:51:51 +0000
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1UBtPK-0004VE-Dc; Sat, 02 Mar 2013 20:51:50 +0000
Message-ID: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk>
Subject: THP broken on MIPS-32 [3.8]
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mips@linux-mips.org
Date:   Sat, 02 Mar 2013 20:51:39 +0000
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-1dO0jcHx31CSAKkK9w4Z"
X-Mailer: Evolution 3.4.4-2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:470:1f08:1539:a11:96ff:fec6:70c4
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-archive-position: 35837
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-1dO0jcHx31CSAKkK9w4Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You implemented transparent huge pages for MIPS:

commit 970d032fec3f9687446595ee2569fb70b858a69f
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Oct 18 13:54:15 2012 +0200

    MIPS: Transparent Huge Pages support

but THP also changed in 3.8:

commit fc9fe822f7112db23e51e2be3b886f5d8f0afdb6
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Wed Dec 12 13:50:51 2012 -0800

    thp: copy_huge_pmd(): copy huge zero page

This added the requirement for pfn_pmd(), which is only defined if
CONFIG_64BIT && !CONFIG_CPU_VR41XX.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.

--=-1dO0jcHx31CSAKkK9w4Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUTJmW+e/yOyVhhEJAQpjmBAAlUeuC4zER8Q92ihG+j/POv5Wciewew3e
bW4L/nSA/V4eh1lf6NtOB6asayWnZR0ifBL0VNtbCayE5gZl3n0hRmccvyQzzdDX
CWxUiLnvREeT3n+Q99t8bEo1mDWy1KSg++RFjnUveSp00wIOAUYO6Oy2TldOK4wj
91xb8h4j6nF+0KBQrsS3jIwlyPPyzhliJmKSGtfzQdKyYSEYZbzIc2HO649BkeB3
dX0TbKwHnwdnOiXv6c9EdxvIL5xixaf9/0Kp67TXfIJi2RpsrslPuvB/s5/7g57g
6LKBwlewijxUSCblJzW9qNbPCt6IpdXezNWTNnu2J4pyerGsVLCdD/SdAXqBwtmZ
jn8Yexjx/3zhIr86HUvk6NOud5hgLdPaHGZnrXXE96DaT9glDgfwsmIsxzMv+27h
TYhDjSNAw5RrLhMH37quH9ELfzdbvaf2mP72gF5JFCmxf6oAcB8VyNCAHHLDSK63
34QJkqLD0scMb4B7thGivon1VSteu6ltehh6CsfcASTPZCOLsmI2xGppbKHmyzZl
+kh1yIUQiPm9wn89dK9l0ChQldmR1NXDrATpWUc7JTCgqG5Ugs+sJiM2GMpnSTrG
jx5EtzTbYWRrgJkkwbcmDDvj4Ksd6RUuKk11sU+S0Y8bByG8KeitPDIwrP4r6rZF
c0aBbG8u//4=
=fSlX
-----END PGP SIGNATURE-----

--=-1dO0jcHx31CSAKkK9w4Z--
