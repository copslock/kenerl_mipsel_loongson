Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 22:36:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42937 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491966Ab0F3Ugs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jun 2010 22:36:48 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5UFbdTQ007652;
        Wed, 30 Jun 2010 16:37:39 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5UFbcc3007650;
        Wed, 30 Jun 2010 16:37:38 +0100
Date:   Wed, 30 Jun 2010 16:37:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 4/9] Removing dead CONFIG_MTD_PB1550_BOOT,
 CONFIG_MTD_PB1550_USER
Message-ID: <20100630153737.GA4982@linux-mips.org>
References: <cover.1275925108.git.siccegge@cs.fau.de>
 <038d00ad3c402eb0a941b034daecdc3603d82e37.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038d00ad3c402eb0a941b034daecdc3603d82e37.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20562

On Wed, Jun 09, 2010 at 01:21:30PM +0200, Christoph Egger wrote:

> CONFIG_MTD_PB1550_BOOT, CONFIG_MTD_PB1550_USER doesn't exist in
> Kconfig, therefore removing all references for it from the source
> code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Queued for 2.6.26.  When I dug deep in git I didn't want to wait for git
to actually find the last real use of CONFIG_MTD_PB1550_USER - maybe it
was never actually used.

Thanks,

  Ralf
