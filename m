Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 15:41:54 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:15376
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225960AbUEMOlx>; Thu, 13 May 2004 15:41:53 +0100
Received: from comm1.baslerweb.com ([172.16.13.2]) by proxy.baslerweb.com
          (Post.Office MTA v3.5.3 release 223 ID# 0-0U10L2S100V35)
          with ESMTP id com; Thu, 13 May 2004 16:41:26 +0200
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JHN38QLP; Thu, 13 May 2004 16:41:50 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: Re: titan ethernet driver
Date: Thu, 13 May 2004 16:44:26 +0200
User-Agent: KMail/1.6.1
Cc: Ralf Baechle <ralf@linux-mips.org>, lachwani@pmc-sierra.com
References: <200403261512.06502.thomas.koeller@baslerweb.com> <20040326212001.GA4927@linux-mips.org>
In-Reply-To: <20040326212001.GA4927@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405131644.26009.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Friday, March 26th, 2004 Ralf Baechle wrote:
> On Fri, Mar 26, 2004 at 03:12:06PM +0100, Thomas Koeller wrote:
> > I am trying to use your titan ethernet driver. I
> > found that I could not compile it for a 2.6.4
> > kernel, because it uses 2.4 kernel APIs. When
> > fixing that I found that the code contains
> > obvious errors; it does not even compile unchanged.
> > This makes me a bit uneasy. Would you mind
> > commenting on the state of this driver? Are there
> > any newer sources than those contained in CVS at
> > linux-mips.org?
>
> I'm going to fix Yosemite / Titan support in 2.6 asap - as soon as I get
> the board which should be somewhen next week.
>
>   Ralf

I see work going on for the titan ge driver, but AFAIK the only
platform supporting this hardware is the yosemite board, and the
board support has not been updated for months and is still
non-functional. So I wonder how these changes are tested - or
am I missing something?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
