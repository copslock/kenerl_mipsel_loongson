Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 11:20:33 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.235]:21312 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022742AbXFNKTo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 11:19:44 +0100
Received: by hu-out-0506.google.com with SMTP id 31so87380huc
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:subject:date:message-id:x-mailer:from;
        b=qXwhsIWYAll4biAV1CLqwIt+F4M5eViJw8VfNorHrjQ7byrYVWMHegWe7xvqiyJTfckiEXJzZNek+M+kQyr05pq8Rh6OoAG0OT0bgxk9vcHSdcRBlooVy9m8wCjKi7psQKrTdXChjAL0c5K2YFv+fOVw6BEuBWB2SGkrKgdBkgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:date:message-id:x-mailer:from;
        b=Z4BnGWetEJyX1Tt7rSC9OI9fC0N4jtOqtpk5INr92IMHHFZlVVB7VwfFJVU94SMZw6ZX7LmrHC0wU+nANbMo2O1kDZlQmvP4UEOKR24Pm6AT7x4Z1GTwqrCtDCiX2xNeGnS4/2Cp7+/Mrm8DPjE+0cOoPZwVvlsR5NTNn71+ArE=
Received: by 10.67.22.12 with SMTP id z12mr1951076ugi.1181816383342;
        Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z37sm3863704ikz.2007.06.14.03.19.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2007 03:19:42 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 1375E23F76E; Thu, 14 Jun 2007 12:20:02 +0200 (CEST)
To:	linux-mips@linux-mips.org
Subject: [RFD] Time rework [take #2]
Date:	Thu, 14 Jun 2007 12:19:56 +0200
Message-Id: <11818164011355-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

OK, I don't get any feedbacks since my original post but I had time to
make some changes...

It's now based on "linux-2.6.22-rc4-357-g7518784", with a part of Ralf's
linux-time patches.

I'd like to port some 'interesting' platforms as a proof of
concept. Could anybody name them ? I'd like to port a platform that
uses the 'hpt' as clock source and timer. A second one that uses the
hpt only as a timer, and a third one that doesn't uses it at all. A
small description can help too...

Thanks

		Franck
---
 arch/mips/Kconfig                         |   13 +
 arch/mips/au1000/common/irq.c             |    3 +-
 arch/mips/au1000/common/setup.c           |    2 -
 arch/mips/au1000/common/time.c            |   44 ---
 arch/mips/basler/excite/excite_setup.c    |    5 +-
 arch/mips/ddb5xxx/common/rtc_ds1386.c     |   10 +-
 arch/mips/ddb5xxx/ddb5477/setup.c         |    4 +-
 arch/mips/dec/setup.c                     |    4 -
 arch/mips/dec/time.c                      |   12 +-
 arch/mips/emma2rh/markeins/setup.c        |    4 +-
 arch/mips/gt64120/wrppmc/setup.c          |    4 -
 arch/mips/gt64120/wrppmc/time.c           |    2 +-
 arch/mips/jmr3927/rbhma3100/setup.c       |    4 +-
 arch/mips/kernel/Makefile                 |    2 +
 arch/mips/kernel/hpt.c                    |  294 ++++++++++++++++++
 arch/mips/kernel/process.c                |    2 +
 arch/mips/kernel/smp.c                    |    1 +
 arch/mips/kernel/smtc.c                   |    2 +-
 arch/mips/kernel/time.c                   |  468 ++--------------------------
 arch/mips/lasat/ds1603.c                  |    6 +-
 arch/mips/lasat/ds1603.h                  |    2 -
 arch/mips/lasat/setup.c                   |    6 +-
 arch/mips/lasat/sysctl.c                  |   59 ----
 arch/mips/lib/Makefile                    |    2 +-
 arch/mips/lib/time.c                      |   52 ++++
 arch/mips/mips-boards/atlas/atlas_setup.c |    5 -
 arch/mips/mips-boards/generic/time.c      |  101 +------
 arch/mips/mips-boards/malta/malta_setup.c |    4 -
 arch/mips/mips-boards/sead/sead_setup.c   |    3 -
 arch/mips/mips-boards/sim/sim_setup.c     |    3 -
 arch/mips/mips-boards/sim/sim_time.c      |   72 +-----
 arch/mips/momentum/ocelot_3/setup.c       |   12 +-
 arch/mips/momentum/ocelot_c/setup.c       |   15 +-
 arch/mips/philips/pnx8550/common/setup.c  |    3 -
 arch/mips/philips/pnx8550/common/time.c   |    7 +-
 arch/mips/pmc-sierra/yosemite/setup.c     |   18 +-
 arch/mips/sgi-ip22/ip22-int.c             |    3 +-
 arch/mips/sgi-ip22/ip22-setup.c           |    2 -
 arch/mips/sgi-ip22/ip22-time.c            |   25 +--
 arch/mips/sgi-ip27/ip27-init.c            |    3 -
 arch/mips/sgi-ip27/ip27-timer.c           |   24 +--
 arch/mips/sgi-ip32/ip32-setup.c           |   12 +-
 arch/mips/sibyte/bcm1480/time.c           |   13 +-
 arch/mips/sibyte/sb1250/time.c            |   13 +-
 arch/mips/sibyte/swarm/setup.c            |   48 +++-
 arch/mips/sibyte/swarm/time.c             |  244 ---------------
 arch/mips/sni/a20r.c                      |    1 -
 arch/mips/sni/ds1216.c                    |    4 +-
 arch/mips/sni/pcimt.c                     |    3 -
 arch/mips/sni/pcit.c                      |    3 -
 arch/mips/sni/rm200.c                     |    2 -
 arch/mips/sni/time.c                      |    2 +-
 arch/mips/tx4927/common/tx4927_setup.c    |    9 +-
 arch/mips/tx4938/common/rtc_rx5c348.c     |   10 +-
 arch/mips/tx4938/common/setup.c           |    9 -
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |    4 +-
 arch/mips/vr41xx/common/init.c            |    8 +-
 include/asm-mips/hpt.h                    |   16 +
 include/asm-mips/rtc.h                    |    6 +-
 include/asm-mips/time.h                   |   51 +---
 60 files changed, 516 insertions(+), 1249 deletions(-)
 create mode 100644 arch/mips/kernel/hpt.c
 create mode 100644 arch/mips/lib/time.c
 delete mode 100644 arch/mips/sibyte/swarm/time.c
 create mode 100644 include/asm-mips/hpt.h
