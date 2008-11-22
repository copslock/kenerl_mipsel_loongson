Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 13:55:44 +0000 (GMT)
Received: from n6b.bullet.mail.ac4.yahoo.com ([76.13.13.76]:63310 "HELO
	n6b.bullet.mail.ac4.yahoo.com") by ftp.linux-mips.org with SMTP
	id S23833455AbYKVNz3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 13:55:29 +0000
Received: from [76.13.13.26] by n6.bullet.mail.ac4.yahoo.com with NNFMP; 22 Nov 2008 13:55:23 -0000
Received: from [76.13.10.165] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 22 Nov 2008 13:55:23 -0000
Received: from [127.0.0.1] by omp106.mail.ac4.yahoo.com with NNFMP; 22 Nov 2008 13:55:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 183605.20367.bm@omp106.mail.ac4.yahoo.com
Received: (qmail 91741 invoked by uid 60001); 22 Nov 2008 13:55:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=K0xB8DIm4emutc4XoMks6Dw/qf7lz1256Hiz6H+lIDN+MmSHRN5CK51tFgsEXkpyMw4N9s285AblYgqSY+4ONUgjND3slIvXsqDY57p3tO2K4cqQRpAxtJrILhZG07bCNmyIqsId2S6IgXSCoME4EkAF1tXXdzKNw5oTPclLThY=;
X-YMail-OSG: x5I_7KgVM1kq5wNNq4S.rKCIkGF5FolhgjeRI3tF5Pu7QKyAebZ9fzLDRI25MyHZiHFSrbyqvlOqLuorMJCAugSJhY90J_30qwU7XgGq42v9Y.Jb7doIwHON1v8qS8QzlHNnZ1s-
Received: from [84.204.225.1] by web59801.mail.ac4.yahoo.com via HTTP; Sat, 22 Nov 2008 05:55:20 PST
X-Mailer: YahooMailWebService/0.7.260.1
Date:	Sat, 22 Nov 2008 05:55:20 -0800 (PST)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: old binutils-2.13-msp.diff and binutils 2.19
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <922652.90789.qm@web59801.mail.ac4.yahoo.com>
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello. Sorry for asking this question - but while trying to move forward this patch, i faced with duplicated opcode in opcodes/mips-ops.c One "vmulu" was defined for Octeon, and one - for SGI O2 VICE coprocessor. After commenting out one from Octeon - my [patched] binutils finally was able to pass gcc-3.4.6 compilation. I saw some duplicates in this file, apart from my case,  but i'm really unsure what to do in this case? Move patch parts around? But moving them in random order will break assembler, already learned this ....

Also I'm lost in gas/config/tc-mips.c Original patch was designed for (K, m, n) [i don't know what they mean .. some form of internal markers?] and i changed it for (+K, +m,+n). But i'm really lost in those big switches there. Right now my new code disabled, looking at old patch i must add some logic before yet another switch. Where is the best place for discussing this - here or on gcc mail list?


      
