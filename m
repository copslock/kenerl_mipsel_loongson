Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 21:14:09 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:7642 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992096AbeCZTOCP1HT7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Mar 2018 21:14:02 +0200
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2018 12:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000"; 
   d="scan'208";a="45450249"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2018 12:13:56 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1f0XZ5-000BHk-Cd; Tue, 27 Mar 2018 03:13:55 +0800
Date:   Tue, 27 Mar 2018 03:13:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kbuild-all@01.org, "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <201803270232.QvYkUzOs%fengguang.wu@intel.com>
References: <20180323201117.8416-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63235
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

Hi Alexandre,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20180323]
[also build test WARNING on v4.16-rc7]
[cannot apply to net-next/master net/master robh/for-next v4.16-rc6 v4.16-rc5 v4.16-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/Microsemi-Ocelot-switch-support/20180325-234932
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/mscc/ocelot.c:395:17: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] [usertype] val @@    got ed int [unsigned] [usertype] val @@
   drivers/net/ethernet/mscc/ocelot.c:395:17:    expected unsigned int [unsigned] [usertype] val
   drivers/net/ethernet/mscc/ocelot.c:395:17:    got restricted __le32 [usertype] <noident>
--
>> drivers/net/ethernet/mscc/ocelot_io.c:110:24: sparse: incorrect type in return expression (different address spaces) @@    expected struct regmap * @@    got void [noderef] <asnstruct regmap * @@
   drivers/net/ethernet/mscc/ocelot_io.c:110:24:    expected struct regmap *
   drivers/net/ethernet/mscc/ocelot_io.c:110:24:    got void [noderef] <asn:2>*[assigned] regs
--
>> drivers/net/ethernet/mscc/ocelot_board.c:41:26: sparse: cast to restricted __be32
>> drivers/net/ethernet/mscc/ocelot_board.c:41:26: sparse: cast to restricted __be32
>> drivers/net/ethernet/mscc/ocelot_board.c:41:26: sparse: cast to restricted __be32
>> drivers/net/ethernet/mscc/ocelot_board.c:41:26: sparse: cast to restricted __be32
>> drivers/net/ethernet/mscc/ocelot_board.c:41:26: sparse: cast to restricted __be32
>> drivers/net/ethernet/mscc/ocelot_board.c:41:26: sparse: cast to restricted __be32
>> drivers/net/ethernet/mscc/ocelot_board.c:142:34: sparse: cast to restricted __le32

vim +395 drivers/net/ethernet/mscc/ocelot.c

   367	
   368	static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
   369	{
   370		struct ocelot_port *port = netdev_priv(dev);
   371		struct ocelot *ocelot = port->ocelot;
   372		u32 val, ifh[IFH_LEN];
   373		struct frame_info info = {};
   374		u8 grp = 0; /* Send everything on CPU group 0 */
   375		int i, count, last;
   376	
   377		val = ocelot_read(ocelot, QS_INJ_STATUS);
   378		if (!(val & QS_INJ_STATUS_FIFO_RDY(BIT(grp))) ||
   379		    (val & QS_INJ_STATUS_WMARK_REACHED(BIT(grp))))
   380			return NETDEV_TX_BUSY;
   381	
   382		ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
   383				 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
   384	
   385		info.port = BIT(port->chip_port);
   386		info.cpuq = 0xff;
   387		ocelot_gen_ifh(ifh, &info);
   388	
   389		for (i = 0; i < IFH_LEN; i++)
   390			ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
   391	
   392		count = (skb->len + 3) / 4;
   393		last = skb->len % 4;
   394		for (i = 0; i < count; i++) {
 > 395			ocelot_write_rix(ocelot, cpu_to_le32(((u32 *)skb->data)[i]),
   396					 QS_INJ_WR, grp);
   397		}
   398	
   399		/* Add padding */
   400		while (i < (OCELOT_BUFFER_CELL_SZ / 4)) {
   401			ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
   402			i++;
   403		}
   404	
   405		/* Indicate EOF and valid bytes in last word */
   406		ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
   407				 QS_INJ_CTRL_VLD_BYTES(skb->len < OCELOT_BUFFER_CELL_SZ ? 0 : last) |
   408				 QS_INJ_CTRL_EOF,
   409				 QS_INJ_CTRL, grp);
   410	
   411		/* Add dummy CRC */
   412		ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
   413		skb_tx_timestamp(skb);
   414	
   415		dev->stats.tx_packets++;
   416		dev->stats.tx_bytes += skb->len;
   417		dev_kfree_skb_any(skb);
   418	
   419		return NETDEV_TX_OK;
   420	}
   421	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
