Received:  by oss.sgi.com id <S42244AbQGIWnd>;
	Sun, 9 Jul 2000 15:43:33 -0700
Received: from iglou4.iglou.com ([192.107.41.39]:17068 "EHLO iglou.com")
	by oss.sgi.com with ESMTP id <S42185AbQGIWnM>;
	Sun, 9 Jul 2000 15:43:12 -0700
Received: from [204.255.238.187] (helo=tool.net) 
	by iglou.com with esmtp (8.9.3/8.9.3)
	id 13BPnC-000765-00; Sun, 09 Jul 2000 18:43:19 -0400
Message-ID: <396971C3.6EB63B13@tool.net>
Date:   Mon, 10 Jul 2000 02:48:35 -0400
From:   Jason Mesker <jasonm@tool.net>
Reply-To: jasonm@tool.net
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.2.15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "debian-mips@lists.debian.org" <debian-mips@lists.debian.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: R5000 oops
Content-Type: multipart/mixed;
 boundary="------------B68A2EC6A0529B815E206118"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------B68A2EC6A0529B815E206118
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am trying to compile vim and during the configure script exec I get an
oops.




--------------B68A2EC6A0529B815E206118
Content-Type: text/plain; charset=us-ascii;
 name="ksys.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksys.oops"

ksymoops 2.3.4 on sparc64 2.2.16.  Options used
     -v ./vmlinux-0704b (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m ./System.map-0704b.foo (specified)
     -t elf32-bigmips -a mips:4600

checking for opendir... Unable to handle kernel paging request at virtual address 0040dca0, epc == 88043190, ra == 88065748
Warning (Oops_read): Code line not seen, dumping what data is available

Oops in fault.c:do_page_fault, line 158:
init : 00000000 1000fc00 00000000 8fdc0010
 : 8ac22f80 8ac22f80 0040dca0 8aaf9ee0
 : 886867c4 00000000 ffffffe0 88686720
2: 00000003 84000000 00000000 00000021
6: 8853e868 8853e860 1000fc01 00000007
0: 8aaf9ee0 8aaf9ee8 00000000 00000006
4: 00000000 2abd4640
8: 8aaf8000 8aaf9e18 00000180 88065748

>>RA;  88065748 <d_alloc+30/174>

epc   : 88043190
Status: 1000fc02
Cause : 00000004
Process gcc (pid: 1266, stackpage=8aaf8000)
Stack: 8aaf9ee0 8805a804 00000000 00000000 fffffff4 8be0dd80 8be0dd80 8aaf9ee8
       88065748 00000006 8805a7d8 8ac2d004 8aaf9ef8 8805a804 fffffff4 8be0dd80
       8be067c0 8aaf9ee8 8805b950 8be0dd80 8ac2d000 00000000 00000180 00000503
       8be06818 ffffffeb 8be0dd80 00000503 8805be3c 8805bd74 88195488 00000008
       00000000 88195484 00000001 88195144 00000502 00000502 00000180 8ac2d000
       00413f00 ...
Call Trace: [<8805a804>] [<88065748>] [<8805a7d8>] [<8805a804>] [<8805b950>] [<8805be3c>] [<8805bd74>] [<8804a4d4>] [<8804a94c>] [<88010f68>] [<88010f68>]
Code: 8ca20004  54400025  8e240008 <acc50000> 8e220008  00c28023  40086000  3409ff00  01094024 

>>PC;  0000000088043190 <kmem_cache_alloc+ac/374>   <=====
Trace; 000000008805a804 <cached_lookup+44/7c>
Trace; 0000000088065748 <d_alloc+30/174>
Trace; 000000008805a7d8 <cached_lookup+18/7c>
Trace; 000000008805a804 <cached_lookup+44/7c>
Trace; 000000008805b950 <lookup_hash+90/ec>
Trace; 000000008805be3c <open_namei+198/92c>
Trace; 000000008805bd74 <open_namei+d0/92c>
Trace; 000000008804a4d4 <filp_open+38/5c>
Trace; 000000008804a94c <sys_open+54/188>
Trace; 0000000088010f68 <stack_done+1c/38>
Trace; 0000000088010f68 <stack_done+1c/38>
Code;  0000000088043184 <kmem_cache_alloc+a0/374>
0000000000000000 <_PC>:
Code;  0000000088043184 <kmem_cache_alloc+a0/374>
   0:   8ca20004  lw      $v0,4($a1)
Code;  0000000088043188 <kmem_cache_alloc+a4/374>
   4:   54400025  0x54400025
Code;  000000008804318c <kmem_cache_alloc+a8/374>
   8:   8e240008  lw      $a0,8($s1)
Code;  0000000088043190 <kmem_cache_alloc+ac/374>   <=====
   c:   acc50000  sw      $a1,0($a2)   <=====
Code;  0000000088043194 <kmem_cache_alloc+b0/374>
  10:   8e220008  lw      $v0,8($s1)
Code;  0000000088043198 <kmem_cache_alloc+b4/374>
  14:   00c28023  subu    $s0,$a2,$v0
Code;  000000008804319c <kmem_cache_alloc+b8/374>
  18:   40086000  mfc0    $t0,$12
Code;  00000000880431a0 <kmem_cache_alloc+bc/374>
  1c:   3409ff00  li      $t1,0xff00
Code;  00000000880431a4 <kmem_cache_alloc+c0/374>
  20:   01094024  and     $t0,$t0,$t1


1 warning issued.  Results may not be reliable.

--------------B68A2EC6A0529B815E206118--
