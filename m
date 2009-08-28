Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 09:57:41 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58828 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492497AbZH1H5d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 09:57:33 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7S7wXt1018102;
	Fri, 28 Aug 2009 08:58:33 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7S7wXU3018100;
	Fri, 28 Aug 2009 08:58:33 +0100
Date:	Fri, 28 Aug 2009 08:58:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexey Dobriyan <adobriyan@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: fix compilation of mips-lasat
Message-ID: <20090828075833.GA11775@linux-mips.org>
References: <20090812195927.GA2647@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090812195927.GA2647@x200.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 12, 2009 at 11:59:27PM +0400, Alexey Dobriyan wrote:

> Header needed for current_cpu_data which expands to smp_processor_id().
> However, linux/smp.h can't be included into asm/cpu-info.h due to
> horrible circular dependencies, so plug it here.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Thanks, applied!

  Ralf
