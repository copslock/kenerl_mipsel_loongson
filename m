Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2004 10:20:38 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:1250 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224948AbUJZJUd>; Tue, 26 Oct 2004 10:20:33 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP
	id 777AF1EFFA; Tue, 26 Oct 2004 11:20:26 +0200 (CEST)
Message-ID: <417E1747.9020603@enix.org>
Date: Tue, 26 Oct 2004 11:22:15 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: uclibc@uclibc.org
Cc: linux-mips@linux-mips.org
Subject: [buildroot] Compilation failure on MIPS with 2.6.9.1 kernel headers
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0A49C883E08FDECCA5A1C600"
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A49C883E08FDECCA5A1C600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The compilation fails on MIPS with the new 2.6.9.1 kernel headers :

================================================================
In file included from ../../../include/bits/socket.h:305,
                  from ../../../include/netinet/in.h:212,
                  from ../../../include/netdb.h:28,
                  from __h_errno_location.c:3:
../../../include/asm/socket.h:86: error: conflicting types for 'SOCK_DGRAM'
../../../include/bits/socket.h:43: error: previous definition of 
'SOCK_DGRAM' was here
../../../include/asm/socket.h:87: error: conflicting types for 'SOCK_STREAM'
../../../include/bits/socket.h:46: error: previous definition of 
'SOCK_STREAM' was here
../../../include/asm/socket.h:88: error: conflicting types for 'SOCK_RAW'
../../../include/bits/socket.h:49: error: previous definition of 
'SOCK_RAW' was here
../../../include/asm/socket.h:89: error: conflicting types for 'SOCK_RDM'
../../../include/bits/socket.h:51: error: previous definition of 
'SOCK_RDM' was here
../../../include/asm/socket.h:90: error: conflicting types for 
'SOCK_SEQPACKET'
../../../include/bits/socket.h:53: error: previous definition of 
'SOCK_SEQPACKET' was here
../../../include/asm/socket.h:91: error: conflicting types for 'SOCK_PACKET'
../../../include/bits/socket.h:60: error: previous definition of 
'SOCK_PACKET' was here
================================================================

I think this issue has been discussed (and fixed) in the Linux MIPS CVS, 
see :
  http://www.linux-mips.org/archives/linux-mips/2004-10/msg00286.html
  http://www.linux-mips.org/archives/linux-cvs/2004-10/msg00120.html

As I understand it, #ifdef __KERNEL__ conditionnal is missing, leading 
to SOCK_* being visible to the userspace, and conflicting with libc 
definitions.

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig0A49C883E08FDECCA5A1C600
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfhdK9lPLMJjT96cRAm5FAJ0XH7MQxAy86hmNIh26P3MIS8Gt+ACeLFEO
+Zvdgl+/CF/mkSOvenvOe3w=
=wR2l
-----END PGP SIGNATURE-----

--------------enig0A49C883E08FDECCA5A1C600--
