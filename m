Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 16:30:33 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:58611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeBRPaWSyCZl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Feb 2018 16:30:22 +0100
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2018 07:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,530,1511856000"; 
   d="scan'208";a="18756973"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 18 Feb 2018 07:30:16 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1enQv4-000LBi-G2; Sun, 18 Feb 2018 23:30:26 +0800
Date:   Sun, 18 Feb 2018 23:29:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 06/14] net: pch_gbe: Allow longer for resets
Message-ID: <201802182337.MbzFpPAM%fengguang.wu@intel.com>
References: <20180217201037.3006-7-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217201037.3006-7-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62609
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

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.16-rc1 next-20180216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Burton/net-pch_gbe-Fixes-MIPS-support/20180218-213023
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:33: sparse: incorrect type in argument 2 (different base types) @@ expected unsigned short uid_hi @@ got short uid_hi @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:33: expected unsigned short uid_hi
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:33: got restricted __be16 <noident>
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:45: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int uid_lo @@ got ed int uid_lo @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:45: expected unsigned int uid_lo
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:45: got restricted __be32 <noident>
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:56: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned short seqid @@ got short seqid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:56: expected unsigned short seqid
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:177:56: got restricted __be16 <noident>
>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: sparse: incorrect type in argument 1 (different address spaces) @@ expected void const volatile @@ got @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: expected void const volatile
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: got void
>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: sparse: incorrect type in argument 1 (different address spaces) @@ expected void const volatile @@ got @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: expected void const volatile
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: got void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:354:33: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got unsigned int <avoid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:354:33: expected void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:354:33: got unsigned int
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:361:33: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got unsigned int <avoid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:361:33: expected void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:361:33: got unsigned int
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:389:33: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got unsigned int <avoid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:389:33: expected void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:389:33: got unsigned int
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:430:33: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got unsigned int <avoid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:430:33: expected void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:430:33: got unsigned int
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:463:49: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got unsigned int <avoid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:463:49: expected void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:463:49: got unsigned int
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:537:41: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got unsigned int <avoid @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:537:41: expected void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:537:41: got unsigned int

vim +325 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c

   150	
   151	static void
   152	pch_rx_timestamp(struct pch_gbe_adapter *adapter, struct sk_buff *skb)
   153	{
   154		struct skb_shared_hwtstamps *shhwtstamps;
   155		struct pci_dev *pdev;
   156		u64 ns;
   157		u32 hi, lo, val;
   158		u16 uid, seq;
   159	
   160		if (!adapter->hwts_rx_en)
   161			return;
   162	
   163		/* Get ieee1588's dev information */
   164		pdev = adapter->ptp_pdev;
   165	
   166		val = pch_ch_event_read(pdev);
   167	
   168		if (!(val & RX_SNAPSHOT_LOCKED))
   169			return;
   170	
   171		lo = pch_src_uuid_lo_read(pdev);
   172		hi = pch_src_uuid_hi_read(pdev);
   173	
   174		uid = hi & 0xffff;
   175		seq = (hi >> 16) & 0xffff;
   176	
 > 177		if (!pch_ptp_match(skb, htons(uid), htonl(lo), htons(seq)))
   178			goto out;
   179	
   180		ns = pch_rx_snap_read(pdev);
   181	
   182		shhwtstamps = skb_hwtstamps(skb);
   183		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
   184		shhwtstamps->hwtstamp = ns_to_ktime(ns);
   185	out:
   186		pch_ch_event_write(pdev, RX_SNAPSHOT_LOCKED);
   187	}
   188	
   189	static void
   190	pch_tx_timestamp(struct pch_gbe_adapter *adapter, struct sk_buff *skb)
   191	{
   192		struct skb_shared_hwtstamps shhwtstamps;
   193		struct pci_dev *pdev;
   194		struct skb_shared_info *shtx;
   195		u64 ns;
   196		u32 cnt, val;
   197	
   198		shtx = skb_shinfo(skb);
   199		if (likely(!(shtx->tx_flags & SKBTX_HW_TSTAMP && adapter->hwts_tx_en)))
   200			return;
   201	
   202		shtx->tx_flags |= SKBTX_IN_PROGRESS;
   203	
   204		/* Get ieee1588's dev information */
   205		pdev = adapter->ptp_pdev;
   206	
   207		/*
   208		 * This really stinks, but we have to poll for the Tx time stamp.
   209		 */
   210		for (cnt = 0; cnt < 100; cnt++) {
   211			val = pch_ch_event_read(pdev);
   212			if (val & TX_SNAPSHOT_LOCKED)
   213				break;
   214			udelay(1);
   215		}
   216		if (!(val & TX_SNAPSHOT_LOCKED)) {
   217			shtx->tx_flags &= ~SKBTX_IN_PROGRESS;
   218			return;
   219		}
   220	
   221		ns = pch_tx_snap_read(pdev);
   222	
   223		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
   224		shhwtstamps.hwtstamp = ns_to_ktime(ns);
   225		skb_tstamp_tx(skb, &shhwtstamps);
   226	
   227		pch_ch_event_write(pdev, TX_SNAPSHOT_LOCKED);
   228	}
   229	
   230	static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
   231	{
   232		struct hwtstamp_config cfg;
   233		struct pch_gbe_adapter *adapter = netdev_priv(netdev);
   234		struct pci_dev *pdev;
   235		u8 station[20];
   236	
   237		if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
   238			return -EFAULT;
   239	
   240		if (cfg.flags) /* reserved for future extensions */
   241			return -EINVAL;
   242	
   243		/* Get ieee1588's dev information */
   244		pdev = adapter->ptp_pdev;
   245	
   246		if (cfg.tx_type != HWTSTAMP_TX_OFF && cfg.tx_type != HWTSTAMP_TX_ON)
   247			return -ERANGE;
   248	
   249		switch (cfg.rx_filter) {
   250		case HWTSTAMP_FILTER_NONE:
   251			adapter->hwts_rx_en = 0;
   252			break;
   253		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
   254			adapter->hwts_rx_en = 0;
   255			pch_ch_control_write(pdev, SLAVE_MODE | CAP_MODE0);
   256			break;
   257		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
   258			adapter->hwts_rx_en = 1;
   259			pch_ch_control_write(pdev, MASTER_MODE | CAP_MODE0);
   260			break;
   261		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
   262			adapter->hwts_rx_en = 1;
   263			pch_ch_control_write(pdev, V2_MODE | CAP_MODE2);
   264			strcpy(station, PTP_L4_MULTICAST_SA);
   265			pch_set_station_address(station, pdev);
   266			break;
   267		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
   268			adapter->hwts_rx_en = 1;
   269			pch_ch_control_write(pdev, V2_MODE | CAP_MODE2);
   270			strcpy(station, PTP_L2_MULTICAST_SA);
   271			pch_set_station_address(station, pdev);
   272			break;
   273		default:
   274			return -ERANGE;
   275		}
   276	
   277		adapter->hwts_tx_en = cfg.tx_type == HWTSTAMP_TX_ON;
   278	
   279		/* Clear out any old time stamps. */
   280		pch_ch_event_write(pdev, TX_SNAPSHOT_LOCKED | RX_SNAPSHOT_LOCKED);
   281	
   282		return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
   283	}
   284	
   285	static inline void pch_gbe_mac_load_mac_addr(struct pch_gbe_hw *hw)
   286	{
   287		iowrite32(0x01, &hw->reg->MAC_ADDR_LOAD);
   288	}
   289	
   290	/**
   291	 * pch_gbe_mac_read_mac_addr - Read MAC address
   292	 * @hw:	            Pointer to the HW structure
   293	 * Returns:
   294	 *	0:			Successful.
   295	 */
   296	s32 pch_gbe_mac_read_mac_addr(struct pch_gbe_hw *hw)
   297	{
   298		struct pch_gbe_adapter *adapter = pch_gbe_hw_to_adapter(hw);
   299		u32  adr1a, adr1b;
   300	
   301		adr1a = ioread32(&hw->reg->mac_adr[0].high);
   302		adr1b = ioread32(&hw->reg->mac_adr[0].low);
   303	
   304		hw->mac.addr[0] = (u8)(adr1a & 0xFF);
   305		hw->mac.addr[1] = (u8)((adr1a >> 8) & 0xFF);
   306		hw->mac.addr[2] = (u8)((adr1a >> 16) & 0xFF);
   307		hw->mac.addr[3] = (u8)((adr1a >> 24) & 0xFF);
   308		hw->mac.addr[4] = (u8)(adr1b & 0xFF);
   309		hw->mac.addr[5] = (u8)((adr1b >> 8) & 0xFF);
   310	
   311		netdev_dbg(adapter->netdev, "hw->mac.addr : %pM\n", hw->mac.addr);
   312		return 0;
   313	}
   314	
   315	/**
   316	 * pch_gbe_wait_clr_bit - Wait to clear a bit
   317	 * @reg:	Pointer of register
   318	 * @busy:	Busy bit
   319	 */
   320	static void pch_gbe_wait_clr_bit(void *reg, u32 bit)
   321	{
   322		int err;
   323		u32 tmp;
   324	
 > 325		err = readl_poll_timeout_atomic(reg, tmp, !(tmp & bit), 10, 25000);
   326		if (err)
   327			pr_err("Error: busy bit is not cleared\n");
   328	}
   329	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
