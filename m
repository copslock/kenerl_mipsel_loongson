Received:  by oss.sgi.com id <S553891AbRCFGds>;
	Mon, 5 Mar 2001 22:33:48 -0800
Received: from galt.foobazco.org ([198.144.194.227]:29329 "EHLO
        galt.foobazco.org") by oss.sgi.com with ESMTP id <S553888AbRCFGdS>;
	Mon, 5 Mar 2001 22:33:18 -0800
Received: (from wesolows@localhost)
	by galt.foobazco.org (8.9.3/8.9.3) id WAA26892;
	Mon, 5 Mar 2001 22:32:58 -0800
Date:   Mon, 5 Mar 2001 22:32:58 -0800
From:   Keith M Wesolowski <wesolows@foobazco.org>
To:     Karsten Merker <karsten@excalibur.cologne.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: build-problems: GNU fileutils 4.01 on mipsel with glibc 2.2.2
Message-ID: <20010305223258.B25870@foobazco.org>
References: <20010304213609.B25825@linuxtag.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010304213609.B25825@linuxtag.org>; from karsten@excalibur.cologne.de on Sun, Mar 04, 2001 at 09:36:09PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Mar 04, 2001 at 09:36:09PM +0100, Karsten Merker wrote:

> starts ok, but when coming to "checking for working mktime..." the script
> just hangs forever, and according to top there is nothing consuming CPU
...
> glibc-2.0.6 the problem does not appear. Can anybody confirm this on
> another system? Any ideas what can be the reason for this?

I can confirm that this does *not* happen for me with the same C
library but current CVS binutils and gcc (3.0 branch) on a big-endian
system.  I have observed a definite and reproducible problem, however,
with the version of binutils you described; in my case, the symptom
was insertion of garbage instructions into my kernel.  The problem
went away when I upgraded binutils.  I have no idea whether this is
related to the problem you are seeing.

I would suggest that you extract the test that configure is running
into a small C program (the tests are usually C programs); try to
compile, link, and run that program, and see what happens.  It could
be that the compiler or linker is hanging trying to build it, or that
the program itself hangs for some reason.  If the program hangs, run
it in a debugger and/or use strace.  Then post a minimal testcase.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
