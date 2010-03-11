Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 08:52:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60032 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491885Ab0CKHv6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Mar 2010 08:51:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2B7ptOr009973;
        Thu, 11 Mar 2010 08:51:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2B7prCO009971;
        Thu, 11 Mar 2010 08:51:53 +0100
Date:   Thu, 11 Mar 2010 08:51:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix elfcore.c build warning
Message-ID: <20100311075151.GB18065@linux-mips.org>
References: <1268286142-20615-1-git-send-email-yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268286142-20615-1-git-send-email-yang.shi@windriver.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 11, 2010 at 01:42:22PM +0800, Yang Shi wrote:

> kernel/elfcore.c includes elf.h which includes arch specific elf.h.
> In MIPS elf.h, 'struct pt_regs' is declared inside the parameter
> list of elf_dump_regs function. This cause kernel build warning.
> 
> So, move the declaration out of the function parameter list to
> remove build warning.

What fixes the warning is the forward declaration of struct pt_regs not
removing the function parameter name.  So I've added a patch which does
just that.

Thanks!

  Ralf
