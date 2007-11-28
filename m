Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 14:28:24 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49900 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030789AbXK1O1f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 14:27:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAS9r3oi011266
	for <linux-mips@linux-mips.org>; Wed, 28 Nov 2007 09:53:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAS9r3NB011265;
	Wed, 28 Nov 2007 09:53:03 GMT
Date:	Wed, 28 Nov 2007 09:53:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28: added cache barrier to assembly routines
Message-ID: <20071128095303.GC1568@linux-mips.org>
References: <20071126223955.9BAAAC2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126223955.9BAAAC2B26@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 25, 2007 at 11:47:56AM +0100, Thomas Bogendoerfer wrote:

> IP28 needs special treatment to avoid speculative accesses. gcc
> takes care for .c code, but for assembly code we need to do it
> manually.
> 
> This is taken from Peter Fuersts IP28 patches.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Queued for 2.6.25 as well.

Thanks,

  Ralf
