Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 06:52:30 +0000 (GMT)
Received: from ms4.Sony.CO.JP ([211.125.136.198]:5766 "EHLO ms4.sony.co.jp")
	by ftp.linux-mips.org with ESMTP id S28604064AbYCRGw2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 06:52:28 +0000
Received: from mta5.sony.co.jp (mta5.Sony.CO.JP [137.153.71.6])
 by ms4.sony.co.jp (R8/Sony) with ESMTP id m2I6qFwm003207
 for <linux-mips@linux-mips.org>; Tue, 18 Mar 2008 15:52:15 +0900 (JST)
Received: from mta5.sony.co.jp (localhost [127.0.0.1])
 by mta5.sony.co.jp (R8/Sony) with ESMTP id m2I6qFdw014273
 for <linux-mips@linux-mips.org>; Tue, 18 Mar 2008 15:52:15 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
 by mta5.sony.co.jp (R8/Sony) with ESMTP id m2I6qFXm014268
 for <linux-mips@linux-mips.org>; Tue, 18 Mar 2008 15:52:15 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.4.141.32]) by smail1.sm.sony.co.jp (8.11.6p2/8.11.6) with ESMTP id m2I6qFP01703 for <linux-mips@linux-mips.org>; Tue, 18 Mar 2008 15:52:15 +0900 (JST)
Received: from localhost (tidal.sm.sony.co.jp [43.4.145.112])
	by imail.sm.sony.co.jp (8.12.11/3.7W) with ESMTP id m2I6qDr3015696
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2008 15:52:13 +0900 (JST)
Date:	Tue, 18 Mar 2008 15:47:01 +0900 (JST)
Message-Id: <20080318.154701.74743177.kaminaga@sm.sony.co.jp>
To:	linux-mips@linux-mips.org
Subject: MIPS prelink question
From:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kaminaga@sm.sony.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaminaga@sm.sony.co.jp
Precedence: bulk
X-list: linux-mips


Hi!

I'm not sure if this is the right ML to ask, but since I've found
discussion about MIPS prelink here, I'm posting here...

In the below thread, patch for MIPS prelink was posted.
http://www.linux-mips.org/archives/linux-mips/2006-11/msg00034.html

I've tried this patch, but I got below error when I tried to do prelink.

	No space in ELF segment table to add new ELF segment

On the montavista pro 5.0 note, I found that they have fixed above
prelink error, but I could not find the patch. Could someone give
me pointer to address this issue?


Thanks in Advance,


(Hiroki Kaminaga)
t
--
