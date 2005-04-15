Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2005 07:56:16 +0100 (BST)
Received: from chrom.openbsd-geek.de ([IPv6:::ffff:217.160.135.112]:6937 "EHLO
	chrom.openbsd-geek.de") by linux-mips.org with ESMTP
	id <S8226202AbVDOG4B>; Fri, 15 Apr 2005 07:56:01 +0100
Received: by chrom.openbsd-geek.de (Postfix, from userid 1000)
	id 6712D32560; Fri, 15 Apr 2005 08:55:58 +0200 (CEST)
Date:	Fri, 15 Apr 2005 08:55:58 +0200
From:	Waldemar Brodkorb <wbx@openbsd-geek.de>
To:	Henk <Henk.Vergonet@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Porting mips based routers
Message-ID: <20050415065558.GD25962@openbsd-geek.de>
References: <20050414210645.GB30585@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050414210645.GB30585@god.dyndns.org>
X-Editor: VIM
X-Operating-System: OpenBSD 3.6 i386
User-Agent: Mutt/1.5.6i
Return-Path: <wbx@openbsd-geek.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openbsd-geek.de
Precedence: bulk
X-list: linux-mips

Hi,
Henk wrote,

> On Thu, Apr 14, 2005 at 07:05:27PM +0100, Ralf Baechle wrote:
> > On Thu, Apr 14, 2005 at 06:26:34PM +0200, Henk wrote:
> > > There's an initial wiki page on the openWRT site.
> > > http://openwrt.org/Kernel26Firmware
> > > 
> > > If so I would like to see if we can set up some colaborative effort...
> > 
> > None of the code for the routers or ASICs has been contributed back to
> > linux-mips.org so far so all you'll find there is a little blurb in the
> > wiki and a bunch of pointers.
> 
> That little blurb in the wiki I contributed yesterday, in the hope of
> raising some interest in the openwrt community ;)
> 
> I will try to see if I can get a list of 2.4 source files that need to
> be contributed back to linux-mips.org, with a quick initial proposal on
> how to migrate this to the 2.6 kernel tree.

If you like to help, I would be giving you detailed information
about the needed source code changes/addons.

I ported Linksys 2.4.20 patches to linux-mips 2.4.29 and added some
quirks to get the wlan binary kernel modul working.

All the stuff is really new for me, that is the reason I wait before
I contribute it back, because I like to see how stable this stuff
is in reality.

But may be it is time to send some patches...
 
bye
   Waldemar 

-- 
Waldemar Brodkorb                       waldemar.brodkorb@dass-it.de                                     
dass IT GmbH                               Phone: +49.221.3565666-0
http://www.dass-IT.de                        Fax: +49.221.3565666-10
