Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 05:57:57 +0100 (BST)
Received: from bay1-f45.bay1.hotmail.com ([IPv6:::ffff:65.54.245.45]:20744
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225278AbTEJE5z>; Sat, 10 May 2003 05:57:55 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 9 May 2003 21:57:47 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Sat, 10 May 2003 04:57:46 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: jbglaw@lug-owl.de, linux-mips@linux-mips.org
Cc: muthu@iqmail.net
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Fri, 09 May 2003 21:57:46 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F45jlKqwWil63h0000a6fd@hotmail.com>
X-OriginalArrivalTime: 10 May 2003 04:57:47.0274 (UTC) FILETIME=[B32EA6A0:01C316B0]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

The linux kernel on the Atlas board went past the NFS issue.

Now a new one :(


Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.


in src/linux/init/main.c

open("/dev/console", O_RDWR, 0) is returning a negative value. I don't have 
a video device on board., required? Will /dev/console open a UART port 
(/dev/ttyS0 or /dev/tty0)? Why am I getting this error?

1. Is the kernel not build properly (did not include console driver)?
2. Should I pass init=blablabla as a parameter? <but nothing like that is 
specified in the doc.>.

Advice me please...

Thanks,

-Mike.

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus
