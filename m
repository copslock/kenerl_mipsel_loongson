Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DDGql29054
	for linux-mips-outgoing; Wed, 13 Jun 2001 06:16:52 -0700
Received: from bunny.shuttle.de (bunny.shuttle.de [193.174.247.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DDGjP29036;
	Wed, 13 Jun 2001 06:16:45 -0700
Received: by bunny.shuttle.de (Postfix, from userid 112)
	id 3D4964A868; Wed, 13 Jun 2001 15:16:44 +0200 (CEST)
Date: Wed, 13 Jun 2001 15:16:44 +0200
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010613151644.A19513@bunny.shuttle.de>
References: <8067.992432780@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8067.992432780@ocs4.ocs-net>
User-Agent: Mutt/1.3.18i
From: borenius@shuttle.de (Raoul Borenius)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 13, 2001 at 09:46:20PM +1000, Keith Owens wrote:
> On Wed, 13 Jun 2001 13:37:51 +0200, 
> borenius@shuttle.de (Raoul Borenius) wrote:
> >Unable to handle kernel paging request at virtual address 00000000, epc == 8800e                               e5c, ra == 8800ee5c
> >Call Trace: [<88124dc0>] [<88124dd8>] [<8800eb84>] [<88063810>] [<880647f4>] [<8                               8063670>] [<880640f0>] [<880640b8>] [<8805f7f4>] [<88052a88>] [<88052b74>] [<880
> >537c0>] [<88053768>] [<88052294>] [<8804ef14>] [<8800fc28>] [<8800c638>] [<c013d                               686>]
> 
> The epc line and the call trace have embedded spaces and newlines which
> are preventing ksymoops from doing a full conversion.  Try again with
> the extra characters removed, i.e.

Sorry about that. These things happen every time I try to do five or more
things at the same time...

Hope the trace is ok now.

Regards

Raoul

 ---------------------------------------------------------------------
 Raoul Gunnar Borenius		Deutsches Forschungsnetz e.V.
 WiNShuttle			Lindenspürstr.32, 70176 Stuttgart
 Phone  : +49 711 63314-206	FAX: +49 711 63314-133
 E-Mail : borenius@shuttle.de	http://www.shuttle.de
 ---------------------------------------------------------------------

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace.txt"

ksymoops 2.4.1 on mips 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map-2.4.3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Starting periodic command scheduler: cronkernel BUG at semaphore.c:235!
Unable to handle kernel paging request at virtual address 00000000, epc == 8800e                               e5c, ra == 8800ee5c
$0 : 00000000 1000fc00 0000001f 8f63a000
$4 : 00000017 00000000 00000001 8877a3a0
$8 : 0000000a 88171cc0 00000000 00000000
$12: 00000000 881718e0 fffffff9 0000000a
$16: 8877a59c 00000000 8f63a000 8877a5a4
$20: 8f63bf04 8f63bf00 8f63bea0 00000009
$24: 8f63bcf2 ffffffff
$28: 8f63a000 8f63bdd8 7fff7bb0 8800ee5c
epc   : 8800ee5c
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: 1000fc03
Cause : 0000000c
Process start-stop-daem (pid: 129, stackpage=8f63a000)
Stack: 88124dc0 88124dd8 000000eb 00000000 8877a59c 8877a580 8800eb84 10011f10
       00000000 8ffa02c0 88063810 880647f4 00000000 8f63a000 8877a5a4 8877a5a4
       fffffffe 8877a580 8fac4840 8877a59c 8f63bf04 88063670 8fac4660 8f8cec20
       8f63bf00 8f63bf00 8fac4840 8f63bf00 8fac4840 8814b00d 8f63bf00 8f63bf04
       880640f0 880640b8 8fac4840 8805f7f4 8fac4660 8814b00d 8f8ceca0 8f8ceca0
       88052a88 ...
Call Trace: [<88124dc0>] [<88124dd8>] [<8800eb84>] [<88063810>] [<880647f4>] [<88063670>] [<880640f0>] [<880640b8>] [<8805f7f4>] [<88052a88>] [<88052b74>] [<880 537c0>] [<88053768>] [<88052294>] [<8804ef14>] [<8800fc28>] [<8800c638>] [<c013d686>]
Code: 240600eb  0e007859  00000000 <ae200000> 26040010  24050003  0e006b45  24060001  0a003b85

>>RA;  8800ee5c <__rwsem_wake+b8/dc>
>>PC;  8800ee5c <__rwsem_wake+b8/dc>   <=====
Trace; 88124dc0 <prom_getsysid+cc8/106c>
Trace; 88124dd8 <prom_getsysid+ce0/106c>
Trace; 8800eb84 <__down_read+1dc/1e4>
Trace; 88063810 <proc_root_link+b4/e4>
Trace; 880647f4 <proc_pid_make_inode+24/10c>
Trace; 88063670 <proc_exe_link+1cc/1d4>
Trace; 880640f0 <proc_pid_follow_link+98/b0>
Trace; 880640b8 <proc_pid_follow_link+60/b0>
Trace; 8805f7f4 <update_atime+6c/78>
Trace; 88052a88 <path_walk+334/a94>
Trace; 88052b74 <path_walk+420/a94>
Code;  8800ee50 <__rwsem_wake+ac/dc>
0000000000000000 <_PC>:
Code;  8800ee50 <__rwsem_wake+ac/dc>
   0:   240600eb  li      $a2,235
Code;  8800ee54 <__rwsem_wake+b0/dc>
   4:   0e007859  jal     801e164 <_PC+0x801e164> 9002cfb4 <END_OF_CODE+7e98120/????>
Code;  8800ee58 <__rwsem_wake+b4/dc>
   8:   00000000  nop
Code;  8800ee5c <__rwsem_wake+b8/dc>   <=====
   c:   ae200000  sw      $zero,0($s1)   <=====
Code;  8800ee60 <__rwsem_wake+bc/dc>
  10:   26040010  addiu   $a0,$s0,16
Code;  8800ee64 <__rwsem_wake+c0/dc>
  14:   24050003  li      $a1,3
Code;  8800ee68 <__rwsem_wake+c4/dc>
  18:   0e006b45  jal     801ad14 <_PC+0x801ad14> 90029b64 <END_OF_CODE+7e94cd0/????>
Code;  8800ee6c <__rwsem_wake+c8/dc>
  1c:   24060001  li      $a2,1
Code;  8800ee70 <__rwsem_wake+cc/dc>
  20:   0a003b85  j       800ee14 <_PC+0x800ee14> 9001dc64 <END_OF_CODE+7e88dd0/????>


2 warnings issued.  Results may not be reliable.

--UugvWAfsgieZRqgk--
