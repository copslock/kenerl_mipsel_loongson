Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 14:08:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:37268 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20021565AbZCaNIm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 14:08:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2VD8fG2025067;
	Tue, 31 Mar 2009 15:08:41 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2VD8fjN025065;
	Tue, 31 Mar 2009 15:08:41 +0200
Date:	Tue, 31 Mar 2009 15:08:41 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: PATCH for SMTC: Update CP0 access macros
Message-ID: <20090331130841.GB3804@linux-mips.org>
References: <49D1F78C.90501@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D1F78C.90501@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 31, 2009 at 12:59:24PM +0200, Kevin D. Kissell wrote:

> Commit ae462c65c5bad2d815cf3f0f3de36ee5187c72d8 changed the return value
> semantics of some macros in their base versions, but not in the SMTC
> variants.  The attached patch fixes this.

Thanks to the Dead Supercomputer Society for fixing SMTC ;-)

  Ralf
