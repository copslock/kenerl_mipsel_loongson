Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 11:30:04 +0000 (GMT)
Received: from smtp3.infineon.com ([203.126.106.229]:44036 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20029240AbYAEL34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2008 11:29:56 +0000
X-SBRS:	None
Received: from unknown (HELO sinse302.ap.infineon.com) ([172.20.70.23])
  by smtp3.infineon.com with ESMTP; 05 Jan 2008 19:29:48 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse302.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 5 Jan 2008 19:29:48 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Arch/mips/kernel/vpe.c
Date:	Sat, 5 Jan 2008 19:29:46 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C1729860320EADA@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Arch/mips/kernel/vpe.c
Thread-Index: AchPjkawk2pAYPyuRxmg9UQLLqsC3Q==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 05 Jan 2008 11:29:48.0238 (UTC) FILETIME=[476DAEE0:01C84F8E]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi;
	I am working on MIPS34KC with APRP kernel and I use uclibc
gccc-3.4.4 to build applications to run on VPE1. The present
implementation of VPE loader is limited to a few relocation types which
are used when mips_sde compiler is used. However, the relocatable binary
churn out from my uclibc-gcc-3.4.4 has more other relocation types than
the ones defined in arch/mips/kernel/vpe.c, especially those with GOT
relocation types. I have taken a look at the System V ABI Third Edition
but if anybody has any code reference and pointers to how each
relocation types should be implemented in C-code, it would be very
helpful.
	Thanks.

Regards,
KH
