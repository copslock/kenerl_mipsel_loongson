Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Nov 2017 03:40:15 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:58321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990428AbdKECkIaZp02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Nov 2017 03:40:08 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2017 19:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,345,1505804400"; 
   d="gz'50?scan'50,208,50";a="1239832073"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2017 19:40:01 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1eBAvt-0003nF-7L; Sun, 05 Nov 2017 10:45:09 +0800
Date:   Sun, 5 Nov 2017 10:39:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     kbuild-all@01.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH V9 3/4] scsi: Align block queue to
 dma_get_cache_alignment()
Message-ID: <201711051024.PinX4pOo%fengguang.wu@intel.com>
References: <1508742767-28366-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <1508742767-28366-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkp@intel.com
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huacai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc7]
[cannot apply to next-20171103]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Huacai-Chen/dma-mapping-Rework-dma_get_cache_alignment/20171023-154436
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   drivers//scsi/scsi_lib.c: In function '__scsi_init_queue':
>> drivers//scsi/scsi_lib.c:2139:2: error: implicit declaration of function 'dma_get_cache_alignment' [-Werror=implicit-function-declaration]
     blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment(dev)) - 1);
     ^
   cc1: some warnings being treated as errors

vim +/dma_get_cache_alignment +2139 drivers//scsi/scsi_lib.c

  2103	
  2104	void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
  2105	{
  2106		struct device *dev = shost->dma_dev;
  2107	
  2108		queue_flag_set_unlocked(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
  2109	
  2110		/*
  2111		 * this limit is imposed by hardware restrictions
  2112		 */
  2113		blk_queue_max_segments(q, min_t(unsigned short, shost->sg_tablesize,
  2114						SG_MAX_SEGMENTS));
  2115	
  2116		if (scsi_host_prot_dma(shost)) {
  2117			shost->sg_prot_tablesize =
  2118				min_not_zero(shost->sg_prot_tablesize,
  2119					     (unsigned short)SCSI_MAX_PROT_SG_SEGMENTS);
  2120			BUG_ON(shost->sg_prot_tablesize < shost->sg_tablesize);
  2121			blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
  2122		}
  2123	
  2124		blk_queue_max_hw_sectors(q, shost->max_sectors);
  2125		blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
  2126		blk_queue_segment_boundary(q, shost->dma_boundary);
  2127		dma_set_seg_boundary(dev, shost->dma_boundary);
  2128	
  2129		blk_queue_max_segment_size(q, dma_get_max_seg_size(dev));
  2130	
  2131		if (!shost->use_clustering)
  2132			q->limits.cluster = 0;
  2133	
  2134		/*
  2135		 * set a reasonable default alignment on word/cacheline boundaries:
  2136		 * the host and device may alter it using
  2137		 * blk_queue_update_dma_alignment() later.
  2138		 */
> 2139		blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment(dev)) - 1);
  2140	}
  2141	EXPORT_SYMBOL_GPL(__scsi_init_queue);
  2142	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uIuJTRt00BdlJAw8nIytFAIAA0RcJZG9AAA=

--1yeeQ81UyVL57Vl7--
