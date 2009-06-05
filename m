Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 15:58:57 +0100 (WEST)
Received: from wmproxy1-g27.free.fr ([212.27.42.91]:22448 "EHLO
	wmproxy1-g27.free.fr" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023077AbZFEO6s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2009 15:58:48 +0100
Received: from wmproxy1-g27.free.fr (localhost [127.0.0.1])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id 64A6D2123D;
	Fri,  5 Jun 2009 16:58:44 +0200 (CEST)
Received: from UNKNOWN (imp5-g19.priv.proxad.net [172.20.243.135])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id 7A3B7C3D0;
	Fri,  5 Jun 2009 16:58:42 +0200 (CEST)
Received: by UNKNOWN (Postfix, from userid 0)
	id 79C525D7166E0; Fri,  5 Jun 2009 16:58:42 +0200 (CEST)
Received: from  ([62.210.107.40]) 
	by imp.free.fr (IMP) with HTTP 
	for <castet.matthieu@172.20.243.55>; Fri, 05 Jun 2009 16:58:42 +0200
Message-ID: <1244213922.4a2932a272094@imp.free.fr>
Date:	Fri, 05 Jun 2009 16:58:42 +0200
From:	castet.matthieu@free.fr
To:	Florian Fainelli <florian@openwrt.org>
Cc:	matthieu castet <castet.matthieu@free.fr>, wim@iguana.be,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org,
	Aleksandar Radovanovic <biblbroks@sezampro.rs>
Subject: Re: add bcm47xx watchdog driver
References: <4A282D98.6020004@free.fr> <200906051558.02303.florian@openwrt.org>
In-Reply-To: <200906051558.02303.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 62.210.107.40
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

Hi Florian,

Quoting Florian Fainelli <florian@openwrt.org>:

>
> Your driver looks good, could you turn this into a platform device/driver
> instead ? You declare bcm47xx_wdt_platform_device which is unused and you
> also declare a MODULE_ALIAS which suggets it is one.
What's the advantage of using platform device/driver ?
Not all watchdog driver use it (for example softdog).
This seems useless in this case because the driver don't have any resource,
don't care about suspend/resume and add complexity in the code (2 registers in
module probe, ...).


Matthieu
