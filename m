Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 12:20:18 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.201]:39960 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133443AbWAPMTz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 12:19:55 +0000
Received: by zproxy.gmail.com with SMTP id l8so1101018nzf
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2006 04:23:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=CzCmpjC7U17TekwL70HqBBvVcj8+1QGL1iCtDPBNzixDoTYrA7Z3cEQnMJfcV4KgvU1gzUeH22NGEBERellrm5XfKFwpq+pha2E3/l/wggKKkaV0pAVGRBZhy7snLTkGC2i92YH3gc1Yk0g/uzycVGIvdr9uUlZTfxct2fnNvJ0=
Received: by 10.36.101.3 with SMTP id y3mr4818948nzb;
        Mon, 16 Jan 2006 04:23:26 -0800 (PST)
Received: by 10.36.49.4 with HTTP; Mon, 16 Jan 2006 04:23:26 -0800 (PST)
Message-ID: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
Date:	Mon, 16 Jan 2006 17:53:26 +0530
From:	Kishore K <hellokishore@gmail.com>
To:	linux-mips@linux-mips.org
Subject: gcc -3.4.4 and linux-2.4.32
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5435_18690732.1137414206474"
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_5435_18690732.1137414206474
Content-Type: multipart/alternative; 
	boundary="----=_Part_5436_32105947.1137414206474"

------=_Part_5436_32105947.1137414206474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi
When 2.4.32 kernel (from linux-mips) is compiled with the tool chain based
on gcc 3.4.4 and binutils 2.16.1, the kernel crashes on malta board. The
crash file is enclosed along with the mail. If the same kernel is compiled
with the tool chain based on gcc 3.3.6, no problem is observed.

May I know, whether it is because of the changes in ABI in gcc 3.4. If so,
has any one got the patch to make 2.4.x kernels work with gcc 3.4 compilers=
?
From the changelog, I can infer that, some changes have been done in
2.4.28kernel to work with gcc
3.4 for i386. If so, has the same thing been done for MIPS as well.

TIA,
--kishore

------=_Part_5436_32105947.1137414206474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi<br>
When 2.4.32 kernel (from linux-mips) is compiled with the tool chain
based on gcc 3.4.4 and binutils 2.16.1, the kernel crashes on malta
board. The crash file is enclosed along with the mail. If the same
kernel is compiled with the tool chain based on gcc 3.3.6, no problem
is observed.<br>
<br>
May I know, whether it is because of the changes in ABI in gcc 3.4. If
so, has any one got the patch to make 2.4.x kernels work with gcc 3.4
compilers? From the changelog, I can infer that, some changes have been
done in 2.4.28 kernel to work with gcc 3.4 for i386. If so, has the
same thing been done for MIPS as well.<br>
<br>
TIA,<br>
--kishore<br>
<br>

------=_Part_5436_32105947.1137414206474--

------=_Part_5435_18690732.1137414206474
Content-Type: application/octet-stream; name=crash
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="crash"

Start = 0x802c2040, range = (0x80100000,0x802fafff), format = SREC
                                                                                                                             
LINUX started...
CPU revision is: 00018005
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Linux version 2.4.32 (inca@localhost.localdomain) (gcc version 3.4.4) #2 Mon Jan 16 17:24:34 IST 2006
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 000ef000 @ 00001000 (ROM data)
 memory: 00010000 @ 000f0000 (reserved)
 memory: 0022a000 @ 00100000 (reserved)
 memory: 03cd6000 @ 0032a000 (usable)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=10.1.1.100:10.1.1.99:10.1.1.99:255.0.0.0:malta:eth0:off root=/dev/nfs nfsroot=/root/kishore/r1-alpha0calculating r4koff... 0009899a(625050)
CPU frequency 125.01 MHz
Using 62.505 MHz high precision timer.
Calibrating delay loop... 124.51 BogoMIPS
Memory: 61584k/62296k available (1787k kernel code, 712k reserved, 112k data, 108k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Unable to handle kernel paging request at virtual address 00000014, epc == 8014579c, ra == 801457a4
Oops in fault.c::do_page_fault, line 206:
$0 : 00000000 1000fc00 00000000 810fb0a0 802ec184 810fb120 00000000 810fb000
$8 : 00000030 80285240 00000000 000010fb 802ebb80 00000000 1000fc01 80300000
$16: 80100784 810fb0a0 00010f00 810fb120 ffffffe9 00000001 80300000 00000000
$24: 0000002c ba2e8ba3                   802c0000 802c1e30 802dc300 801457a4
Hi : 00000000
Lo : 00000080
epc   : 8014579c    Not tainted
Status: 1000fc03
Cause : 90800008
PrId  : 00018005
Process swapper (pid: 0, stackpage=802c0000)
Stack:    80300000 0000059c 80300000 80300000 80300000 80300000 000f41ff
 80317248 802feb7c 80310000 0000059c 802ea920 802ff10c 00000060 00000000
 ba2e8ba3 80100784 00000000 00010f00 00000000 802dc300 00000001 80290000
 00000000 802dc300 8010726c 802c1ea8 801ac834 00000000 8032b428 000001f0
 8032b420 80107d00 00000001 00010f00 00000000 802c1f68 ffffffff 000001f0
 00000578 ...
Call Trace:   [<80100784>] [<80290000>] [<8010726c>] [<801ac834>] [<80107d00>]
 [<8015fb60>] [<80160118>] [<80100784>] [<80290000>] [<8018c998>] [<80111348>]
 [<801601e0>] [<80102780>] [<80111348>]
                                                                                                                             
Code: 00409821  3c168030  8ec26320 <0c055173> 8c440014  104000b0  00408021  0c0515a0  00402021
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing



------=_Part_5435_18690732.1137414206474--
