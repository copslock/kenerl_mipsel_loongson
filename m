Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 23:53:13 +0000 (GMT)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:1858 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133613AbWCUXxF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Mar 2006 23:53:05 +0000
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 21 Mar 2006 16:02:24 -0800
X-IronPort-AV: i="4.03,116,1141632000"; 
   d="scan'208"; a="263339714:sNHT26945740"
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com [128.107.191.63])
	by sj-core-3.cisco.com (8.12.10/8.12.6) with ESMTP id k2M02L1j013404
	for <linux-mips@linux-mips.org>; Tue, 21 Mar 2006 16:02:23 -0800 (PST)
Received: from xfe-sjc-211.amer.cisco.com ([171.70.151.174]) by xbh-sjc-221.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 21 Mar 2006 16:02:20 -0800
Received: from [171.69.51.240] ([171.69.51.240]) by xfe-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 21 Mar 2006 16:02:20 -0800
Message-ID: <4420940B.9030605@hotmail.com>
Date:	Tue, 21 Mar 2006 16:02:19 -0800
From:	Srinivas Kommu <kommu@hotmail.com>
User-Agent: Thunderbird 1.4 (Windows/20050908)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: how to get a process backtrace from kernel gdb?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2006 00:02:20.0586 (UTC) FILETIME=[E3C0F8A0:01C64D43]
Return-Path: <kommu@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kommu@hotmail.com
Precedence: bulk
X-list: linux-mips

I'm running gdb on vmlinux connected to a remote target (2.4 kernel). I 
have the task_struct address of 'current' and other processes. Is it 
possible to get a symbolic stack trace of the kernel stack? Where is the 
kernel stack located? I tried to print (task_struct->reg29)[13]. Is this 
the PC?

thanks
srini

PS. I broke into gdb using a hotkey on the serial console; so the gdb 
backtrace shows the serial driver.
