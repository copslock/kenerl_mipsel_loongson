Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Dec 2004 04:55:17 +0000 (GMT)
Received: from web54504.mail.yahoo.com ([IPv6:::ffff:68.142.225.174]:49756
	"HELO web54504.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224786AbULQEzL>; Fri, 17 Dec 2004 04:55:11 +0000
Received: (qmail 50912 invoked by uid 60001); 17 Dec 2004 04:54:52 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=jlR90E5rhqzJuYsIeFPpYk7+rpRBgFfMXOICB+sh5LgUurJY1F0/++gfoUK1AEwD5+lXzdkdb+tkNJyJntNTTjtaodjrDr6ZjvKqzal9/yqqQjDaMpyEjVUogq4FuM5UM5S7/HygJBgT1FHb76jDQwVwjJJs5ShH1YPDd9jcWoE=  ;
Message-ID: <20041217045452.50910.qmail@web54504.mail.yahoo.com>
Received: from [203.101.73.166] by web54504.mail.yahoo.com via HTTP; Thu, 16 Dec 2004 20:54:52 PST
Date: Thu, 16 Dec 2004 20:54:52 -0800 (PST)
From: Srividya Ramanathan <navaraga@yahoo.com>
Subject: memory mapping
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <navaraga@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: navaraga@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
 Thanks a lot. I am facing one more problem. There is
one section of the driver where we map a small portion
of the PCI card's memory into user space. During
driver initialization, a magic number is written into
this space and read back from user space to verify the
driver is set up correctly. This fails.

any other way to locate the problem?

Thanks
R Srividya



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 
