Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 20:58:50 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:55427 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20040370AbWKMSfi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2006 18:35:38 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id AC99BE4052
	for <linux-mips@linux-mips.org>; Mon, 13 Nov 2006 12:02:40 -0800 (PST)
Subject: Portmap on the Encore M3
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 13 Nov 2006 10:46:47 -0800
Message-Id: <1163443607.6532.9.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I get the following error after the NFS is mounted and the kernel frees
136k of memory:



> >
> RPC: sendmsg returned error 128.
> <4>nfs: RPC call returned error 128 
> 

I m trying to boot the 2.6.14.6 kernel onto the Encore M3 board that has
the MIPS AU1500 processor on it.

The .config file contains the following line: CONFIG_PORTMAP=y
The server from which the NFS is mounted is also running the portmap
daemon..

Is there a way to check if the portmap server is functioning properly?


Also:

- The BogoMIPS value is 7186 which seems too low for the AU1500 -- how
can I check that the timer interrupt is being handled correctly?  The
AU1500 has 2 counters which are used to generate a clock

- On the serial console I can only see messages upto this point:


> 16.35 BogoMIPS (lpj=8176)
> calibrate delay done
> anon vma init done
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  unavailable.
> NET: Registered protocol family 16
> size of au1xxx platform devices is 1

After this, the serial console 'hangs' -- I can see the RPC error from the log buffer, accessed from the JTAG port..
--Please give any suggestions as to where I should start looking to narrow down and figure out the problem..

Thank you!
Ashlesha.

Kenati Technologies
Suite #220 
800 W California Ave
Sunnyvale 
94086 CA
