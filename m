Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 18:39:24 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:61869 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8226056AbVDDRjH>; Mon, 4 Apr 2005 18:39:07 +0100
Received: (qmail 28937 invoked by uid 101); 4 Apr 2005 17:38:54 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 4 Apr 2005 17:38:54 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j34HcsOn013654;
	Mon, 4 Apr 2005 10:38:54 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <H2DN3VP2>; Mon, 4 Apr 2005 10:38:54 -0700
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDE1D@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Brad Larson <Brad_Larson@pmc-sierra.com>
To:	"'priya'" <priya@procsys.com>, linux-mips@linux-mips.org
Subject: RE: Porting davicom driver to pmon
Date:	Mon, 4 Apr 2005 10:38:19 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

It's a DEC Tulip type chip handled by the dc driver. Should work with "dc* at pci ?".
Should because I have no own experience with that particular chip.

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of priya
Sent: Monday, April 04, 2005 7:55 AM
To: linux-mips@linux-mips.org
Subject: Porting davicom driver to pmon


Hi,
I am using a custom board which has mips
processor and davicom ethernet chip. Iam
using pmon bootloader. Has anyone ported
davicom driver for pmon. Iam facing a
lot of problem in sending even a set up
frame

regards
priya
