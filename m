Received:  by oss.sgi.com id <S553868AbQLPOy4>;
	Sat, 16 Dec 2000 06:54:56 -0800
Received: from web1.lanscape.net ([64.240.156.194]:12041 "EHLO
        web1.lanscape.net") by oss.sgi.com with ESMTP id <S553864AbQLPOy1>;
	Sat, 16 Dec 2000 06:54:27 -0800
Received: from sumpf.cyrius.com (IDENT:root@localhost [127.0.0.1])
	by web1.lanscape.net (8.9.3/8.9.3) with ESMTP id IAA07736;
	Sat, 16 Dec 2000 08:54:02 -0600
Received: by sumpf.cyrius.com (Postfix, from userid 1000)
	id 7729E14EF4; Sat, 16 Dec 2000 16:00:51 +0100 (CET)
Date:   Sat, 16 Dec 2000 16:00:51 +0100
From:   Martin Michlmayr <tbm@cyrius.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation
Message-ID: <20001216160051.A904@sumpf.cyrius.com>
References: <20001216085603.A514@sumpf.cyrius.com> <15209.976965550@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15209.976965550@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Sat, Dec 16, 2000 at 10:19:10PM +1100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

* Keith Owens <kaos@melbourne.sgi.com> [20001216 22:19]:
> Those two lines have been truncated at end of line instead of wrapping
> onto the next line.  Capture the full text (without truncation) and run
> it through ksymoops[*] to decode it.

ksymoops 2.3.5 on i586 2.2.15.  Options used
     -v /home/tbm/a/vmlinux-2.4.0-test8-pre1 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /home/tbm/a/System.map-2.4.0-test8-pre1 (specified)
     -a mipsel

Unable to handle kernel paging request at virtual address 00000004, epc == 800599f4, ra == 8005999c
$0 : 00000000 10002000 80720370 00000000 00000000 00001098 10002000 0000003c
$8 : 00002000 ffff00ff 00000000 00000000 00000000 00000000 801a9d94 10002001
$16: 00000f00 81098000 80048000 a000fcf8 30464354 a0002f88 fffffff4 00000f00
$24: 00000000 00000000                   80720000 80720f58 80721090 8005999c
epc  : 800599f4
Using defaults from ksymoops -t elf32-i386
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
Error (Oops_bfd_perror): scan_arch for specified architecture Success

>>RA;  8005999c <do_fork+b0/1264>
>>EIP; 800599f4 <do_fork+108/1264>   <=====
Trace; 800d7054 <timer_interrupt+104/1c0>
Trace; 800613a8 <tasklet_hi_action+e0/160>
Trace; 80061064 <__gnu_compiled_c+c4/138>
Trace; 80048000 <__gnu_compiled_c+0/0>
Trace; 8004e934 <sys_clone+5c/6c>
Trace; 8004b2cc <stack_done+20/3c>

1 error issued.  Results may not be reliable.

(This kernel is from ftp://ftp.rfc822.org/pub/local/linux-mipsel/kernel (?)
file: kernel-image-2.4.0-test8-pre1-dec-r3k.tar.gz)



ksymoops 2.3.5 on i586 2.2.15.  Options used
     -v /home/tbm/linux-2.4.0test11mipsel (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -M (specified)
     -a mipsel

Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is /home/tbm/linux-2.4.0test11mipsel a valid vmlinux file?
Warning (merge_maps): no symbols in merged map
Unable to handle kernel paging request at virtual address 00000004, epc == 80059b7c, ra == 80059b34
$0 : 00000000 10002000 80720410 00000000 80720410 00000000 810884d4 10002000
$8 : 00000000 00000000 00000000 00000000 00bd0000 fffffff7 ffffffff 81097180
$16: 00010f00 81094000 00000000 80048000 30464354 a0002f88 fffffff4 00010f00
$24: 00000001 0000000a                   80720000 80720f58 80721090 80059b34
epc  : 80059b7c
Using defaults from ksymoops -t elf32-i386
Status: 10002004
Cause : 30000408
Process  (pid: 0, stackpage=80720000)
Stack: 8005f564 00002400 000000c0 8005f228 801c6c6c 800f191c 00000000 00000000
       00000000 80720f7c 80720f7c 00000023 00000000 00000000 00000000 80720f7c
       80720f7c 00000023 00010f00 00010000 00000000 80048000 30464354 a0002f88
       00000000 001200d2 40208a0a 8004e168 00000000 00000020 80720fe0 00000000
       8004b42c 0000261c 00010f00 00000000 80721090 0000261c 00bd0000 fffffff7
       00000000 ...
Call Trace: [<8005f564>] [<8005f228>] [<800f191c>] [<80048000>] [<8004e168>] [<8004b42c>]
Code: 24630010  8e2501d4  8e230218 <8ca20004> 00000000  0043102b  10400431  2416fff5  40046000 
Error (Oops_bfd_perror): scan_arch for specified architecture Success

>>RA;  80059b34 No symbols available
>>EIP; 80059b7c No symbols available   <=====
Trace; 8005f564 No symbols available
Trace; 8005f228 No symbols available
Trace; 800f191c No symbols available
Trace; 80048000 No symbols available
Trace; 8004e168 No symbols available
Trace; 8004b42c No symbols available

2 warnings and 2 errors issued.  Results may not be reliable.

(This kernel is from http://www.fs.tum.de/~bunk/linux-2.4.0test11mipsel)

-- 
Martin Michlmayr
tbm@cyrius.com
