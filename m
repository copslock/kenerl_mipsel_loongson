Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 15:52:33 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.190]:4093 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226049AbVDDOwI>; Mon, 4 Apr 2005 15:52:08 +0100
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DISvv-0007ey-00
	for linux-mips@linux-mips.org; Mon, 04 Apr 2005 16:52:07 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DISvu-0005J8-00
	for linux-mips@linux-mips.org; Mon, 04 Apr 2005 16:52:06 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: No PCI memory response
Date:	Mon, 4 Apr 2005 16:52:33 +0200
User-Agent: KMail/1.7.1
References: <000001c53924$db7c75e0$2000a8c0@gillpc>
In-Reply-To: <000001c53924$db7c75e0$2000a8c0@gillpc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504041652.33950.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Gill wrote:
> Can anyone help?  We're trying to talk to a RealTek RTL8139 device across
> the PCI bus, and, although linux can access configuration registers on the
> device, it does not access memory space correctly, and we are unable to
> read back any sensible values from the RTL8139 registers.
>
> We are using the latest 2.6 linux on an Alchemy DB1550 board.

Random reads, discarded data after writing? I had the same problem and solved 
it by simply configuring the static bus controller of my Au1100 properly (of 
which before I didn't even know it existed...).

hth

Uli
