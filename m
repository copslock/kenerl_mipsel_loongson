Received:  by oss.sgi.com id <S42277AbQGSVMP>;
	Wed, 19 Jul 2000 14:12:15 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:970 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S42275AbQGSVLm>;
	Wed, 19 Jul 2000 14:11:42 -0700
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by gatekeep.ti.com (8.10.2/8.10.1) with ESMTP id e6JLBBH08527
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 16:11:15 -0500 (CDT)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA18433
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 16:10:47 -0500 (CDT)
Received: from dlep3.itg.ti.com (dlep3.itg.ti.com [157.170.188.62])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA18428
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 16:10:47 -0500 (CDT)
Received: from ti.com (IDENT:bbrown@bbrown.sc.ti.com [158.218.100.128])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA04675
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 16:11:09 -0500 (CDT)
Message-ID: <39761989.D37E89FE@ti.com>
Date:   Wed, 19 Jul 2000 15:11:37 -0600
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: egcs 1.0.3a-2 crosscompiler behavior
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have several steps in my build process where I use the linker to link
a pure binary file (usually a zipped image) into a relocatable elf file,
which is then linked with other elf files to create a final image. I am
running the mipsel-linux cross compiler tool chain on an i386. After
upgrading the tools to egcs 1.0.3a-2 the linking of this binary file
fails.

Example:
mipsel-linux-ld -T link.script -r -b binary image.gz -o image.o

link.script file contents are:
OUTPUT_FORMAT("elf32-littlemips")
OUTPUT_ARCH(mips)
SECTIONS
{
    .data :
    {
        image_start = .;
        *(.data)
        image_end = .;
      }
}

The normal output from the old linker was:
mipsel-linux-ld: image.gz: compiled for a little endian system and
target is little endian

The new linker gives:
mipsel-linux-ld: image.gz: compiled for a little endian system and
target is big endian
File in wrong format: failed to merge target specific data of file
image.gz?
make[1]: *** [image.o] Error 1

I have been unable to figure out why the linker thinks the target is big
endian and have yet to find a way to get this to work. Any ideas?
--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
