Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 09:02:54 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:7175 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20024252AbXHXICq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Aug 2007 09:02:46 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AEA03D8D1; Fri, 24 Aug 2007 08:02:33 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3A4035437A; Fri, 24 Aug 2007 10:02:16 +0200 (CEST)
Date:	Fri, 24 Aug 2007 10:02:16 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tulip driver broken on Cobalt RaQ1 in 2.6
Message-ID: <20070824080215.GA31646@deprecation.cyrius.com>
References: <20070823203757.GA25971@deprecation.cyrius.com> <20070824133656.4163c577.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070824133656.4163c577.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2007-08-24 13:36]:
> What error occurs on Raq1?

There is no error, but I never get a DHCP response:

Listening on LPF/eth0/00:10:e0:00:27:5c
Sending on   LPF/eth0/00:10:e0:00:27:5c
Sending on   Socket/fallback/fallback-net
DHCPREQUEST on eth0 to 255.255.255.255 port 67
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 10
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 14
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 17
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
No DHCPOFFERS received.

> > Galileo: PCI retry count exceeded (06.0)
> 
> I cannot find this line in current git.

It's in arch/mips/cobalt/irq.c

> Do you apply any patch for Debian kernel?

This is a pristine kernel from git (well, I had to apply your patch to
get IDE going).

-- 
Martin Michlmayr
http://www.cyrius.com/
