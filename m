Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4N6f8x28685
	for linux-mips-outgoing; Tue, 22 May 2001 23:41:08 -0700
Received: from blackdog.wirespeed.com ([208.170.106.25])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4N6f4F28681;
	Tue, 22 May 2001 23:41:04 -0700
Received: from redhat.com (IDENT:joe@dhcp-247.hsv.redhat.com [172.16.17.247] (may be forged))
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id BAA03739;
	Wed, 23 May 2001 01:27:11 -0500
Message-ID: <3B0B5AC6.6060208@redhat.com>
Date: Wed, 23 May 2001 01:37:58 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.8.1) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Florian Lohoff <flo@rfc822.org>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <3B099A91.5030300@csh.rit.edu> <3B09A074.2010809@mvista.com> <3B09A388.8AC77827@mvista.com> <20010522143330.B9891@paradigm.rfc822.org> <3B0AEC51.B0C477E1@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I would vote for option #4 - make sure the ll/sc emulation stuff works 
and use ll/sc in glibc instead of sysmips. Beyond the pthreads mutex 
stuff in glibc I have yet to come across usage of sysmips. Of course you 
still need sys_sysmips to function correctly (in case somebody did a 
silly thing like call sysmips directly just for the fun of it), so I 
like like Florian's solution. Adding a parameter is a silly thing to do, 
and we don't need to be adding functionality to sys_sysmips through 
NEW_MO_BETTER_AS_SEEN_ON_TV_ATOMIC_SET or what have you...

Joe

Jun Sun wrote:

> Florian Lohoff wrote:
> 
>> On Mon, May 21, 2001 at 04:23:52PM -0700, Jun Sun wrote:
>> 
>>> The patch seems to be just a fast implementation of sysmips().  Why would it
>>> solve an otherwise illegal instruction problem?
>>> 
>>> George, what was exactly the error and the faulty instruction?
>> 
>> Wrong - Its not only a "fast" path sysmips. It solves the illegal instruction
>> case as it carefully doesnt touch registers it should not touch.
>> 
>> The sysmips illegal instruction stuff came from the early exit
>> needed to skip the -EXXXX case in the scall32.S which did not
>> restore the modified registers. This needed fixing and there was
>> no clean way of doing this in C thus i wrote an asm sysmips/MIPS_ATOMIC_SET
>> and called it "fast_sysmips" which itself would go into the old
>> sysmips function when not MIPS_ATOMIC_SET.
>> 
> 
> 
> I see.
> 
> I took a look of MIPS ABI in system V and found that the spec only specifies
> this extended call in C prototype:
> 
> int _test_and_set(int *p, int v);
> 
> It seems perfectly legal for us to add one more argument to store the return
> value while still have the function returns error.  Of course, doing that will
> break binary compatibility.
> 
> Otherwise, I think Flo's patch is the best fix to satisfy the spec and binary
> compatibility although it is a little clunky.
> 
> A third possibility is the have a MIPS_NEW_ATOMIC_SET that take three
> arguments.  If that approach is taken, I would take out the inline assembly
> that jumps to o32_ret_from_sys_call and documents MIPS_ATOMIC_SET as
> deprecated and valnerable.
> 
> My preference, in the decreasing order, is 3), 2) and 1).
> 
> Ralf, what do you think?  We cannot let the bug sit around in the CVS tree for
> long.  Have to have some fix.
> 
> Jun


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
