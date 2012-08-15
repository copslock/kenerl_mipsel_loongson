Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2012 21:36:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55045 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1902756Ab2HOTgT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Aug 2012 21:36:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7FJaImq016344;
        Wed, 15 Aug 2012 21:36:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7FJaINe016343;
        Wed, 15 Aug 2012 21:36:18 +0200
Date:   Wed, 15 Aug 2012 21:36:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V5 01/18] MIPS: Loongson: Add basic Loongson-3 definition.
Message-ID: <20120815193617.GA15844@linux-mips.org>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
 <1344677543-22591-2-git-send-email-chenhc@lemote.com>
 <50274467.90509@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50274467.90509@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34182
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Aug 12, 2012 at 07:51:35AM +0200, John Crispin wrote:

> On 11/08/12 11:32, Huacai Chen wrote:
> >  #define PRID_IMP_LOONGSON2	0x6300
> > +#define PRID_IMP_LOONGSON3	0x6300
> >  
> 
> as PRID_IMP_LOONGSON2 and PRID_IMP_LOONGSON3 share the same value, its
> not really a uniq ID anymore. Maybe change this to a common PRID ?
> 
> patch 2/18 does not even make use of this new symbol inside
> arch/mips/kernel/cpu-probe.c

PRID_IMP_LOONGSON3 is not even being used in the series.  If it was, it'd
cause a duplicate case label in the usual switch construction in
cpu_probe_legacy().

Huacai, can you please resend with this symbol removed?  Thanks.

  Ralf
