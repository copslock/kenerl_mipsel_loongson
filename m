Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 15:36:39 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:28026 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225002AbVDLOgX>; Tue, 12 Apr 2005 15:36:23 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 12 Apr 2005 10:31:57 -0400
Message-ID: <425BDCE4.6070708@timesys.com>
Date:	Tue, 12 Apr 2005 10:36:20 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: BogoMIPS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2005 14:31:57.0078 (UTC) FILETIME=[6143D360:01C53F6C]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Has anyone else noticed BogoMIPS is zero? Are we not doing the calibrate 
delay?

Greg Weeks

-bash-2.05b# cat /proc/cpuinfo
system type             : MIPS Malta
processor               : 0
cpu model               : MIPS 4Kc V0.1
BogoMIPS                : 0.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes
VCED exceptions         : not available
VCEI exceptions         : not available
-
