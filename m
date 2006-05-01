Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 00:13:32 +0100 (BST)
Received: from test-iport-3.cisco.com ([171.71.176.78]:23094 "EHLO
	test-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133612AbWEAXNX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 00:13:23 +0100
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by test-iport-3.cisco.com with ESMTP; 01 May 2006 16:13:16 -0700
Received: from [0.0.0.0] (ssh-sjc-1.cisco.com [171.68.225.134])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k41NDFh0020423
	for <linux-mips@linux-mips.org>; Mon, 1 May 2006 16:13:16 -0700 (PDT)
Message-ID: <4456960D.70403@telus.net>
Date:	Mon, 01 May 2006 16:13:17 -0700
From:	Jim <jimssubs@telus.net>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: how do i get register state from process before interrupt?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jimssubs@telus.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jimssubs@telus.net
Precedence: bulk
X-list: linux-mips

I have a number of processes and drivers on a SB1250 card
and I suspect one of the drivers is misbehaving such that
user processes are not getting a chance to run.  I implemented
a rudimentary watchdog in the timer interrupt which is kicked
by one such user process if things when things are fine.
How would I capture the register state of the process
that was running before the interrupt is run?  I'm on
linux 2.4.18.

Thanks,
Jim
