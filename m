Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 13:59:36 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:31208
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225221AbVA1N7V>; Fri, 28 Jan 2005 13:59:21 +0000
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CuWeZ-00081i-00
	for linux-mips@linux-mips.org; Fri, 28 Jan 2005 14:59:15 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CuWeY-00010Q-00
	for linux-mips@linux-mips.org; Fri, 28 Jan 2005 14:59:14 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: bitrot in drivers/net/au1000_eth.c
Date:	Fri, 28 Jan 2005 15:01:17 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281501.19162.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

I've been debugging a problem in above mentioned file and found several cases 
of redundant, unused or even buggy code in the handling of the MII there. 
Also, there is a comment that suggests that I'm not the only one: 
 * FIXME
 * All of the PHY code really should be detached from the MAC
 * code.

An important point there is that much of the code is in fact not even specific 
to the au1x00 ethernet adapters. I found driver code for the MII I wanted to 
drive in sis900.c, and it looked almost similar to the code in au1x00.c. 
Simply adding the device/vendor IDs to a map and choosing the first of the 
drivers there got my ethernet running.

Now, question is how to proceed. There are basically three ways I would go:
1. Leave it like it is, because someone else is working on it. I'd just post a 
mini-patch that binds my device to an existing driver.
2. Remove the dead/unused parts from au1x00.c, try to restructure and document 
the code so it is easier to maintain in the future.
3. Split off the MII handling code or, better, reuse the facility already 
provided by drivers/net/mii.c. This would mean a significant rewrite of 
au1x00.c, including probably breaking things on the way.

Uli
