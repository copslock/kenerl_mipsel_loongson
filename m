Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 07:07:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35882 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20024234AbZD2GHZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Apr 2009 07:07:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3T67O0w028270;
	Wed, 29 Apr 2009 08:07:24 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3T67OmD028268;
	Wed, 29 Apr 2009 08:07:24 +0200
Date:	Wed, 29 Apr 2009 08:07:23 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Remove the RAMROOT function for msp71xx
Message-ID: <20090429060723.GA26289@linux-mips.org>
References: <E1LywHr-0006MX-S3@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LywHr-0006MX-S3@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 05:00:27PM -0600, Shane McDonald wrote:

> The RAMROOT function was a successful but non-portable attempt to append
> the root filesystem to the end of the kernel image.  The preferred and
> portable solution is to use an initramfs instead.  This patch removes
> the RAMROOT functionality.
> 
> This patch has been compile-tested against the current HEAD.

Thanks, applied!

  Ralf
