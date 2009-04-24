Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 15:57:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:17539 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023931AbZDXO5j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 15:57:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3OEvbrG007173;
	Fri, 24 Apr 2009 16:57:37 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3OEvZQM007171;
	Fri, 24 Apr 2009 16:57:35 +0200
Date:	Fri, 24 Apr 2009 16:57:35 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dan Williams <dan.j.williams@intel.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DMA: TXx9 Soc DMA Controller driver (v3)
Message-ID: <20090424145735.GA5930@linux-mips.org>
References: <1240414831-20429-1-git-send-email-anemo@mba.ocn.ne.jp> <e9c3a7c20904240749g79b7b54cufa64149e44b5753a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c3a7c20904240749g79b7b54cufa64149e44b5753a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 24, 2009 at 07:49:10AM -0700, Dan Williams wrote:

> On Wed, Apr 22, 2009 at 8:40 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > This patch adds support for the integrated DMAC of the TXx9 family.
> >
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Thanks, queued for 2.6.31.

  Ralf
