Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2005 07:36:48 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.177]:24803
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225428AbVCWHgc>; Wed, 23 Mar 2005 07:36:32 +0000
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DE0Pc-00083y-00
	for linux-mips@linux-mips.org; Wed, 23 Mar 2005 08:36:20 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DE0Pc-0006kA-00
	for linux-mips@linux-mips.org; Wed, 23 Mar 2005 08:36:20 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Off by two error in au1000/common/setup.c?
Date:	Wed, 23 Mar 2005 08:36:29 +0100
User-Agent: KMail/1.7.1
References: <200503221531.46186.eckhardt@satorlaser.com> <424059E2.201@embeddedalley.com>
In-Reply-To: <424059E2.201@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503230836.29948.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> > // in au1000.h
> > #define Au1500_PCI_MEM_START      0x440000000ULL
> > #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
> >
> > // in setup.c
> > start = (u32)Au1500_PCI_MEM_START;
> > end = (u32)Au1500_PCI_MEM_END;
> > /* check for pci memory window */
> > if ((phys_addr >= start) && ((phys_addr + size) < end)) {
> >  return (phys_addr - start) + Au1500_PCI_MEM_START;
> > }
> >
> >For the (unlikely?) case that I want to use a size of 0x0 1000 0000,
> >'phys_addr+size == end+1'. IOW I need 'phys_addr+size-1' to get the last
> >address and use '<= end' to compare with the last valid address in the
> > range.
> >
> >Right?
>
> But the a size of 0x0 1000 0001 would pass the test since phys_addr +
> 1000 0001 - 1 <= end.

Really?
0x4 4000 0000 + 0x0 1000 0001 - 1 = 0x4 5000 0000 > 0x4 ffff ffff
;)

> How about if I just make MEM_END 0x450000000 and the check " <= end" ?

I'm not sure, it's a question of consistency: that solution would be the 
one-past-the-end address, which I'm fine with (being used to C++'s STL-style 
iterators..). The only problem I see arises if that one-past-the-end actually 
wraps around.
Other than that, what is used generally, first and last valid address or first 
valid address and first not valid address? Or first valid address and size?

Uli
