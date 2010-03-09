Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 00:29:41 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38510 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492561Ab0CIX3i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Mar 2010 00:29:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o29NTZKg020037;
        Wed, 10 Mar 2010 00:29:35 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o29NTYWS020035;
        Wed, 10 Mar 2010 00:29:34 +0100
Date:   Wed, 10 Mar 2010 00:29:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Remove vestiges of
 CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
Message-ID: <20100309232933.GA2848@linux-mips.org>
References: <1267643227-27710-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267643227-27710-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 03, 2010 at 11:07:07AM -0800, David Daney wrote:

> The config option CAVIUM_RESERVE32_USE_WIRED_TLB is not supported.
> Remove the dead code controlled by it.

Thanks, applied.

  Ralf
