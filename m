Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 11:47:06 +0100 (CET)
Received: from webmail36.rediffmail.com ([203.199.83.248]:31661 "HELO
	webmail36.rediffmail.com") by linux-mips.org with SMTP
	id <S1121744AbSKTKrF>; Wed, 20 Nov 2002 11:47:05 +0100
Received: (qmail 23927 invoked by uid 510); 20 Nov 2002 10:46:38 -0000
Date: 20 Nov 2002 10:46:38 -0000
Message-ID: <20021120104638.23926.qmail@webmail36.rediffmail.com>
Received: from unknown (202.54.89.83) by rediffmail.com via HTTP; 20 Nov 2002 10:46:38 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: epc status cause all are reported zero?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello all,

I have a wiered problem.

following is the Oops by kernel when it tries to exec the shell.

while loading /bin/sh it reads the elf_ex.e_entry as 0x4000b0 this 
address is confirmed by
mip-linux-objdump -S bin/sh after mount -o loop on my host.
$mips-linux-objdump -S ./sh

./sh:     file format elf32-bigmips

Disassembly of section .text:

00000000004000b0 <.text>:
   4000b0:	3c1c0fc1 	lui	$gp,0xfc1
   4000b4:	279c96e0 	addiu	$gp,$gp,-26912
   4000b8:	0399e021 	addu	$gp,$gp,$t9


During exec there is a page fault of 4000b0 but immediately after 
that i get another page fault 0f 0x0fc01788 and following register 
dump after it
fails to get a fixup address.

Unable to handle kernel paging request at virtual address 
0fc01788, epc == 00000Oops in fault.c:do_page_fault, line 230:
$0 : 00000000 00000000 00000000 00000000
$4 : 00007340 800f0474 00000000 801fa000
$8 : 00000000 00000000 00000000 4c696e75
$12: 78000000 00000000 00000000 00000000
$16: 00000000 00000000 00000000 00000000
$20: 00000000 00000000 00000000 00000000
$24: 00000000 00000000
$28: 6e652900 00000000 00000000 00000000
epc   : 00000000
Status: 00000000
Cause : 00000000
Process sh (pid: 1, stackpage=801fa000)


i am confused how come the epc status and cause register all are 
reported zero.
whether my regs ( pointer to struct pt_regs) is pointing somewhere 
else..?

secondly Is this a problem with shell or kernel..? may be 
somewhere the kernel is not checking the
validity of user space address and hence this problem..

to avoid any other posibilities i am running uncached.

any thought

Best Regards,
Atul



__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
