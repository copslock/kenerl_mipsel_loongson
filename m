Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2005 13:33:29 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.176]:27596
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225841AbVEKMdN>; Wed, 11 May 2005 13:33:13 +0100
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DVqOk-0007FV-00
	for linux-mips@linux-mips.org; Wed, 11 May 2005 14:33:10 +0200
Received: from [213.39.254.68] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DVqOk-00033D-00
	for linux-mips@linux-mips.org; Wed, 11 May 2005 14:33:10 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: CompactFlash/ATA on Au1100 misses interrupts
Date:	Wed, 11 May 2005 14:34:39 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505111434.39601.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

I'm trying to glue together my board (TTP1100, almost like DB1100) with a 
compact flash card and I'm already pretty far, but the interrupt-controlled 
ATA driver still doesn't work. 

The problem seems to be that the CF generates such short pulses on the IREQ 
line that they are simply missed. However, some facts first:
1. If I configure the connected GPIO for edge sensitivity (rising or falling 
doesn't matter) and issue an ATA command to the CF, I see the interrupt.
2. If I configure for level sensitivity and issue ATA commands, I see no 
interrupts. Using a logic analyzer, I saw that the generated impulses are 
~600ns long, which is not too short usually.
3. If I remove the CF card, configure for level sensitivity and pull the pin 
to ground, I see an interrupt.

I'm currently a bit out of ideas what to try, if any of you have another idea 
where I could look I'm open for it.

Another thing I was wondering about is the boot message that it's "Assuming 
50MHz system bus speed". Can/should I specify this differently?

thanks

Uli
