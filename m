Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2012 13:16:13 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:48053 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817387Ab2L0MQM2dEv1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2012 13:16:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 7E33219B9DE;
        Thu, 27 Dec 2012 14:16:11 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id PQQ+k44QEKqE; Thu, 27 Dec 2012 14:16:11 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 2CF165BC004;
        Thu, 27 Dec 2012 14:16:10 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Thu, 27 Dec 2012 14:16:07 +0200
Date:   Thu, 27 Dec 2012 14:16:07 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org
Subject: Re: 3.8-rc1 build failure with MIPS/SPARSEMEM
Message-ID: <20121227121607.GA7097@blackmetal.musicnaut.iki.fi>
References: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi>
 <20121226003434.GA27760@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20121226003434.GA27760@otc-wbsnb-06>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35337
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

On Wed, Dec 26, 2012 at 02:34:35AM +0200, Kirill A. Shutemov wrote:
> On MIPS if SPARSEMEM is enabled we've got this:
> 
> In file included from /home/kas/git/public/linux/arch/mips/include/asm/pgtable.h:552,
>                  from include/linux/mm.h:44,
>                  from arch/mips/kernel/asm-offsets.c:14:
> include/asm-generic/pgtable.h: In function ‘my_zero_pfn’:
> include/asm-generic/pgtable.h:466: error: implicit declaration of function ‘page_to_section’
> In file included from arch/mips/kernel/asm-offsets.c:14:
> include/linux/mm.h: At top level:
> include/linux/mm.h:738: error: conflicting types for ‘page_to_section’
> include/asm-generic/pgtable.h:466: note: previous implicit declaration of ‘page_to_section’ was here
> 
> Due header files inter-dependencies, the only way I see to fix it is
> convert my_zero_pfn() for __HAVE_COLOR_ZERO_PAGE to macros.
> 
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>

Thanks, this works.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
