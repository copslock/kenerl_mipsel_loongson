Received:  by oss.sgi.com id <S553802AbQLQUWm>;
	Sun, 17 Dec 2000 12:22:42 -0800
Received: from viemta06.chello.at ([195.34.133.56]:63473 "EHLO
        viemta06.chello.at") by oss.sgi.com with ESMTP id <S553795AbQLQUWe>;
	Sun, 17 Dec 2000 12:22:34 -0800
Received: from katze.cyrius.com ([213.47.247.121]) by viemta06.chello.at
          (InterMail vK.4.02.00.10 201-232-116-110 license 9caa03a7df1d31c048ffcc0d31ac5855)
          with ESMTP
          id <20001217202230.VMM16613.viemta06@katze.cyrius.com>;
          Sun, 17 Dec 2000 21:22:30 +0100
Received: by katze.cyrius.com (Postfix, from userid 1000)
	id 99EBC1818F; Sun, 17 Dec 2000 21:23:34 +0100 (MET)
Date:   Sun, 17 Dec 2000 21:23:34 +0100
From:   Martin Michlmayr <tbm@cyrius.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation
Message-ID: <20001217212334.A842@katze.cyrius.com>
References: <20001216160051.A904@sumpf.cyrius.com> <23987.976979391@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23987.976979391@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Sun, Dec 17, 2000 at 02:09:51AM +1100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

* Keith Owens <kaos@melbourne.sgi.com> [20001217 02:09]:
> The joys of cross system debugging.  You need to set ksymoops option
> -t, it is defaulting to elf32-i386 which is no good for mips objects.

When I ran the program on Intel, I feared I might have to change
something... anyway, I did it natively on mipsel now.  I hope it's
ok:

With Karel van Houten's kernel from
http://www.xs4all.nl/~vhouten/mipsel/vmlinux-2.4.0-decR3k.tgz

ksymoops 2.3.5 on mips 2.0.34C52_SK.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Unable to handle kernel paging request at virtual address 00000004, epc == 800596b8, ra == 80059660
$0 : 00000000 10002000 80720380 00000000 00000000 801c38e0 10002000 80230000
$8 : 00002000 ffff00ff 00000000 00000000 00000000 00000000 ffffffff 81096180
$16: 00010f00 81094000 80048000 a000fcf8 30464354 a0002f88 fffffff4 00010f00
$24: 00000001 00000002                   80720000 80720f58 80721090 80059660
epc  : 800596b8
Using defaults from ksymoops -t elf32-littlemips -a mips:3000
Status: 10002004
Cause : 30000408
Process  (pid: 0, stackpage=80720000)
Stack: 00000008 0000000d 80060bc0 00000000 8020c020 00000001 00000000 00000000
       00000000 80720f7c 80720f7c 80048518 00000000 00000000 00000000 80720f7c
       80720f7c 80048518 00010f00 00000000 80048000 a000fcf8 30464354 a0002f88
       00000200 001220d2 40208a0a 8004e988 8023e268 0000000a 80720fe0 00000000
       8004b2cc ffff00ff 00010f00 00000000 80721090 00000000 ffffffff 81096180
       00000000 ...
Call Trace: [<80060bc0>] [<80048518>] [<80048518>] [<80048000>] [<8004e988>] [<8004b2cc>]
Code: ac6b0004  8e2401d4  8e230218 <8c820004> 00000000  0043102b  1040043b  2416fff5  40036000 

>>RA;  80059660 <do_fork+b4/124c>
>>PC;  800596b8 <do_fork+10c/124c>   <=====
Trace; 80060bc0 <open_softirq+30/90>
Trace; 80048518 <handle_softirq+8/10>
Trace; 80048518 <handle_softirq+8/10>
Trace; 80048000 <__gnu_compiled_c+0/0>
Trace; 8004e988 <sys_clone+5c/6c>
Trace; 8004b2cc <stack_done+20/3c>


With Flo's kernel from
ftp://ftp.rfc822.org/pub/local/debian-mipsel/kernel/kernel-image-2.4.0-test8-pre1-dec-r3k.tar.gz

ksymoops 2.3.5 on mips 2.0.34C52_SK.  Options used
     -v vmlinux-2.4.0-test8-pre1 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map-2.4.0-test8-pre1 (specified)

Unable to handle kernel paging request at virtual address 00000004, epc == 800599f4, ra == 8005999c
$0 : 00000000 10002000 80720370 00000000 00000000 00001098 10002000 0000003c
$8 : 00002000 ffff00ff 00000000 00000000 00000000 00000000 801a9d94 10002001
$16: 00000f00 81098000 80048000 a000fcf8 30464354 a0002f88 fffffff4 00000f00
$24: 00000000 00000000                   80720000 80720f58 80721090 8005999c
epc  : 800599f4
Using defaults from ksymoops -t elf32-littlemips -a mips:3000
Status: 10002004
Cause : 30000408
Process  (pid: 0, stackpage=80720000)
Stack: 800d7054 81086200 800613a8 00000001 00000008 80061064 00000000 00000000
       00000000 80720f7c 80720f7c 801b6737 00000000 00000000 00000000 80720f7c
       80720f7c 801b6737 00000f00 00000000 80048000 a000fcf8 30464354 a0002f88
       00000200 001200d2 40208a0a 8004e934 00000000 00000020 80720fe0 0000000a
       8004b2cc 0000003c 00000f00 00000000 80721090 0000003c 801b6748 801a9d94
       00000000 ...
Call Trace: [<800d7054>] [<800613a8>] [<80061064>] [<80048000>] [<8004e934>] [<8004b2cc>]
Code: ac6b0004  8e2401d0  8e230214 <8c820004> 00000000  0043102b  10400442  2416fff5  40036000 
Error (Oops_bfd_perror): set_section_contents Section has no contents

>>RA;  8005999c <do_fork+b0/1264>
>>PC;  800599f4 <do_fork+108/1264>   <=====
Trace; 800d7054 <timer_interrupt+104/1c0>
Trace; 800613a8 <tasklet_hi_action+e0/160>
Trace; 80061064 <__gnu_compiled_c+c4/138>
Trace; 80048000 <__gnu_compiled_c+0/0>
Trace; 8004e934 <sys_clone+5c/6c>
Trace; 8004b2cc <stack_done+20/3c>


1 error issued.  Results may not be reliable.
-- 
Martin Michlmayr
tbm@cyrius.com
