Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2004 12:48:37 +0000 (GMT)
Received: from grex.cyberspace.org ([IPv6:::ffff:216.93.104.34]:35083 "HELO
	grex.cyberspace.org") by linux-mips.org with SMTP
	id <S8225215AbUA0Msh>; Tue, 27 Jan 2004 12:48:37 +0000
Received: from localhost (navgrex@localhost) by grex.cyberspace.org (8.6.13/8.6.12) with SMTP id HAA02871; Tue, 27 Jan 2004 07:49:13 -0500
Date: Tue, 27 Jan 2004 07:49:13 -0500 (EST)
From: navin <navgrex@cyberspace.org>
To: linux-mips@linux-mips.org
cc: navgrex@cyberspace.org
Subject: Clock interrupt simulation on sde-gdb
Message-ID: <Pine.SUN.3.96.1040127074316.1295C-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <navgrex@grex.cyberspace.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: navgrex@cyberspace.org
Precedence: bulk
X-list: linux-mips

Hi,

I am new to MIPS. So please don't mind if this is a trivial question.

I am trying to run microC/OS-II over MIPS 4KE. At this point of time, 
as there is no hardware available. I am trying to test my code using
sde-gdb simulator.

For proper task scheduling, etc, microC/OS-II needs to get periodic
interrupt from MIPS. I understand the possible implementation of such
facility in MIPS (i.e. using Count and Compare registers of CP0).

On trying to test microC/OS-II, I find that HW5 interrupt is not getting
generated. I verified by dumping value of a global variable which would
get updated in the timer expiry function. As a result task scheduling is
not happening.

As such my bootup code seems to be configuring thigs (Count, Compare, and
Status registers) properly. Is it that such timer interrupt CAN'T BE 
SIMULATED on sde-gdb? I have tried trace32 simulator software 
(demo version) also.

Any help will be highly appreciated,

Regards,
Navin
