Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 06:54:27 +0100 (BST)
Received: from [IPv6:::ffff:202.125.80.34] ([IPv6:::ffff:202.125.80.34]:20745
	"EHLO mail.esn.activedirectory") by linux-mips.org with ESMTP
	id <S8225073AbTEIFyZ>; Fri, 9 May 2003 06:54:25 +0100
Received: by mail.esn.activedirectory with Internet Mail Service (5.5.2650.10)
	id <K3RTBJLV>; Fri, 9 May 2003 11:24:31 +0530
Message-ID: <AF572D578398634881E52418B28925670EFF20@mail.esn.activedirectory>
From: JinuM <jinum@esntechnologies.co.in>
To: linux-mips@linux-mips.org
Subject: open file in kernel mode
Date: Fri, 9 May 2003 11:24:25 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.10)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <jinum@esntechnologies.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jinum@esntechnologies.co.in
Precedence: bulk
X-list: linux-mips


Hi,

Can anyone help me with this simple problem.

I am trying to write a firmware loader driver. Instead of reading the
firmware as a buffer(predefined array)  we would like to read the firmware
from a file (say /root/firmware). Do we have some function which reads the
file contents in kernel mode.

-Jinu
