Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 18:46:11 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:5067 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226101AbVF3Rp4>; Thu, 30 Jun 2005 18:45:56 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc12) with SMTP
          id <2005063017453701200hgqnpe>; Thu, 30 Jun 2005 17:45:37 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: top and SMP
Date:	Thu, 30 Jun 2005 13:45:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-index: AcV9m4WMcIhOHh14S1iIWDy5SwxYEg==
Message-Id: <20050630174556Z8226101-3678+737@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

I have tried to get top to display processor utilization on a per CPU basis,
but to no avail.  Does anyone know how to get top to properly display
statistics for a SMP system?  Better yet, does anyone know of a better
utility than top?  

The man file for top says that it will display a separate column for each
CPU detected.  I only ever get one column.  I think both processors of my
RM9224 are working, because a "cat /proc/cpuinfo" lists information on
processor 0 and also for processor 1.

I am writing a multi-threaded radar processing application.  It would be
very nice to verify that the threads were being shared between the 2
processors.  I would like to use a utility like top to help me optimize my
code to properly utilize both processors.

Thanks!
Bryan  
