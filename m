Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 11:27:31 +0000 (GMT)
Received: from smtp3.infineon.com ([203.126.106.229]:39448 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20024851AbXKDL1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Nov 2007 11:27:23 +0000
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 04 Nov 2007 19:26:13 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 4 Nov 2007 19:26:13 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Get stuck in wake_up_process(rq->migration_thread);
Date:	Sun, 4 Nov 2007 19:26:12 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C17298602B11510@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Get stuck in wake_up_process(rq->migration_thread);
Thread-Index: Acge1YErxPuWjyVPRty8t31LfT16Jg==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 04 Nov 2007 11:26:13.0981 (UTC) FILETIME=[821C28D0:01C81ED5]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi;
	I have a linux-2.6.20 kernel configured with CONFIG_MIPS_MT_SMP
(SMVPE) running on a MIPS34KC processor emulation platform. Everything
goes fine until the scheduler gets stuck in trying to wake up the
migration thread. I configured the kernel with max_cache_size=2097152,
having no idea of what the variable is all about. Putting debug messages
in kernel/sched.c tells me that the the migration_thread() routine has
gone to sleep calling schedul() function and set_cpus_allowed() function
gets stuck in wake_up_process(rq->migration_thread); 
	Any insight is appreciated.

Regards.
KH
