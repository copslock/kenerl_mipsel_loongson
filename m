Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JFkXT31301
	for linux-mips-outgoing; Fri, 19 Oct 2001 08:46:33 -0700
Received: from saturn.mikemac.com (saturn.mikemac.com [216.99.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JFkTD31297
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 08:46:29 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id IAA27669;
	Fri, 19 Oct 2001 08:56:04 -0700
Message-Id: <200110191556.IAA27669@saturn.mikemac.com>
To: Justin Carlson <justincarlson@cmu.edu>
cc: linux-mips@oss.sgi.com
Subject: Re: Moving kernel_entry to LOADADDR 
In-Reply-To: Your message of "19 Oct 2001 11:21:41 EDT."
             <1003504901.29529.54.camel@gs256.sp.cs.cmu.edu> 
Date: Fri, 19 Oct 2001 08:56:04 -0700
From: Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>Subject: Re: Moving kernel_entry to LOADADDR
>From: Justin Carlson <justincarlson@cmu.edu>
>To: linux-mips@oss.sgi.com
>Date: 19 Oct 2001 11:21:41 -0400
>
>On Fri, 2001-10-19 at 11:11, Mike McDonald wrote:
>
>>   Because a bare bones bootloader may not know anything about ELF. The
>> simplest solution is to just stick a "jmp start_kernel" at LOADADDR
>> right before the fill. Then the load address and the entry point are
>> the same. Once the exception vectors get loaded, they'll overwrite the
>> jmp, so no space is wasted and none of the LOADADDRs have to be
>> changed.
>
>
>This may be true, but grokking ELF far enough to find e_entry just a
>matter of looking at a fixed offset into the kernel image.  Problems
>that require bootloaders to be simpler than that are pretty rare...
>
>-Justin

  But they do exist, especially in the embedded world. For instance,
I've run linux with boot loader out of a 1MB flash into 8MB of RAM. 
(VR4121 based system.) The kernel image stored in the flash had to be
a compressed raw memory image inorder to fit in the flash.  (The flash
also had to have room to the initrd.) Adding ELF headers to the image
would probably have pushed the size over the limit.

  Mike McDonald
  mikemac@mikemac.com
