Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 14:33:32 +0100 (CET)
Received: from webmail35.rediffmail.com ([203.199.83.246]:51611 "HELO
	webmail35.rediffmail.com") by linux-mips.org with SMTP
	id <S1122123AbSKUNdb>; Thu, 21 Nov 2002 14:33:31 +0100
Received: (qmail 10572 invoked by uid 510); 21 Nov 2002 13:33:07 -0000
Date: 21 Nov 2002 13:33:07 -0000
Message-ID: <20021121133307.10571.qmail@webmail35.rediffmail.com>
Received: from unknown (203.197.184.107) by rediffmail.com via HTTP; 21 Nov 2002 13:33:07 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: mysterious page fault in _syscall3..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

on Mips idt with Rc323334 core i have following problem.

1.After boot when the shell is execved the sequence goes like 
this.

in init/main.c

execve -( macro expansion in _syscall3 in unistd. h)--> sys_execve 
--> do_execve

do_execve return success and i get a sensible register dump after 
do_execve(0 call in sys_execve() like,

$0 : 00000000 00000000 00000000 00000000
$4 : 00000000 00000000 00000000 00000000
$8 : 00000000 00000000 00000000 00000000
$12: 00000000 00000000 00000000 00000000
$16: 00000000 00000000 00000000 00000000
$20: 00000000 00000000 00000000 00000000
$24: 00000000 00000000
$28: 00000000 7fff7f80 00000000 00000000
epc   : 004000b0
Status: 0000ff13
Cause : 00000020

EPC 004000b0 is verified by objdump of /bin/sh
STATUS 0000ff13 imply user mode and CAUSE 00000020 indicate 
syscall exception..all fine.

2.but immediately after sys_execve returns the value, i get a 
sudden page fault producing a imposible register dump ( epc status 
and cause all zero)

Unable to handle kernel paging request at virtual address 
0fc01788, epc == 00000000, ra == 00000000
Oops in fault.c:do_page_fault, line 225:
$0 : 00000000 00000000 00000000 00000000
$4 : 000072c0 800ef814 00000000 801fc000
$8 : 00000000 00000000 00000000 4c696e75
$12: 78000000 00000000 00000000 00000000
$16: 00000000 00000000 00000000 00000000
$20: 00000000 00000000 00000000 00000000
$24: 00000000 00000000
$28: 6e652900 00000000 00000000 00000000
epc   : 00000000
Status: 00000000
Cause : 00000000

this i guess when sys_execve returns , stack is corrupted somehow 
and regs(pointer to struct pt_regs) is no more correct.

though i haven't read fully the gcc info page and acquanited with 
nasty  asm code of _syscall3 in unistd.h , but does execve enters 
sys_execve directly by macro expansion in _syscall3 ..or there are 
relevant steps in between.?

what kind of problem i am facing ?
is this problem with saving & restoring , corruption
or in _syscall3..?
any possibility of write buffer and pipeline hazard..?

I have tried with interrupts disabled in sys_execve just for 
checking prupose..
would taking support of BDI2000 kind of debuggers will be 
helpful?

Best Regards,
Atul



__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
