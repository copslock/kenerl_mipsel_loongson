Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 12:34:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37233 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008337AbbIVKewYtlQa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Sep 2015 12:34:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8MAYnJX011132;
        Tue, 22 Sep 2015 12:34:49 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8MAYnWq011131;
        Tue, 22 Sep 2015 12:34:49 +0200
Date:   Tue, 22 Sep 2015 12:34:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [BISECTED] Linux 4.3-rc1 boot regression on OCTEON
Message-ID: <20150922103448.GD10284@linux-mips.org>
References: <20150915143850.GO1199@ak-desktop.emea.nsn-net.net>
 <20150921171213.GA25587@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150921171213.GA25587@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49271
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

On Mon, Sep 21, 2015 at 10:12:13AM -0700, Paul Burton wrote:

> On Tue, Sep 15, 2015 at 05:38:50PM +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > OCTEON+/OCTEON II fails to boot with 4.3-rc1. Bisected to:
> > 
> > 1a3d59579b9f436da038f377309cf2270c76318e is the first bad commit
> > commit 1a3d59579b9f436da038f377309cf2270c76318e
> > Author: Paul Burton <paul.burton@imgtec.com>
> > Date:   Mon Aug 3 08:49:30 2015 -0700
> > 
> >     MIPS: Tidy up FPU context switching
> 
> Hi Aaro,
> 
> Sorry about that! This patch I've just submitted should fix it up:
> 
>     http://marc.info/?l=linux-mips&m=144285532009315&w=2
> 
> Let me know if not.
> 
> Ralf: can we get those 2 FP fixes (11166 & 11167 in patchwork) into v4.3
>       please?

Applied, thanks!

And btw, this also means I'm back from my vaction.

  Ralf
