Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 16:00:45 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:25025
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224925AbVDFPA2>; Wed, 6 Apr 2005 16:00:28 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwtQ-1DJC0z2xxE-000150; Wed, 06 Apr 2005 17:00:21 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: When code and comments disagree...
Date:	Wed, 6 Apr 2005 17:00:53 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061700.53764.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

... both are probably wrong, as the saying goes. I stumbled across this line 
in arch/mips/au1000/common/reset.c:

   au_writel(0x00, 0xb1900100); /* sys_pininputen */

However, 0xb1900100 is SYS_TRIOUTCLR, while SYS_PININPUTEN is 0xb1900110... 
Which one is right now?

Also, does the switch statement in that file make sense at all? I mean is it 
possible to compile a kernel that runs on several Alchemy systems?

Uli
