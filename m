Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 07:45:18 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:11204 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225255AbTDYGpP>;
	Fri, 25 Apr 2003 07:45:15 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3P6j1Ue028288;
	Thu, 24 Apr 2003 23:45:01 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA08232;
	Thu, 24 Apr 2003 23:45:02 -0700 (PDT)
Message-ID: <004201c30af7$524fb0a0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Chip Coldwell" <coldwell@frank.harvard.edu>
Cc: <linux-mips@linux-mips.org>
References: <Pine.LNX.4.44.0304241839110.19067-100000@frank.harvard.edu>
Subject: Re: NCD900 port?
Date: Fri, 25 Apr 2003 08:53:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Thu, 24 Apr 2003, Chip Coldwell wrote:
> 
> > On Thu, 24 Apr 2003, Kevin D. Kissell wrote:
> > > 
> > > What PCI bridge is being used?  Galileo?
> > 
> > Good question.  Short answer: I don't know.  I'll pry off the hood
> > and take a peek at what's on the board, unless this is something that
> > shares a die with the CPU.
> 
> It was easy to identify once I took off the cover.  The PCI bridge is
> made by V3 Semiconductor (now a part of QuickLogic?), part number
> V32OUSC-75LP (Rev. B1):
> 
> http://www.quicklogic.com/home.asp?PageID=235&sMenuID=126
> 
> Is this the one called "Galileo"?

No, Galileo is/was a different company.  So you may not be able
to recycle as much existing code as you might have otherwise, but 
at least you've got some documentation for it.

            Kevin K.
