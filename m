Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 08:13:30 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:37099
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224905AbVDFHNO>; Wed, 6 Apr 2005 08:13:14 +0100
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DJ4iu-0006Oq-00
	for linux-mips@linux-mips.org; Wed, 06 Apr 2005 09:13:12 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DJ4iu-0002o8-00
	for linux-mips@linux-mips.org; Wed, 06 Apr 2005 09:13:12 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Porting to new board [was: Re: Au1100 FB driver uplift for 2.6]
Date:	Wed, 6 Apr 2005 09:13:43 +0200
User-Agent: KMail/1.7.2
References: <200504041717.29098.eckhardt@satorlaser.com> <de11cd376cdc88e9c292ae7e204e2de9@embeddededge.com>
In-Reply-To: <de11cd376cdc88e9c292ae7e204e2de9@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504060913.43780.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:
> On Apr 4, 2005, at 11:17 AM, Ulrich Eckhardt wrote:
> > [2] Based on DB1100. Are there any pointers on how to port to a new
> > board, btw?
>
> One of the discussion items is always how to keep a "generic"
> driver and still provide unique setup/control for different types of
> boards.  I guess if we can discuss other board ports, it will be
> more clear how to do this.

OK, I'll be more concrete:
The board I'm talking about has different peripherals than the DB1100. In 
particular, it doesn't have any BCSRs, it only has a single flash-chip with 2 
MB RAM on board, a CAN bus interface and a rather peculiar way to generate 
the clocks for attached displays. 
 Most of this is easily remedied by only compiling a selected driver in and 
I'm doing rather fine loading a DB1100 config and modifying it a bit to get 
the board running. There are a few things though where I could really use a 
preprocessor check for that board:
- the layout table for the on-board flash RAM. The current driver only checks 
for a handful of layouts supported by the DB1x/PB1x boards, but those don't 
fit. This needs more research though.
- a default configuration file would be nice, but optional.
- the mentioned BCSRs are used to control some peripherals. Code that uses 
them needs to be changed.

All in all, I'd just write a different board_setup() routine than the one for 
DB1100 and have a few #ifdef HAVE_DB1x00_BCSR and be done. I'd even make this 
a subtype of the 'standard' DB1100 configuration, because of its strong 
similarities, but there are a few cases where I simply need to determine the 
type in the code.

I'd send a patch for discussion, but I'm far from finished yet. If there are 
any pitfalls I should watch out for or you have any suggestion how to tackle 
this problem, I'm all open ears.

thanks

Uli
