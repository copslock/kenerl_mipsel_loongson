Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2010 12:35:01 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491040Ab0IPKes (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Sep 2010 12:34:48 +0200
Date:   Thu, 16 Sep 2010 11:34:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>,
        linux-mips@linux-mips.org
Subject: Re: What is CONFIG_MIPS_MT_SMTC configuration and when is this
 recommended to be used?
Message-ID: <20100916103446.GA13219@linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D076010CFA3B@CORPEXCH1.na.ads.idt.com>
 <4C9132E9.6060807@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C9132E9.6060807@paralogos.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12645

On Wed, Sep 15, 2010 at 01:56:09PM -0700, Kevin D. Kissell wrote:

> SMTC is a kernel for the 34K (and, just maybe, with some mods,
> 1004K) that turns TC microthreads into virtual SMP CPUs.  See
> http://tree.celinuxforum.org/CelfPubWiki/ELC2006Presentations?action=AttachFile&do=view&target=CELF_SMTC_April_2006_v0.3.pdf

The help text provided for the MIPS_MT_SMP (VSMP) and MIPS_MT_SMTC options
didn't make it easier to understand what SMTC is by incorrectly stating
that MIPS marketing had renamed both to SMVP.  I used the opportunity to
rewrite the help text and slightly polish

http://www.linux-mips.org/wiki/SMTC#SMTC

  Ralf
