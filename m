Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 07:18:00 +0100 (BST)
Received: from ftp-xb.sasken.com ([IPv6:::ffff:164.164.56.3]:31155 "EHLO
	sandesha.sasken.com") by linux-mips.org with ESMTP
	id <S8225072AbTDIGR7>; Wed, 9 Apr 2003 07:17:59 +0100
Received: from sunsv2.sasken.com (localhost [127.0.0.1])
	by sandesha.sasken.com (8.12.8/8.12.8) with ESMTP id h396Hi35029407
	for <linux-mips@linux-mips.org>; Wed, 9 Apr 2003 11:47:45 +0530 (IST)
X-Authentication-Warning: sandesha.sasken.com: iscan owned process doing -bs
Received: from pcz-madhavis.sasken.com (IDENT:madhavis@pcz-madhavis.sasken.com [10.1.64.210])
	by sunsv2.sasken.com (8.11.6/8.11.6) with ESMTP id h396Hpw10678
	for <linux-mips@linux-mips.org>; Wed, 9 Apr 2003 11:47:51 +0530 (IST)
Date: Wed, 9 Apr 2003 11:47:51 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-mips@linux-mips.org>
Subject: cross-compiler for mips (r5432)
Message-ID: <Pine.LNX.4.33.0304091136220.1873-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Return-Path: <madhavis@sasken.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madhavis@sasken.com
Precedence: bulk
X-list: linux-mips

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi

I want to install a cross-compiler for MIPS(R5432 CPU) on an i686 host.
Since R4000 is compatible with R5432, I am using "mips3" as the target.
binutils-2.13 and I phase compilation of gcc-3.2 happened without any
problems. But, glibc-2.2.5 is giving many compilation problems. This is
how I configured glibc:

configure --build=i686-linux --host=mips3el-linux --enable-add-ons
--prefix=/usr.

Could someone guide me on this or give me some pointers for installation?
Is the target option "mips3" the right choice for R5432?

Thank you in advance.

regards
Madhavi.

Madhavi Suram
Software Engineer
Customer Delivery / Networks
Sasken Communication Technologies Limited
139/25, Ring Road, Domlur
Bangalore - 560071 India
Email: madhavis@sasken.com
Tel: + 91 80 5355501 Extn: 8062
Fax: + 91 80 5351133
URL: www.sasken.com



--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

************************************************************************

SASKEN BUSINESS DISCLAIMER

This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken accepts no liability for any loss or damage, which may be caused by viruses.

***********************************************************************

--=_IS_MIME_Boundary--
