Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 21:45:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44872 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493605AbZJMTpS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 21:45:18 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DJkXGK002556;
	Tue, 13 Oct 2009 21:46:34 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DJkPUp002551;
	Tue, 13 Oct 2009 21:46:25 +0200
Date:	Tue, 13 Oct 2009 21:46:25 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: reduce size of irq dispatcher
Message-ID: <20091013194625.GB727@linux-mips.org>
References: <1255458391-14544-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255458391-14544-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 08:26:31PM +0200, Manuel Lauss wrote:

> By replacing an extra do_IRQ with a goto, the assembly shrinks
> from 260 to 212 bytes (gcc-4.3.4).
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>  Applies on top of the irq changes in -queue.

Thanks, queued for 2.6.33.

  Ralf
