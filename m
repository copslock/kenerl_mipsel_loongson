Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 17:45:33 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:52458 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492140AbZGFPp0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 17:45:26 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A8397D8D1; Mon,  6 Jul 2009 15:38:27 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B552C160281; Mon,  6 Jul 2009 17:38:21 +0200 (CEST)
Date:	Mon, 6 Jul 2009 17:38:21 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
	dwmw2@infradead.org
Subject: Re: mtd related Cobalt build failure with current git
Message-ID: <20090706153821.GB2467@deprecation.cyrius.com>
References: <20090704213741.GA6438@deprecation.cyrius.com> <200907051310.02673.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907051310.02673.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Florian Fainelli <florian@openwrt.org> [2009-07-05 13:10]:
> > Does anyone know if there's a fix for this already?
> 
> I also had that problem and did the following fix, which still applies to
> the mtd-2.6 tree, master branch.

Thanks, Florian!
-- 
Martin Michlmayr
http://www.cyrius.com/
