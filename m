Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OB0qj26030
	for linux-mips-outgoing; Thu, 24 Jan 2002 03:00:52 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OB0hP25987
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 03:00:44 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 9E62B1E46A; Thu, 24 Jan 2002 10:57:02 +0100 (MET)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: drepper@redhat.com (Ulrich Drepper)
Cc: Machida Hiroyuki <machida@sm.sony.co.jp>, kevink@mips.com, hjl@lucon.org,
   libc-hacker@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
References: <20020120193843M.machida@sm.sony.co.jp>
	<002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>
	<20020120221607T.machida@sm.sony.co.jp>
	<20020122152744C.machida@sm.sony.co.jp> <m38zaqsxgx.fsf@myware.mynet>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 24 Jan 2002 10:56:57 +0100
In-Reply-To: <m38zaqsxgx.fsf@myware.mynet> (Ulrich Drepper's message of "21
 Jan 2002 22:37:02 -0800")
Message-ID: <hovgdskr6e.fsf@gee.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ulrich Drepper <drepper@redhat.com> writes:

> Machida Hiroyuki <machida@sm.sony.co.jp> writes:
>
>>   * glibc change:
>> 
>> 	We implement  test_and_set(addr, val) as follows,
>> 
>> 		Do mmap /dev/tst to _TST_START_MAGIC, if not yet mapped.
>> 		call _TST_START_MAGIC(addr, val)
>> 	
>> 	If we can't open /dev/tst then, use sysmips() as final resort.
>
> First, the patch as it is unacceptable.  A file with copyright Sony?
> All the code must be copyrighted by the FSF.  Sony will have to assign
> the copyright for the code to the FSF.
>
> Also, no such change can be accepted until the necessary kernel
> changes are in the official kernel sources.  I cannot make any
> exceptions since otherwise all kinds of people want to see support for
> their local hack added.
>
> Furthermore, the symbols were not available in version 2.2.  Therefore
> they cannot be exported with this version.  It'll either be 2.2.6 (if
> their ever will be such a release) or 2.3.
>
> And finally, the patch should be sent to the glibc MIPS maintainer for
> review.  The question is who feels responsible...

I'll look into it later in more detail.

But for now, let me just tell that I agree with Ulrich's comments.
Additionally I'd like to wait with adding this patch until:
- a solution for the thread register is found for MIPS (and those
  solution should not conflict with this patch)
- the kernel side patches have been adopted.

Therefore please discuss this with the kernel and ABI folks, and then
let's look again at the issues.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
