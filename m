Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VJC3t10311
	for linux-mips-outgoing; Wed, 31 Oct 2001 11:12:03 -0800
Received: from localhost.cygnus.com (to-velocet.redhat.com [216.138.202.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VJBw010302
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 11:11:58 -0800
Received: from cygnus.com (localhost [127.0.0.1])
	by localhost.cygnus.com (Postfix) with ESMTP
	id 029903D47; Wed, 31 Oct 2001 13:11:25 -0500 (EST)
Message-ID: <3BE03ECD.5060904@cygnus.com>
Date: Wed, 31 Oct 2001 13:11:25 -0500
From: Andrew Cagney <ac131313@cygnus.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD macppc; en-US; rv:0.9.3) Gecko/20011020
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Steven J. Hill" <sjhill@cotw.com>, gdb@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: Old bug with 'gdb/dbxread.c' and screwed up MIPS symbolic debugging...
References: <3BDF7F79.6050205@cygnus.com> <3BE02E31.3B2CA5FC@cotw.com> <20011031113208.A1882@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> 
> Well, the change in objdump output is purely cosmetic.  For 32bit
> object formats we just truncate the display now.

As an aside, is there an option to turn this truncation off?  The vr5432 
as and ld will still pass around 64 bit addresses.

>> 
>> "SOLUTION"
>> ----------
>> On August 15, H.J. Lu applied a patch to 'gdb/dbxread.c' shown here:
>> 
>> diff -urN -x CVS work/gdb/dbxread.c gdb-5.0-08162001/gdb/dbxread.c
>> --- work/gdb/dbxread.c  Tue Oct 30 16:33:33 2001
>> +++ gdb-5.0-08162001/gdb/dbxread.c      Wed Aug 15 00:02:28 2001
>> @@ -951,7 +951,10 @@
>> (intern).n_type = bfd_h_get_8 (abfd, (extern)->e_type);            \
>> (intern).n_strx = bfd_h_get_32 (abfd, (extern)->e_strx);           \
>> (intern).n_desc = bfd_h_get_16 (abfd, (extern)->e_desc);           \
>> -    (intern).n_value = bfd_h_get_32 (abfd, (extern)->e_value);         \
>> +    if (bfd_get_sign_extend_vma
>> (abfd))                                       \
>> +      (intern).n_value = bfd_h_get_signed_32 (abfd,
>> (extern)->e_value);       \
>> +    else                                                               \
>> +      (intern).n_value = bfd_h_get_32 (abfd, (extern)->e_value);       \
>> }
>> > /* Invariant: The symbol pointed to by symbuf_idx is the first one
>> 
>> If I back out this change, my debug output is "correct", but I no longer
>> have the nice line numbers and files decoded for me:
> 
> 
> If you back it out, I believe we just give up in confusion  [:)] This is
> int the reading of stabs info.  breakinst has no stabs info, so it's
> getting its line info somewhere else.

It might - assembler debugging ...

> Please point me at a copy of your kernel binary with debug info, and
> I'll look into it.

Yes, you want to look for a version of breakinst that isn't sign 
extended.  Since pulling the above patch helped it won't be in .stabs so 
the symbol table?

Andrew
