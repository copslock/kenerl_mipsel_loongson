Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 19:02:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47137 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862318Ab3IQRCSECPOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 19:02:18 +0200
Date:   Tue, 17 Sep 2013 18:02:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: DECstation I/O ASIC DMA interrupt handling
 fix
In-Reply-To: <20130917161327.GG22468@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309171801110.5967@linux-mips.org>
References: <alpine.LFD.2.03.1309171613160.5967@linux-mips.org> <20130917161327.GG22468@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 17 Sep 2013, Ralf Baechle wrote:

> >  I see you have applied the original change after all; I'd prefer it to be 
> > dropped to avoid cluttering the history, but please let me know if you 
> > need an incremental change instead.
> 
> The first patch is already upstream in 3.12-rc1, so I will need an
> incremental patch.

 Argh, that means I'll have to rewrite the explanation...  Ran out of time 
now, will post later.

  Maciej
