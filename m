Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 02:05:03 +0100 (BST)
Received: from web50310.mail.yahoo.com ([IPv6:::ffff:206.190.38.243]:23927
	"HELO web50310.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225219AbUHRBE7>; Wed, 18 Aug 2004 02:04:59 +0100
Message-ID: <20040818010451.71068.qmail@web50310.mail.yahoo.com>
Received: from [66.237.41.195] by web50310.mail.yahoo.com via HTTP; Tue, 17 Aug 2004 18:04:51 PDT
Date: Tue, 17 Aug 2004 18:04:51 -0700 (PDT)
From: usha davuluri <ranidavuluri@yahoo.com>
Subject: MIPS Malta board linux problem 
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ranidavuluri@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranidavuluri@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
 I am trying to bring up the Malta board with the
prebuils kernel. I am using TFTP server for that. I am
pretty much sure that TFTP server is up on my host
Redhat linux laptop. Some how I am not able to load
the immage on to the board. Please any one can help me
to solve this problem. 
I tested the tftp with the $:xinetd -d command. The
out put came well( TFTP is running). Following error
messages I am getting when I try to load the linux
kernel using tftp.

load
tftp://192.168.0.115//vmlinux-2.4.3.malta.install.el-01.02.srec
About to load
tftp://192.168.0.115//vmlinux-2.4.3.malta.install.el-01.02.srec
Press Ctrl-C to break
Error : TFTP READ-REQ ERROR
Diag  : Host returned: ErrorCode = 2, ErrorMsg =
Access violation
Hint  : Check TFTP-server: file-existence,
directory/file-attributes
Thank you,
Usha.


		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com
