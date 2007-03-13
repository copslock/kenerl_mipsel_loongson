Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 14:24:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:36046 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022301AbXCMOYX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 14:24:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2DEMVei001344
	for <linux-mips@linux-mips.org>; Tue, 13 Mar 2007 14:22:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2DEMUkx001343
	for linux-mips@linux-mips.org; Tue, 13 Mar 2007 14:22:30 GMT
Date:	Tue, 13 Mar 2007 14:22:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Oscar awards
Message-ID: <20070313142230.GA692@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The golden award for the most warnings in the code goes to atlas_defconfig
which build with 73 warnings.  Actually not so terrible but the the SAA9730
ethernet driver is a horrible piece of code which in turn largely due to
the SAA9730 being one of most broken pieces of silicon ever marketed.

The silver medal goes to db1200_defconfig with 64 warnings and bronce
goes to sb1250-swarm_defconfig with just 48 points ;-)

So with the Viper 2 (non-)support gone all but one of the 46 MIPS defconfig
files actually build with the one exception being excite_defconfig:

  CC      arch/mips/basler/excite/excite_prom.o
  CC      arch/mips/basler/excite/excite_setup.o
arch/mips/basler/excite/excite_setup.c: In function 'excite_init_console':
arch/mips/basler/excite/excite_setup.c:115: error: 'UPIO_RM9000' undeclared (first use in this function)
arch/mips/basler/excite/excite_setup.c:115: error: (Each undeclared identifier is reported only once
arch/mips/basler/excite/excite_setup.c:115: error: for each function it appears in.)
arch/mips/basler/excite/excite_setup.c:116: error: 'PORT_RM9000' undeclared (first use in this function)
make[1]: *** [arch/mips/basler/excite/excite_setup.o] Error 1
make: *** [arch/mips/basler/excite] Error 2
make: Leaving directory `/var/tmp/kernel-orig'

  Ralf
