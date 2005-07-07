Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 20:29:12 +0100 (BST)
Received: from smtp006.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.83]:15257
	"HELO smtp006.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226313AbVGGT25>; Thu, 7 Jul 2005 20:28:57 +0100
Received: (qmail 89543 invoked from network); 7 Jul 2005 19:29:01 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp006.bizmail.sc5.yahoo.com with SMTP; 7 Jul 2005 19:29:01 -0000
Subject: Re: compiling error of linux 2.6.12 recent cvs head for db1550
	using defconfig
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61L.0507071213480.3205@blysk.ds.pg.gda.pl>
References: <2db32b7205070616124fa47ef3@mail.gmail.com>
	 <1120694886.5724.134.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507071213480.3205@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 07 Jul 2005 12:29:07 -0700
Message-Id: <1120764548.5777.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-07 at 12:22 +0100, Maciej W. Rozycki wrote:
> On Wed, 6 Jul 2005, Pete Popov wrote:
> 
> > Maciej, I assume you built a kernel for one of the Au1x boards before
> > you applied the patch ;)?
> 
>  Certainly not -- I don't maintain that part of the tree in any sense -- I 
> don't even have any related hardware, so why should I bother?  

Well, I understand you don't have the HW so you can't test the patch.
But at least it should compile, imho.

> I sent the 
> patch for public review to let interested parties exactly to catch such 
> problems -- I even mentioned explicitly I only did a minimal arrangement 
> for the Au1000 code.


Pete
