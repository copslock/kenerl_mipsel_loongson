Received:  by oss.sgi.com id <S305163AbQCRW12>;
	Sat, 18 Mar 2000 14:27:28 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26202 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCRW1H>; Sat, 18 Mar 2000 14:27:07 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA08417; Sat, 18 Mar 2000 14:30:34 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA72675
	for linux-list;
	Sat, 18 Mar 2000 14:04:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA56749;
	Sat, 18 Mar 2000 14:02:43 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id OAA26916;
	Sat, 18 Mar 2000 14:02:42 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14547.64770.154305.606794@liveoak.engr.sgi.com>
Date:   Sat, 18 Mar 2000 14:02:42 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Ralf Baechle" <ralf@oss.sgi.com>,
        "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
In-Reply-To: <005901bf90d1$269b2690$0ceca8c0@satanas.mips.com>
References: <005901bf90d1$269b2690$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
...
 > >The whole inconsistence was a stupid accident.  Since apparently only very
 > >little software was affected negativly (read: no known problems)  we didn't
 > >try to come up with some genious compatibility hacks but just fixed the
 > >definitions the hard way.
 > 
 > Having two independent sets of include files between kernel and userland
 > is always a bad idea, but is not *necessarily* broken, and sometimes
 > cannot be avoided.   The problem is not that the definitions are seperately
 > wired, but that they are incompatible - the risk one takes when one creates
 > multiple independent definitions.

      In this case the definitions are supposed to match the MIPS ABI.
That the glibc definitions (at least as of 2.1.1) do not is just a glibc bug.
This is no different that having Linux and FreeBSD header files for some
I/O controller, with one of them having incorrect values for some field
definitions.  The one which does not match the standard (the ABI or the
I/O controller hardware) is simply wrong.

     Since glibc is shared among a great many operating systems, it really
needs to be self-contained in regard to the C and POSIX and UNIX98 standards.
