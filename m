Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 10:29:06 +0200 (CEST)
Received: from mga04.intel.com ([192.55.52.120]:18120 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991786AbdFNI24LQ4HW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 10:28:56 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2017 01:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,340,1493708400"; 
   d="scan'208";a="1182282826"
Received: from vkoul-udesk7.iind.intel.com (HELO localhost) ([10.223.84.143])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2017 01:28:47 -0700
Date:   Wed, 14 Jun 2017 14:01:27 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
Message-ID: <20170614083127.GJ13020@localhost>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-4-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58443
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

On Thu, Jun 08, 2017 at 03:25:28PM +0200, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not a public API and will go away.  Instead properly
> unwind based on the loop counter.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
