Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 15:34:15 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:26818
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224914AbVDFOeA>; Wed, 6 Apr 2005 15:34:00 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1DJBbS31yA-0003YW; Wed, 06 Apr 2005 16:33:58 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Au1100 FB driver uplift for 2.6
Date:	Wed, 6 Apr 2005 16:34:29 +0200
User-Agent: KMail/1.7.2
References: <200504041717.29098.eckhardt@satorlaser.com> <de11cd376cdc88e9c292ae7e204e2de9@embeddededge.com> <200504061131.38457.eckhardt@satorlaser.com>
In-Reply-To: <200504061131.38457.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061634.29993.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Dan Malek wrote:
> > On Apr 4, 2005, at 11:17 AM, Ulrich Eckhardt wrote:
> > > Am I on the wrong way or should I just reimplement it and send a patch?
> >
> > If you an test it, do it and send a patch.
>
> There will be two patches, this one doesn't reimplement the mentioned
> feature but fixes a few other bugs.

I'm currently preparing the second part, but I stumbled across something 
puzzling: the number and configuration of the displays differ a lot to 
previous versions. Here's a list of displays and their mode_toyclksrc values:

Old driver:
Sharp_320x240_16      (1 << SYS_CS_ML_BIT) | SYS_CS_DL | SYS_CS_CL)
Generic_640x480_16    (1 << SYS_CS_ML_BIT) | SYS_CS_DL
PrimeView_640x480_16  (1 << SYS_CS_ML_BIT) | SYS_CS_DL
NEON_800x600_16       (1 << SYS_CS_ML_BIT) | SYS_CS_DL
NEON_640x480_16       (1 << SYS_CS_ML_BIT) | SYS_CS_DL

New driver:
CRT_800x600_16        (1 << SYS_CS_ML_BIT)
WWPC LCD              (1 << SYS_CS_ML_BIT)
Sharp_LQ038Q5DR01      (1 << SYS_CS_ML_BIT)
Hitachi_SP14Qxxx      (1 << SYS_CS_ML_BIT)
TFT_640x480_16        (1 << SYS_CS_ML_BIT)
PrimeView_640x480_16  (1 << SYS_CS_ML_BIT)

Changed names:
Sharp_320x240_16    =   Sharp_LQ038Q5DR01
Generic_640x480_16  =   TFT_640x480_16
NEON_800x600_16         (~CRT_800x600_16)
NEON_640x480_16         (missing)

Notes:
- The SYS_CS_DL flag is only evaluated when the SYS_CS_CL flag is also set. 
IOW, setting the flag was useless except for the Sharp_320x240_16 panel in 
the old configuration.
- 'WWPC LCD' contains a space, meaning you can't possibly specify it on the 
kernel commandline - that's obviously a bug.
- The NEON_640x480_16 panel is missing. The other NEON also has no 100% 
equivalent, the CRT panel mostly matches though.
- The parameters for the Sharp display have effectively changed. I don't know 
if this was intentional and I don't have such a display for testing.
- I have an Hitachi SP14Q and a PrimeView PD104SL5 here for testing on a 
- In the old header was the comment that "The fb driver assumes that AUX PLL 
is at 48MHz." This can't be true, because the minimum multiplier is 8 and the 
external clock should be 12MHz, making this 96MHz.
- You can change some frequency for the LCD controller with the divider in 
SYS_CLKSRC and via the LCD_CLKCONTROL, is it possible that you can change one 
frequency and make up for it via another? 
In fact, I'm currently pretty puzzled, because it might be that the 
differences are rather in the board and not in the panels. Also, I fail to 
find where the AUX PLL is started (the default is off), which puzzles me even 
further...

regards,

Uli
