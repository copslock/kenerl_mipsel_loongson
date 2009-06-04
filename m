Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 13:53:39 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38642 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022564AbZFDMxc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 13:53:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n54CkfDP021159;
	Thu, 4 Jun 2009 13:46:41 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n54CkVGV021157;
	Thu, 4 Jun 2009 13:46:31 +0100
Date:	Thu, 4 Jun 2009 13:46:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc:	Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Michael Abbott <michael@araneidae.co.uk>
Subject: Re: [PATCH 4/6] headers_check fix: mips, ioctl.h
Message-ID: <20090604124631.GB19459@linux-mips.org>
References: <1244118232.5172.26.camel@ht.satnam> <1244118476.5172.29.camel@ht.satnam> <1244118599.5172.31.camel@ht.satnam> <1244118714.5172.33.camel@ht.satnam> <1244118949.5172.37.camel@ht.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1244118949.5172.37.camel@ht.satnam>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 06:05:49PM +0530, Jaswinder Singh Rajput wrote:

> Make ioctl.h compatible with asm-generic/ioctl.h and userspace
> 
> fix the following 'make headers_check' warning:
> 
>   usr/include/asm-mips/ioctl.h:64: extern's make no sense in userspace
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

Thanks, applied.

   Ralf
