Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 04:46:24 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:31927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbLJDqWVjjnC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 04:46:22 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 09 Dec 2015 19:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,406,1444719600"; 
   d="scan'208";a="870549551"
Received: from vkoul-udesk7.iind.intel.com (HELO localhost) ([10.223.84.135])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2015 19:46:12 -0800
Date:   Thu, 10 Dec 2015 09:19:22 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/28] dmaengine: pch_dma: allow build on MIPS platforms
Message-ID: <20151210034922.GK1854@localhost>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-12-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448900513-20856-12-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vinod.koul@intel.com
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

On Mon, Nov 30, 2015 at 04:21:36PM +0000, Paul Burton wrote:
> Allow the pch_dma driver to be built on MIPS platforms, in preparation
> for use on the MIPS Boston board.

Acked-by: Vinod Koul <vinod.koul@intel.com>


-- 
~Vinod
