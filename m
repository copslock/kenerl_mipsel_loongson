Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2010 19:38:03 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33147 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492468Ab0F2Rh6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jun 2010 19:37:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5SDa8L1029957;
        Mon, 28 Jun 2010 14:36:09 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5SDa7k4029955;
        Mon, 28 Jun 2010 14:36:07 +0100
Date:   Mon, 28 Jun 2010 14:36:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 1/9] Removing dead CONFIG_SOC_AU1000_FREQUENCY
Message-ID: <20100628133606.GA29229@linux-mips.org>
References: <cover.1275925108.git.siccegge@cs.fau.de>
 <2bd4314b3380c3c4aedd686f14187a80d00522e7.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd4314b3380c3c4aedd686f14187a80d00522e7.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19589

On Wed, Jun 09, 2010 at 01:20:23PM +0200, Christoph Egger wrote:

> CONFIG_SOC_AU1000_FREQUENCY doesn't exist in Kconfig, therefore
> removing all references for it from the source code.

Not comments received and seems to make sense so I queued this one for
2.6.36.

Thanks,

  Ralf
