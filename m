Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 11:48:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34507 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493573AbZJOJsQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Oct 2009 11:48:16 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9F9nZZd021857;
	Thu, 15 Oct 2009 11:49:36 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9F9nZSh021855;
	Thu, 15 Oct 2009 11:49:35 +0200
Date:	Thu, 15 Oct 2009 11:49:35 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] [MIPS] mipssim: remove unused code
Message-ID: <20091015094935.GB19134@linux-mips.org>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com> <1255546939-3302-2-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255546939-3302-2-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 10:02:17PM +0300, Dmitri Vorobiev wrote:

> The function prom_init_cmdline() doesn't do anything, and nobody calls
> the prom_getcmdline() function. Since these two are the only functions
> in the file arch/mips/mipssim/sim_cmdline.c, the whole file can be
> removed now along with the call to the no-op prom_init_cmdline()
> routine.

Queued for 2.6.33.  Thanks!

  Ralf
