Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2010 17:32:13 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43448 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492464Ab0AWQcJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2010 17:32:09 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0NGW1sE027005;
        Sat, 23 Jan 2010 17:32:03 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0NGVw5X027003;
        Sat, 23 Jan 2010 17:31:58 +0100
Date:   Sat, 23 Jan 2010 17:31:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Roel Kluin <roel.kluin@gmail.com>, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: cleanup switches with cases that can be merged
Message-ID: <20100123163158.GB5570@linux-mips.org>
References: <4B56475F.8070608@gmail.com>
 <4B56641E.1030803@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B56641E.1030803@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15380

On Tue, Jan 19, 2010 at 06:02:06PM -0800, David Daney wrote:

> This patch should be split up.
> 
> Octeon, PowerTV, and IP32 are all different architectures.  They
> should be in their own patches.
> 
> The two math-emu parts could probably go together.
> 
> cpu-probe seems like its own thing.

It's conceptually the same change that's being applied everywhere and the
total size is modest so I'm happy to apply it as just a single patch as is.

> This brings us to the larger question:  This is just code churn.  Is
> it even worthwhile?

This has been discussed many times over and we maintainers have not come to
a final conclusion on this type of patches.  I tend to apply this sort of
patches anyway but treat them as low priority.

  Ralf
