Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 20:57:32 +0100 (BST)
Received: from rwcrmhc14.comcast.net ([IPv6:::ffff:216.148.227.89]:56814 "EHLO
	rwcrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8226031AbVEFT5P>; Fri, 6 May 2005 20:57:15 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc14) with SMTP
          id <200505061957070140087urue>; Fri, 6 May 2005 19:57:07 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: ATA devices attached to arbitary busses
Date:	Fri, 6 May 2005 15:57:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVSYjUJGmHm0bXVS0GMLNJCA4j1uQAEnHfQ
In-Reply-To: <Pine.LNX.4.61L.0505061832390.25293@blysk.ds.pg.gda.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050506195715Z8226031-1340+6653@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

I just read Documents/ide.txt.  It looks like you can tell the kernel where
to find an IDE drive by providing a command line argument
"hdx=cyl,head,sect".  If this is true, I don't see why I would need to write
any kernel code (provided that I design my FPGA local bus IDE host adapter
so that it conforms to the standard).

Bryan
