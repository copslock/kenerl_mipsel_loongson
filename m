Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 12:03:12 +0000 (GMT)
Received: from midas-91-171-chn.midascomm.com ([203.196.171.91]:41373 "EHLO
	info.midascomm.com") by ftp.linux-mips.org with ESMTP
	id S8133541AbWB1MDE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 12:03:04 +0000
Received: from bharathi.midascomm.com ([192.168.13.175])
	by info.midascomm.com (8.12.10/8.12.10) with ESMTP id k1SCAZLG022889
	for <linux-mips@linux-mips.org>; Tue, 28 Feb 2006 17:40:37 +0530
Date:	Tue, 28 Feb 2006 17:52:13 +0530 (IST)
From:	Bharathi Subramanian <sbharathi@MidasComm.Com>
To:	Linux MIPS <linux-mips@linux-mips.org>
Subject: CPU Frequency change using PLL
Message-ID: <Pine.LNX.4.44.0602281744590.6277-100000@bharathi.midascomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-midascomm.com-MailScanner-Information: Please contact the ISP for more information
X-midascomm.com-MailScanner: Found to be clean
X-midascomm.com-MailScanner-From: sbharathi@midascomm.com
Return-Path: <sbharathi@MidasComm.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbharathi@MidasComm.Com
Precedence: bulk
X-list: linux-mips

Hi All,

I am trying to clock down the MIPS Processor by changing the PLL 
setting. So I can change the CPU Freq at runtime just switching 
between the PLLs. 

During my try, after changing the PLL Freq, the board is stops
running. I feel, it is due to change in SDRAM Refresh rate. Is it
right ?? Any body tried this, Kindly share exprience with me. Like how
to reprogram the peripherals with-out affecting the operation etc..

Kindly CC to me.

Thanks,
-- 
Bharathi S
