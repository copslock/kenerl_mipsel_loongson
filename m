Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 13:33:38 +0100 (BST)
Received: from [85.186.197.132] ([85.186.197.132]:1234 "HELO swpark.galati.ro")
	by ftp.linux-mips.org with SMTP id S20022247AbXIKMda (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 13:33:30 +0100
Received: (qmail 27455 invoked by uid 1011); 11 Sep 2007 11:33:37 -0000
Received: from unknown (HELO ?10.95.12.191?) (vlad@comsys.ro@127.0.0.1)
  by swpark.galati.ro with SMTP; 11 Sep 2007 11:33:37 -0000
Message-ID: <46E68AA3.2010907@comsys.ro>
Date:	Tue, 11 Sep 2007 15:31:31 +0300
From:	Vlad Lungu <vlad@comsys.ro>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Subject: Qemu and Linux 2.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vlad@comsys.ro>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vlad@comsys.ro
Precedence: bulk
X-list: linux-mips

I know some of you will laugh, but:

- QEMU malta emulation is not really complete, to put it mildly
- the QEMU target is available only for Linux 2.6
- despite popular opinion, 2.4 ain't dead yet, at least in the embedded 
market


I have a port of the QEMU target for Linux 2.4.34.4 (latest 2.4 kernel 
on linux-mips.org), with NE2000 card working (in both BE and LE modes).
Still rough at the edges, but it works on stock qemu-0.9.0 with -M mips.

If anyone is interested, I can send the patch by e-mail. I have no idea 
if I can post attachments to the list(s), that's why it's not attached.

Vlad
