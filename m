Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 10:20:36 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:14607 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133389AbVLFKUP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 10:20:15 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jB6AJpp8014806;
	Tue, 6 Dec 2005 10:19:51 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jB6AJoca014805;
	Tue, 6 Dec 2005 10:19:50 GMT
Date:	Tue, 6 Dec 2005 10:19:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Leonardo Silva Amaral <leonardosilv@yahoo.com.br>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux on handheld
Message-ID: <20051206101950.GB2698@linux-mips.org>
References: <4394570E.7040702@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394570E.7040702@yahoo.com.br>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Oi,

On Mon, Dec 05, 2005 at 01:04:46PM -0200, Leonardo Silva Amaral wrote:

> I Want to run linux on my handheld NEC700, but using linux from
> linux-mips.org and from kernel.org i give problems on compilation.
> 
> Thet does matter, linux-mips, give a parse error on vmlinux.ld. Some
> onde have fixed it?

I don't think we support the NEC700.  The error you're seeing is probably
a result of having chosen by a kernel configuration for a broken target,
which system did you configure for?

  Ralf
