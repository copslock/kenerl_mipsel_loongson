Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 09:19:37 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:62045 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20023362AbXIUIT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 09:19:29 +0100
X-SBRS:	None
Received: from unknown (HELO sinse302.ap.infineon.com) ([172.20.70.23])
  by smtp3.infineon.com with ESMTP; 21 Sep 2007 16:18:23 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse302.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Sep 2007 16:18:20 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: YAMON booting Linux kernels from malta board harddisk....
Date:	Fri, 21 Sep 2007 16:18:19 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: YAMON booting Linux kernels from malta board harddisk....
Thread-Index: Acf8J/fbpB5W24HJRmKaGGbt/cSRYg==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>
Cc:	<Friedrich-Nachtmann.External@infineon.com>
X-OriginalArrivalTime: 21 Sep 2007 08:18:20.0684 (UTC) FILETIME=[F8868CC0:01C7FC27]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi list;
	I read of MIPSboot that is loaded into the MBR which is then
read from YAMON to boot a selection of kernels from the harddisk.
However, google-ing for "MIPSboot" does not yield any useful result so
far. Does anybody have any insight and experience to share as to what
and how to setup the MBR of a harddisk that I can boot a selection of
Linux kernels from YAMON on Malta board?
	Thanks.

Regards,
KH
