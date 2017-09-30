Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2017 01:31:03 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:22925 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991743AbdI3Xa4oIIlC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Oct 2017 01:30:56 +0200
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2017 16:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,460,1500966000"; 
   d="gz'50?scan'50,208,50";a="1020235702"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2017 16:30:48 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dyRIb-000T9z-C3; Sun, 01 Oct 2017 07:35:57 +0800
Date:   Sun, 1 Oct 2017 07:30:19 +0800
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
        linux-scsi@vger.kernel.org, Roland Dreier <rolandd@cisco.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@mvista.com>,
        Robert Baldyga <r.baldyga@samsung.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: Re: [PATCH V7 2/2] scsi: Align block queue to
 dma_get_cache_alignment()
Message-ID: <201710010700.tKdsiFdb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1506332766-23966-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60211
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


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huacai,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc2 next-20170929]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Huacai-Chen/dma-mapping-Rework-dma_get_cache_alignment/20170926-063324
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   drivers/scsi/scsi_lib.c: In function '__scsi_init_queue':
>> drivers/scsi/scsi_lib.c:2139:2: error: implicit declaration of function 'dma_get_cache_alignment' [-Werror=implicit-function-declaration]
     blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment(dev)) - 1);
     ^
   cc1: some warnings being treated as errors

vim +/dma_get_cache_alignment +2139 drivers/scsi/scsi_lib.c

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

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--FCuugMFkClbJLl1L--
