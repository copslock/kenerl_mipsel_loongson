Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 14:31:56 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.190]:9200 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226817AbVCVObl>; Tue, 22 Mar 2005 14:31:41 +0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DDkPz-0001Oz-00
	for linux-mips@linux-mips.org; Tue, 22 Mar 2005 15:31:39 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DDkPy-0000CM-00
	for linux-mips@linux-mips.org; Tue, 22 Mar 2005 15:31:38 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Off by two error in au1000/common/setup.c?
Date:	Tue, 22 Mar 2005 15:31:46 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221531.46186.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

Could someone take a look at these lines from fixup_bigphys_addr():

 // in au1000.h
 #define Au1500_PCI_MEM_START      0x440000000ULL
 #define Au1500_PCI_MEM_END        0x44FFFFFFFULL

 // in setup.c
 start = (u32)Au1500_PCI_MEM_START;
 end = (u32)Au1500_PCI_MEM_END;
 /* check for pci memory window */
 if ((phys_addr >= start) && ((phys_addr + size) < end)) {
  return (phys_addr - start) + Au1500_PCI_MEM_START;
 }

For the (unlikely?) case that I want to use a size of 0x0 1000 0000, 
'phys_addr+size == end+1'. IOW I need 'phys_addr+size-1' to get the last 
address and use '<= end' to compare with the last valid address in the range.

Right?

Uli
