Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 17:54:21 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:13505
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224827AbTCZRyT> convert rfc822-to-8bit; Wed, 26 Mar 2003 17:54:19 +0000
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18yF6Q-0003cK-00
	for linux-mips@linux-mips.org; Wed, 26 Mar 2003 18:54:18 +0100
Received: from [62.109.119.183] (helo=192.168.202.41)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 18yF6Q-00089P-00
	for linux-mips@linux-mips.org; Wed, 26 Mar 2003 18:54:18 +0100
From: Bruno Randolf <br1@4g-systems.de>
Organization: 4G Mobile Systeme
To: linux-mips@linux-mips.org
Subject: au1500 mm problems?
Date: Wed, 26 Mar 2003 18:54:01 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303261854.10478.br1@4g-systems.de>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello!

i am regularily getting the following 2 types of kernel oopses on my au1500 
based board (mycable XXS), whenever i try to do something more demanding to 
the CPU (like compiling):

Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn,
line 481:

Unable to handle kernel paging request at virtual address 02000014, epc ==
80137554, ra == 4
Oops in fault.c::do_page_fault, line 205:

do you have any suggestions for me what could be causes for these? 

i have 64MB ram and my root filesystem mounted over NFS. branch linux_2_4 a 
few weeks ago. i can provide you with the complete oops if that would help.

btw: i cant use petes 36bit patch on the latest linux_2_4 branch anymore - it 
always gives me a "Reserved instruction in kernel code in traps.c::do_ri, 
line 654:" when i boot the kernel.

thanks,
bruno







-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gelCfg2jtUL97G4RAqdAAJ9EHSZ4vaCMAOPTSM0uekiRk2aDVQCeIoZs
WP4h2LkaKgDc4s21w5qM3NY=
=gwBM
-----END PGP SIGNATURE-----
