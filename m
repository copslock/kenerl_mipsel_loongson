Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4G0dIN25271
	for linux-mips-outgoing; Tue, 15 May 2001 17:39:18 -0700
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4G0dFF25267
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 17:39:15 -0700
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id 8B9B5205FA
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 17:39:36 -0700 (PDT)
Received: from SMTP agent by mail gateway 
 Tue, 15 May 2001 17:30:46 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 4E4B51595F
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 17:39:05 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id E96A7686D; Tue, 15 May 2001 17:39:00 -0700 (PDT)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: linux-mips@oss.sgi.com
Subject: mips64, _end, tools, and relocations
Date: Tue, 15 May 2001 17:25:13 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01051517390007.00784@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Taking a walk on the mips64 side of the world, I'm compiling
with the i386-linux=>mips64-linux cross tools from the rpms
at oss.sgi.com. 

Looking at the build process, we build at kseg0, then objcopy
and relocate to xkphys space as the last step in the build.  I assume
this is to work around the known elf64 compilation issues, and
seems fine in theory.

Unfortunately, it doesn't seem to quite work for me.  Looking
at bootmem_init() in arch/mips64/mm/init.c, __pa(&_end) is
optimized down to a literal load during compilation:

a800000000113a2c:	3c0280aa 	lui	$v0,0x80aa
a800000000113a30:	64427b18 	daddiu	$v0,$v0,31512
a800000000113a34:	0040202d 	move	$a0,$v0
a800000000113a38:	3c035800 	lui	$v1,0x5800
a800000000113a3c:	0003183c 	dsll32	$v1,$v1,0x0
a800000000113a40:	34630fff 	ori	$v1,$v1,0xfff
a800000000113a44:	0043102d 	daddu	$v0,$v0,$v1

This is the result of having &_end be in kseg0, but __pa assuming
that it's in xkphys.  Also, at this point, the relocation is gone.  So
when I objcopy, I'm left with the strange address from hell being
passed in to bootmem_init().

This, of course, makes the kernel very unhappy.  

I could fix this instance any number of ways, but that doesn't seem
to be a solution for the general problem...I'm sure this same kind of thing is
going to bite me in a couple dozen other places.

I assume other people are successfully building mips64 kernels with those
tools; does anyone have any hints as to how to fix this?

Thanks,

-Justin
carlson@sibyte.com
