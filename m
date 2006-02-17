Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 10:56:44 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:30472 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133619AbWBTKzh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 10:55:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KB1GwX005775;
	Mon, 20 Feb 2006 11:01:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1HMEQ1Y004593;
	Fri, 17 Feb 2006 22:14:26 GMT
Date:	Fri, 17 Feb 2006 22:14:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable VIA82CXXX and TULIP in Cobalt defconfig
Message-ID: <20060217221426.GA4386@linux-mips.org>
References: <20060217182747.GA25475@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217182747.GA25475@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 17, 2006 at 06:27:51PM +0000, Martin Michlmayr wrote:

> All MIPS based Cobalt machines have an in-built VIA82CXXX IDE chip and
> Tulip Ethernet.  It therefore makes sense to activate those in the Cobalt
> defconfig.

Indeed.  Applied,

  Ralf
