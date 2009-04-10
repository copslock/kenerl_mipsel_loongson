Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2009 20:16:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53950 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20025574AbZDJTQR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2009 20:16:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3AJGDeI025865;
	Fri, 10 Apr 2009 12:16:14 -0700
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3AJGC2C025864;
	Fri, 10 Apr 2009 12:16:12 -0700
Date:	Fri, 10 Apr 2009 12:16:11 -0700
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Include linux/errno.h from
	arch/mips/include/asm/compat.h
Message-ID: <20090410191611.GB23582@linux-mips.org>
References: <1239388895-27305-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239388895-27305-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 10, 2009 at 11:41:35AM -0700, David Daney wrote:

> The recent change that added #include <linux/seccomp.h> breaks
> (because EINVAL is not defined) when building
> arch/mips/kernel/asm-offsets.s if CONFIG_SECCOMP is not defined.
> Including errno.h fixes the problem.

NAK, <linux/seccomp.h> should include <linux/errno.h>.

  Ralf
