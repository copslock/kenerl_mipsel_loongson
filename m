Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 00:52:18 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:49071
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20153738AbYI0Xvn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 00:51:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8RNpeKL006923;
	Sun, 28 Sep 2008 00:51:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8RNpd9i006921;
	Sun, 28 Sep 2008 00:51:39 +0100
Date:	Sun, 28 Sep 2008 00:51:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE
	driver
Message-ID: <20080927235138.GA6802@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <Pine.LNX.4.55.0809241448480.811@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0809241448480.811@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 24, 2008 at 02:52:07PM +0100, Maciej W. Rozycki wrote:

> >    Platform device in the driver itself? Interesting... :-)
> 
>  Better than nothing for platforms which did not have platform
> initialisation at all.  Some driver subsystems do not support
> non-driver-model devices at all or anymore.

Historically registration of the device file in the driver itself wasn't
uncommon before it turned out to be not such a great idea.  I hope this
was the last of the affected MIPS-specific drivers.

  Ralf
