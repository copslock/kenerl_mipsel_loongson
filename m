Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 12:04:44 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:60733 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20021450AbXGQLEm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2007 12:04:42 +0100
X-SBRS:	None
Received: from unknown (HELO sinse302.ap.infineon.com) ([172.20.70.23])
  by smtp3.infineon.com with ESMTP; 17 Jul 2007 19:03:35 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse302.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Jul 2007 19:03:34 +0800
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: linux-2.6.20 setjmp/longjmp OR how to contain bus-error for non-existing PCI device during PCI device scan?
Date:	Tue, 17 Jul 2007 19:03:34 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C172986019B76D7@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux-2.6.20 setjmp/longjmp OR how to contain bus-error for non-existing PCI device during PCI device scan?
Thread-Index: AcfIYh56sD1a1m7HSLeq6iC678LWjA==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 17 Jul 2007 11:03:35.0170 (UTC) FILETIME=[1EC18E20:01C7C862]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi;
   I am using linux-2.6.20 on MIPS24KE and I need to know what is the best way to contain bus error during PCI bus scan process for non-existing device? I thought of setjmp/longjmp but unfortunately, I have `googled` and `find` the whole kernel source tree there is no such support in the kernel for MIPS architecture. Any insight is appreciated.
 
Regards,
Kok How
