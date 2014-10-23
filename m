Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 19:29:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48297 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012276AbaJWR31ry9qe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Oct 2014 19:29:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9NHTQJC005809;
        Thu, 23 Oct 2014 19:29:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9NHTQDE005808;
        Thu, 23 Oct 2014 19:29:26 +0200
Date:   Thu, 23 Oct 2014 19:29:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: idle: Remove leftover __pastwait symbol and its
 references
Message-ID: <20141023172926.GD1673@linux-mips.org>
References: <1410872228-12116-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410872228-12116-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43542
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

On Tue, Sep 16, 2014 at 01:57:08PM +0100, Markos Chandras wrote:

> The __pastwait symbol was only used by the address_is_in_r4k_wait_irqoff
> function but this is no longer used since the SMTC removal in commit
> b633648c5ad3 ('MIPS: MT: Remove SMTC support'). That symbol also led to
> build failures under certain random configuration due to the way the
> compiler compiled the r4k_wait_irqoff function. If that function was
> called multiple times, the __pastwait symbol was redefined breaking the
> build like this:

Applied.  If this problems show up again on older kernels that still have
SMTC we still can cook up a different fix.

> CHK     include/generated/compile.h
> CC      arch/mips/kernel/idle.o
> {standard input}: Assembler messages:
> {standard input}:527: Error: symbol `__pastwait' is already defined
> 
> Link: http://www.linux-mips.org/archives/linux-mips/2009-06/msg00282.html

When posting any kind of reference please always use the permanent links.

Applied,

  Ralf
