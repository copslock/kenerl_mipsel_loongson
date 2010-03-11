Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 11:06:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36909 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492047Ab0CKKGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Mar 2010 11:06:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2BA6n1D015743;
        Thu, 11 Mar 2010 11:06:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2BA6mU5015741;
        Thu, 11 Mar 2010 11:06:48 +0100
Date:   Thu, 11 Mar 2010 11:06:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Initialize an atomic_t properly with
 ATOMIC_INIT(0).
Message-ID: <20100311100647.GD18065@linux-mips.org>
References: <alpine.LFD.2.00.1002271201230.20373@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002271201230.20373@localhost>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 27, 2010 at 12:02:51PM -0500, Robert P. J. Day wrote:

>   AFAIK, the technically correct way to initialize atomic variables is
> with ATOMIC_INIT(n).

Indeed, applied.

Thanks!

  Ralf
