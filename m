Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2004 10:11:53 +0100 (BST)
Received: from futarque.com ([IPv6:::ffff:212.242.80.58]:60563 "HELO
	mail.futarque.com") by linux-mips.org with SMTP id <S8224918AbUI1JLs>;
	Tue, 28 Sep 2004 10:11:48 +0100
Received: (qmail 883 invoked by uid 64014); 28 Sep 2004 09:11:40 -0000
Received: from smm@futarque.com by mail by uid 64011 with qmail-scanner-1.16 
 (uvscan: v4.1.60/v4278. spamassassin: 2.63.   Clear:. 
 Processed in 0.23807 secs); 28 Sep 2004 09:11:40 -0000
Received: from excalibur.futarque.com (192.168.2.15)
  by mail.futarque.com with SMTP; 28 Sep 2004 09:11:40 -0000
Subject: Problem debugging multi-threaded app
From: Steffen Malmgaard Mortensen <smm@futarque.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1096362700.5227.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 11:11:40 +0200
Content-Transfer-Encoding: 7bit
Return-Path: <smm@futarque.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smm@futarque.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm trying to debug a multi-threaded app using gdbserver/gdb. I see the
same problems as described in
http://www.linux-mips.org/archives/linux-mips/2002-09/msg00155.html -
the program receives SIG32, but gdb doesn't associate that with thread
creation. The solution back in 2002 was to upgrade the tool-chain, but
I'm not sure what versions I should use today (and what patches). I'm
currently using:

CPU: Ati X225 (mips4kc - little endian)
kernel: linux 2.4.18 + vendor patches

glibc: 2.3.2
gcc: 3.3.2
binutils: 2.14
(the three above from crosstool 0.27)

gdb/gdbserver: 6.2

According to strace gdbserver loads libthread_db as it should, but gdb
on my host doesn't load libthread_db.

Any help/suggestions will be greatly appriciated...

Best regards,
Steffen
