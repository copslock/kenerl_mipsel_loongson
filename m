Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jun 2013 00:07:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34594 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827525Ab3FNWHhEo0uE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Jun 2013 00:07:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5EM7YSD019654;
        Sat, 15 Jun 2013 00:07:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5EM7XZF019653;
        Sat, 15 Jun 2013 00:07:33 +0200
Date:   Sat, 15 Jun 2013 00:07:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: Re: [PATCH 12/31] MIPS: Add instruction format information for WAIT,
 MTC0, MFC0, et al.
Message-ID: <20130614220733.GB18936@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-13-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-13-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36910
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

On Fri, Jun 07, 2013 at 04:03:16PM -0700, David Daney wrote:

> To: linux-mips@linux-mips.org, ralf@linux-mips.org, kvm@vger.kernel.org,
>  Sanjay Lal <sanjayl@kymasys.com>
> Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
> Subject: [PATCH 12/31] MIPS: Add instruction format information for WAIT,
>  MTC0, MFC0, et al.

Looks good.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

I wonder if somebody could throw in microMIPS equivalent to this patch?

  Ralf
