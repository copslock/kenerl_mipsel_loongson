Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5AM3rM05586
	for linux-mips-outgoing; Sun, 10 Jun 2001 15:03:53 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5AM3oV05569
	for <linux-mips@oss.sgi.com>; Sun, 10 Jun 2001 15:03:51 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E24A67DD; Mon, 11 Jun 2001 00:03:47 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 02C2B42C3; Mon, 11 Jun 2001 00:03:59 +0200 (CEST)
Date: Mon, 11 Jun 2001 00:03:59 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Kernel crash on boot with current cvs (todays)
Message-ID: <20010611000359.A25631@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
i just tried to boot an Indy of mine with the current cvs (from this
morning) and it crashes 


ksymoops 2.4.1 on i686 2.2.18ext3.  Options used
     -v vmlinux-2.4.3 (specified)
     -K (specified)
     -L (specified)
     -o lib/modules/2.4.3 (specified)
     -m System.map-2.4.3 (specified)

No modules in ksyms, skipping objects
kernel BUG at semaphore.c:235!
Unable to handle kernel paging request at virtual address 00000000, epc == 8800f02c, ra == 8800f02c
$0 : 00000000 3004fc00 0000001f 89d0e000
$4 : 00000017 00000000 00000001 88669440
$8 : 0000000a 8814cc50 00000000 00000000
$12: 00000000 8814c870 fffffff9 0000000a
$16: 8866977c 00000000 89d0e000 88669784
$20: 89d0ff04 89d0ff00 89d0fea0 00000009
$24: 89d0fcf2 ffffffff
$28: 89d0e000 89d0fdd8 7fff7ba0 8800f02c
epc   : 8800f02c
Using defaults from ksymoops -t elf32-little -a unknown
Status: 3004fc03
Cause : 3000000c
Process start-stop-daem (pid: 211, stackpage=89d0e000)
Stack: 88106e30 88106e48 000000eb 00000000 8866977c 88669760 8800ed54 2aba3820
       00000000 885d1280 88064cf0 88065cd4 00000000 89d0e000 88669784 88669784
       fffffffe 88669760 89e24640 8866977c 89d0ff04 88064b50 89e24460 8bd1d8e0
       89d0ff00 89d0ff00 89e24640 89d0ff00 89e24640 8b6d400d 89d0ff00 89d0ff04
       880655d0 88065598 89e24640 88060cf4 89e24460 8b6d400d 8bd1d960 8bd1d960
       88053f88 ...
Call Trace: [<88106e30>] [<88106e48>] [<8800ed54>] [<88064cf0>] [<88065cd4>] [<88064b50>] [<880655d0>] [<88065598>] [<88060cf4>] [<88053f88>] [<88054074>] [<88054cc0>] [<88054c68>] [<88053794>] [<88050414>] [<8800fe08>] [<8800fe08>]
Code: 240600eb  0e007d99  00000000 <ae200000> 26040010  24050003  0e007085  24060001  0a003bf9
Error (Oops_bfd_perror): scan_arch for specified architecture Success

>>RA;  8800f02c <__rwsem_wake+b8/dc>
>>???; 8800f02c <__rwsem_wake+b8/dc>   <=====
Trace; 88106e30 <__gnu_compiled_c+d90/1204>
Trace; 88106e48 <__gnu_compiled_c+da8/1204>
Trace; 8800ed54 <__down_read+1dc/1e4>
Trace; 88064cf0 <proc_root_link+b4/e4>
Trace; 88065cd4 <proc_pid_make_inode+24/10c>
Trace; 88064b50 <proc_exe_link+1cc/1d4>
Trace; 880655d0 <proc_pid_follow_link+98/b0>
Trace; 88065598 <proc_pid_follow_link+60/b0>
Trace; 88060cf4 <update_atime+6c/78>
Trace; 88053f88 <path_walk+334/a94>
Trace; 88054074 <path_walk+420/a94>
Trace; 88054cc0 <__user_walk+78/94>
Trace; 88054c68 <__user_walk+20/94>
Trace; 88053794 <path_release+18/74>
Trace; 88050414 <sys_newstat+20/98>
Trace; 8800fe08 <stack_done+1c/38>
Trace; 8800fe08 <stack_done+1c/38>

1 error issued.  Results may not be reliable.


-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
