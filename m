Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2012 20:59:00 +0100 (CET)
Received: from g4t0017.houston.hp.com ([15.201.24.20]:6959 "EHLO
        g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824283Ab2J3T66hdUwg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2012 20:58:58 +0100
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
        by g4t0017.houston.hp.com (Postfix) with ESMTP id 704F33836F;
        Tue, 30 Oct 2012 19:58:50 +0000 (UTC)
Received: from [10.152.1.10] (openvpn.lnx.usa.hp.com [16.125.113.33])
        by g4t0009.houston.hp.com (Postfix) with ESMTP id 7E363C22A;
        Tue, 30 Oct 2012 19:58:47 +0000 (UTC)
Message-ID: <1351627126.2654.15.camel@lorien2>
Subject: Re: [PATCH RFT RESEND linux-next] mips: dma-mapping: support
 debug_dma_mapping_error
From:   Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, m.szyprowski@samsung.com,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        shuahkhan@gmail.com
Date:   Tue, 30 Oct 2012 13:58:46 -0600
In-Reply-To: <508B0F4B.80601@gmail.com>
References: <1351208193.6851.17.camel@lorien2>
         <1351267298.4013.12.camel@lorien2> <508ABE1D.5010106@gmail.com>
         <1351271198.4013.35.camel@lorien2> <508AED66.3040808@gmail.com>
         <1351288264.6885.11.camel@lorien2> <508B0F4B.80601@gmail.com>
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 34793
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

On Fri, 2012-10-26 at 15:31 -0700, David Daney wrote:
> On 10/26/2012 02:51 PM, Shuah Khan wrote:
> 
> >>>> On 10/26/2012 09:01 AM, Shuah Khan wrote:
> >>>>> Add support for debug_dma_mapping_error() call to avoid warning from
> >>>>> debug_dma_unmap() interface when it checks for mapping error checked
> >>>>> status. Without this patch, device driver failed to check map error
> >>>>> warning is generated.
> 
> I'm confused.
> 
> Your claim that a 'warning is generated' seems to be in conflict with...
> 
> 
> [...]
> > Got it. Thanks. I would volunteer to look at fixing all the problems,
> > but unfortunately I don't have a MIPS box handy
> 
> This statement that you don't have hardware that exhibits the problem.
> 
> How was the patch tested?  How do you even know there is a problem?

I enhanced the existing dma debug interfaces to add an interface to
debug missing dma_mapping_error() checks. That went into linux-next.
With this patch, when dma_map_page() and dma_map_single() are debugged
with a call to debug_dma_map_page() and the corresponding
dma_mapping_error() interface doesn't call debug_dma_mapping_error()
interface, a warning will be generated. I have been sending changes to
arch specific dma_mapping_error() routines to add this debug interface.
That is why I marked this patch RFT requesting testing.

Thanks,
-- Shuah
