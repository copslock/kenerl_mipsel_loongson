Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2003 03:32:23 +0000 (GMT)
Received: from f143.law9.hotmail.com ([IPv6:::ffff:64.4.9.143]:16140 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225240AbTAQDcX>;
	Fri, 17 Jan 2003 03:32:23 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 16 Jan 2003 19:32:12 -0800
Received: from 210.74.191.34 by lw9fd.law9.hotmail.msn.com with HTTP;
	Fri, 17 Jan 2003 03:32:12 GMT
X-Originating-IP: [210.74.191.34]
From: "" <henaldohzh@hotmail.com>
To: linux-mips@linux-mips.org
Subject: problem about porting kernel to mips`
Date: Fri, 17 Jan 2003 03:32:12 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <F143mF1IT18olkDTM9w00040789@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2003 03:32:12.0397 (UTC) FILETIME=[05E0D9D0:01C2BDD9]
Return-Path: <henaldohzh@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: henaldohzh@hotmail.com
Precedence: bulk
X-list: linux-mips

hi, all,
  So sorry to distrub you. 
  now, I am porting kernel to a board with vr4131 core. But when I run 
application, sometimes, kernel report bug in sched.c or traps.c. I debuged 
the kernel and found that problem is in_interrupt return 2(local_bh_irq is 
2). So am I puzzled. And sometimes,kernel report data unaligned. 
  Thanks very much for your help.

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/cn 
