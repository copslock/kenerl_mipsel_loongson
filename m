Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2005 23:49:00 +0000 (GMT)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:13485 "EHLO
	smtp.voda.cz") by linux-mips.org with ESMTP id <S8224923AbVBOXso>;
	Tue, 15 Feb 2005 23:48:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.voda.cz (Postfix) with ESMTP id 5C68311890
	for <linux-mips@linux-mips.org>; Wed, 16 Feb 2005 00:48:38 +0100 (CET)
Received: from smtp.voda.cz ([127.0.0.1])
 by localhost (gw [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16776-09 for <linux-mips@linux-mips.org>;
 Wed, 16 Feb 2005 00:48:32 +0100 (CET)
Received: from [10.1.1.77] (unknown [213.151.77.162])
	by smtp.voda.cz (Postfix) with ESMTP id 375DCFC65
	for <linux-mips@linux-mips.org>; Wed, 16 Feb 2005 00:48:32 +0100 (CET)
Message-ID: <42128A4F.20107@voda.cz>
Date:	Wed, 16 Feb 2005 00:48:31 +0100
From:	=?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: module segfault problem ADM5120
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at voda.cz
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Hello,

I am currently experiencing trouble trying to load the madwifi drivers 
on my MIPS (ADM5120), everytime I end up with the Oops pasted below. 
Does that provide anyone a clue what may be wrong ? I've tried changing 
the modules around, but this is what I get...

       Thanks, Tom

Unable to handle kernel paging request at virtual address 00000000, epc 
== 800fb6fc, ra == 80013fa8
Oops in fault.c:do_page_fault, line 205:
$0 : 00000000 10008400 1003a050 fffffff2 00000000 1003a000 0000000a 7fff5bb0
$8 : ffffffff 80a46000 80014180 00000010 00000034 00000000 00000100 00000018
$16: c0000edc 00000050 1003a050 1003a000 7fff5bb0 000003b0 00000000 c0000000
$24: 00000000 004884f0                   80184000 80185ec8 100059cc 80013fa8
Hi : 00000000
Lo : 00000001
epc  : 800fb6fc    Not tainted
<4>Status: 10008403
<4>Cause : 10800008
Status: 10008403
<4>Cause : 10800008
Cause : 10800008
Process insmod (pid: 33, stackpage=80184000)
Stack: 100059cc 800307f4 801ef440 00000000 ffffffea c0000000 80a46000 
1003a000
<4>             00000400 00000004 7fff5bb0 00000001 8001431c 8002382c 
00000000 802592e0
<4>             00013a00 00000000 1003a000 00000004 1001fc00 1001efe0 
00000001 00000000
<4>             7fff5bb0 80008ec4 10005a0c 100059dc 100059ec 10005ffc 
7fff5bb0 00000000
<4>             00000000 10018a04 0000105b 00000400 1001fc00 00000004 
1003a000 00000400
<4>             00000021 ...
<4>Call Trace:Call Trace: [<800307f4>] [<c0000000>] [<8001431c>] 
[<8002382c>] [<80008ec4>]
Warning (Oops_read): Code line not seen, dumping what data is available


 >>RA;  80013fa8 <qm_symbols+11c/228>
 >>$1; 10008400 <_binary_ramdisk_gz_size+ff579b6/7ff515b6>
 >>$2; 1003a050 <_binary_ramdisk_gz_size+ff89606/7ff515b6>
 >>$5; 1003a000 <_binary_ramdisk_gz_size+ff895b6/7ff515b6>
 >>$7; 7fff5bb0 <_binary_ramdisk_gz_size+7ff45166/7ff515b6>
 >>$10; 80014180 <sys_query_module+0/1f8>
 >>$18; 1003a050 <_binary_ramdisk_gz_size+ff89606/7ff515b6>
 >>$19; 1003a000 <_binary_ramdisk_gz_size+ff895b6/7ff515b6>
 >>$20; 7fff5bb0 <_binary_ramdisk_gz_size+7ff45166/7ff515b6>
 >>$25; 004884f0 <_binary_ramdisk_gz_size+3d7aa6/7ff515b6>
 >>$28; 80184000 <_binary_ramdisk_gz_start+45000/b0a4a>
 >>$29; 80185ec8 <_binary_ramdisk_gz_start+46ec8/b0a4a>
 >>$30; 100059cc <_binary_ramdisk_gz_size+ff54f82/7ff515b6>
 >>$31; 80013fa8 <qm_symbols+11c/228>

 >>PC;  800fb6fc <strlen+0/24>   <=====

-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
