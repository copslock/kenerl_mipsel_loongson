Received:  by oss.sgi.com id <S42283AbQGSXBH>;
	Wed, 19 Jul 2000 16:01:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56627 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42282AbQGSXAj>; Wed, 19 Jul 2000 16:00:39 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA05542
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 16:05:57 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA35891;
	Wed, 19 Jul 2000 16:00:01 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id 03893A7875; Wed, 19 Jul 2000 15:58:37 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14710.12957.944464.88872@calypso.engr.sgi.com>
Date:   Wed, 19 Jul 2000 15:58:37 -0700 (PDT)
To:     Brady Brown <bbrown@ti.com>
Cc:     SGI news group <linux-mips@oss.sgi.com>
Subject: Re: egcs 1.0.3a-2 crosscompiler behavior
In-Reply-To: <39761989.D37E89FE@ti.com>
References: <39761989.D37E89FE@ti.com>
X-Mailer: VM 6.75 under Emacs 20.5.1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Brady,

This is fixed in the current CVS version of binutils.  I have no idea
what version of ld you are running, but if you look at the function
_bfd_mips_elf_merge_private_bfd_data in elf32-mips.c you'll see that
the check ibfd->xvec->byteorder != BFD_ENDIAN_UNKOWN is forgotten in
the if statement.

Ulf

Brady Brown writes:
 > I have several steps in my build process where I use the linker to link
 > a pure binary file (usually a zipped image) into a relocatable elf file,
 > which is then linked with other elf files to create a final image. I am
 > running the mipsel-linux cross compiler tool chain on an i386. After
 > upgrading the tools to egcs 1.0.3a-2 the linking of this binary file
 > fails.
 > 
 > Example:
 > mipsel-linux-ld -T link.script -r -b binary image.gz -o image.o
 > 
 > link.script file contents are:
 > OUTPUT_FORMAT("elf32-littlemips")
 > OUTPUT_ARCH(mips)
 > SECTIONS
 > {
 >     .data :
 >     {
 >         image_start = .;
 >         *(.data)
 >         image_end = .;
 >       }
 > }
 > 
 > The normal output from the old linker was:
 > mipsel-linux-ld: image.gz: compiled for a little endian system and
 > target is little endian
 > 
 > The new linker gives:
 > mipsel-linux-ld: image.gz: compiled for a little endian system and
 > target is big endian
 > File in wrong format: failed to merge target specific data of file
 > image.gz?
 > make[1]: *** [image.o] Error 1
 > 
 > I have been unable to figure out why the linker thinks the target is big
 > endian and have yet to find a way to get this to work. Any ideas?
 > --
 > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > Brady Brown (bbrown@ti.com)       Work:(801)619-6103
 > Texas Instruments: Broadband Access Group
 > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > 
 > 
