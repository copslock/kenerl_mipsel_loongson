Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 11:46:55 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:38794 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225839AbTLWLqy>;
	Tue, 23 Dec 2003 11:46:54 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBNBkhQF024198;
	Tue, 23 Dec 2003 12:46:44 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id MAA05473;
	Tue, 23 Dec 2003 12:46:44 +0100 (MET)
Date: Tue, 23 Dec 2003 12:46:44 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: macro@ds2.pg.gda.pl
Cc: linux-mips@linux-mips.org
Subject: Support for newer gcc/gas options
Message-ID: <20031223114644.GA5458@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

Hi,

  I just upgraded to the arch/mips/Makefile which adds support for newer
  gcc/gas options. I now get the warning

  "cc1: warning: The -march option is incompatible to -mipsN and therefore
+ignored."

  when compiling. I have the CONFIG_CPU_VR41XX option set, which sets
  the c-flags to:

  "-I /home/dimitri/work/linux/include/asm/gcc -G 0 -mno-abicalls
  -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=r4100 -mips3
  -Wa,-32 -Wa,-march=r4100 -Wa,-mips3 -Wa,--trap"

  I suppose that for the newer gcc versions only -march= should be
  set (I'm using gcc-3.2.2) ?

  Dimitri

-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
