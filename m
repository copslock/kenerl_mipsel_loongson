Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Oct 2002 15:42:00 +0200 (CEST)
Received: from webmail24.rediffmail.com ([203.199.83.146]:32402 "HELO
	webmail24.rediffmail.com") by linux-mips.org with SMTP
	id <S1123927AbSJXNl7>; Thu, 24 Oct 2002 15:41:59 +0200
Received: (qmail 16415 invoked by uid 510); 24 Oct 2002 13:43:22 -0000
Date: 24 Oct 2002 13:43:22 -0000
Message-ID: <20021024134322.16414.qmail@webmail24.rediffmail.com>
Received: from unknown (203.197.186.246) by rediffmail.com via HTTP; 24 Oct 2002 13:43:22 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: ramdisk loading scheme...
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

which is better scheme..

either to include compressed ramdisk in kernel image image itself 
identified by binary_ramdisk_gz_start symbol
or load ramdisk seperately.

I am using compressed ramdisk image as part
of vmlinux and later converting it into a binary image
as reqd. by bootloader.

in this piece of System.map file it shows that
ramdisk is included at the end of data section(_edata).

000000800f3f08 D prom_console_driver
00000000800f4000 D __rd_start
00000000800f4000 D _binary_ramdisk_gz_
0000000080187960 D __rd_end
0000000080187960 D _binary_ramdisk_gz_
0000000080188000 A __bss_start
0000000080188000 A _edata

this is done by following Makefile and ld.script

in Makefile i have
ramdisk.o: ramdisk.gz ld.script
         $(LD) -no-warn-mismatch -T ld.script -b binary -        o 
$@ ramdisk.gz

in ld.script I have ,

OUTPUT_FORMAT("elf32-bigmips")
OUTPUT_ARCH(mips)
SECTIONS
{
   .initrd :
   {
        *(.data)
   }
}


one question is that is it necessary to include comprese ramdisk 
at the end of data section ..?

rd_image_load is zero which i think is alright as it indicates the 
offset in ram (device that holds initrd).

i am facing problems in execving the /bin/sh in main.c as it 
accesses some wrong address in do_page_fault
i doubt there may be some issues when i am uncompressing the 
ramdisk and all though i am being reported for corect length and 
crc for ramdisk in boot messages.

Best Regards,
Atul


__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
