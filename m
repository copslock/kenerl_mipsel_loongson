Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 20:14:10 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:45348
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdKBTOBEoVqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 20:14:01 +0100
Received: by mail-pg0-x242.google.com with SMTP id b192so448638pga.2;
        Thu, 02 Nov 2017 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbkXiN1XIvyBk2F0ZSTD2iaIU1Fmi+RXsdEAcqVxa5Y=;
        b=Dys5ETXzNRZHF6ZEU7E6SKcbSaw4qaL/gN/Xee8D0ToZc6n8lBfvBHLROI5+5gQ6Pu
         WBBGS2ubUkyDPz4hMeujMbC1feefNBWN8utWjnd1sO1+z0s31CoMJprcFXRuQdDykygs
         eH8WYuHgMkMDOa2D44Agqr03nfUsFHjktNKdSTiJ4NLZ+8SgHKI6evbHmPyeEROXD40u
         Qy5AaLCJNSxXmHP28U/OVPG28V2NU4tcyDbf1n+XKZoiDxwRCIM1wmkJllH9OMXJacYX
         7BkYQNjQs3iYteoUUPYDwKE6MirJY1oi6mrXRTuj/HagGcwO5zGZ20t6ATcytJqm93GK
         JCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbkXiN1XIvyBk2F0ZSTD2iaIU1Fmi+RXsdEAcqVxa5Y=;
        b=BPq3R7F7xqO5PG6bgAhnv2vxj8sKP1GGHOSg+Rb919FtwHDmyKZydNqisb3iK4DPUg
         3qRRrrLiIYJPQDWIOMiKBvs3vWahkX9Qkcpw4QQLLt/aLDaC4fJNpEMq9IDlUgLkVv9c
         yKwVrcyoMo3pKDPURfFP5/Wy+z3+vNUApHHU8ZeNrCFCZ4POB67PibgcqOwfUm2RO+S+
         kuLYamNgD4lUMkyxCPDiOEFrdGuareL1zcPFDcUiI2bfAoJLRsln1/PPFuJBYGr/8dlW
         dyBAkJ+72IvcJAjeLrCGhtEGWOXRNSk7SR+I62RznefAgzbN21Rhklkpq1JPM8jz0J1B
         6ljg==
X-Gm-Message-State: AMCzsaUeDWg3slkM5UQh58/9tDfhgtjRejEiOKyIwShbjl3ZNxspnSPh
        YeGiE91w0qpf9Tc8Zhmy/TM=
X-Google-Smtp-Source: ABhQp+R6muuuu7c5sjWBJRk5Frm1oSXt/K5AEgb/tnGY+KNgxx5MLXp5Ss3L11pgRdqmmvg4hp1rFA==
X-Received: by 10.159.235.147 with SMTP id f19mr4304845plr.42.1509650032899;
        Thu, 02 Nov 2017 12:13:52 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id r78sm8823363pfb.29.2017.11.02.12.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 12:13:51 -0700 (PDT)
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <55d6cf88-7444-42ea-02f1-27efdee2be4b@gmail.com>
Date:   Thu, 2 Nov 2017 12:13:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171102003606.19913-7-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 11/01/2017 05:36 PM, David Daney wrote:
> From: Carlos Munoz <cmunoz@cavium.com>
> 
> The Cavium OCTEON cn78xx and cn73xx SoCs have network packet I/O
> hardware that is significantly different from previous generations of
> the family.
> 
> Add a new driver for this hardware.  The Ethernet MAC is called BGX on
> these devices.  Common code for the MAC is in octeon3-bgx-port.c.
> Four of these BGX MACs are grouped together and managed as a group by
> octeon3-bgx-nexus.c.  Ingress packet classification is done by the PKI
> unit initialized in octeon3-pki.c.  Queue management is done in the
> SSO, initialized by octeon3-sso.c.  Egress is handled by the PKO,
> initialized in octeon3-pko.c.
> 
> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---

> +static char *mix_port;
> +module_param(mix_port, charp, 0444);
> +MODULE_PARM_DESC(mix_port, "Specifies which ports connect to MIX interfaces.");

Can you derive this from Device Tree /platform data configuration?

> +
> +static char *pki_port;
> +module_param(pki_port, charp, 0444);
> +MODULE_PARM_DESC(pki_port, "Specifies which ports connect to the PKI.");

Likewise

> +
> +#define MAX_MIX_PER_NODE	2
> +
> +#define MAX_MIX			(MAX_NODES * MAX_MIX_PER_NODE)
> +
> +/**
> + * struct mix_port_lmac - Describes a lmac that connects to a mix
> + *			  port. The lmac must be on the same node as
> + *			  the mix.
> + * @node:	Node of the lmac.
> + * @bgx:	Bgx of the lmac.
> + * @lmac:	Lmac index.
> + */
> +struct mix_port_lmac {
> +	int	node;
> +	int	bgx;
> +	int	lmac;
> +};
> +
> +/* mix_ports_lmacs contains all the lmacs connected to mix ports */
> +static struct mix_port_lmac mix_port_lmacs[MAX_MIX];
> +
> +/* pki_ports keeps track of the lmacs connected to the pki */
> +static bool pki_ports[MAX_NODES][MAX_BGX_PER_NODE][MAX_LMAC_PER_BGX];
> +
> +/* Created platform devices get added to this list */
> +static struct list_head pdev_list;
> +static struct mutex pdev_list_lock;
> +
> +/* Created platform device use this structure to add themselves to the list */
> +struct pdev_list_item {
> +	struct list_head	list;
> +	struct platform_device	*pdev;
> +};

Don't you have a top-level platform device that you could use which
would hold this data instead of having it here?

[snip]

> +/* Registers are accessed via xkphys */
> +#define SSO_BASE			0x1670000000000ull
> +#define SSO_ADDR(node)			(SET_XKPHYS + NODE_OFFSET(node) +      \
> +					 SSO_BASE)
> +#define GRP_OFFSET(grp)			((grp) << 16)
> +#define GRP_ADDR(n, g)			(SSO_ADDR(n) + GRP_OFFSET(g))
> +#define SSO_GRP_AQ_CNT(n, g)		(GRP_ADDR(n, g)		   + 0x20000700)
> +
> +#define MIO_PTP_BASE			0x1070000000000ull
> +#define MIO_PTP_ADDR(node)		(SET_XKPHYS + NODE_OFFSET(node) +      \
> +					 MIO_PTP_BASE)
> +#define MIO_PTP_CLOCK_CFG(node)		(MIO_PTP_ADDR(node)		+ 0xf00)
> +#define MIO_PTP_CLOCK_HI(node)		(MIO_PTP_ADDR(node)		+ 0xf10)
> +#define MIO_PTP_CLOCK_COMP(node)	(MIO_PTP_ADDR(node)		+ 0xf18)

I am sure this will work great on anything but MIPS64 ;)

> +
> +struct octeon3_ethernet;
> +
> +struct octeon3_rx {
> +	struct napi_struct	napi;
> +	struct octeon3_ethernet *parent;
> +	int rx_grp;
> +	int rx_irq;
> +	cpumask_t rx_affinity_hint;
> +} ____cacheline_aligned_in_smp;
> +
> +struct octeon3_ethernet {
> +	struct bgx_port_netdev_priv bgx_priv; /* Must be first element. */
> +	struct list_head list;
> +	struct net_device *netdev;
> +	enum octeon3_mac_type mac_type;
> +	struct octeon3_rx rx_cxt[MAX_RX_QUEUES];
> +	struct ptp_clock_info ptp_info;
> +	struct ptp_clock *ptp_clock;
> +	struct cyclecounter cc;
> +	struct timecounter tc;
> +	spinlock_t ptp_lock;		/* Serialize ptp clock adjustments */
> +	int num_rx_cxt;
> +	int pki_aura;
> +	int pknd;
> +	int pko_queue;
> +	int node;
> +	int interface;
> +	int index;
> +	int rx_buf_count;
> +	int tx_complete_grp;
> +	int rx_timestamp_hw:1;
> +	int tx_timestamp_hw:1;
> +	spinlock_t stat_lock;		/* Protects stats counters */
> +	u64 last_packets;
> +	u64 last_octets;
> +	u64 last_dropped;
> +	atomic64_t rx_packets;
> +	atomic64_t rx_octets;
> +	atomic64_t rx_dropped;
> +	atomic64_t rx_errors;
> +	atomic64_t rx_length_errors;
> +	atomic64_t rx_crc_errors;
> +	atomic64_t tx_packets;
> +	atomic64_t tx_octets;
> +	atomic64_t tx_dropped;

Do you really need those to be truly atomic64_t types, can't you use u64
and use the helpers from u64_stats_sync.h? That should be good enough?

> +	/* The following two fields need to be on a different cache line as
> +	 * they are updated by pko which invalidates the cache every time it
> +	 * updates them. The idea is to prevent other fields from being
> +	 * invalidated unnecessarily.
> +	 */
> +	char cacheline_pad1[CVMX_CACHE_LINE_SIZE];
> +	atomic64_t buffers_needed;
> +	atomic64_t tx_backlog;
> +	char cacheline_pad2[CVMX_CACHE_LINE_SIZE];
> +};
> +
> +static DEFINE_MUTEX(octeon3_eth_init_mutex);
> +
> +struct octeon3_ethernet_node;
> +
> +struct octeon3_ethernet_worker {
> +	wait_queue_head_t queue;
> +	struct task_struct *task;
> +	struct octeon3_ethernet_node *oen;
> +	atomic_t kick;
> +	int order;
> +};
> +
> +struct octeon3_ethernet_node {
> +	bool init_done;
> +	int next_cpu_irq_affinity;
> +	int node;
> +	int pki_packet_pool;
> +	int sso_pool;
> +	int pko_pool;
> +	void *sso_pool_stack;
> +	void *pko_pool_stack;
> +	void *pki_packet_pool_stack;
> +	int sso_aura;
> +	int pko_aura;
> +	int tx_complete_grp;
> +	int tx_irq;
> +	cpumask_t tx_affinity_hint;
> +	struct octeon3_ethernet_worker workers[8];
> +	struct mutex device_list_lock;	/* Protects the device list */
> +	struct list_head device_list;
> +	spinlock_t napi_alloc_lock;	/* Protects napi allocations */
> +};
> +
> +static int wait_pko_response;
> +module_param(wait_pko_response, int, 0644);
> +MODULE_PARM_DESC(wait_pko_response, "Wait for response after each pko command.");

Under which circumstances is this used?

> +
> +static int num_packet_buffers = 768;
> +module_param(num_packet_buffers, int, 0444);
> +MODULE_PARM_DESC(num_packet_buffers,
> +		 "Number of packet buffers to allocate per port.");

Consider implementing ethtool -g/G for this.

> +
> +static int packet_buffer_size = 2048;
> +module_param(packet_buffer_size, int, 0444);
> +MODULE_PARM_DESC(packet_buffer_size, "Size of each RX packet buffer.");

How is that different from adjusting the network device's MTU?

> +
> +static int rx_queues = 1;
> +module_param(rx_queues, int, 0444);
> +MODULE_PARM_DESC(rx_queues, "Number of RX threads per port.");

Same thing, can you consider using an ethtool knob for that?

> +
> +int ilk0_lanes = 1;
> +module_param(ilk0_lanes, int, 0444);
> +MODULE_PARM_DESC(ilk0_lanes, "Number of SerDes lanes used by ILK link 0.");
> +
> +int ilk1_lanes = 1;
> +module_param(ilk1_lanes, int, 0444);
> +MODULE_PARM_DESC(ilk1_lanes, "Number of SerDes lanes used by ILK link 1.");
> +
> +static struct octeon3_ethernet_node octeon3_eth_node[MAX_NODES];
> +static struct kmem_cache *octeon3_eth_sso_pko_cache;
> +
> +/**
> + * Reads a 64 bit value from the processor local scratchpad memory.
> + *
> + * @param offset byte offset into scratch pad to read
> + *
> + * @return value read
> + */
> +static inline u64 scratch_read64(u64 offset)
> +{
> +	return *(u64 *)((long)SCRATCH_BASE + offset);
> +}

No barriers needed whatsoever?

> +
> +/**
> + * Write a 64 bit value to the processor local scratchpad memory.
> + *
> + * @param offset byte offset into scratch pad to write
> + @ @praram value to write
> + */
> +static inline void scratch_write64(u64 offset, u64 value)
> +{
> +	*(u64 *)((long)SCRATCH_BASE + offset) = value;
> +}
> +
> +static int get_pki_chan(int node, int interface, int index)
> +{
> +	int	pki_chan;
> +
> +	pki_chan = node << 12;
> +
> +	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) &&
> +	    (interface == 1 || interface == 2)) {
> +		/* SRIO */
> +		pki_chan |= 0x240 + (2 * (interface - 1)) + index;
> +	} else {
> +		/* BGX */
> +		pki_chan |= 0x800 + (0x100 * interface) + (0x10 * index);
> +	}
> +
> +	return pki_chan;
> +}
> +
> +/* Map auras to the field priv->buffers_needed. Used to speed up packet
> + * transmission.
> + */
> +static void *aura2bufs_needed[MAX_NODES][FPA3_NUM_AURAS];
> +
> +static int octeon3_eth_lgrp_to_ggrp(int node, int grp)
> +{
> +	return (node << 8) | grp;
> +}
> +
> +static void octeon3_eth_gen_affinity(int node, cpumask_t *mask)
> +{
> +	int cpu;
> +
> +	do {
> +		cpu = cpumask_next(octeon3_eth_node[node].next_cpu_irq_affinity, cpu_online_mask);
> +		octeon3_eth_node[node].next_cpu_irq_affinity++;
> +		if (cpu >= nr_cpu_ids) {
> +			octeon3_eth_node[node].next_cpu_irq_affinity = -1;
> +			continue;
> +		}
> +	} while (false);
> +	cpumask_clear(mask);
> +	cpumask_set_cpu(cpu, mask);
> +}
> +
> +struct wr_ret {
> +	void *work;
> +	u16 grp;
> +};
> +
> +static inline struct wr_ret octeon3_core_get_work_sync(int grp)
> +{
> +	u64		node = cvmx_get_node_num();
> +	u64		addr;
> +	u64		response;
> +	struct wr_ret	r;
> +
> +	/* See SSO_GET_WORK_LD_S for the address to read */
> +	addr = 1ull << 63;
> +	addr |= BIT(48);
> +	addr |= DID_TAG_SWTAG << 40;
> +	addr |= node << 36;
> +	addr |= BIT(30);
> +	addr |= BIT(29);
> +	addr |= octeon3_eth_lgrp_to_ggrp(node, grp) << 4;
> +	addr |= SSO_NO_WAIT << 3;
> +	response = __raw_readq((void __iomem *)addr);
> +
> +	/* See SSO_GET_WORK_RTN_S for the format of the response */
> +	r.grp = (response & GENMASK_ULL(57, 48)) >> 48;
> +	if (response & BIT(63))
> +		r.work = NULL;
> +	else
> +		r.work = phys_to_virt(response & GENMASK_ULL(41, 0));

There are quite a lot of phys_to_virt() and virt_to_phys() uses
throughout this driver, this will likely not work on anything but
MIPS64, so there should be a better way, abstracted to do this, see below.

> +
> +	return r;
> +}
> +
> +/**
> + * octeon3_core_get_work_async - Request work via a iobdma command. Doesn't wait
> + *				 for the response.
> + *
> + * @grp: Group to request work for.
> + */
> +static inline void octeon3_core_get_work_async(unsigned int grp)
> +{
> +	u64	data;
> +	u64	node = cvmx_get_node_num();
> +
> +	/* See SSO_GET_WORK_DMA_S for the command structure */
> +	data = SCR_SCRATCH << 56;
> +	data |= 1ull << 48;
> +	data |= DID_TAG_SWTAG << 40;
> +	data |= node << 36;
> +	data |= 1ull << 30;
> +	data |= 1ull << 29;
> +	data |= octeon3_eth_lgrp_to_ggrp(node, grp) << 4;
> +	data |= SSO_NO_WAIT << 3;
> +
> +	__raw_writeq(data, (void __iomem *)IOBDMA_SENDSINGLE);
> +}
> +
> +/**
> + * octeon3_core_get_response_async - Read the request work response. Must be
> + *				     called after calling
> + *				     octeon3_core_get_work_async().
> + *
> + * Returns work queue entry.
> + */
> +static inline struct wr_ret octeon3_core_get_response_async(void)
> +{
> +	struct wr_ret	r;
> +	u64		response;
> +
> +	CVMX_SYNCIOBDMA;
> +	response = scratch_read64(SCR_SCRATCH);
> +
> +	/* See SSO_GET_WORK_RTN_S for the format of the response */
> +	r.grp = (response & GENMASK_ULL(57, 48)) >> 48;
> +	if (response & BIT(63))
> +		r.work = NULL;
> +	else
> +		r.work = phys_to_virt(response & GENMASK_ULL(41, 0));
> +
> +	return r;
> +}
> +
> +static void octeon3_eth_replenish_rx(struct octeon3_ethernet *priv, int count)
> +{
> +	struct sk_buff *skb;
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		void **buf;
> +
> +		skb = __alloc_skb(packet_buffer_size, GFP_ATOMIC, 0, priv->node);
> +		if (!skb)
> +			break;
> +		buf = (void **)PTR_ALIGN(skb->head, 128);
> +		buf[SKB_PTR_OFFSET] = skb;

Can you use build_skb()?

> +		octeon_fpa3_free(priv->node, priv->pki_aura, buf);
> +	}
> +}
> +

[snip]

> +static int octeon3_eth_tx_complete_worker(void *data)
> +{
> +	struct octeon3_ethernet_worker *worker = data;
> +	struct octeon3_ethernet_node *oen = worker->oen;
> +	int backlog;
> +	int order = worker->order;
> +	int tx_complete_stop_thresh = order * 100;
> +	int backlog_stop_thresh = order == 0 ? 31 : order * 80;
> +	u64 aq_cnt;
> +	int i;
> +
> +	while (!kthread_should_stop()) {
> +		wait_event_interruptible(worker->queue, octeon3_eth_tx_complete_runnable(worker));
> +		atomic_dec_if_positive(&worker->kick); /* clear the flag */
> +
> +		do {
> +			backlog = octeon3_eth_replenish_all(oen);
> +			for (i = 0; i < 100; i++) {

Do you really want to bound your TX reclamation worker, all other
network drivers never bound their napi TX completion task and instead
reclaim every transmitted buffers.

> +				void **work;
> +				struct net_device *tx_netdev;
> +				struct octeon3_ethernet *tx_priv;
> +				struct sk_buff *skb;
> +				struct wr_ret r;
> +
> +				r = octeon3_core_get_work_sync(oen->tx_complete_grp);
> +				work = r.work;
> +				if (!work)
> +					break;
> +				tx_netdev = work[0];
> +				tx_priv = netdev_priv(tx_netdev);
> +				if (unlikely(netif_queue_stopped(tx_netdev)) &&
> +				    atomic64_read(&tx_priv->tx_backlog) < MAX_TX_QUEUE_DEPTH)
> +					netif_wake_queue(tx_netdev);
> +				skb = container_of((void *)work, struct sk_buff, cb);
> +				if (unlikely(tx_priv->tx_timestamp_hw) &&
> +				    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS))
> +					octeon3_eth_tx_complete_hwtstamp(tx_priv, skb);

This is where you should be incremeting the TX bytes and packets
statistcs, not in your ndo_start_xmit() like you are currently doing.

> +				dev_kfree_skb(skb);

Consider using dev_consume_skb() to be drop-monitor friendly.

> +			}
> +
> +			aq_cnt = oct_csr_read(SSO_GRP_AQ_CNT(oen->node, oen->tx_complete_grp));
> +			aq_cnt &= GENMASK_ULL(32, 0);
> +			if ((backlog > backlog_stop_thresh || aq_cnt > tx_complete_stop_thresh) &&
> +			    order < ARRAY_SIZE(oen->workers) - 1) {
> +				atomic_set(&oen->workers[order + 1].kick, 1);
> +				wake_up(&oen->workers[order + 1].queue);
> +			}
> +		} while (!need_resched() &&
> +			 (backlog > backlog_stop_thresh ||
> +			  aq_cnt > tx_complete_stop_thresh));
> +
> +		cond_resched();
> +
> +		if (!octeon3_eth_tx_complete_runnable(worker))
> +			octeon3_sso_irq_set(oen->node, oen->tx_complete_grp, true);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t octeon3_eth_tx_handler(int irq, void *info)
> +{
> +	struct octeon3_ethernet_node *oen = info;
> +	/* Disarm the irq. */
> +	octeon3_sso_irq_set(oen->node, oen->tx_complete_grp, false);
> +	atomic_set(&oen->workers[0].kick, 1);
> +	wake_up(&oen->workers[0].queue);

Can you move the whole worker to a NAPI context/softirq context?

> +	return IRQ_HANDLED;
> +}
> +
> +static int octeon3_eth_global_init(unsigned int node,
> +				   struct platform_device *pdev)
> +{
> +	int i;
> +	int rv = 0;
> +	unsigned int sso_intsn;
> +	struct octeon3_ethernet_node *oen;
> +
> +	mutex_lock(&octeon3_eth_init_mutex);
> +
> +	oen = octeon3_eth_node + node;
> +
> +	if (oen->init_done)
> +		goto done;
> +
> +	/* CN78XX-P1.0 cannot un-initialize PKO, so get a module
> +	 * reference to prevent it from being unloaded.
> +	 */
> +	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_0))
> +		if (!try_module_get(THIS_MODULE))
> +			dev_err(&pdev->dev,
> +				"ERROR: Could not obtain module reference for CN78XX-P1.0\n");
> +
> +	INIT_LIST_HEAD(&oen->device_list);
> +	mutex_init(&oen->device_list_lock);
> +	spin_lock_init(&oen->napi_alloc_lock);
> +
> +	oen->node = node;
> +
> +	octeon_fpa3_init(node);
> +	rv = octeon_fpa3_pool_init(node, -1, &oen->sso_pool,
> +				   &oen->sso_pool_stack, 40960);
> +	if (rv)
> +		goto done;
> +
> +	rv = octeon_fpa3_pool_init(node, -1, &oen->pko_pool,
> +				   &oen->pko_pool_stack, 40960);
> +	if (rv)
> +		goto done;
> +
> +	rv = octeon_fpa3_pool_init(node, -1, &oen->pki_packet_pool,
> +				   &oen->pki_packet_pool_stack, 64 * num_packet_buffers);
> +	if (rv)
> +		goto done;
> +
> +	rv = octeon_fpa3_aura_init(node, oen->sso_pool, -1,
> +				   &oen->sso_aura, num_packet_buffers, 20480);
> +	if (rv)
> +		goto done;
> +
> +	rv = octeon_fpa3_aura_init(node, oen->pko_pool, -1,
> +				   &oen->pko_aura, num_packet_buffers, 20480);
> +	if (rv)
> +		goto done;
> +
> +	dev_info(&pdev->dev, "SSO:%d:%d, PKO:%d:%d\n", oen->sso_pool,
> +		 oen->sso_aura, oen->pko_pool, oen->pko_aura);
> +
> +	if (!octeon3_eth_sso_pko_cache) {
> +		octeon3_eth_sso_pko_cache = kmem_cache_create("sso_pko", 4096, 128, 0, NULL);
> +		if (!octeon3_eth_sso_pko_cache) {
> +			rv = -ENOMEM;
> +			goto done;
> +		}
> +	}
> +
> +	rv = octeon_fpa3_mem_fill(node, octeon3_eth_sso_pko_cache,
> +				  oen->sso_aura, 1024);
> +	if (rv)
> +		goto done;
> +
> +	rv = octeon_fpa3_mem_fill(node, octeon3_eth_sso_pko_cache,
> +				  oen->pko_aura, 1024);
> +	if (rv)
> +		goto done;
> +
> +	rv = octeon3_sso_init(node, oen->sso_aura);
> +	if (rv)
> +		goto done;
> +
> +	oen->tx_complete_grp = octeon3_sso_alloc_grp(node, -1);
> +	if (oen->tx_complete_grp < 0)
> +		goto done;
> +
> +	sso_intsn = SSO_INTSN_EXE << 12 | oen->tx_complete_grp;
> +	oen->tx_irq = irq_create_mapping(NULL, sso_intsn);
> +	if (!oen->tx_irq) {
> +		rv = -ENODEV;
> +		goto done;
> +	}
> +
> +	rv = octeon3_pko_init_global(node, oen->pko_aura);
> +	if (rv) {
> +		rv = -ENODEV;
> +		goto done;
> +	}
> +
> +	octeon3_pki_vlan_init(node);
> +	octeon3_pki_cluster_init(node, pdev);
> +	octeon3_pki_ltype_init(node);
> +	octeon3_pki_enable(node);
> +
> +	for (i = 0; i < ARRAY_SIZE(oen->workers); i++) {
> +		oen->workers[i].oen = oen;
> +		init_waitqueue_head(&oen->workers[i].queue);
> +		oen->workers[i].order = i;
> +	}
> +	for (i = 0; i < ARRAY_SIZE(oen->workers); i++) {
> +		oen->workers[i].task = kthread_create_on_node(octeon3_eth_tx_complete_worker,
> +							      oen->workers + i, node,
> +							      "oct3_eth/%d:%d", node, i);
> +		if (IS_ERR(oen->workers[i].task)) {
> +			rv = PTR_ERR(oen->workers[i].task);
> +			goto done;
> +		} else {
> +#ifdef CONFIG_NUMA
> +			set_cpus_allowed_ptr(oen->workers[i].task, cpumask_of_node(node));
> +#endif
> +			wake_up_process(oen->workers[i].task);
> +		}
> +	}
> +
> +	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X))
> +		octeon3_sso_pass1_limit(node, oen->tx_complete_grp);
> +
> +	rv = request_irq(oen->tx_irq, octeon3_eth_tx_handler,
> +			 IRQ_TYPE_EDGE_RISING, "oct3_eth_tx_done", oen);
> +	if (rv)
> +		goto done;
> +	octeon3_eth_gen_affinity(node, &oen->tx_affinity_hint);
> +	irq_set_affinity_hint(oen->tx_irq, &oen->tx_affinity_hint);
> +
> +	octeon3_sso_irq_set(node, oen->tx_complete_grp, true);
> +
> +	oen->init_done = true;
> +done:
> +	mutex_unlock(&octeon3_eth_init_mutex);
> +	return rv;
> +}
> +
> +static struct sk_buff *octeon3_eth_work_to_skb(void *w)
> +{
> +	struct sk_buff *skb;
> +	void **f = w;
> +
> +	skb = f[-16];
> +	return skb;
> +}
> +
> +/* Receive one packet.
> + * returns the number of RX buffers consumed.
> + */
> +static int octeon3_eth_rx_one(struct octeon3_rx *rx, bool is_async, bool req_next)
> +{
> +	int segments;
> +	int ret;
> +	unsigned int packet_len;
> +	struct wqe *work;
> +	u8 *data;
> +	int len_remaining;
> +	struct sk_buff *skb;
> +	union buf_ptr packet_ptr;
> +	struct wr_ret r;
> +	struct octeon3_ethernet *priv = rx->parent;
> +
> +	if (is_async)
> +		r = octeon3_core_get_response_async();
> +	else
> +		r = octeon3_core_get_work_sync(rx->rx_grp);
> +	work = r.work;
> +	if (!work)
> +		return 0;
> +
> +	/* Request the next work so it'll be ready when we need it */
> +	if (is_async && req_next)
> +		octeon3_core_get_work_async(rx->rx_grp);
> +
> +	skb = octeon3_eth_work_to_skb(work);
> +
> +	segments = work->word0.bufs;
> +	ret = segments;
> +	packet_ptr = work->packet_ptr;
> +	if (unlikely(work->word2.err_level <= PKI_ERRLEV_LA &&
> +		     work->word2.err_code != PKI_OPCODE_NONE)) {
> +		atomic64_inc(&priv->rx_errors);
> +		switch (work->word2.err_code) {
> +		case PKI_OPCODE_JABBER:
> +			atomic64_inc(&priv->rx_length_errors);
> +			break;
> +		case PKI_OPCODE_FCS:
> +			atomic64_inc(&priv->rx_crc_errors);
> +			break;
> +		}
> +		data = phys_to_virt(packet_ptr.addr);
> +		for (;;) {
> +			dev_kfree_skb_any(skb);
> +			segments--;
> +			if (segments <= 0)
> +				break;
> +			packet_ptr.u64 = *(u64 *)(data - 8);
> +#ifndef __LITTLE_ENDIAN
> +			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
> +				/* PKI_BUFLINK_S's are endian-swapped */
> +				packet_ptr.u64 = swab64(packet_ptr.u64);
> +			}
> +#endif
> +			data = phys_to_virt(packet_ptr.addr);
> +			skb = octeon3_eth_work_to_skb((void *)round_down((unsigned long)data, 128ull));
> +		}
> +		goto out;
> +	}
> +
> +	packet_len = work->word1.len;
> +	data = phys_to_virt(packet_ptr.addr);
> +	skb->data = data;
> +	skb->len = packet_len;
> +	len_remaining = packet_len;
> +	if (segments == 1) {
> +		/* Strip the ethernet fcs */
> +		skb->len -= 4;
> +		skb_set_tail_pointer(skb, skb->len);
> +	} else {
> +		bool first_frag = true;
> +		struct sk_buff *current_skb = skb;
> +		struct sk_buff *next_skb = NULL;
> +		unsigned int segment_size;
> +
> +		skb_frag_list_init(skb);
> +		for (;;) {
> +			segment_size = (segments == 1) ? len_remaining : packet_ptr.size;
> +			len_remaining -= segment_size;
> +			if (!first_frag) {
> +				current_skb->len = segment_size;
> +				skb->data_len += segment_size;
> +				skb->truesize += current_skb->truesize;
> +			}
> +			skb_set_tail_pointer(current_skb, segment_size);
> +			segments--;
> +			if (segments == 0)
> +				break;
> +			packet_ptr.u64 = *(u64 *)(data - 8);
> +#ifndef __LITTLE_ENDIAN
> +			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
> +				/* PKI_BUFLINK_S's are endian-swapped */
> +				packet_ptr.u64 = swab64(packet_ptr.u64);
> +			}
> +#endif
> +			data = phys_to_virt(packet_ptr.addr);
> +			next_skb = octeon3_eth_work_to_skb((void *)round_down((unsigned long)data, 128ull));
> +			if (first_frag) {
> +				next_skb->next = skb_shinfo(current_skb)->frag_list;
> +				skb_shinfo(current_skb)->frag_list = next_skb;
> +			} else {
> +				current_skb->next = next_skb;
> +				next_skb->next = NULL;
> +			}
> +			current_skb = next_skb;
> +			first_frag = false;
> +			current_skb->data = data;
> +		}
> +
> +		/* Strip the ethernet fcs */
> +		pskb_trim(skb, skb->len - 4);
> +	}
> +
> +	if (likely(priv->netdev->flags & IFF_UP)) {
> +		skb_checksum_none_assert(skb);
> +		if (unlikely(priv->rx_timestamp_hw)) {
> +			/* The first 8 bytes are the timestamp */
> +			u64 hwts = *(u64 *)skb->data;
> +			u64 ns;
> +			struct skb_shared_hwtstamps *shts;
> +
> +			ns = timecounter_cyc2time(&priv->tc, hwts);
> +			shts = skb_hwtstamps(skb);
> +			memset(shts, 0, sizeof(*shts));
> +			shts->hwtstamp = ns_to_ktime(ns);
> +			__skb_pull(skb, 8);
> +		}
> +
> +		skb->protocol = eth_type_trans(skb, priv->netdev);
> +		skb->dev = priv->netdev;
> +		if (priv->netdev->features & NETIF_F_RXCSUM) {
> +			if ((work->word2.lc_hdr_type == PKI_LTYPE_IP4 ||
> +			     work->word2.lc_hdr_type == PKI_LTYPE_IP6) &&
> +			    (work->word2.lf_hdr_type == PKI_LTYPE_TCP ||
> +			     work->word2.lf_hdr_type == PKI_LTYPE_UDP ||
> +			     work->word2.lf_hdr_type == PKI_LTYPE_SCTP))
> +				if (work->word2.err_code == 0)
> +					skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		}
> +
> +		napi_gro_receive(&rx->napi, skb);
> +	} else {
> +		/* Drop any packet received for a device that isn't up */

If that happens, is not that a blatant indication that there is a bug in
how the interface is brought down?

> +		atomic64_inc(&priv->rx_dropped);
> +		dev_kfree_skb_any(skb);
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int octeon3_eth_napi(struct napi_struct *napi, int budget)
> +{
> +	int rx_count = 0;
> +	struct octeon3_rx *cxt;
> +	struct octeon3_ethernet *priv;
> +	u64 aq_cnt;
> +	int n = 0;
> +	int n_bufs = 0;
> +	u64 old_scratch;
> +
> +	cxt = container_of(napi, struct octeon3_rx, napi);
> +	priv = cxt->parent;
> +
> +	/* Get the amount of work pending */
> +	aq_cnt = oct_csr_read(SSO_GRP_AQ_CNT(priv->node, cxt->rx_grp));
> +	aq_cnt &= GENMASK_ULL(32, 0);
> +
> +	if (likely(USE_ASYNC_IOBDMA)) {
> +		/* Save scratch in case userspace is using it */
> +		CVMX_SYNCIOBDMA;
> +		old_scratch = scratch_read64(SCR_SCRATCH);
> +
> +		octeon3_core_get_work_async(cxt->rx_grp);
> +	}
> +
> +	while (rx_count < budget) {
> +		n = 0;
> +
> +		if (likely(USE_ASYNC_IOBDMA)) {
> +			bool req_next = rx_count < (budget - 1) ? true : false;
> +
> +			n = octeon3_eth_rx_one(cxt, true, req_next);
> +		} else {
> +			n = octeon3_eth_rx_one(cxt, false, false);
> +		}
> +
> +		if (n == 0)
> +			break;
> +
> +		n_bufs += n;
> +		rx_count++;
> +	}
> +
> +	/* Wake up worker threads */
> +	n_bufs = atomic64_add_return(n_bufs, &priv->buffers_needed);
> +	if (n_bufs >= 32) {
> +		struct octeon3_ethernet_node *oen;
> +
> +		oen = octeon3_eth_node + priv->node;
> +		atomic_set(&oen->workers[0].kick, 1);
> +		wake_up(&oen->workers[0].queue);
> +	}
> +
> +	/* Stop the thread when no work is pending */
> +	if (rx_count < budget) {
> +		napi_complete(napi);
> +		octeon3_sso_irq_set(cxt->parent->node, cxt->rx_grp, true);
> +	}
> +
> +	if (likely(USE_ASYNC_IOBDMA)) {
> +		/* Restore the scratch area */
> +		scratch_write64(SCR_SCRATCH, old_scratch);
> +	}
> +
> +	return rx_count;
> +}
> +
> +#undef BROKEN_SIMULATOR_CSUM
> +
> +static void ethtool_get_drvinfo(struct net_device *netdev,
> +				struct ethtool_drvinfo *info)
> +{
> +	strcpy(info->driver, "octeon3-ethernet");
> +	strcpy(info->version, "1.0");
> +	strcpy(info->bus_info, "Builtin");

I believe the correct way to specify that type of bus is to use "platform".

[snip]

> +static int octeon3_eth_common_ndo_stop(struct net_device *netdev)
> +{
> +	struct octeon3_ethernet *priv = netdev_priv(netdev);
> +	void **w;
> +	struct sk_buff *skb;
> +	struct octeon3_rx *rx;
> +	int i;
> +
> +	/* Allow enough time for ingress in transit packets to be drained */
> +	msleep(20);

Can you find a better way to do that? You can put a hard disable on the
hardware, and then wait until a particular condition to indicate full
drainage?

[snip]

> +static int octeon3_eth_ndo_start_xmit(struct sk_buff *skb,
> +				      struct net_device *netdev)
> +{
> +	struct sk_buff *skb_tmp;
> +	struct octeon3_ethernet *priv = netdev_priv(netdev);
> +	u64 scr_off = LMTDMA_SCR_OFFSET;
> +	u64 pko_send_desc;
> +	u64 lmtdma_data;
> +	u64 aq_cnt = 0;
> +	struct octeon3_ethernet_node *oen;
> +	long backlog;
> +	int frag_count;
> +	u64 head_len;
> +	int i;
> +	u64 *dma_addr;

dma_addr_t?

> +	void **work;
> +	unsigned int mss;
> +	int grp;
> +
> +	frag_count = 0;
> +	if (skb_has_frag_list(skb))
> +		skb_walk_frags(skb, skb_tmp)
> +			frag_count++;
> +
> +	/* Stop the queue if pko or sso are not keeping up */
> +	oen = octeon3_eth_node + priv->node;
> +	aq_cnt = oct_csr_read(SSO_GRP_AQ_CNT(oen->node, oen->tx_complete_grp));
> +	aq_cnt &= GENMASK_ULL(32, 0);
> +	backlog = atomic64_inc_return(&priv->tx_backlog);
> +	if (unlikely(backlog > MAX_TX_QUEUE_DEPTH || aq_cnt > 100000))
> +		netif_stop_queue(netdev);
> +
> +	/* We have space for 11 segment pointers, If there will be
> +	 * more than that, we must linearize.  The count is: 1 (base
> +	 * SKB) + frag_count + nr_frags.
> +	 */
> +	if (unlikely(skb_shinfo(skb)->nr_frags + frag_count > 10)) {
> +		if (unlikely(__skb_linearize(skb)))
> +			goto skip_xmit;
> +		frag_count = 0;
> +	}

What's so special about 10? The maximum the network stack could pass is
SKB_MAX_FRAGS, what would happen in that case?

> +
> +	work = (void **)skb->cb;
> +	work[0] = netdev;
> +	work[1] = NULL;
> +
> +	/* Adjust the port statistics. */
> +	atomic64_inc(&priv->tx_packets);
> +	atomic64_add(skb->len, &priv->tx_octets);

Do this in the TX completion worker, there is no guarantee the packet
will be transmitted that early in this function.

> +
> +	/* Make sure packet data writes are committed before
> +	 * submitting the command below
> +	 */
> +	wmb();

That seems just wrong here, if your goal is to make sure that e.g:
skb_linearize() did finish its pending writes to DRAM, you need to use
DMA-API towards that goal. If the device is cache coherent, DMA-API will
know that and do nothing.

> +
> +	/* Build the pko command */
> +	pko_send_desc = build_pko_send_hdr_desc(skb);
> +	preempt_disable();

Why do you disable preemption here?

> +	scratch_write64(scr_off, pko_send_desc);
> +	scr_off += sizeof(pko_send_desc);
> +
> +	/* Request packet to be ptp timestamped */
> +	if ((unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) &&
> +	    unlikely(priv->tx_timestamp_hw)) {
> +		pko_send_desc = build_pko_send_ext_desc(skb);
> +		scratch_write64(scr_off, pko_send_desc);
> +		scr_off += sizeof(pko_send_desc);
> +	}
> +
> +	/* Add the tso descriptor if needed */
> +	mss = skb_shinfo(skb)->gso_size;
> +	if (unlikely(mss)) {
> +		pko_send_desc = build_pko_send_tso(skb, netdev->mtu);
> +		scratch_write64(scr_off, pko_send_desc);
> +		scr_off += sizeof(pko_send_desc);
> +	}
> +
> +	/* Add a gather descriptor for each segment. See PKO_SEND_GATHER_S for
> +	 * the send gather descriptor format.
> +	 */
> +	pko_send_desc = 0;
> +	pko_send_desc |= (u64)PKO_SENDSUBDC_GATHER << 45;
> +	head_len = skb_headlen(skb);
> +	if (head_len > 0) {
> +		pko_send_desc |= head_len << 48;
> +		pko_send_desc |= virt_to_phys(skb->data);
> +		scratch_write64(scr_off, pko_send_desc);
> +		scr_off += sizeof(pko_send_desc);
> +	}
> +	for (i = 1; i <= skb_shinfo(skb)->nr_frags; i++) {
> +		struct skb_frag_struct *fs = skb_shinfo(skb)->frags + i - 1;
> +
> +		pko_send_desc &= ~(GENMASK_ULL(63, 48) | GENMASK_ULL(41, 0));
> +		pko_send_desc |= (u64)fs->size << 48;
> +		pko_send_desc |= virt_to_phys((u8 *)page_address(fs->page.p) + fs->page_offset);
> +		scratch_write64(scr_off, pko_send_desc);
> +		scr_off += sizeof(pko_send_desc);
> +	}
> +	skb_walk_frags(skb, skb_tmp) {
> +		pko_send_desc &= ~(GENMASK_ULL(63, 48) | GENMASK_ULL(41, 0));
> +		pko_send_desc |= (u64)skb_tmp->len << 48;
> +		pko_send_desc |= virt_to_phys(skb_tmp->data);
> +		scratch_write64(scr_off, pko_send_desc);
> +		scr_off += sizeof(pko_send_desc);
> +	}
> +
> +	/* Subtract 1 from the tx_backlog. */
> +	pko_send_desc = build_pko_send_mem_sub(virt_to_phys(&priv->tx_backlog));
> +	scratch_write64(scr_off, pko_send_desc);
> +	scr_off += sizeof(pko_send_desc);
> +
> +	/* Write the ptp timestamp in the skb itself */
> +	if ((unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) &&
> +	    unlikely(priv->tx_timestamp_hw)) {
> +		pko_send_desc = build_pko_send_mem_ts(virt_to_phys(&work[1]));
> +		scratch_write64(scr_off, pko_send_desc);
> +		scr_off += sizeof(pko_send_desc);
> +	}
> +
> +	/* Send work when finished with the packet. */
> +	grp = octeon3_eth_lgrp_to_ggrp(priv->node, priv->tx_complete_grp);
> +	pko_send_desc = build_pko_send_work(grp, virt_to_phys(work));
> +	scratch_write64(scr_off, pko_send_desc);
> +	scr_off += sizeof(pko_send_desc);
> +
> +	/* See PKO_SEND_DMA_S in the HRM for the lmtdam data format */
> +	lmtdma_data = 0;
> +	lmtdma_data |= (u64)(LMTDMA_SCR_OFFSET >> 3) << 56;
> +	if (wait_pko_response)
> +		lmtdma_data |= 1ull << 48;
> +	lmtdma_data |= 0x51ull << 40;
> +	lmtdma_data |= (u64)priv->node << 36;
> +	lmtdma_data |= priv->pko_queue << 16;
> +
> +	dma_addr = (u64 *)(LMTDMA_ORDERED_IO_ADDR | ((scr_off & 0x78) - 8));
> +	*dma_addr = lmtdma_data;
> +
> +	preempt_enable();
> +
> +	if (wait_pko_response) {
> +		u64	query_rtn;
> +
> +		CVMX_SYNCIOBDMA;
> +
> +		/* See PKO_QUERY_RTN_S in the HRM for the return format */
> +		query_rtn = scratch_read64(LMTDMA_SCR_OFFSET);
> +		query_rtn >>= 60;
> +		if (unlikely(query_rtn != PKO_DQSTATUS_PASS)) {
> +			netdev_err(netdev, "PKO enqueue failed %llx\n",
> +				   (unsigned long long)query_rtn);
> +			dev_kfree_skb_any(skb);
> +		}
> +	}

So I am not sure I fully understand how sending packets works, although
it seems to be like you are building a work element (pko_send_desc)
which references either a full-size Ethernet frame, or that frame and
its fragments (multiple pko_send_desc). In that case, I don't see why
you can't juse dma_map_single()/dma_unmap_single() against skb->data and
its potential fragments instead of using virt_to_phys() like you
currently do, which is absolutely not portable.

dma_map_single() on the kernel linear address space should be equivalent
to virt_to_phys() anyway, and you would get the nice things about
DMA-API like its portability.

I could imagine that, for coherency purposes, there may be a requirement
to keep tskb->data and frieds to be within XKSEG0/1, if that's the case,
DMA-API should know that too.

I might be completely off, but using virt_to_phys() sure does sound non
portable here.

> +
> +	return NETDEV_TX_OK;
> +skip_xmit:
> +	atomic64_inc(&priv->tx_dropped);
> +	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static void octeon3_eth_ndo_get_stats64(struct net_device *netdev,
> +					struct rtnl_link_stats64 *s)
> +{
> +	struct octeon3_ethernet *priv = netdev_priv(netdev);
> +	u64 packets, octets, dropped;
> +	u64 delta_packets, delta_octets, delta_dropped;
> +
> +	spin_lock(&priv->stat_lock);

Consider using u64_stats_sync to get rid of this lock...

> +
> +	octeon3_pki_get_stats(priv->node, priv->pknd, &packets, &octets, &dropped);
> +
> +	delta_packets = (packets - priv->last_packets) & ((1ull << 48) - 1);
> +	delta_octets = (octets - priv->last_octets) & ((1ull << 48) - 1);
> +	delta_dropped = (dropped - priv->last_dropped) & ((1ull << 48) - 1);
> +
> +	priv->last_packets = packets;
> +	priv->last_octets = octets;
> +	priv->last_dropped = dropped;
> +
> +	spin_unlock(&priv->stat_lock);
> +
> +	atomic64_add(delta_packets, &priv->rx_packets);
> +	atomic64_add(delta_octets, &priv->rx_octets);
> +	atomic64_add(delta_dropped, &priv->rx_dropped);

and summing up these things as well.

> +
> +	s->rx_packets = atomic64_read(&priv->rx_packets);
> +	s->rx_bytes = atomic64_read(&priv->rx_octets);
> +	s->rx_dropped = atomic64_read(&priv->rx_dropped);
> +	s->rx_errors = atomic64_read(&priv->rx_errors);
> +	s->rx_length_errors = atomic64_read(&priv->rx_length_errors);
> +	s->rx_crc_errors = atomic64_read(&priv->rx_crc_errors);
> +
> +	s->tx_packets = atomic64_read(&priv->tx_packets);
> +	s->tx_bytes = atomic64_read(&priv->tx_octets);
> +	s->tx_dropped = atomic64_read(&priv->tx_dropped);
> +}

[snip]

> +enum port_mode {
> +	PORT_MODE_DISABLED,
> +	PORT_MODE_SGMII,
> +	PORT_MODE_RGMII,
> +	PORT_MODE_XAUI,
> +	PORT_MODE_RXAUI,
> +	PORT_MODE_XLAUI,
> +	PORT_MODE_XFI,
> +	PORT_MODE_10G_KR,
> +	PORT_MODE_40G_KR4
> +};

Can you use phy_interface_t values for this?

> +
> +enum lane_mode {
> +	R_25G_REFCLK100,
> +	R_5G_REFCLK100,
> +	R_8G_REFCLK100,
> +	R_125G_REFCLK15625_KX,
> +	R_3125G_REFCLK15625_XAUI,
> +	R_103125G_REFCLK15625_KR,
> +	R_125G_REFCLK15625_SGMII,
> +	R_5G_REFCLK15625_QSGMII,
> +	R_625G_REFCLK15625_RXAUI,
> +	R_25G_REFCLK125,
> +	R_5G_REFCLK125,
> +	R_8G_REFCLK125
> +};
> +
> +struct port_status {
> +	int	link;
> +	int	duplex;
> +	int	speed;
> +};

Likewise, using phy_device would give you this information.
-- 
Florian
