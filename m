Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2010 19:38:29 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37039 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492470Ab0F2RiJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jun 2010 19:38:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5SDo01h030442;
        Mon, 28 Jun 2010 14:50:00 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5SDnxgh030440;
        Mon, 28 Jun 2010 14:49:59 +0100
Date:   Mon, 28 Jun 2010 14:49:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jiri Kosina <jkosina@suse.cz>
Cc:     Christoph Egger <siccegge@cs.fau.de>,
        Gilles Espinasse <g.esp@free.fr>, Tejun Heo <tj@kernel.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 3/9] Removing dead CONFIG_SIBYTE_BCM1480_PROF
Message-ID: <20100628134959.GC29229@linux-mips.org>
References: <cover.1275925108.git.siccegge@cs.fau.de>
 <c217f4530c057f4b8030bd14459a0cb2856decde.1275925108.git.siccegge@cs.fau.de>
 <alpine.LNX.2.00.1006161800290.12271@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1006161800290.12271@pobox.suse.cz>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19592

On Wed, Jun 16, 2010 at 06:00:59PM +0200, Jiri Kosina wrote:

> On Wed, 9 Jun 2010, Christoph Egger wrote:
> 
> > CONFIG_SIBYTE_BCM1480_PROF doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> 
> The patch isn't present in linux-next as of today. I have applied it to my 
> tree, thanks.

Nack.  This only need to be rewired to use the ZBus profiler just like
the SB1250 already does.  It's the virtually same hardware after all!

  Ralf
