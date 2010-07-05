Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 11:11:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53198 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491875Ab0GEJL3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 11:11:29 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o659BOWT006474;
        Mon, 5 Jul 2010 10:11:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o659BOMV006473;
        Mon, 5 Jul 2010 10:11:24 +0100
Date:   Mon, 5 Jul 2010 10:11:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     Christoph Egger <siccegge@cs.fau.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 7/9] Removing dead CONFIG_PMCTWILED
Message-ID: <20100705091124.GB4461@linux-mips.org>
References: <cover.1275925108.git.siccegge@cs.fau.de>
 <0a4b5e5841e7842f7b80e368c1d103b5e98d3335.1275925108.git.siccegge@cs.fau.de>
 <AANLkTin3EsoPJPb9s7_nwSrWY9HihXMJHorAK96dKKIa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTin3EsoPJPb9s7_nwSrWY9HihXMJHorAK96dKKIa@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 10, 2010 at 01:24:08PM -0600, Shane McDonald wrote:

> On Wed, Jun 9, 2010 at 5:22 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> > CONFIG_PMCTWILED doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> >
> > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Queued for 2.6.26.  Thanks,

  Ralf
