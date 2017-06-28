Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 04:37:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60006 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990507AbdF1ChQP2twY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 04:37:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 924613BAA337A;
        Wed, 28 Jun 2017 03:37:08 +0100 (IST)
Received: from [10.20.78.46] (10.20.78.46) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 28 Jun 2017
 03:37:08 +0100
Date:   Wed, 28 Jun 2017 03:36:54 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <Matt.Redfearn@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>
Subject: Re: [PATCH 3/8] MIPS: R6: Fix PREF instruction usage by memcpy for
 MIPS R6
In-Reply-To: <9915e476-70fe-4281-a1e4-85ca2e8683b3@imgtec.com>
Message-ID: <alpine.DEB.2.00.1706280329280.31404@tp.orcam.me.uk>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com> <1497887415-13825-4-git-send-email-aleksandar.markovic@rt-rk.com> <a5842e4b-a75b-2dde-d835-6a488790dbda@imgtec.com> <20170628005853.GC6738@linux-mips.org>,<alpine.DEB.2.00.1706280224120.31404@tp.orcam.me.uk>
 <9915e476-70fe-4281-a1e4-85ca2e8683b3@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.46]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 28 Jun 2017, Leonid Yegoshin wrote:

> The bigger problem is a prefetch overrun to device registers. AT use is just
> nuisance.

 That isn't however what the patch addresses, not at least according to 
the description provided.

 How far beyond the data copied do we prefetch anyway, and can't we simply 
waste a page's worth of space or so at the physical end of each RAM area 
present in a given system?  Or perhaps use it for something we know for 
sure that won't ever be copied.

  Maciej
