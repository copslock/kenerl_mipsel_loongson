Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Sep 2002 20:28:05 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:64015 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1122978AbSIUS2E>;
	Sat, 21 Sep 2002 20:28:04 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <S7YA830K>; Sat, 21 Sep 2002 14:27:55 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C3F@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: linux-mips@linux-mips.org
Subject: RM5231A: problems in timer using COUNT/COMPARE register.
Date: Sat, 21 Sep 2002 14:27:55 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

Hello,

I am in the process of porting Linux to our FPGA platform using RM5231A
processor. The COUNT/COMPARE register timer is acting funny with me. When I
set the compare register value to something like 0x0100_0000 or less I get
timer interrupt as expected but if I set the COMPARE register to a greater
value timer interrupt never happens. I have verified this using our boot
loader also and the results are the same. I am waiting for a reply from PMC
but would also like to know if there is anyone out there who faced similar
problems with RM5231A. From data sheets and user manual I know the count
register is 32 bit but apparently there is some hitch somewhere that I need
to discover. 

Dinesh
iVivity
