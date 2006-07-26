Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 01:09:50 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:42678 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S8133989AbWGZAJh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 01:09:37 +0100
Received: from [192.168.1.105] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id AD114E4052
	for <linux-mips@linux-mips.org>; Tue, 25 Jul 2006 17:24:11 -0700 (PDT)
Subject: YAMON: go
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 25 Jul 2006 17:14:22 -0700
Message-Id: <1153872862.6478.7.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I compiled an 2.6 kernel for the db1500 board and used the load command
in YAMON to write the srec image to the RAM using tftp.  Now I want to
start the kernel and so I issued the go command.  It gives me the
following error:

* Exception (user) : Reserved instruction *

CAUSE    = 0x00808028  STATUS   = 0x00000002
EPC      = 0x80404004  ERROREPC = 0x00000000
BADVADDR = 0x00000000

Also another query is this: How does one know whether the load command
has written to the RAM or the Flash?  The help load says that this
depends on the address.  However, upon issuing the load command without
any options, YAMON outputs the following as the location of the load:

Start = 0x80404000, range = (0x80100000,0x80423084), format = SREC

Thanks & Regards,

Ashlesha Shintre.
Intern
Kenati Technologies
800W California Ave.
Sunnyvale, CA
