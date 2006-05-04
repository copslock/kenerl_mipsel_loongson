Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 07:31:29 +0100 (BST)
Received: from bay18-f22.bay18.hotmail.com ([65.54.187.72]:62399 "EHLO
	hotmail.com") by ftp.linux-mips.org with ESMTP id S8133525AbWEDGbS
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 07:31:18 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 3 May 2006 23:31:11 -0700
Message-ID: <BAY18-F22BF9163A6C30B8B903B8EADB40@phx.gbl>
Received: from 220.247.245.66 by by18fd.bay18.hotmail.msn.com with HTTP;
	Thu, 04 May 2006 06:31:08 GMT
X-Originating-IP: [220.247.245.66]
X-Originating-Email: [safiudeen@hotmail.com]
X-Sender: safiudeen@hotmail.com
From:	"safiudeen Ts" <safiudeen@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Linux-2.6.16 on DB1100
Date:	Thu, 04 May 2006 06:31:08 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 04 May 2006 06:31:11.0343 (UTC) FILETIME=[55BB37F0:01C66F44]
Return-Path: <safiudeen@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: safiudeen@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi all,
I am testing linux-2.6.16 on DB1100 board.I downloded the kernel from 
www.linux-mips.org and cross compiled with configaration that suit for 
Db1100.
I used following command to get vmlinux.srec

$ make vmlinux.srec

and copyed it to /tftpboot/

DB1100 board load the kernel image through nfs using yamon boot loader.

when we reset the board, it starts the yamon and load the kernel from nfs 
server after that it hang threre. There are no any kernel messages comming 
to minicom ( minicom is running in PC with serial port is connected to the 
db1100 boards serial port 0)

Followings are the minicom output I recived
-----------------------------------------------------------


About to load tftp://192.168.0.3//tftpboot/vmlinux.srec
Press Ctrl-C to break
...............................................................................
..................................................................................
................................................................................

Start = 0x8034f000, range = ( 0x80100000,0x8036e084 )

-----------------------------------------------------------

Please can anyone help me to short it out this problem?

Thanx
Safiudeen

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
