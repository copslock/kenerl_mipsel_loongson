Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 23:37:24 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:34796 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994607AbeIDVhMtrfZI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Sep 2018 23:37:12 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 3649841DAF;
        Tue,  4 Sep 2018 23:37:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id QqV98AxKr1yT; Tue,  4 Sep 2018 23:37:05 +0200 (CEST)
Subject: Re: [PATCH v2 net-next 5/7] net: lantiq: Add Lantiq / Intel VRX200
 Ethernet driver
To:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120427.9983-1-hauke@hauke-m.de>
 <6d3bdb60-c993-9129-6e87-afb08ff5c113@gmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <3955587e-b661-34b5-a448-b7fb21be9e20@hauke-m.de>
Date:   Tue, 4 Sep 2018 23:37:00 +0200
MIME-Version: 1.0
In-Reply-To: <6d3bdb60-c993-9129-6e87-afb08ff5c113@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="37GKMcPsFDfqw31W3277uHLydBAcXpuWs"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--37GKMcPsFDfqw31W3277uHLydBAcXpuWs
Content-Type: multipart/mixed; boundary="H5OI5WC0EHSDcjf2yM3o6hU1BFAhnbDSC";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
 vivien.didelot@savoirfairelinux.com, john@phrozen.org,
 linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
 devicetree@vger.kernel.org
Message-ID: <3955587e-b661-34b5-a448-b7fb21be9e20@hauke-m.de>
Subject: Re: [PATCH v2 net-next 5/7] net: lantiq: Add Lantiq / Intel VRX200
 Ethernet driver
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120427.9983-1-hauke@hauke-m.de>
 <6d3bdb60-c993-9129-6e87-afb08ff5c113@gmail.com>
In-Reply-To: <6d3bdb60-c993-9129-6e87-afb08ff5c113@gmail.com>

--H5OI5WC0EHSDcjf2yM3o6hU1BFAhnbDSC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thanks for the review.

On 09/03/2018 09:24 PM, Florian Fainelli wrote:
>=20
>=20
> On 9/1/2018 5:04 AM, Hauke Mehrtens wrote:
>> This drives the PMAC between the GSWIP Switch and the CPU in the VRX20=
0
>> SoC. This is currently only the very basic version of the Ethernet
>> driver.
>>
>> When the DMA channel is activated we receive some packets which were
>> send to the SoC while it was still in U-Boot, these packets have the
>> wrong header. Resetting the IP cores did not work so we read out the
>> extra packets at the beginning and discard them.
>>
>> This also adapts the clock code in sysctrl.c to use the default name o=
f
>> the device node so that the driver gets the correct clock. sysctrl.c
>> should be replaced with a proper common clock driver later.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 arch/mips/lantiq/xway/sysctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-
>> =C2=A0 drivers/net/ethernet/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> =C2=A0 drivers/net/ethernet/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/net/ethernet/lantiq_xrx200.c | 591
>> +++++++++++++++++++++++++++++++++++
>> =C2=A0 5 files changed, 603 insertions(+), 3 deletions(-)
>> =C2=A0 create mode 100644 drivers/net/ethernet/lantiq_xrx200.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4b2ee65f6086..ffff912d31b5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8171,6 +8171,7 @@ M:=C2=A0=C2=A0=C2=A0 Hauke Mehrtens <hauke@hauke=
-m.de>
>> =C2=A0 L:=C2=A0=C2=A0=C2=A0 netdev@vger.kernel.org
>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 net/dsa/tag_gswip.c
>> +F:=C2=A0=C2=A0=C2=A0 drivers/net/ethernet/lantiq_xrx200.c
>> =C2=A0 =C2=A0 LANTIQ MIPS ARCHITECTURE
>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 John Crispin <john@phrozen.org>
>> diff --git a/arch/mips/lantiq/xway/sysctrl.c
>> b/arch/mips/lantiq/xway/sysctrl.c
>> index e0af39b33e28..eeb89a37e27e 100644
>> --- a/arch/mips/lantiq/xway/sysctrl.c
>> +++ b/arch/mips/lantiq/xway/sysctrl.c
>> @@ -505,7 +505,7 @@ void __init ltq_soc_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1a800000.pcie", "pdi", 1, 1, PMU1_PCIE2_PDI);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu("1e108000.e=
th", NULL, 0, 0, PMU_SWITCH |
>> PMU_PPE_DP);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu("1e10b308.e=
th", NULL, 0, 0, PMU_SWITCH |
>> PMU_PPE_DP);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1da00000.usif", "NULL", 1, 0, PMU_USIF);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1e103100.deu", NULL, 1, 0, PMU_DEU);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (of_machine_is_compatible("la=
ntiq,ar10")) {
>> @@ -513,7 +513,7 @@ void __init ltq_soc_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_ar10_fpi_hz(), ltq_ar10_pp=
32_hz());
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1e101000.usb", "otg", 1, 0, PMU_USB0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1e106000.usb", "otg", 1, 0, PMU_USB1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu("1e108000.e=
th", NULL, 0, 0, PMU_SWITCH |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu("1e10b308.e=
th", NULL, 0, 0, PMU_SWITCH |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMU_PPE_DP | PMU_PPE_TC)=
;
>=20
> Should not that be part of patch 4 where you define the base register
> address?

hmm, I can also put this into patch number 4.

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1da00000.usif", "NULL", 1, 0, PMU_USIF);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
"1f203020.gphy", NULL, 1, 0, PMU_GPHY);
>> @@ -536,7 +536,7 @@ void __init ltq_soc_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu(=
NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_a=
dd_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu("1e108000.e=
th", NULL, 0, 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkdev_add_pmu("1e10b308.e=
th", NULL, 0, 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM=
 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMU_PPE_QSB | PMU_PPE_TOP);
>=20
> Likewise.
>=20
> [snip]
>=20
>> +static int xrx200_open(struct net_device *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_priv *priv =3D netdev_priv(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_open(&priv->chan_tx.dma);
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_enable_irq(&priv->chan_tx.dma);
>> +
>> +=C2=A0=C2=A0=C2=A0 napi_enable(&priv->chan_rx.napi);
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_open(&priv->chan_rx.dma);
>> +=C2=A0=C2=A0=C2=A0 /* The boot loader does not always deactivate the =
receiving of
>> frames
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * on the ports and then some packets queue u=
p in the PPE buffers.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * They already passed the PMAC so they do no=
t have the tags
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * configured here. Read the these packets he=
re and drop them.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The HW should have written them into memor=
y after 10us
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 udelay(10);
>=20
> You execute in process context with the ndo_open() callback (AFAIR),
> would usleep_range() work here?

The Documentation/timers/timers-howto.txt says for ~10us I should use
udaly also in non atomic context, I can try usleep_range() too.

>> +=C2=A0=C2=A0=C2=A0 xrx200_flush_dma(&priv->chan_rx);
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_enable_irq(&priv->chan_rx.dma);
>> +
>> +=C2=A0=C2=A0=C2=A0 netif_wake_queue(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int xrx200_close(struct net_device *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_priv *priv =3D netdev_priv(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 netif_stop_queue(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 napi_disable(&priv->chan_rx.napi);
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_close(&priv->chan_rx.dma);
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_close(&priv->chan_tx.dma);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int xrx200_alloc_skb(struct xrx200_chan *ch)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +#define DMA_PAD=C2=A0=C2=A0=C2=A0 (NET_IP_ALIGN + NET_SKB_PAD)
>> +=C2=A0=C2=A0=C2=A0 ch->skb[ch->dma.desc] =3D dev_alloc_skb(XRX200_DMA=
_DATA_LEN +
>> DMA_PAD);
>> +=C2=A0=C2=A0=C2=A0 if (!ch->skb[ch->dma.desc]) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto skip;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Would not netdev_alloc_skb() do what you want already?

Ok, I am now using netdev_alloc_skb_ip_align()

>> +
>> +=C2=A0=C2=A0=C2=A0 skb_reserve(ch->skb[ch->dma.desc], NET_SKB_PAD);
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc_base[ch->dma.desc].addr =3D dma_map_s=
ingle(ch->priv->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
->skb[ch->dma.desc]->data, XRX200_DMA_DATA_LEN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DM=
A_FROM_DEVICE);
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(dma_mapping_error(ch->priv->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch->dma.d=
esc_base[ch->dma.desc].addr))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_kfree_skb_any(ch->skb[=
ch->dma.desc]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto skip;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc_base[ch->dma.desc].addr =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPHYSADDR(ch->skb[ch->dma.=
desc]->data);
>> +=C2=A0=C2=A0=C2=A0 skb_reserve(ch->skb[ch->dma.desc], NET_IP_ALIGN);
>> +
>> +skip:
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc_base[ch->dma.desc].ctl =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTQ_DMA_OWN | LTQ_DMA_RX_O=
FFSET(NET_IP_ALIGN) |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XRX200_DMA_DATA_LEN;
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static int xrx200_hw_receive(struct xrx200_chan *ch)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_priv *priv =3D ch->priv;
>> +=C2=A0=C2=A0=C2=A0 struct ltq_dma_desc *desc =3D &ch->dma.desc_base[c=
h->dma.desc];
>> +=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D ch->skb[ch->dma.desc];
>> +=C2=A0=C2=A0=C2=A0 int len =3D (desc->ctl & LTQ_DMA_SIZE_MASK);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D xrx200_alloc_skb(ch);
>> +
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc++;
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc %=3D LTQ_DESC_NUM;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_err(priv->net_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "failed to allocate new rx buffer\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 skb_put(skb, len);
>> +=C2=A0=C2=A0=C2=A0 skb->dev =3D priv->net_dev;
>=20
> eth_type_trans() does the skb->dev assignment already, this is not
> necessary.

removed

>> +=C2=A0=C2=A0=C2=A0 skb->protocol =3D eth_type_trans(skb, priv->net_de=
v);
>> +=C2=A0=C2=A0=C2=A0 netif_receive_skb(skb);
>> +=C2=A0=C2=A0=C2=A0 priv->stats.rx_packets++;
>> +=C2=A0=C2=A0=C2=A0 priv->stats.rx_bytes +=3D len;
>=20
> Does the length reported by the hardware include the Ethernet Frame
> Check Sequence (FCS)? If so, you need to remove it here, since you are
> not supposed to pass it up the stack unless NETIF_F_RXFCS* is turned on=
=2E

Yes the FCS is included, I removed it.

>=20
> [snip]
>=20
>> +static void xrx200_tx_housekeeping(unsigned long ptr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_chan *ch =3D (struct xrx200_chan *)p=
tr;
>> +=C2=A0=C2=A0=C2=A0 int pkts =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int bytes =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_ack_irq(&ch->dma);
>> +=C2=A0=C2=A0=C2=A0 while ((ch->dma.desc_base[ch->tx_free].ctl &
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (LTQ_DMA_OWN | LTQ_DMA_C))=
 =3D=3D LTQ_DMA_C) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D ch=
->skb[ch->tx_free];
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkts++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes +=3D skb->len;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch->skb[ch->tx_free] =3D N=
ULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_kfree_skb(skb);
>=20
> Consider using dev_consume_skb() to be drop monitor friendly,
> dev_kfree_skb() indicates the SKB was freed upon error, this is not the=

> case here.

Will call consume_skb() here.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&ch->dma.desc_base[=
ch->tx_free], 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(struct ltq_dma_desc));
>=20
> Humm, don't you need a write barrier here to make sure the HW view's of=

> the descriptor is consistent with the CPU's view?

I do not think so, but it could be that I miss some side affects. This
is the TX queue free, this will be used next by the driver xmit function
 when the next packet in this descriptor is written to the HW. I think
we can even leave this memset out as this descriptor is already given to
the driver.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch->tx_free++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch->tx_free %=3D LTQ_DESC_=
NUM;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_enable_irq(&ch->dma);
>> +
>> +=C2=A0=C2=A0=C2=A0 netdev_completed_queue(ch->priv->net_dev, pkts, by=
tes);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!pkts)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 netif_wake_queue(ch->priv->net_dev);
>=20
> Can you do this in NAPI context, even if that means creating a specific=

> TX NAPI object instead of doing this in tasklet context?

Should I put the TX freeing into the RX NAPI handler or create a own
NAPI handler for TX freeing only?

>> +}
>> +
>> +static struct net_device_stats *xrx200_get_stats(struct net_device *d=
ev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_priv *priv =3D netdev_priv(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 return &priv->stats;
>=20
> As Andrew pointed out, consider using dev->stats, or better yet,
> implement 64-bit statistics.

I am already using dev->stats.

>> +}
>> +
>> +static int xrx200_start_xmit(struct sk_buff *skb, struct net_device
>> *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_priv *priv =3D netdev_priv(dev);
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_chan *ch;
>> +=C2=A0=C2=A0=C2=A0 struct ltq_dma_desc *desc;
>> +=C2=A0=C2=A0=C2=A0 u32 byte_offset;
>> +=C2=A0=C2=A0=C2=A0 dma_addr_t mapping;
>> +=C2=A0=C2=A0=C2=A0 int len;
>> +
>> +=C2=A0=C2=A0=C2=A0 ch =3D &priv->chan_tx;
>> +
>> +=C2=A0=C2=A0=C2=A0 desc =3D &ch->dma.desc_base[ch->dma.desc];
>> +
>> +=C2=A0=C2=A0=C2=A0 skb->dev =3D dev;
>> +=C2=A0=C2=A0=C2=A0 len =3D skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;=

>=20
> Consider using skb_put_padto() which would do that automatically for yo=
u.

Will use skb_put_padto()

>> +
>> +=C2=A0=C2=A0=C2=A0 /* dma needs to start on a 16 byte aligned address=
 */
>> +=C2=A0=C2=A0=C2=A0 byte_offset =3D CPHYSADDR(skb->data) % 16;
>=20
> That really should not be necessary, the stack should already be handin=
g
> you off packets that are aligned to the max between the L1 cache line
> size and 64 bytes. Also, CPHYSADDR is a MIPSism, getting rid of it woul=
d
> help with the portability and building the driver on other architecture=
s.

I will do this based on the mapping which is returned from
dma_map_single(). The byte offset is anyway needed based on the HW
address. The DMA controller can access the memory at 16 bytes offsets,
but we can provide an extra offset in the DMA descriptor.

>> +
>> +=C2=A0=C2=A0=C2=A0 if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) ||
>> ch->skb[ch->dma.desc]) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_err(dev, "tx ring f=
ull\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netif_stop_queue(dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NETDEV_TX_BUSY;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ch->skb[ch->dma.desc] =3D skb;
>> +
>> +=C2=A0=C2=A0=C2=A0 netif_trans_update(dev);
>=20
> This should not be necessary the stack does that already AFAIR.

removed

>> +
>> +=C2=A0=C2=A0=C2=A0 mapping =3D dma_map_single(priv->dev, skb->data, l=
en, DMA_TO_DEVICE);
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(dma_mapping_error(priv->dev, mapping)=
))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_drop;
>> +
>> +=C2=A0=C2=A0=C2=A0 desc->addr =3D mapping - byte_offset;
>> +=C2=A0=C2=A0=C2=A0 /* Make sure the address is written before we give=
 it to HW */
>> +=C2=A0=C2=A0=C2=A0 wmb();
>> +=C2=A0=C2=A0=C2=A0 desc->ctl =3D LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_=
EOP |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTQ_DMA_TX_OFFSET(byte_off=
set) | (len & LTQ_DMA_SIZE_MASK);
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc++;
>> +=C2=A0=C2=A0=C2=A0 ch->dma.desc %=3D LTQ_DESC_NUM;
>> +=C2=A0=C2=A0=C2=A0 if (ch->dma.desc =3D=3D ch->tx_free)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netif_stop_queue(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 netdev_sent_queue(dev, skb->len);
>=20
> As soon as you write to the descriptor, the packet is handed to HW and
> you could thereoteically have it completed before you even get to acces=
s
> skb->len here since your TX completion interrupt could preempt this
> function, that would mean use after free, so consider using 'len' here.=


Ok, I will use len.

>> +=C2=A0=C2=A0=C2=A0 priv->stats.tx_packets++;
>> +=C2=A0=C2=A0=C2=A0 priv->stats.tx_bytes +=3D len;
>=20
> Updating sucessful TX completion statistics should occur in your TX
> completion handler: xrx200_tx_housekeeping() because you could have a
> stuck TX path, so knowing whether the TX IRQ fired and cleaned up your
> packets is helpful to troubleshoot problems.

Ok, I wil move this.

>> +
>> +=C2=A0=C2=A0=C2=A0 return NETDEV_TX_OK;
>> +
>> +err_drop:
>> +=C2=A0=C2=A0=C2=A0 dev_kfree_skb(skb);
>> +=C2=A0=C2=A0=C2=A0 priv->stats.tx_dropped++;
>> +=C2=A0=C2=A0=C2=A0 priv->stats.tx_errors++;
>> +=C2=A0=C2=A0=C2=A0 return NETDEV_TX_OK;
>> +}
>> +
>> +static const struct net_device_ops xrx200_netdev_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .ndo_open=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D xrx200_open,
>> +=C2=A0=C2=A0=C2=A0 .ndo_stop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D xrx200_close,
>> +=C2=A0=C2=A0=C2=A0 .ndo_start_xmit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D xrx200_start_xmit,
>> +=C2=A0=C2=A0=C2=A0 .ndo_set_mac_address=C2=A0=C2=A0=C2=A0 =3D eth_mac=
_addr,
>> +=C2=A0=C2=A0=C2=A0 .ndo_validate_addr=C2=A0=C2=A0=C2=A0 =3D eth_valid=
ate_addr,
>> +=C2=A0=C2=A0=C2=A0 .ndo_change_mtu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D eth_change_mtu,
>> +=C2=A0=C2=A0=C2=A0 .ndo_get_stats=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D xrx200_get_stats,
>> +};
>> +
>> +static irqreturn_t xrx200_dma_irq_tx(int irq, void *ptr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_priv *priv =3D ptr;
>> +=C2=A0=C2=A0=C2=A0 struct xrx200_chan *ch =3D &priv->chan_tx;
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_disable_irq(&ch->dma);
>> +=C2=A0=C2=A0=C2=A0 ltq_dma_ack_irq(&ch->dma);
>> +
>> +=C2=A0=C2=A0=C2=A0 tasklet_schedule(&ch->tasklet);
>=20
> Can you use NAPI instead (similar to what was suggested before)?
>=20
> [snip]
>=20
>> +=C2=A0=C2=A0=C2=A0 /* enable clock gate */
>> +=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(priv->clk);
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_uninit_dma;
>=20
> Since there is no guarantee that a network device will be used up until=

> some point, you should consider defering the clock enabling into the
> ndo_open() callback to save some possible power. Likewise with resource=
s
> that require memory allocations, you should defer them to as as late as=

> possible.

Ok I will move this.

Hauke



--H5OI5WC0EHSDcjf2yM3o6hU1BFAhnbDSC--

--37GKMcPsFDfqw31W3277uHLydBAcXpuWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluO+vwACgkQ8bdnhZyy
68eXlgf/eGvBSMpXMMNTe6Gxb9UlmeS+F3RmVD0zmhbnrBRNsnxasc2tgKhjuSIo
bU/wFquyFulNcWmOg2Qen2Qv7aO0j95Ot3wKZvFzk0bin+eN87dHXrqYYQIv5HZu
Gsj4rO5wvtVmNaKedYjE7D/jXZ07tVGCofiBDExAPsugufaVTJahK6IJKqJOnhCt
6egRvpkXf/3FMFOTKqTQ8ydfHyBPvu7sso6Sp+wJXHYurO9Eo0nZkcxD7wmtUb2r
XPNL2OcAjJlwZwd9Sh/i5i/eN2FepfGqIkTD6Gj6cdME+Ei+KmkR7I+qsc4e2XJ5
UZoPylAnuOT9tWatyR4I4rA338G2fg==
=869T
-----END PGP SIGNATURE-----

--37GKMcPsFDfqw31W3277uHLydBAcXpuWs--
