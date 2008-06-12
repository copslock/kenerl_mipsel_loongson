Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 15:32:23 +0100 (BST)
Received: from vs166246.vserver.de ([62.75.166.246]:1761 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S28578982AbYFLOcV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 15:32:21 +0100
Received: from t4ea4.t.pppool.de ([89.55.78.164] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1K6nqd-0001t7-AW; Thu, 12 Jun 2008 14:32:19 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: pending mips build fixes
Date:	Thu, 12 Jun 2008 16:31:57 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Adrian Bunk <bunk@kernel.org>, linux-mips@linux-mips.org,
	Aurelien Jarno <aurelien@aurel32.net>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
References: <20080612134539.GA20487@cs181133002.pp.htv.fi> <20080612135835.GB20015@linux-mips.org>
In-Reply-To: <20080612135835.GB20015@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806121631.57857.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Thursday 12 June 2008 15:58:35 Ralf Baechle wrote:
> On Thu, Jun 12, 2008 at 04:45:40PM +0300, Adrian Bunk wrote:
> > From: Adrian Bunk <bunk@kernel.org>
> > Date: Thu, 12 Jun 2008 16:45:40 +0300
> > To: ralf@linux-mips.org
> > Cc: linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
> > 	Aurelien Jarno <aurelien@aurel32.net>,
> > 	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > Subject: pending mips build fixes
> > Content-Type: text/plain; charset=utf-8
> > 
> > Hi Ralf,
> > 
> > I hope I'm not too annoying on this, but I like it when as many 
> > defconfigs as possible compile.
> > 
> > Please review and push the following patches for 2.6.26:
> > 
> >   BCM47xx: Add platform specific PCI code
> >   http://marc.info/?l=linux-kernel&amp;m=120876451216558&amp;w=2

> Can't comment at the BCM47xx patch yet.

The 47xx patch is OK. It was a merge error by me. I simply forgot
to push these two functions upstream.

-- 
Greetings Michael.
