Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 01:25:48 +0100 (BST)
Received: from mail1.lge.co.kr ([156.147.1.151]:27375 "EHLO mail1.lge.co.kr")
	by ftp.linux-mips.org with ESMTP id S8133731AbWDRAZj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Apr 2006 01:25:39 +0100
Received: from [150.150.71.243] (jsungkim@lge.com) by 
          mail1.lge.co.kr (Terrace MailWatcher) 
          with ESMTP id 2006041809:37:57:896309.21746.24
          for <linux-mips@linux-mips.org>; 
          Tue, 18 Apr 2006 09:37:57 +0900 (KST) 
From:	"Kim, Jong-Sung" <jsungkim@lge.com>
To:	<linux-mips@linux-mips.org>
Subject: Reading an entire cacheline
Date:	Tue, 18 Apr 2006 09:37:18 +0900
Message-ID: <058801c66280$3fa1ebb0$f3479696@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcZigD+A+CMHDL7jSviP63YyQN7LKw==
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Return-Path: <jsungkim@lge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsungkim@lge.com
Precedence: bulk
X-list: linux-mips

Hi,

Is there any way to read an entire cacheline from the MIPS5Kf? Four
sequential cache instructions do similarly, but sometimes the tags from a
same cacheline differ. How can I read a consistent cacheline safely?

Thanks.
