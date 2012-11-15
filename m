Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 19:21:32 +0100 (CET)
Received: from g1t0028.austin.hp.com ([15.216.28.35]:30340 "EHLO
        g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825919Ab2KOSVbX8hxN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2012 19:21:31 +0100
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
        by g1t0028.austin.hp.com (Postfix) with ESMTP id 9D5F71C043;
        Thu, 15 Nov 2012 18:21:24 +0000 (UTC)
Received: from [10.152.0.142] (swa01cs006-da01.atlanta.hp.com [16.114.29.156])
        by g1t0039.austin.hp.com (Postfix) with ESMTP id 9F94134049;
        Thu, 15 Nov 2012 18:21:22 +0000 (UTC)
Message-ID: <1353003681.2532.53.camel@lorien2>
Subject: Re: [PATCH RFT RESEND linux-next] mips: dma-mapping: support
 debug_dma_mapping_error
From:   Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To:     m.szyprowski@samsung.com
Cc:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, linux-mips@linux-mips.org,
        ddaney.cavm@gmail.com, shuahkhan@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Nov 2012 11:21:21 -0700
In-Reply-To: <1351627126.2654.15.camel@lorien2>
References: <1351208193.6851.17.camel@lorien2>
         <1351267298.4013.12.camel@lorien2> <508ABE1D.5010106@gmail.com>
         <1351271198.4013.35.camel@lorien2> <508AED66.3040808@gmail.com>
         <1351288264.6885.11.camel@lorien2> <508B0F4B.80601@gmail.com>
         <1351627126.2654.15.camel@lorien2>
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 35016
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

On Tue, 2012-10-30 at 13:58 -0600, Shuah Khan wrote:
> On Fri, 2012-10-26 at 15:31 -0700, David Daney wrote:
> > On 10/26/2012 02:51 PM, Shuah Khan wrote:
> > 
> > >>>> On 10/26/2012 09:01 AM, Shuah Khan wrote:
> > >>>>> Add support for debug_dma_mapping_error() call to avoid warning from
> > >>>>> debug_dma_unmap() interface when it checks for mapping error checked
> > >>>>> status. Without this patch, device driver failed to check map error
> > >>>>> warning is generated.
> > 
> > I'm confused.
> > 
> > Your claim that a 'warning is generated' seems to be in conflict with...
> > 
> > 
> > [...]
> > > Got it. Thanks. I would volunteer to look at fixing all the problems,
> > > but unfortunately I don't have a MIPS box handy
> > 
> > This statement that you don't have hardware that exhibits the problem.
> > 
> > How was the patch tested?  How do you even know there is a problem?
> 
> I enhanced the existing dma debug interfaces to add an interface to
> debug missing dma_mapping_error() checks. That went into linux-next.
> With this patch, when dma_map_page() and dma_map_single() are debugged
> with a call to debug_dma_map_page() and the corresponding
> dma_mapping_error() interface doesn't call debug_dma_mapping_error()
> interface, a warning will be generated. I have been sending changes to
> arch specific dma_mapping_error() routines to add this debug interface.
> That is why I marked this patch RFT requesting testing.


Marek,

This one is for mips to go through your tree with the other arch patches
for debug_dma_mapping_error().

Thanks,
-- Shuah
