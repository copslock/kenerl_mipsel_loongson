Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 23:16:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53973 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133757AbWDZWQW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Apr 2006 23:16:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3QMGLSO022391;
	Wed, 26 Apr 2006 23:16:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3QMGKbJ022390;
	Wed, 26 Apr 2006 23:16:20 +0100
Date:	Wed, 26 Apr 2006 23:16:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Sergey Sivkov <ssp@woodland.ru>, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: Re: SNI RM300C with R10000
Message-ID: <20060426221619.GB21670@linux-mips.org>
References: <20060425075615.GA15261@woodland.ru> <20060425091123.GD7822@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425091123.GD7822@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 25, 2006 at 11:11:23AM +0200, Martin Michlmayr wrote:

> * Sergey Sivkov <ssp@woodland.ru> [2006-04-25 13:56]:
> > I have SNI RM300C with R10000 CPU. Is there any chance i'll be able
> > to start Linux on that computer?
> 
> Certainly not out of the box.  However, Ralf Baechle (the MIPS kernel
> maintainer) has (or used to have) a RM200C so it might be possible to
> get it going.
> 
> Ralf, what's the status of RM200C/RM300C support?

Slight bitrot but would be easy to fix that.  The reason for the bitrot
is that my RM is still in Germany ...

  Ralf
