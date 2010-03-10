Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 17:04:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42109 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492497Ab0CJQEr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Mar 2010 17:04:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2AG4jCC015563;
        Wed, 10 Mar 2010 17:04:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2AG4iiY015560;
        Wed, 10 Mar 2010 17:04:44 +0100
Date:   Wed, 10 Mar 2010 17:04:42 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: sleepcode without compile-time cputype
 dependencies
Message-ID: <20100310160442.GA15118@linux-mips.org>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 08, 2010 at 08:22:59PM +0100, Manuel Lauss wrote:

> Split the low-level sleepcode into per-memory-controller-generation
> functions and figure out which one to call at runtime instead of
> relying on compile-time-defined cpu types.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks, queued for 2.6.35.

  Ralf
