Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ALBfW14665
	for linux-mips-outgoing; Thu, 10 May 2001 14:11:41 -0700
Received: from bvdexchange.eicon.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ALBdF14662
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 14:11:39 -0700
Received: from eicon.com (172.16.2.231 [172.16.2.231]) by bvdexchange.eicon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.1960.3)
	id KVL8PZQ1; Thu, 10 May 2001 23:12:27 +0200
Message-ID: <3AFB03F6.7A3C7847@eicon.com>
Date: Thu, 10 May 2001 23:11:18 +0200
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: shay@jungo.com
CC: linux-mips@oss.sgi.com, michaels@jungo.com
Subject: Re: No bss cause strange values in insmod and ELF
References: <01051009104509.01140@athena.home.krftech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Shay Deloya wrote:
> 
> Continuing my previous problem...
> 
> I have created a module with no bss , and compiled it with kernel 2.2.
> Comparing this module with same code that has bss and acts OK.
> 
> Inserting the module with modutiles 2.2.2/ busybox insmod causes
> a relocation overflow message , the reasons are:
> 
> 1.in function obj_relocate: corrupted intsym->secidx value
>   (not the needed index in the ELF)
>    for some .text segments, other segments get their index value OK.
>   the ELF file seems to be OK.
> 2. in function arch_apply_relocation: the wrong index (secidx=1006a1e8)
>    cause R_MIPS_26 symbols (jump commands) to have the value of
>    obj_reloc_overflow and then causes relocation overflow.
> 
> Does anyone knows why same module that has a variable in bss acts fine
>  and the one without bss causes Relocation overflow in MIPS ? (in x86 there
> is no problem).
> 
> Searching the code I see there is no initialization of the secidx ,
>  is it a problem of wrong reading of ELF files by insmod ?
> 
> Attached the two ELF files , and obj_relocate values.
> 

I had a look at the attachments and I think the cause of your problem is 
that the module is not a relocatable file!

ld can fix this for you. Try ld -r -o new.o <modulename>.o, and then 
insert new.o instead.

Regarding the effect of empty/non-empty .bss section (and of recompiling
modutils), I think this is just a case of "fix by accident". Meaning
that
it's still broke - it just didn't die (this time).

Regards,
Tommy Christensen
