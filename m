Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 04:49:56 +0100 (BST)
Received: from [IPv6:::ffff:203.145.184.221] ([IPv6:::ffff:203.145.184.221]:30482
	"EHLO naturesoft.net") by linux-mips.org with ESMTP
	id <S8225192AbTFDDty> convert rfc822-to-8bit; Wed, 4 Jun 2003 04:49:54 +0100
Received: from [192.168.0.15] (helo=cork.royalchallenge.com)
	by naturesoft.net with esmtp (Exim 3.35 #1)
	id 19NPDN-0002Xr-00; Wed, 04 Jun 2003 09:15:29 +0530
Content-Type: text/plain;
  charset="us-ascii"
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Single stepping in mips
Date: Wed, 4 Jun 2003 09:18:01 +0530
User-Agent: KMail/1.4.1
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306040918.01943.krishnakumar@naturesoft.net>
Return-Path: <krishnakumar@naturesoft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnakumar@naturesoft.net
Precedence: bulk
X-list: linux-mips

Hi,

How can we single step through an instruction 
in mips architecture. 

In intel 386 architecture if we set TF flag
of the EFLAGS register a trap will be generated
after every instruction. Is there a way in 
mips to do the same. 

Regards and Thanks
KK
