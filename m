Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Aug 2004 06:22:34 +0100 (BST)
Received: from web60808.mail.yahoo.com ([IPv6:::ffff:216.155.196.71]:65161
	"HELO web60808.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224802AbUHVFW3>; Sun, 22 Aug 2004 06:22:29 +0100
Message-ID: <20040822052222.1625.qmail@web60808.mail.yahoo.com>
Received: from [217.218.17.100] by web60808.mail.yahoo.com via HTTP; Sat, 21 Aug 2004 22:22:22 PDT
Date: Sat, 21 Aug 2004 22:22:22 -0700 (PDT)
From: Reza Javadi <rs_javadi@yahoo.com>
Subject: xine crash when playing DIVx with 128 MB RAM ...
To: xine-user@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rs_javadi@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rs_javadi@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello to all,

Our company is working on a set-top box (Internet
Appliance) which has a LFS (Linux From Scrach) as its
embedded OS. When I play DIVx movies with xine in 128
MB of RAM it crashes. 

I used gdb for debugging, but the problem is when I
run xine in gdb, I receive a SIGTRAP and then when I
use c (continuing) nothing happens and I do not have
any video and audio and I can not progress in
debugging. 

Therefore I need someone help to solve my  problem of
running xine with gdb to debug the crash.   

Is gdb useful in this particular case ?

Thanks


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
