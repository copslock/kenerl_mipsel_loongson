Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 09:28:55 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:20171
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225507AbVDAI2k>; Fri, 1 Apr 2005 09:28:40 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML25U-1DHHVF2lXV-0002RA; Fri, 01 Apr 2005 10:27:41 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: conflicting declaration of prom_getcmdline()
Date:	Fri, 1 Apr 2005 10:28:04 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504011028.04244.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Greetings!

I just stumbled over arch/mips/au1000/common/prom.c, which contains a function 
defined like this:
  char* prom_getcmdline(void);
  EXPORT_SYMBOL(prom_getcmdline);
while there are implementations that define the function as
  char* __init prom_getcmdline();
Further, there are several declarations throughout sourcefiles and in 
include/asm-mips/mips-boards/prom.h and include/asm-mips/sgialib.h. Just grep 
for it and you'll see the mess.

If anyone tells me which one is right and cares to explain why I hereby 
volunteer to create a patch. ;)

Apart from that, some code in arch/mips/au1000/common/prom.c is unnecessarily 
complicated.

cheers

Uli
