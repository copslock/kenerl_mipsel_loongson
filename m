Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 19:30:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37572 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493780AbZKZS37 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 19:29:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAQIUAPq020261;
        Thu, 26 Nov 2009 18:30:11 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAQIU8Qr020251;
        Thu, 26 Nov 2009 18:30:08 GMT
Date:   Thu, 26 Nov 2009 18:30:07 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Joseph S. Myers" <joseph@codesourcery.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS asm/mman.h and MADV_HWPOISON
Message-ID: <20091126183007.GA19853@linux-mips.org>
References: <Pine.LNX.4.64.0911252356300.31853@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0911252356300.31853@digraph.polyomino.org.uk>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 11:57:07PM +0000, Joseph S. Myers wrote:

> In the course of updating glibc ports's bits/mman.h files for new MADV_* 
> definitions, I noticed that arch/mips/include/asm/mman.h does not define 
> MADV_HWPOISON, although architectures using asm-generic/mman.h get that 
> definition automatically.  Should I take it that this is an oversight and 
> that a definition of MADV_HWPOISON will be added with value 100, or is 
> there some reason for it not to be defined for MIPS or for it to have a 
> different value?

Just an omission.  Thanks for reporting.  I've just checked in below
patch.

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>

MIPS: Add missing definition for MADV_HWPOISON.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/mman.h b/arch/mips/include/asm/mman.h
index a2250f3..c892bfb 100644
--- a/arch/mips/include/asm/mman.h
+++ b/arch/mips/include/asm/mman.h
@@ -75,6 +75,7 @@
 
 #define MADV_MERGEABLE   12		/* KSM may merge identical pages */
 #define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
+#define MADV_HWPOISON    100		/* poison a page for testing */
 
 /* compatibility flags */
 #define MAP_FILE	0
