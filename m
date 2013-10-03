Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 20:29:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52788 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868687Ab3JCS3UC5tCU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Oct 2013 20:29:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r93ITHL5019033;
        Thu, 3 Oct 2013 20:29:17 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r93ITFQU019032;
        Thu, 3 Oct 2013 20:29:15 +0200
Date:   Thu, 3 Oct 2013 20:29:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Prem Mallappa <prem.mallappa@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: KDUMP: Fix to access non-sectioned memory
Message-ID: <20131003182915.GA15556@linux-mips.org>
References: <1380786415-24956-1-git-send-email-pmallappa@caviumnetworks.com>
 <1380786415-24956-2-git-send-email-pmallappa@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380786415-24956-2-git-send-email-pmallappa@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38187
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

On Thu, Oct 03, 2013 at 01:16:55PM +0530, Prem Mallappa wrote:

> @@ -41,19 +42,20 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  	if (!csize)
>  		return 0;
>  
> -	vaddr = kmap_atomic_pfn(pfn);
> +	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);

This is not portable, I'm afraid.

Ioremap on MIPS is creating uncached mappings - on most systems, that is.
However there is no guarantee that the data accessed through this mapping
does not reside in a cache on another CPU or another virtual address
which would make the operation undefined.

On SGI IP27 and IP35 ioremap is not even able to create RAM mappings at
all.  If you're lucky this would result in a bus error; if you're unlucky
it'll make the SCSI controller scribble the answer to the universe, life
and everything on the disk drive only to corrupt it again before you have
a chance to read it ;-)

I think this is bulletproof on Octeon so until there's a better patch you
may want to keep this around for the SDK.

I wonder, does commit 5395d97b675986e7e8f3140f9e0819d20b1d22cd
in upstream-sfr.git fix your issue?

Cheers,

  Ralf
