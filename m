Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2009 15:30:27 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:46741 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023958AbZC0PaZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2009 15:30:25 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2RFUME2012069;
	Fri, 27 Mar 2009 16:30:23 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2RFUL4e012067;
	Fri, 27 Mar 2009 16:30:21 +0100
Date:	Fri, 27 Mar 2009 16:30:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] [MIPS] ip22: use a generic method for irq
	statistics
Message-ID: <20090327153021.GB24274@linux-mips.org>
References: <1238153951-18307-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238153951-18307-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 27, 2009 at 01:39:11PM +0200, Dmitri Vorobiev wrote:

> The structure 'struct kernel_stat' defines the 'irqs' array as its
> field only when CONFIG_GENERIC_HARDIRQS is not set. However, the ip22
> code makes use of this field unconditionally. As the result, the
> following build error is produced:
> 
>   CC      arch/mips/sgi-ip22/ip22-int.o
> arch/mips/sgi-ip22/ip22-int.c: In function 'indy_buserror_irq':
> arch/mips/sgi-ip22/ip22-int.c:158: error: 'struct kernel_stat' has no
> member named 'irqs'
> make[1]: *** [arch/mips/sgi-ip22/ip22-int.o] Error 1
> make: *** [arch/mips/sgi-ip22] Error 2
> 
> This patch fixes the build error by using the generic method for the irq
> statistics.

Applied, thanks!

  Ralf
