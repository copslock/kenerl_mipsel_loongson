Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 13:48:26 +0100 (BST)
Received: from god.demon.nl ([IPv6:::ffff:83.160.164.11]:9929 "EHLO
	god.dyndns.org") by linux-mips.org with ESMTP id <S8225550AbVDRMsM>;
	Mon, 18 Apr 2005 13:48:12 +0100
Received: by god.dyndns.org (Postfix, from userid 1005)
	id 729B24EC13; Mon, 18 Apr 2005 14:48:09 +0200 (CEST)
Date:	Mon, 18 Apr 2005 14:48:09 +0200
From:	Henk <Henk.Vergonet@gmail.com>
To:	Waldemar Brodkorb <wbx@openbsd-geek.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Porting mips based routers
Message-ID: <20050418124809.GA27967@god.dyndns.org>
References: <20050414210645.GB30585@god.dyndns.org> <20050415065558.GD25962@openbsd-geek.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415065558.GD25962@openbsd-geek.de>
User-Agent: Mutt/1.5.6i
Return-Path: <spam@god.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Henk.Vergonet@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Apr 15, 2005 at 08:55:58AM +0200, Waldemar Brodkorb wrote:
> > I will try to see if I can get a list of 2.4 source files that need to
> > be contributed back to linux-mips.org, with a quick initial proposal on
> > how to migrate this to the 2.6 kernel tree.

See section 1.3 on the wiki page:
http://openwrt.org/Kernel26Firmware
Feel free to comment here on the list.

General comments on the WRT code:
 - There's some code bloat that enables the inclusion of code in other OS's
  this should probably be removed.
 - We should probably make some abstraction/API of the so called Silicon
  Backplane bus that broadcom defined. I see allot of drivers, even in
  the mainline kernel (b44 ethernet driver) that use this.

> If you like to help, I would be giving you detailed information
> about the needed source code changes/addons.

Yes! Do you have any objection to make these publicly available?

> But may be it is time to send some patches...

Again yes, it should be possible to get this train rolling with some colaborative effort.

Regards,

Henk
