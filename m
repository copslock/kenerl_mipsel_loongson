Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f851bPN06470
	for linux-mips-outgoing; Tue, 4 Sep 2001 18:37:25 -0700
Received: from smtp (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f851bHd06464
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 18:37:17 -0700
Received: from ex2k.pcs.psdc.com ([172.19.1.1])
 by smtp (NAVIEG 2.1 bld 63) with SMTP id M2001090418375410933
 for <linux-mips@oss.sgi.com>; Tue, 04 Sep 2001 18:37:54 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Load address of the application is not right.
Date: Tue, 4 Sep 2001 18:34:08 -0700
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A28BC@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Load address of the application is not right.
Thread-Index: AcE1qtpx0+a1YXvkQtu6m+bBMTfe8w==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f851bHd06465
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, All:

I have built the linux kernel and the glibc for my R3000 CPU. Because
the /sbin/init could not be lunched, I wrote the following program to
replace the init program:

liu.c:

#include <stdio.h>
#include <string.h>

main()
{
    char s[20];
   strcpy(s,"RUNNING");//failed
}

After built it, I got the following by using objdump:

liu:     file format elf32-bigmips

Disassembly of section .text:

00000000004000c0 <main>:
  4000c0:	3c1c0fc2 	lui	$gp,0xfc2
  4000c4:	279c8090 	addiu	$gp,$gp,-32624
  4000c8:	0399e021 	addu	$gp,$gp,$t9
  4000cc:	27bdffc0 	addiu	$sp,$sp,-64
  4000d0:	afbc0010 	sw	$gp,16($sp)
  4000d4:	afbf0038 	sw	$ra,56($sp)
  4000d8:	afbe0034 	sw	$s8,52($sp)
  4000dc:	afbc0030 	sw	$gp,48($sp)
  4000e0:	03a0f021 	move	$s8,$sp
  4000e4:	27c40018 	addiu	$a0,$s8,24
  4000e8:	8f858018 	lw	$a1,-32744($gp)      <========
failed here ! 
  4000ec:	00000000 	nop
  4000f0:	24a500b0 	addiu	$a1,$a1,176
  4000f4:	8f99802c 	lw	$t9,-32724($gp)
  4000f8:	00000000 	nop
  4000fc:	0320f809 	jalr	$t9
  400100:	00000000 	nop
  400104:	8fdc0010 	lw	$gp,16($s8)
  400108:	03c0e821 	move	$sp,$s8
  40010c:	8fbf0038 	lw	$ra,56($sp)
  400110:	8fbe0034 	lw	$s8,52($sp)
  400114:	03e00008 	jr	$ra
  400118:	27bd0040 	addiu	$sp,$sp,64
  40011c:	00000000 	nop

0000000000400120 <strcpy>:
  400120:	3c1c0fc2 	lui	$gp,0xfc2
  400124:	279c8030 	addiu	$gp,$gp,-32720
  400128:	0399e021 	addu	$gp,$gp,$t9
  40012c:	00851023 	subu	$v0,$a0,$a1
  400130:	2446ffff 	addiu	$a2,$v0,-1
  400134:	90a30000 	lbu	$v1,0($a1)
  400138:	24a50001 	addiu	$a1,$a1,1
  40013c:	00a61021 	addu	$v0,$a1,$a2
  400140:	a0430000 	sb	$v1,0($v0)
  400144:	00031e00 	sll	$v1,$v1,0x18
  400148:	1460fffa 	bnez	$v1,400134 <strcpy+14>
  40014c:	00801021 	move	$v0,$a0
  400150:	03e00008 	jr	$ra
	...

Here is the screen output:

Here 15: retval=0

[init:1:004000c0:0:004000c0:00001000]

in handle_mm_fault()

In do_no_page: calling nopage()

In filemap_nopage()

In do_no_page: called nopage()

calling: update_mmu_cache()

[HIT]

called: update_mmu_cache()

[init:1:0fc100a8:0:004000e8:0003f040]

Unable to handle kernel paging request at virtual address 0fc100a8, epc
== 004000e8
Oops: 0000

$0 : 00000000 1000fc00 00000000 00000000 7fffff68 00000000 00000000
00000000    
$8 : 0000fc00 00000010 00000000 00001fe7 80257970 00000001 1000fc01
00000060    
$16: 80241598 8020d7a4 80241570 801081c0 00000000 00000000 00000000
00000000    
$24: 0000000a 00000000                   0fc18090 7fffff50 7fffff50
00000000    
epc  : 004000e8

Status: 0000fc00

Cause : 00000008

Process init (pid: 1, stackpage=83ff8000)

Stack: 00000fd4 00000fd5 00000fd6 00000fd7 0fc18090 00000fd9 00000fda
00000fdb         
00000fdc 00000fdd 00000fde 00000fdf 0fc18090 800938c0 00000000 00000fe3

00000001 7fffffda 00000000 7fffffdd 7fffffde 00000000 00000010 00000000

00000000 00000000 00000fee 00000fef 00000ff0 00000ff1 00000ff2 00000ff3

00000ff4 00000ff5 00000ff6 00000ff7 00000ff8 00000ff9 00000ffa 00000ffb

00000ffc ...                             
CaCode: afbc0030  03a0f021  27c40018 <8f858018> 00000000  24a500b0
8f99802c  00000000


As we know, $gp is managed by the OS. My question is who assign value to
register t9 (i.e. $25) and where? Why $gp was given 0xfc2 and
then added by  -32624 ? Because $gp and $t9 gave a wrong address
0fc100a8, the CPU give a page fault and the OS said that the address is
not
GROWDOWN and faild to continue.  

I think it related to my glibc but I do not know the exact place. 

If you had this kind problem before, please share your knowlage with me.

Thanks,

Steven Liu
