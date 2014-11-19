Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 12:37:39 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:58457 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011908AbaKSLhgPhXGs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 12:37:36 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1Xr3Zg-0002Ak-FL from Maciej_Rozycki@mentor.com ; Wed, 19 Nov 2014 03:37:28 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 19 Nov
 2014 11:37:27 +0000
Date:   Wed, 19 Nov 2014 11:37:22 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: jump_label.c: Handle the microMIPS J instruction
 encoding
In-Reply-To: <20141119092734.GA7358@linux-mips.org>
Message-ID: <alpine.DEB.1.10.1411191135110.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411170524070.2881@tp.orcam.me.uk> <alpine.DEB.1.10.1411170530220.2881@tp.orcam.me.uk> <20141119092734.GA7358@linux-mips.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

On Wed, 19 Nov 2014, Ralf Baechle wrote:

> > +	if (IS_ENABLED(CONFIG_CPU_MICROMIPS)) {
> > +		insn_p->halfword[0] = insn.word >> 16;
> > +		insn_p->halfword[1] = insn.word;
> > +	} else
> > +		*insn_p = insn;
> 
> I think the IS_ENABLED() should be replaced with cpu_has_mmips?

 Nope, this leg must only execute if the kernel itself has been built as 
microMIPS code -- it's patching itself here.

  Maciej
