Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 16:20:29 +0100 (BST)
Received: from rwcrmhc14.comcast.net ([IPv6:::ffff:216.148.227.89]:24481 "EHLO
	rwcrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8225995AbVEFPUG>; Fri, 6 May 2005 16:20:06 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc14) with SMTP
          id <200505061519550140086qe8e>; Fri, 6 May 2005 15:19:55 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: ATA devices attached to arbitary busses
Date:	Fri, 6 May 2005 11:19:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVRnTpQ2HSr6HCSTjOMsTTmmVOC6gAphcdQ
In-Reply-To: <1115316338.19844.100.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050506152006Z8225995-1340+6646@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips


Alan,

Thank you, that is very helpful.  I think I understand, but let me ramble a
bit so that you can correct me if I am wrong.  

All IDE drives should have the identical memory map.  But, the kernel does
not communicate directly with the drive, it communicates though an IDE host
adaptor (which may have different implementations).  If the host adaptor's
memory map "matches" that of the IDE drive spec, then you consider it to be
a "standard port layout"?  Since my host adaptor will be implemented in an
FPGA, if I give it the IDE memory map defined in ide.h, then your example
code will be applicable.

The memory map defined in ide.h makes sense to me (it seems to match the IDE
drive memory map) until we get down to offset 6 (IDE_SELECT_OFFSET).  From
here down, I have trouble matching the #define names with the register
names/descriptions from the IDE spec.  Also, I am puzzled as to why there
are 10 registers defined in ide.h when my IDE spec only shows 9.  The IDE
spec that I am referencing looks like this:

CS0   CS1    DA2   DA1   DA0   READ              WRITE
A     N      0     0     0     Data              Data
A     N      0     0     1     Error             Features
A     N      0     1     0     Sector Count      Sector Count
A     N      0     1     1     Sector Number     Sector Number
A     N      1     0     0     Cylinder Low      Cylinder Low
A     N      1     0     1     Cylinder High     Cylinder High
A     N      1     1     0     Device/Head       Device/Head
A     N      1     1     1     Status            Command
N     A      1     1     0     Alternate Status  Device Control (IRQ en/dis)


ide.h shows the following offsets:

#define IDE_DATA_OFFSET		(0)
#define IDE_ERROR_OFFSET	(1)
#define IDE_NSECTOR_OFFSET	(2)
#define IDE_SECTOR_OFFSET	(3)
#define IDE_LCYL_OFFSET		(4)
#define IDE_HCYL_OFFSET		(5)
#define IDE_SELECT_OFFSET	(6)
#define IDE_STATUS_OFFSET	(7)
#define IDE_CONTROL_OFFSET	(8)
#define IDE_IRQ_OFFSET		(9)

Do you know of an IDE host adapter chipset which is standard?  If someone
knows of a part number, I could look up its datasheet.  This would probably
clear up my confusion.  Thanks again!  

Bryan

>It really depends on the complexity of your controller. If you are just
>doing PIO with generic IDE interfacing then its simply a matter of
>telling Linux that there is an interface at these addresses with these
>port operations and it'll just do the rest for you, except hotplug.
