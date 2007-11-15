Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 19:45:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64922 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032453AbXKOTpt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 19:45:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAFJjm7D031101;
	Thu, 15 Nov 2007 19:45:48 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAFJjmwk031100;
	Thu, 15 Nov 2007 19:45:48 GMT
Date:	Thu, 15 Nov 2007 19:45:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: "exportfs -a" -> stale NFS filehandle
Message-ID: <20071115194548.GA30481@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C54DC88F@exchange.ZeugmaSystems.local> <DDFD17CC94A9BD49A82147DDF7D545C54DC8C7@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DC8C7@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 15, 2007 at 11:26:06AM -0800, Kaz Kylheku wrote:

> After backing out the nfsutils patch, the diskless node does boot.
> 
> However, the original "exportfs -a" problem comes back!
> 
> So this problem is not resolved simply by using the correct compat
> routine; it's deeper.
> 
> Sigh.

Thanks for testing anyway!

  Ralf
