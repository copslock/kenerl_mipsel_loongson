Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 18:26:56 +0100 (BST)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:28602 "EHLO
	sccrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8226172AbVGAR0l>; Fri, 1 Jul 2005 18:26:41 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc14) with SMTP
          id <20050701172627014004e4jhe>; Fri, 1 Jul 2005 17:26:28 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Maciej W. Rozycki'" <macro@linux-mips.org>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: top and SMP
Date:	Fri, 1 Jul 2005 13:26:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.61L.0507010950310.30138@blysk.ds.pg.gda.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcV+GjopURKKgsNTSVGITQNgbOGu6wARoEGw
Message-Id: <20050701172641Z8226172-3678+842@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Maciej,

Looks like I am running procps version 2.0.7.  The latest is 3.2.5, so I am
a bit out of date.  I would like to upgrade, but I am having trouble cross
compiling the latest.  I get this error:
	Proc/libproc-3.2.5.so: undefined reference to '__ctype_b'
For other reasons, I need to upgrade my toolchain.  Hopefully I'll have
better luck cross compiling procps afterwards.

Bryan

-----Original Message-----
From: macro@blysk.ds.pg.gda.pl [mailto:macro@blysk.ds.pg.gda.pl] On Behalf
Of Maciej W. Rozycki
Sent: Friday, July 01, 2005 4:53 AM
To: Bryan Althouse
Cc: 'Linux/MIPS Development'
Subject: Re: top and SMP

On Thu, 30 Jun 2005, Bryan Althouse wrote:

> I have tried to get top to display processor utilization on a per CPU
basis,
> but to no avail.  Does anyone know how to get top to properly display
> statistics for a SMP system?  Better yet, does anyone know of a better
> utility than top?  

 Do you have a recent version of procps?

  Maciej
