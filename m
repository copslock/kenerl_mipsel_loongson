Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 16:01:16 +0000 (GMT)
Received: from web38810.mail.mud.yahoo.com ([209.191.125.101]:52654 "HELO
	web38810.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28577473AbYCUQBO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 16:01:14 +0000
Received: (qmail 92359 invoked by uid 60001); 21 Mar 2008 16:00:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ry3zeCwfTyvu1WL+CLM07sOhFdfQrvcR6SF34NSP27XCHaiDYSKANCd+V9HALSZLT/HOmD6v3VRh3hRb55luSvPbkQTVu6shEaJQPKNPdZNvEr636/DQ+rujXh+5pfzC2r3QyW0RoN4e8KYjJxuRHONt/wPlFmgW/tuPMZhqcTM=;
X-YMail-OSG: 45DGeD8VM1lA_zSuzCBvUHobPt.7j6n9Wz6VZbSFZyGggDvggU7.3ODfVc4Sk.bKqvV1.eLjj8TgZve4iF55vpSD6xTBZVkVTstfzc9c2wiONQPn5Z2CtINeR69Vzw--
Received: from [68.236.82.170] by web38810.mail.mud.yahoo.com via HTTP; Fri, 21 Mar 2008 09:00:52 PDT
Date:	Fri, 21 Mar 2008 09:00:52 -0700 (PDT)
From:	Larry Stefani <lstefani@yahoo.com>
Subject: Extraneous line in interrupt.h in 2.6.16.60 kernel?
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <582735.81620.qm@web38810.mail.mud.yahoo.com>
Return-Path: <lstefani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstefani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Back in 2.6.16.29, there were a lot changes made to
support MT_SMTC.  Among them were changes to the
include/asm-mips/interrupt.h:

__asm__ (
  " .macro  local_irq_enable        \n"
  " .set  push            \n"
  " .set  reorder           \n"
  " .set  noat            \n"
#ifdef CONFIG_CPU_MIPSR2
  " .set  mips32r2          \n"
#ifdef CONFIG_MIPS_MT_SMTC
  "mfc0 $1, $2, 1 # SMTC - clear TCStatus.IXMT    \n"
  "ori  $1, 0x400           \n"
  "xori $1, 0x400           \n"
  "mtc0 $1, $2, 1           \n"
#else
  " .set  mips32r2          \n"
  " ei              \n"
  " .set  mips0           \n"
#endif
#else
  " mfc0  $1,$12            \n"
  " ori $1,0x1f           \n"
  " xori  $1,0x1e           \n"
  " mtc0  $1,$12            \n"
#endif
  " irq_enable_hazard         \n"
  " .set  pop           \n"
  " .endm");


Am I missing something, or is the second ".set 
mips32r2  \n" (line 51) redundant?

Thanks,
Larry Stefani
lstefani@yahoo.com


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
