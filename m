Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 09:16:49 +0000 (GMT)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:58402 "HELO krt.neobee.net")
	by ftp.linux-mips.org with SMTP id S20037799AbWKMJQp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2006 09:16:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (Postfix) with ESMTP id 47463FCC53
	for <linux-mips@linux-mips.org>; Mon, 13 Nov 2006 10:16:39 +0100 (CET)
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02019-03 for <linux-mips@linux-mips.org>;
 Mon, 13 Nov 2006 10:16:38 +0100 (CET)
Received: from had (unknown [192.168.0.92])
	by krt.neobee.net (Postfix) with ESMTP id 8E57AFCC52
	for <linux-mips@linux-mips.org>; Mon, 13 Nov 2006 10:16:38 +0100 (CET)
From:	"Mile Davidovic" <Mile.Davidovic@micronasnit.com>
To:	<linux-mips@linux-mips.org>
Subject: Uncached mmap
Date:	Mon, 13 Nov 2006 10:18:52 +0100
Message-ID: <001201c70704$bc731230$5c00a8c0@niit.micronasnit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccHBLwkgp9Y/8vEQMebBTkgYIALGw==
Return-Path: <Mile.Davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mile.Davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello to all,
I am working on fb device and I have general questions regarding cache/uncache
access to MIPS memory. 

User space application use mmap access for r/w access to fb device. If fb use
cached memory, user space application has to call cacheflush to flush contents
instruction and/or data cache. In this case there are no limitations regarding
byte access to this memory. Is this correct statement?

If fb use uncached memory, there is no need for cacheflush call in user space
application but limitation is access to mmap uncached memory. There is no byte
access to uncached mmaped memory. Is this correct statement?


Many thanks in advance.
Best regards Mile
