Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M7bVC26071
	for linux-mips-outgoing; Mon, 21 Jan 2002 23:37:31 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M7bRP26067
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 23:37:27 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id WAA11785;
	Mon, 21 Jan 2002 22:37:04 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0M6b2q26556;
	Mon, 21 Jan 2002 22:37:02 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: Machida Hiroyuki <machida@sm.sony.co.jp>
Cc: kevink@mips.com, hjl@lucon.org, libc-hacker@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
References: <20020120193843M.machida@sm.sony.co.jp>
	<002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>
	<20020120221607T.machida@sm.sony.co.jp>
	<20020122152744C.machida@sm.sony.co.jp>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 21 Jan 2002 22:37:02 -0800
In-Reply-To: <20020122152744C.machida@sm.sony.co.jp>
Message-ID: <m38zaqsxgx.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Machida Hiroyuki <machida@sm.sony.co.jp> writes:

>   * glibc change:
> 
> 	We implement  test_and_set(addr, val) as follows,
> 
> 		Do mmap /dev/tst to _TST_START_MAGIC, if not yet mapped.
> 		call _TST_START_MAGIC(addr, val)
> 	
> 	If we can't open /dev/tst then, use sysmips() as final resort.

First, the patch as it is unacceptable.  A file with copyright Sony?
All the code must be copyrighted by the FSF.  Sony will have to assign
the copyright for the code to the FSF.

Also, no such change can be accepted until the necessary kernel
changes are in the official kernel sources.  I cannot make any
exceptions since otherwise all kinds of people want to see support for
their local hack added.

Furthermore, the symbols were not available in version 2.2.  Therefore
they cannot be exported with this version.  It'll either be 2.2.6 (if
their ever will be such a release) or 2.3.

And finally, the patch should be sent to the glibc MIPS maintainer for
review.  The question is who feels responsible...

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
