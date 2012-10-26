Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2012 19:06:54 +0200 (CEST)
Received: from g4t0016.houston.hp.com ([15.201.24.19]:8529 "EHLO
        g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823145Ab2JZRGxTiMOF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2012 19:06:53 +0200
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
        by g4t0016.houston.hp.com (Postfix) with ESMTP id D707D14198;
        Fri, 26 Oct 2012 17:06:46 +0000 (UTC)
Received: from [10.152.0.198] (openvpn.lnx.usa.hp.com [16.125.113.33])
        by g4t0018.houston.hp.com (Postfix) with ESMTP id B871F1008B;
        Fri, 26 Oct 2012 17:06:44 +0000 (UTC)
Message-ID: <1351271198.4013.35.camel@lorien2>
Subject: Re: [PATCH RFT RESEND linux-next] mips: dma-mapping: support
 debug_dma_mapping_error
From:   Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, m.szyprowski@samsung.com,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        shuahkhan@gmail.com
Date:   Fri, 26 Oct 2012 11:06:38 -0600
In-Reply-To: <508ABE1D.5010106@gmail.com>
References: <1351208193.6851.17.camel@lorien2>
         <1351267298.4013.12.camel@lorien2> <508ABE1D.5010106@gmail.com>
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 34777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shuah.khan@hp.com
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

On Fri, 2012-10-26 at 09:45 -0700, David Daney wrote:
> On 10/26/2012 09:01 AM, Shuah Khan wrote:
> > Add support for debug_dma_mapping_error() call to avoid warning from
> > debug_dma_unmap() interface when it checks for mapping error checked
> > status. Without this patch, device driver failed to check map error
> > warning is generated.
> >
> > Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> > ---
> >   arch/mips/include/asm/dma-mapping.h |    2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> > index be39a12..006b43e 100644
> > --- a/arch/mips/include/asm/dma-mapping.h
> > +++ b/arch/mips/include/asm/dma-mapping.h
> > @@ -40,6 +40,8 @@ static inline int dma_supported(struct device *dev, u64 mask)
> >   static inline int dma_mapping_error(struct device *dev, u64 mask)
> >   {
> >   	struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +	debug_dma_mapping_error(dev, mask);
> >   	return ops->mapping_error(dev, mask);
> >   }
> >
> >
> 
> Although this is a start, I don't think it is sufficient.
> 
> As far as I can tell, there are many missing calls to debug_dma_*() in 
> the various MIPS commone and sub-architecture DMA code.
> 
> Really you (or someone) needs to look at *all* the functions in 
> arch/mips/asm/dma-mapping.h, and arch/mips/mm/dma-default.c and find 
> places missing a debug_dma_*().

Is it correct to assume that this patch is not needed on MIPS until
debug_dma interfaces get added to MIPS common and sub-architecture DMA
code. 

When I didn't see dma_map_page() in arch/mips/include/asm/dma-mapping.h
defined, and just an extern, I incorrectly assumed, it is getting picked
up from <asm-generic/dma-mapping-common.h>, hence the need for this
patch in the first place.

-- Shuah
