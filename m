Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Apr 2004 00:47:42 +0100 (BST)
Received: from [IPv6:::ffff:222.98.69.125] ([IPv6:::ffff:222.98.69.125]:38599
	"EHLO torinet.co.kr") by linux-mips.org with ESMTP
	id <S8225222AbUDOXrc>; Fri, 16 Apr 2004 00:47:32 +0100
Received: from stephen ([222.98.69.120])
	by torinet.co.kr (8.12.8/8.12.8) with ESMTP id i3G0a65i008854
	for <linux-mips@linux-mips.org>; Fri, 16 Apr 2004 09:36:07 +0900
Message-Id: <200404160036.i3G0a65i008854@torinet.co.kr>
From: "JinYoung Kim" <jykim@torinet.co.kr>
To: <linux-mips@linux-mips.org>
Subject: large memory support on  kernel 2.4.21 for 64bit on sb1250?
Date: Fri, 16 Apr 2004 08:47:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcQiEc+4hUP/KmzdSuWfWLV9eA05Xw==
Return-Path: <jykim@torinet.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jykim@torinet.co.kr
Precedence: bulk
X-list: linux-mips

Hello,
 
Is large memory support stable on kernel 2.4.21 with broadcom patch 1 and 2?
 
Would anybody test followingscenrio with BCM91250 reference board or your
own?
 
run ping fluding background to any system from the board.
run it again.
run ping fluding to the board from the system above.
 
panic (page fault) or DBE error occured immediately in my test.
 
I have 2GB main memory, but samething happend on 512MB.
32bit kernel does not have any problem.
 
Jin
 
vroom@magicn.com
 
