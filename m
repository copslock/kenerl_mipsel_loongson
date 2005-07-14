Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 17:10:58 +0100 (BST)
Received: from smtp003.bizmail.yahoo.com ([IPv6:::ffff:216.136.130.195]:57527
	"HELO smtp003.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226711AbVGNQKl>; Thu, 14 Jul 2005 17:10:41 +0100
Received: (qmail 61101 invoked from network); 14 Jul 2005 16:11:44 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp003.bizmail.yahoo.com with SMTP; 14 Jul 2005 16:11:43 -0000
Subject: Re: What is the current USB support status on DB1550?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b7205071409044c9f9317@mail.gmail.com>
References: <2db32b7205071408327b005e4e@mail.gmail.com>
	 <1121356192.4797.362.camel@localhost.localdomain>
	 <2db32b7205071409044c9f9317@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 14 Jul 2005 09:11:49 -0700
Message-Id: <1121357509.4797.371.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-14 at 09:04 -0700, rolf liu wrote:
> Is there big difference between Au1200 and Au1550? 

Sure. Take a look at the marketing pdfs from AMD, they provide a concise
description.

Pete

> Any constrant on Au1550 ?
> Thanks
> 
> 
> On 7/14/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> > On Thu, 2005-07-14 at 08:32 -0700, rolf liu wrote:
> > > Are both usb host and usb gadget support as well? And the On the Go feature?
> > 
> > Host only. We couldn't make gadget work due to interrupt latency
> > requirements by the HW that couldn't be reliably achieved with Linux.
> > But gadget does work on the Au1200.
> > 
> > Pete
> > 
> > 
> >
> 
