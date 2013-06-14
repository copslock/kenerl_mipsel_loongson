Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 10:41:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60054 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6820610Ab3FNIl3zxODx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 10:41:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5E8fQN3012389;
        Fri, 14 Jun 2013 10:41:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5E8fPQ5012388;
        Fri, 14 Jun 2013 10:41:25 +0200
Date:   Fri, 14 Jun 2013 10:41:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS/OCTEON: Override default address space layout.
Message-ID: <20130614084125.GA11911@linux-mips.org>
References: <1371157847-17066-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371157847-17066-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36875
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

On Thu, Jun 13, 2013 at 02:10:47PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> OCTEON II cannot execute code in the default CAC_BASE space, so we
> supply a value (0x8000000000000000) that does work.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Thanks, applied.

I assume this also should be applied to all -stable branches?

  Ralf
