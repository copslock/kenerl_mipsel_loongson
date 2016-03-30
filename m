Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 23:56:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43250 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27024952AbcC3V4USMlCw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2016 23:56:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2ULuJbi019205;
        Wed, 30 Mar 2016 23:56:19 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2ULuJk2019204;
        Wed, 30 Mar 2016 23:56:19 +0200
Date:   Wed, 30 Mar 2016 23:56:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix build failure
Message-ID: <20160330215618.GB5275@linux-mips.org>
References: <1459351789-24544-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160330221329.25ca0849d782e55c0564f139@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160330221329.25ca0849d782e55c0564f139@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52801
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

On Wed, Mar 30, 2016 at 10:13:29PM +0300, Antony Pavlov wrote:

> It is very strange because my original patch has this closing brace.
> Please see my original patch
> https://www.linux-mips.org/archives/linux-mips/2016-03/msg00267.html

The patch didn't apply cleanly and I botched resolving it, sorry.  I folded
the fix into the patch.

> Also I suppose that we have no need in detect_memory_region() if we use devicetree,
> e.g.
> 
>                 ath79_detect_sys_type();
>                 ath79_ddr_ctrl_init();
>  +              detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
>  +      }
>   
>  -      detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);

"suppose" is a bit weak..  Should I move the detect_memory_region call?

  Ralf
