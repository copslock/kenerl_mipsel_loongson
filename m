Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 15:30:24 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.184]:45012
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225311AbVBVPaI>; Tue, 22 Feb 2005 15:30:08 +0000
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1D3bzD-0002yf-00
	for linux-mips@linux-mips.org; Tue, 22 Feb 2005 16:30:07 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1D3bzD-0002Lm-00
	for linux-mips@linux-mips.org; Tue, 22 Feb 2005 16:30:07 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
Date:	Tue, 22 Feb 2005 16:32:53 +0100
User-Agent: KMail/1.7.1
References: <1108962105.6611.24.camel@SillyPuddy.localdomain> <1109052412.20045.6.camel@SillyPuddy.localdomain> <421ADE76.5020905@embeddedalley.com>
In-Reply-To: <421ADE76.5020905@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502221632.53448.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> Here is a 2.6 patch that gets rid of all the Au1x mapping files and
> replaces them with a single file. 

Big step forward, this looks much cleaner and easier to maintain!

Just a few nits:

1. mymtd = do_map_probe("cfi_probe", &alchemy_map);

Doesn't this mean that the Alchemy flash driver depends on the CFI interface? 
I also see that CONFIG_MTD_CFI is not set in the configfiles for some boards.

2. If above do_map_probe() returns NULL, the ioremap()ed memory is leaked. 
Doesn't matter that much probably, but is trivial to fix.

 if (!mymtd)
 {
  iounmap( alchemy_map.virt);
  return -ENXIO;
 }

3. No need to cast the parameter to iounmap(), it should happily digest 
whatever ioremap() returns. If that gives warnings, something different is 
going wrong in between. ;)


I finally figured out that my board is based largely on db1100, but the 
on-board flash in particular isn't, it's just one 16MBit chip on board. Also, 
the access width is 16 bit and not 32. Seems like I'm going to introduce 
another board type TTP1100...

One more question on the partition layout: is this a real hardware property or 
is this just convention? Can't I configure the flash as I want to?


I'm making progress, thank you all!

Uli
