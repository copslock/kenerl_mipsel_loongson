Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Dec 2012 14:31:48 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49945 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823113Ab2LVNbrmu39A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Dec 2012 14:31:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 19D9256E7DF;
        Sat, 22 Dec 2012 15:31:47 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id AxQN2NjjUBP7; Sat, 22 Dec 2012 15:31:46 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id AFB955BC004;
        Sat, 22 Dec 2012 15:31:45 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sat, 22 Dec 2012 15:31:45 +0200
Date:   Sat, 22 Dec 2012 15:31:45 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org
Subject: Re: 3.8-rc1 build failure with MIPS/SPARSEMEM
Message-ID: <20121222133145.GC6847@blackmetal.musicnaut.iki.fi>
References: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi>
 <20121222131022.GA16364@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121222131022.GA16364@otc-wbsnb-06>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Sat, Dec 22, 2012 at 03:10:23PM +0200, Kirill A. Shutemov wrote:
> On Sat, Dec 22, 2012 at 02:27:57PM +0200, Aaro Koskinen wrote:
> > It looks like commit 816422ad76474fed8052b6f7b905a054d082e59a
> > (asm-generic, mm: pgtable: consolidate zero page helpers) broke
> > MIPS/SPARSEMEM build in 3.8-rc1:
> 
> Could you try this:
> 
> http://permalink.gmane.org/gmane.linux.kernel/1410981

It's not helping. And if you look at the error, it shows linux/mm.h is
already there?

[...]
In file included from /home/aaro/git/linux/arch/mips/include/asm/pgtable.h:388:0,
                 from include/linux/mm.h:44,
                 from arch/mips/kernel/asm-offsets.c:14:
[...]

A.
