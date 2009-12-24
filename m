Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2009 15:05:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57253 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492003AbZLXOF0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Dec 2009 15:05:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBOE5TbL031598;
        Thu, 24 Dec 2009 15:05:29 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBOE5Snq031596;
        Thu, 24 Dec 2009 15:05:28 +0100
Date:   Thu, 24 Dec 2009 15:05:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] TXx9: Cleanup builtin-cmdline processing
Message-ID: <20091224140528.GI29598@linux-mips.org>
References: <1261410537-7921-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1261410537-7921-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 22, 2009 at 12:48:57AM +0900, Atsushi Nemoto wrote:

> Since commit 6acc7d ("Fix and enhance built-in kernel command line")
> arcs_cmdline[] does not contain built-in command line.  The commit
> introduce CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE to control
> built-in command line, and now we can use them instead of
> platform-specific built-in command line processing.

Thanks Atsushi-San, applied!

  Ralf
