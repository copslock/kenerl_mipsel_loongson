Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2004 15:32:05 +0100 (BST)
Received: from web60703.mail.yahoo.com ([IPv6:::ffff:216.109.117.226]:56983
	"HELO web60703.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8226341AbUFCOcA>; Thu, 3 Jun 2004 15:32:00 +0100
Message-ID: <20040603143153.42483.qmail@web60703.mail.yahoo.com>
Received: from [164.164.94.19] by web60703.mail.yahoo.com via HTTP; Thu, 03 Jun 2004 15:31:53 BST
Date: Thu, 3 Jun 2004 15:31:53 +0100 (BST)
From: =?iso-8859-1?q?Sujith=20Nayak?= <nayak_27@yahoo.com>
Subject: shared mem problem
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <nayak_27@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nayak_27@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
I am currently working on a board powered by a MIPS
processor, using Linux kernel 2.4.2. The problem that
I am facing is, whenever I create a shared memory
using shmget(), shmat(), etc. APIs, I always see that
the shared mem is created with 0 bytes. As a result
any access to it bombs the process.

Anyone has any idea, I will be grateful for your
response. I had a look at the patch-2.4.2-ac23, which
talks about the some shared mem lock up problem. But I
cannot apply the patch as it is because my customer
has pruned the kernel so much that the patch does not
apply right away.

Pl. help (by CCing your response to my mail id also).

Regards,

Sujeet


	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
