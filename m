Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 20:59:42 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:43963 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133485AbWCUU7b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Mar 2006 20:59:31 +0000
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id DDD03FC4E; Tue, 21 Mar 2006 13:09:17 -0800 (PST)
Subject: Re: Building GCC for BCM1480 SiByte
From:	James E Wilson <wilson@specifix.com>
To:	dan.mcgee@ntsoc.com
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1142975357.11590.34.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Tue, 21 Mar 2006 13:09:17 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

> This compiler works, but there are no floating point
> optimization for the sb1 fpu.

Why do you say this?  Was there something specific that you were
expecting that you didn't see?

I tried this experiment with both gcc-4.0.x and gcc-4.1.x, replacing the
--with-target option with a --target option.  In both cases, I see that
code is being scheduled for an SB-1 cpu.

I verified this by compiling a small testcase with -O2 -dS
-fsched-verbose=2.  This dumps some instruction scheduling info to
stderr.  This output has lines like this:
;;       14--> 23   $f0=$f12*$f0                       :sb1_fp1
which proves that SB-1 scheduling info is being used.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
