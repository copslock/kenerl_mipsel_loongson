Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 21:03:50 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:18569
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225365AbUAMVDt>; Tue, 13 Jan 2004 21:03:49 +0000
Received: from [192.168.1.8] (shakedown.herbertphamily.com [192.168.1.8])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.8/8.12.8) with ESMTP id i0DL3j0M016956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Tue, 13 Jan 2004 13:03:45 -0800
Subject: How stable is 2.6 on a SB1250 processor?
From: Kevin Paul Herbert <kph@cisco.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1074027809.20636.91.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jan 2004 13:03:30 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

I'm working on bringing up the 2.6 kernel on a board using the SB1250
processor, and I have a problem in userland that I'm wondering if anyone
else has seen.

I built a simple test program for userland, which just uses the write()
syscall to say hello world. This is statically linked, and it works
under a 2.4 kernel. Under 2.6, I get no output. My guess is that an
exception is occuring, the signal gets back to my test program, and it
is looping.

I've written a simple assembly language hello world program which does
the exact same thing... write() syscall and I get my hello world.

My next task is to get kgdb working on this board so I can do some
better debugging, but I was wondering if anyone else has seen this
problem, or for that matter whether the SB1 processor support is
expected to work at all.

Thanks for any help,

Kevin


-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.
