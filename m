Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 12:34:38 +0100 (MET)
Received: from webmail34.rediffmail.com ([IPv6:::ffff:203.199.83.247]:31459
	"HELO mailweb34.rediffmail.com") by ralf.linux-mips.org with SMTP
	id <S869800AbSK2Le3>; Fri, 29 Nov 2002 12:34:29 +0100
Received: (qmail 22959 invoked by uid 510); 29 Nov 2002 11:37:59 -0000
Date: 29 Nov 2002 11:37:59 -0000
Message-ID: <20021129113759.22958.qmail@mailweb34.rediffmail.com>
Received: from unknown (219.65.139.42) by rediffmail.com via HTTP; 29 nov 2002 11:37:59 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: pt_regs gets lost during exception handling.
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

Here is a strange case of struct pt_regs* getting corupted.

call sequence when /bin/sh getting exec'ed
-------------------------------------------
sys_execve -> do_execve -> search_binary_handle -> load_elf_binary 
-

--> padzero -> handle_tlbs -> do_page_fault(prints wrong regs 
address)

I have checked throughut from do_execve till before padzero the
regs( struct pt_regs*) is 0x801fded

inside  padzero it print the regs address and
dump of show_regs(regs) is like this---

Regs address is 0x801fded8

$0 : 00000000 8014b793 00000fab 00000060
$4 : 800efcb0 8013a5f4 8013a61c 0000000a
$8 : 800ef5ac ffffffff 00000000 8014b7c0
$12: 8014b7c1 0000002c 00000001 8014b793
$16: 8014b7c0 1000ff01 0000003e 80023ca0
$20: 8010e000 800efcad 80000000 00000000
$24: 0000002d 00000010
$28: 801fc000 801fdf88 8013a5f4 80018318
epc   : 80018344
Status: 1000ff03 ( kernel mode )
Cause : 00000020  (syscall exception)

now padzero() calculates page offset for elf_bss that comes 
0xea8.
now immediately the do_page_fault() for write access on 
0x10001ea8
is generated and it prints  like this...

Page Fault on addres 0x10001ea8 and Regs address is 0x10000000.

I was expecting the regs address passed as first arguement
in do_page_fault() to be same as 0x801fded8.

Am I correct..?

secondly in susequent page faults the regs address is printed
as 0x8013a5f4 which is the address of argv_init from

execve("/bin/sh",argv_init,envp_init);

in MACRO DO_FAULT(write) we have code piece like,

move a0,sp; \
jal do_page_fault; \
li a1,write

is the sp in first instruction not correct ?

Best Regards,
Atul





________________________________________________________________
  NIIT supports World Computer Literacy Day on 2nd December.
  Enroll for NIIT SWIFT Jyoti till 2nd December for only Rs. 749
  and get free Indian Languages Office software worth Rs. 2500.
  For details contact your nearest NIIT centre, SWIFT Point
  or click here http://swift.rediff.com/
