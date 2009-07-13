Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 12:57:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43896 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492581AbZGMK5a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Jul 2009 12:57:30 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6DAvZcM023657;
	Mon, 13 Jul 2009 11:57:36 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6DAvY5i023655;
	Mon, 13 Jul 2009 11:57:34 +0100
Date:	Mon, 13 Jul 2009 11:57:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Gabor Juhos <juhosg@openwrt.org>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix loading of modules with unresolved weak
	symbols
Message-ID: <20090713105734.GB24046@linux-mips.org>
References: <1247476464-8961-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1247476464-8961-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 13, 2009 at 11:14:24AM +0200, Gabor Juhos wrote:

> Loading of modules with unresolved weak symbols fails on MIPS
> since '88173507e4fc1e7ecd111b0565e8cba0cb7dae6d'.
> 
> Modules: handle symbols that have a zero value
> 
> The module subsystem cannot handle symbols that are zero.  If symbols
> are present that have a zero value then the module resolver prints out a
> message that these symbols are unresolved.
> 
> We have to use IS_ERR_VALUE() to check that a symbol has been resolved
> or not.

Applied.  Thanks Gabor!

  Ralf
