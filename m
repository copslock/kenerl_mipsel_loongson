Received:  by oss.sgi.com id <S553690AbQJUTYp>;
	Sat, 21 Oct 2000 12:24:45 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:49163 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553673AbQJUTYc>;
	Sat, 21 Oct 2000 12:24:32 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2577C7D9; Sat, 21 Oct 2000 21:24:30 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 08E2D900C; Sat, 21 Oct 2000 21:23:19 +0200 (CEST)
Date:   Sat, 21 Oct 2000 21:23:18 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: oops in lance initialization / diskboot
Message-ID: <20001021212318.C3619@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I have seen an interesting oops

This happened when i booted with delo from disk and
directly after the "BOOTP" message should have been coming
i got this oops. Previously i got the following messages
on the console.

eth0: Memory error, status fe83
eth0: DMA error
LANCE unopened after 100 ticks, csr0=0001.

I guess this has something to do with diskbooting as this doesnt
happen when booting from tftp/net ...

This is a decstation 5000/150 KN04 V2.1k diskbooted with delo 0.7

Kernel is a 2.4.0-test9 from current cvs as of 001021

BTW: I got another oops when trying to process this oops with ksymoops
which i did not capture :(

----- Forwarded message from root <root@repeat.rfc822.org> -----

ksymoops 2.3.4 on mips 2.4.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test9/ (default)
     -m /boot/System.map-2.4.0-test9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel paging request at virtual address 545f4d74, epc == 80058580, ra == 80058930
$0 : 00000000 10012c00 00000120 545f4d6c
$4 : 0000000a 00000001 8116e000 00000009
$8 : 10012c01 1000001e 10012c01 00010000
$12: 0000000a fffffffd ffffffff 81179c50
$16: 800dce38 8116f820 8116f940 10012c01
$20: 8116f800 00000003 00000000 8116f658
$24: 00000010 00000000
$28: 8116e000 8116f7d0 8043ff80 80058930
epc   : 80058580
Using defaults from ksymoops -t elf32-littlemips -a mips:3000
Status: 10012c02
Cause : 00000008
Process  (pid: -2146251216, stackpage=8116e000)
Stack: 00000000 00000000 00000000 00000000 80058930 00000000 00000000 00000000
       00000000 00000000 8004f1f8 00000000 30687465 00000000 00000000 00000000
       8117d4c0 00000000 80048838 a0020000 bc0c0000 00000003 00000000 0000000c
       00000000 00000000 00000000 10012c01 800dce10 20000000 00000003 8116f800
       8116f928 00000008 00010000 8018c00c 00010100 00010000 017c0000 fffffffd
       ffffffff ...
Call Trace: [<80058930>] [<8004f1f8>] [<80048838>] [<800dce10>] [<800cab9c>] [<800dce3c>] [<80155648>] [<800cab9c>] [<800dc008>] [<800ffefc>] [<800ca73c>] [<80155648>] [<800cab9c>] [<800cac08>] [<800dd6a0>] [<800ca73c>] [<80155648>] [<800cab9c>] [<800cac08>] [<800ca73c>] [<80155648>] [<800cab9c>] [<800cac08>] [<800ca73c>] [<80155648>] [<800cab9c>] [<800cac08>] [<800ca73c>] [<80155648>] [<800cab9c>] [<800cac08>] [<800ca73c>] [<80155648>] [<800cab9c>] [<800cac08>] [<800ca73c>] [<80155648>] [<800ee580>] [<800cab9c>] [<800cac08>] [<800ca73c>] ...
Warning (Oops_trace_line): garbage '...' at end of trace line ignored
Code: 2402fffd  00071140  00621821 <8c620008> 240b0001  504b0001  ac600008  24c90358  24c20340 

>>RA;  80058930 <force_sig+14/20>
>>PC;  80058580 <force_sig_info+70/140>   <=====
Trace; 80058930 <force_sig+14/20>
Trace; 8004f1f8 <do_ade+2b8/2d0>
Trace; 80048838 <handle_ades+f8/100>
Trace; 800dce10 <lance_interrupt+0/230>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800dce3c <lance_interrupt+2c/230>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800dc008 <eth_mac_addr+0/44>
Trace; 800ffefc <eth_header_cache+0/88>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800dd6a0 <lance_set_multicast_retry+0/20>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800ca73c <handle_it+8/10>
Trace; 80155648 <days_in_mo+790/cd0>
Trace; 800ee580 <dma_mmu_get_scsi_sgl+0/50>
Trace; 800cab9c <do_IRQ+128/208>
Trace; 800cac08 <do_IRQ+194/208>
Trace; 800ca73c <handle_it+8/10>
Code;  80058574 <force_sig_info+64/140>
0000000000000000 <_PC>:
Code;  80058574 <force_sig_info+64/140>
   0:   2402fffd  li      $v0,-3
Code;  80058578 <force_sig_info+68/140>
   4:   00071140  sll     $v0,$a3,0x5
Code;  8005857c <force_sig_info+6c/140>
   8:   00621821  addu    $v1,$v1,$v0
Code;  80058580 <force_sig_info+70/140>   <=====
   c:   8c620008  lw      $v0,8($v1)   <=====
Code;  80058584 <force_sig_info+74/140>
  10:   240b0001  li      $t3,1
Code;  80058588 <force_sig_info+78/140>
  14:   504b0001  beql    $v0,$t3,1c <_PC+1c> 80058590 <force_sig_info+80/140>
Code;  8005858c <force_sig_info+7c/140>
  18:   ac600008  sw      $zero,8($v1)
Code;  80058590 <force_sig_info+80/140>
  1c:   24c90358  addiu   $t1,$a2,856
Code;  80058594 <force_sig_info+84/140>
  20:   24c20340  addiu   $v0,$a2,832


3 warnings issued.  Results may not be reliable.

----- End forwarded message -----

-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
