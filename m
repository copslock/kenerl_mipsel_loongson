Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2004 10:19:40 +0100 (BST)
Received: from smail.alcatel.fr ([IPv6:::ffff:62.23.212.165]:45513 "EHLO
	smail.alcatel.fr") by linux-mips.org with ESMTP id <S8224772AbUHBJTg>;
	Mon, 2 Aug 2004 10:19:36 +0100
Received: from bemail03.netfr.alcatel.fr (bemail03.netfr.alcatel.fr [155.132.251.37])
	by smail.alcatel.fr (ALCANET/NETFR) with ESMTP id i729JPZv002931
	for <linux-mips@linux-mips.org>; Mon, 2 Aug 2004 11:19:31 +0200
Received: from alcatel.be ([172.31.202.2])
          by bemail03.netfr.alcatel.fr (Lotus Domino Release 5.0.11)
          with ESMTP id 2004080211192669:1443 ;
          Mon, 2 Aug 2004 11:19:26 +0200 
Message-ID: <410E071F.4060907@alcatel.be>
Date: Mon, 02 Aug 2004 11:19:27 +0200
From: willem.acke@alcatel.be
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: RM9000x2 TLB load exception
X-MIMETrack: Itemize by SMTP Server on BEMAIL03/BE/ALCATEL(Release 5.0.11  |July 24, 2002) at
 08/02/2004 11:19:26,
	Serialize by Router on BEMAIL03/BE/ALCATEL(Release 5.0.11  |July 24, 2002) at
 08/02/2004 11:19:30,
	Serialize complete at 08/02/2004 11:19:30
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-Alcanet-MTA-scanned-and-authorized: yes
Return-Path: <willem.acke@alcatel.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willem.acke@alcatel.be
Precedence: bulk
X-list: linux-mips

All,

I'm trying to port the mips-kernel to a RM9000x2 based custom board.
The kernel file (mips 32) is loaded using VxWorks boot loader.
I got the to the point where the kernel starts loading, but exits with a 
'TLB load exception'.
After putting in a number of printks, it seems that it fails on 
'flush_icache_range' in arch/mips/mm/pg-r4k.c -> build_clear_page.
Since I'm a newbie to this, any pointers to how to tackle this problem 
would be appreciated.

Exception:
Tlb Load Exception
Exception Program Counter: 0x00000000
Status Register: 0x3404ff00
Cause Register: 0x01100008
Access Address : 0x00000000
Task: 0x83e2c760 ""

$0    =                0   t0    =          3ffffff   s0    =         
24810e00
at    =         3404ff00   t1    = fffffffffc1fffff   s1    = 
ffffffffac800000
v0    =                0   t2    = ffffffffffff0000   s2    = 
ffffffffac800004
v1    =                1   t3    =           800000   s3    = 
ffffffffcc9e0200
a0    = ffffffff801a6f30   t4    = ffffffffac000000   s4    = 
ffffffffac800008
a1    = ffffffff801a6f94   t5    =            40000   s5    = 
ffffffffac80000c
a2    = ffffffff801508e8   t6    =             7fff   s6    
=                0
a3    = ffffffff80173e84   t7    =         24000000   s7    =         
24840020
s8    = ffffffff83e2c268   k0    =                0
gp    = ffffffff80172000   k1    =                0   t8    
=                a
ra    = ffffffff80179254   sp    = ffffffff80173e80   t9    = 
ffffffffac80fff8
divlo =             1000   divhi =                0   sr    = 3404ff00
pc    =        0

Thanks in advance,

Wim Acke
