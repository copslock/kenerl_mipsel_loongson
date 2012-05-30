Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 23:01:48 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:56881 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903594Ab2E3VBo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 May 2012 23:01:44 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4UL1gh1006528;
        Wed, 30 May 2012 22:01:42 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4UL1fVT006527;
        Wed, 30 May 2012 22:01:41 +0100
Date:   Wed, 30 May 2012 22:01:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Refactor 'clear_page' and 'copy_page' functions.
Message-ID: <20120530210141.GH30086@linux-mips.org>
References: <1337891904-24093-1-git-send-email-sjhill@mips.com>
 <4FC6628F.9060807@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FC6628F.9060807@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, May 30, 2012 at 11:10:23AM -0700, David Daney wrote:

> On 05/24/2012 01:38 PM, Steven J. Hill wrote:
> >From: "Steven J. Hill"<sjhill@mips.com>
> >
> >Remove usage of the '__attribute__((alias("...")))' hack that aliased
> >to integer arrays containing micro-assembled instructions. This hack
> >breaks when building a microMIPS kernel. It also makes the code much
> >easier to understand.
> >
> >Signed-off-by: Steven J. Hill<sjhill@mips.com>
> 
> Looks good to (and even works for) me:
> 
> Acked-by: David Daney <david.daney@cavium.com>

I have to admit that the attribute hack was a desperate attempt at
avoiding the last bit of assembler code for the page functions.  But somehow
the patch isn't quite ripe yet.  Building malta_defconfig from
7a3434a78b36be2d398a46fb505a3196a9df4a60 with this patch applied on top
I'm getting:

  MODPOST 413 modules
ERROR: "copy_page" [fs/fuse/fuse.ko] undefined!
ERROR: "clear_page" [fs/fuse/fuse.ko] undefined!
ERROR: "clear_page" [drivers/net/ethernet/toshiba/tc35815.ko] undefined!

  Ralf
