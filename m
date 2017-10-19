Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 01:53:35 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:12622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992618AbdJSXxZCrju0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 01:53:25 +0200
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2017 16:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.43,404,1503385200"; 
   d="gz'50?scan'50,208,50";a="1027142844"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2017 16:53:17 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1e5Kho-000TX6-BI; Fri, 20 Oct 2017 07:58:28 +0800
Date:   Fri, 20 Oct 2017 08:04:43 +0800
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
        linux-scsi@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH V8 4/5] libsas: Align SMP req/resp to
 dma_get_cache_alignment()
Message-ID: <201710200735.j45igvnF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1508227542-13165-4-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60490
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


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huacai,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc5 next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Huacai-Chen/dma-mapping-Rework-dma_get_cache_alignment/20171020-050317
config: um-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   drivers/scsi/libsas/sas_expander.c: In function 'sas_ex_phy_discover':
>> drivers/scsi/libsas/sas_expander.c:410:10: error: implicit declaration of function 'dma_get_cache_alignment' [-Werror=implicit-function-declaration]
     align = dma_get_cache_alignment(&dev->phy->dev);
             ^~~~~~~~~~~~~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_set
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:set_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 arch/x86/include/uapi/asm/swab.h:__arch_swab64
   Cyclomatic Complexity 1 include/uapi/linux/swab.h:__fswab16
   Cyclomatic Complexity 1 include/uapi/linux/swab.h:__fswab64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock_irq
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irq
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
   Cyclomatic Complexity 1 include/linux/refcount.h:refcount_set
   Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/kref.h:kref_init
   Cyclomatic Complexity 1 include/linux/kref.h:kref_get
   Cyclomatic Complexity 2 include/linux/kref.h:kref_put
   Cyclomatic Complexity 1 include/scsi/scsi.h:scsi_to_u32
   Cyclomatic Complexity 1 include/scsi/sas_ata.h:dev_is_sata
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_internal.h:sas_fill_in_rphy
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_internal.h:sas_add_parent_port
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_internal.h:sas_alloc_device
   Cyclomatic Complexity 1 drivers/scsi/libsas/sas_internal.h:sas_put_device
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_expander.c:alloc_smp_req
   Cyclomatic Complexity 1 drivers/scsi/libsas/sas_expander.c:alloc_smp_resp
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_expander.c:sas_route_char
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:to_dev_type
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:dev_type_flutter
   Cyclomatic Complexity 3 drivers/scsi/libsas/sas_expander.c:sas_print_parent_topology_bug
   Cyclomatic Complexity 17 drivers/scsi/libsas/sas_expander.c:smp_execute_task_sg
   Cyclomatic Complexity 1 drivers/scsi/libsas/sas_expander.c:smp_execute_task
   Cyclomatic Complexity 21 drivers/scsi/libsas/sas_expander.c:sas_configure_present
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:sas_get_phy_discover
   Cyclomatic Complexity 3 drivers/scsi/libsas/sas_expander.c:sas_get_phy_change_count
   Cyclomatic Complexity 6 drivers/scsi/libsas/sas_expander.c:sas_find_bcast_phy
   Cyclomatic Complexity 6 drivers/scsi/libsas/sas_expander.c:sas_get_ex_change_count
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_expander.c:smp_task_timedout
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_expander.c:smp_task_done
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:ex_assign_report_general
   Cyclomatic Complexity 22 drivers/scsi/libsas/sas_expander.c:sas_check_eeds
   Cyclomatic Complexity 23 drivers/scsi/libsas/sas_expander.c:sas_check_parent_topology
   Cyclomatic Complexity 11 drivers/scsi/libsas/sas_expander.c:sas_configure_set
   Cyclomatic Complexity 3 drivers/scsi/libsas/sas_expander.c:sas_configure_phy
   Cyclomatic Complexity 11 drivers/scsi/libsas/sas_expander.c:sas_configure_parent
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_expander.c:sas_configure_routing
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_expander.c:sas_disable_routing
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_expander.c:sas_find_sub_addr
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:sas_get_phy_attached_dev
   Cyclomatic Complexity 35 drivers/scsi/libsas/sas_expander.c:sas_set_ex_phy
   Cyclomatic Complexity 3 drivers/scsi/libsas/sas_expander.c:sas_ex_phy_discover_helper
   Cyclomatic Complexity 10 drivers/scsi/libsas/sas_expander.c:sas_ex_general
   Cyclomatic Complexity 3 drivers/scsi/libsas/sas_expander.c:ex_assign_manuf_info
   Cyclomatic Complexity 7 drivers/scsi/libsas/sas_expander.c:sas_ex_manuf_info
   Cyclomatic Complexity 6 drivers/scsi/libsas/sas_expander.c:sas_ex_get_linkrate
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_expander.c:sas_ex_join_wide_port
   Cyclomatic Complexity 10 drivers/scsi/libsas/sas_expander.c:sas_dev_present_in_domain
   Cyclomatic Complexity 12 drivers/scsi/libsas/sas_expander.c:sas_ex_discover_end_dev
   Cyclomatic Complexity 6 drivers/scsi/libsas/sas_expander.c:sas_unregister_ex_tree
   Cyclomatic Complexity 12 drivers/scsi/libsas/sas_expander.c:sas_unregister_devs_sas_addr
   Cyclomatic Complexity 10 drivers/scsi/libsas/sas_expander.c:sas_find_bcast_dev
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_expander.c:sas_ex_to_ata
   Cyclomatic Complexity 7 drivers/scsi/libsas/sas_expander.c:sas_ex_phy_discover
   Cyclomatic Complexity 3 drivers/scsi/libsas/sas_expander.c:sas_expander_discover
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:sas_smp_phy_control
   Cyclomatic Complexity 1 drivers/scsi/libsas/sas_expander.c:sas_ex_disable_phy
   Cyclomatic Complexity 13 drivers/scsi/libsas/sas_expander.c:sas_check_ex_subtractive_boundary
   Cyclomatic Complexity 7 drivers/scsi/libsas/sas_expander.c:sas_discover_expander
   Cyclomatic Complexity 9 drivers/scsi/libsas/sas_expander.c:sas_ex_discover_expander
   Cyclomatic Complexity 6 drivers/scsi/libsas/sas_expander.c:sas_ex_disable_port
   Cyclomatic Complexity 14 drivers/scsi/libsas/sas_expander.c:sas_check_level_subtractive_boundary
   Cyclomatic Complexity 40 drivers/scsi/libsas/sas_expander.c:sas_ex_discover_dev
   Cyclomatic Complexity 7 drivers/scsi/libsas/sas_expander.c:sas_ex_discover_devices
   Cyclomatic Complexity 8 drivers/scsi/libsas/sas_expander.c:sas_ex_level_discovery
   Cyclomatic Complexity 2 drivers/scsi/libsas/sas_expander.c:sas_ex_bfs_disc
   Cyclomatic Complexity 8 drivers/scsi/libsas/sas_expander.c:sas_discover_bfs_by_root_level
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:sas_discover_bfs_by_root
   Cyclomatic Complexity 12 drivers/scsi/libsas/sas_expander.c:sas_discover_new
   Cyclomatic Complexity 22 drivers/scsi/libsas/sas_expander.c:sas_rediscover_dev
   Cyclomatic Complexity 9 drivers/scsi/libsas/sas_expander.c:sas_rediscover
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_expander.c:sas_smp_get_phy_events
   Cyclomatic Complexity 4 drivers/scsi/libsas/sas_expander.c:sas_discover_root_expander
   Cyclomatic Complexity 5 drivers/scsi/libsas/sas_expander.c:sas_ex_revalidate_domain
   Cyclomatic Complexity 7 drivers/scsi/libsas/sas_expander.c:sas_smp_handler
   Cyclomatic Complexity 1 drivers/scsi/libsas/sas_expander.c:_GLOBAL__sub_I_65535_0_sas_ex_to_ata
   cc1: some warnings being treated as errors

vim +/dma_get_cache_alignment +410 drivers/scsi/libsas/sas_expander.c

   402	
   403	int sas_ex_phy_discover(struct domain_device *dev, int single)
   404	{
   405		struct expander_device *ex = &dev->ex_dev;
   406		int  res = 0, align;
   407		u8   *disc_req;
   408		u8   *disc_resp;
   409	
 > 410		align = dma_get_cache_alignment(&dev->phy->dev);
   411	
   412		disc_req = alloc_smp_req(DISCOVER_REQ_SIZE, align);
   413		if (!disc_req)
   414			return -ENOMEM;
   415	
   416		disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE, align);
   417		if (!disc_resp) {
   418			kfree(disc_req);
   419			return -ENOMEM;
   420		}
   421	
   422		disc_req[1] = SMP_DISCOVER;
   423	
   424		if (0 <= single && single < ex->num_phys) {
   425			res = sas_ex_phy_discover_helper(dev, disc_req, disc_resp, single);
   426		} else {
   427			int i;
   428	
   429			for (i = 0; i < ex->num_phys; i++) {
   430				res = sas_ex_phy_discover_helper(dev, disc_req,
   431								 disc_resp, i);
   432				if (res)
   433					goto out_err;
   434			}
   435		}
   436	out_err:
   437		kfree(disc_resp);
   438		kfree(disc_req);
   439		return res;
   440	}
   441	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
5CfbHdn9otVzAfp/pe4u3X4sAQA=

--tKW2IUtsqtDRztdT--
