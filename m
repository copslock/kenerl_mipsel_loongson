Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 14:51:39 +0100 (BST)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:21998 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8226926AbVGSNvW>; Tue, 19 Jul 2005 14:51:22 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc11) with SMTP
          id <2005071913530001100qj8uce>; Tue, 19 Jul 2005 13:53:01 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: remote debugging: "Reply contains invalid hex digit 59"
Date:	Tue, 19 Jul 2005 09:52:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWMaSsvbERBhjYxS7eDdrjjDpDV1Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050719135122Z8226926-3678+3493@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips


Is anyone doing remote debugging for mips?  

I start the gdbserver on mips with:  
    gdbserver 192.168.2.39:2222 ./hello_loop
This produces:
    Process ./hello_loop created; pid = 158

On my PC, I type:
    ddd --debugger mips64-linux-gnu-gdb hello_loop
    (at gdb prompt) target remote 192.168.2.55:2222

This produces:
    (on gdb prompt) Couldn't establish connection to remote target
     Reply contains invalid hex digit 59
    (on mips) Remote debugging from host 192.168.2.39
     Readchar: Got EOF
     Remote side has terminated connection.  GDBserver will reopen the
connection. 

This problem is also described here:
http://mailman.uclinux.org/pipermail/uclinux-dev/2004-April/025421.html

Any ideas?  Thanks!

Bryan
