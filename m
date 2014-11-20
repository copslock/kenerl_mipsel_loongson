Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 16:17:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43836 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014080AbaKTPRik9GN7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Nov 2014 16:17:38 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAKFHYxp006432;
        Thu, 20 Nov 2014 16:17:34 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAKFHXQe006431;
        Thu, 20 Nov 2014 16:17:33 +0100
Date:   Thu, 20 Nov 2014 16:17:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Niklas Svensson <niklas.svensson@axis.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: mips-cm: CM regions are disabled at boot
Message-ID: <20141120151733.GC21620@linux-mips.org>
References: <1416486540-28681-1-git-send-email-niklass@axis.com>
 <20141120123434.GW1127@pburton-laptop>
 <546DF354.6030803@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546DF354.6030803@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44322
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

On Thu, Nov 20, 2014 at 02:57:40PM +0100, Niklas Svensson wrote:

> On 11/20/2014 01:34 PM, Paul Burton wrote:
> > On Thu, Nov 20, 2014 at 01:29:00PM +0100, Niklas Svensson wrote:
> >> Each CM_REGION_TARGET is set to disabled at boot,
> > 
> > That part is true...
> > 
> >> so there is no need to disable the matching
> >> CM_GCR_REG explicitly.
> > 
> > ...however there is no guarantee that the bootloader, or another kernel,
> > or some other piece of code didn't program the registers differently
> > before Linux starts. So I believe this patch to be incorrect.
> 
> 
> That is the reason for this patch. This will overwrite settings written by the bootloader.
> 
> Say if the bootloader sets up an iocu, then these writes will clear those settings.

The kernel has to be firmware agnostic, can't know how these registers have
been initialized as long as there is no proper boot protocol for the
handover to the kernel which includes this status.  At this point I think a
solution that hands over the required information as part of the DT is
probably the way to go.

  Ralf
