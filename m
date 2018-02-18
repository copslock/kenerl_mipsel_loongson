Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 17:02:31 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:31252 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeBRQCXcMd5l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Feb 2018 17:02:23 +0100
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2018 08:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,530,1511856000"; 
   d="scan'208";a="18760032"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 18 Feb 2018 08:02:17 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1enRQ4-000LPX-5K; Mon, 19 Feb 2018 00:02:28 +0800
Date:   Mon, 19 Feb 2018 00:01:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 12/14] net: pch_gbe: Fix TX RX descriptor accesses for
 big endian systems
Message-ID: <201802182340.LT7WVxhJ%fengguang.wu@intel.com>
References: <20180217201037.3006-13-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217201037.3006-13-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62612
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

Hi Hassan,

Thank you for the patch! Perhaps something to improve:

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
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: sparse: incorrect type in argument 1 (different address spaces) @@ expected void const volatile @@ got @@
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: expected void const volatile
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: got void
   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:325:15: sparse: incorrect type in argument 1 (different address spaces) @@ expected void const volatile @@ got @@
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
>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:1587:17: sparse: cast from restricted __le16
>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:1587:17: sparse: restricted __le16 degrades to integer

vim +1587 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c

  1527	
  1528	/**
  1529	 * pch_gbe_clean_tx - Reclaim resources after transmit completes
  1530	 * @adapter:   Board private structure
  1531	 * @tx_ring:   Tx descriptor ring
  1532	 * Returns:
  1533	 *	true:  Cleaned the descriptor
  1534	 *	false: Not cleaned the descriptor
  1535	 */
  1536	static bool
  1537	pch_gbe_clean_tx(struct pch_gbe_adapter *adapter,
  1538			 struct pch_gbe_tx_ring *tx_ring)
  1539	{
  1540		struct pch_gbe_tx_desc *tx_desc;
  1541		struct pch_gbe_buffer *buffer_info;
  1542		struct sk_buff *skb;
  1543		unsigned int i;
  1544		unsigned int cleaned_count = 0;
  1545		bool cleaned = false;
  1546		int unused, thresh;
  1547	
  1548		netdev_dbg(adapter->netdev, "next_to_clean : %d\n",
  1549			   tx_ring->next_to_clean);
  1550	
  1551		i = tx_ring->next_to_clean;
  1552		tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
  1553		netdev_dbg(adapter->netdev, "gbec_status:0x%04x  dma_status:0x%04x\n",
  1554			   le16_to_cpu(tx_desc->gbec_status), tx_desc->dma_status);
  1555	
  1556		unused = PCH_GBE_DESC_UNUSED(tx_ring);
  1557		thresh = tx_ring->count - PCH_GBE_TX_WEIGHT;
  1558		if ((le16_to_cpu(tx_desc->gbec_status) == DSC_INIT16) &&
  1559		    (unused < thresh))
  1560		{  /* current marked clean, tx queue filling up, do extra clean */
  1561			int j, k;
  1562			if (unused < 8) {  /* tx queue nearly full */
  1563				netdev_dbg(adapter->netdev,
  1564					   "clean_tx: transmit queue warning (%x,%x) unused=%d\n",
  1565					   tx_ring->next_to_clean, tx_ring->next_to_use,
  1566					   unused);
  1567			}
  1568	
  1569			/* current marked clean, scan for more that need cleaning. */
  1570			k = i;
  1571			for (j = 0; j < PCH_GBE_TX_WEIGHT; j++)
  1572			{
  1573				tx_desc = PCH_GBE_TX_DESC(*tx_ring, k);
  1574				if (le16_to_cpu(tx_desc->gbec_status) != DSC_INIT16)
  1575					break; /*found*/
  1576				if (++k >= tx_ring->count) k = 0;  /*increment, wrap*/
  1577			}
  1578			if (j < PCH_GBE_TX_WEIGHT) {
  1579				netdev_dbg(adapter->netdev,
  1580					   "clean_tx: unused=%d loops=%d found tx_desc[%x,%x:%x].gbec_status=%04x\n",
  1581					   unused, j, i, k, tx_ring->next_to_use,
  1582					   le16_to_cpu(tx_desc->gbec_status));
  1583				i = k;  /*found one to clean, usu gbec_status==2000.*/
  1584			}
  1585		}
  1586	
> 1587		while ((cpu_to_le16(tx_desc->gbec_status) & DSC_INIT16) == 0x0000) {
  1588			netdev_dbg(adapter->netdev, "gbec_status:0x%04x\n",
  1589				   le16_to_cpu(tx_desc->gbec_status));
  1590			buffer_info = &tx_ring->buffer_info[i];
  1591			skb = buffer_info->skb;
  1592			cleaned = true;
  1593	
  1594			if ((le16_to_cpu(tx_desc->gbec_status) &
  1595				PCH_GBE_TXD_GMAC_STAT_ABT)) {
  1596				adapter->stats.tx_aborted_errors++;
  1597				netdev_err(adapter->netdev, "Transfer Abort Error\n");
  1598			} else if ((le16_to_cpu(tx_desc->gbec_status) &
  1599					PCH_GBE_TXD_GMAC_STAT_CRSER)) {
  1600				adapter->stats.tx_carrier_errors++;
  1601				netdev_err(adapter->netdev,
  1602					   "Transfer Carrier Sense Error\n");
  1603			} else if ((le16_to_cpu(tx_desc->gbec_status) &
  1604						PCH_GBE_TXD_GMAC_STAT_EXCOL)) {
  1605				adapter->stats.tx_aborted_errors++;
  1606				netdev_err(adapter->netdev,
  1607					   "Transfer Collision Abort Error\n");
  1608			} else if ((le16_to_cpu(tx_desc->gbec_status) &
  1609				    (PCH_GBE_TXD_GMAC_STAT_SNGCOL |
  1610				     PCH_GBE_TXD_GMAC_STAT_MLTCOL))) {
  1611				adapter->stats.collisions++;
  1612				adapter->stats.tx_packets++;
  1613				adapter->stats.tx_bytes += skb->len;
  1614				netdev_dbg(adapter->netdev, "Transfer Collision\n");
  1615			} else if ((le16_to_cpu(tx_desc->gbec_status) &
  1616					PCH_GBE_TXD_GMAC_STAT_CMPLT)) {
  1617				adapter->stats.tx_packets++;
  1618				adapter->stats.tx_bytes += skb->len;
  1619			}
  1620			if (buffer_info->mapped) {
  1621				netdev_dbg(adapter->netdev,
  1622					   "unmap buffer_info->dma : %d\n", i);
  1623				dma_unmap_single(&adapter->pdev->dev, buffer_info->dma,
  1624						 buffer_info->length, DMA_TO_DEVICE);
  1625				buffer_info->mapped = false;
  1626			}
  1627			if (buffer_info->skb) {
  1628				netdev_dbg(adapter->netdev,
  1629					   "trim buffer_info->skb : %d\n", i);
  1630				skb_trim(buffer_info->skb, 0);
  1631			}
  1632			tx_desc->gbec_status = cpu_to_le16(DSC_INIT16);
  1633			if (unlikely(++i == tx_ring->count))
  1634				i = 0;
  1635			tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
  1636	
  1637			/* weight of a sort for tx, to avoid endless transmit cleanup */
  1638			if (cleaned_count++ == PCH_GBE_TX_WEIGHT) {
  1639				cleaned = false;
  1640				break;
  1641			}
  1642		}
  1643		netdev_dbg(adapter->netdev,
  1644			   "called pch_gbe_unmap_and_free_tx_resource() %d count\n",
  1645			   cleaned_count);
  1646		if (cleaned_count > 0)  { /*skip this if nothing cleaned*/
  1647			/* Recover from running out of Tx resources in xmit_frame */
  1648			netif_tx_lock(adapter->netdev);
  1649			if (unlikely(cleaned && (netif_queue_stopped(adapter->netdev))))
  1650			{
  1651				netif_wake_queue(adapter->netdev);
  1652				adapter->stats.tx_restart_count++;
  1653				netdev_dbg(adapter->netdev, "Tx wake queue\n");
  1654			}
  1655	
  1656			tx_ring->next_to_clean = i;
  1657	
  1658			netdev_dbg(adapter->netdev, "next_to_clean : %d\n",
  1659				   tx_ring->next_to_clean);
  1660			netif_tx_unlock(adapter->netdev);
  1661		}
  1662		return cleaned;
  1663	}
  1664	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
