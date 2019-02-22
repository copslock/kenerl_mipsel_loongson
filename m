Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B3C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 10:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E520823
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 10:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBVKXV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:23:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:37195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfBVKXU (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Feb 2019 05:23:20 -0500
Received: from [192.168.178.38] ([31.18.251.131]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF5FT-1gpkP90OaZ-00GGUX; Fri, 22
 Feb 2019 11:23:08 +0100
Subject: Re: Kernel hang when replace older uboot with uboot master for ath79
 mips platform
To:     "rosysong@rosinson.com" <rosysong@rosinson.com>,
        linux-mips <linux-mips@vger.kernel.org>
References: <201902221035393424496@rosinson.com>
 <2142641f-fcea-b3da-dfe2-9ae6135f5c1d@rempel-privat.de>
 <2019022217575639196011@rosinson.com>
From:   Oleksij Rempel <linux@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
 8VXa+gkZKRSnZTvVMAriaQwqKog=
Message-ID: <4c79294c-18bc-ba20-bc1c-38c7d40ec71e@rempel-privat.de>
Date:   Fri, 22 Feb 2019 11:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2019022217575639196011@rosinson.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2pqsGfrkBNMYQxUpU9rTzaiIJeRshInJA"
X-Provags-ID: V03:K1:8hYhbEDtpD+8qQ+xnVqi1lXJxMuurez7JdsamVIuVngmWMRgFHP
 ytaE/kJo+kkDo0jDhDMXmnt/KnRpQ1M6UlwRQzt+A81xSPuL2GjYN8mDXqP0SSQJ3NM2Ndw
 hFaA30uwr0TcDoOSeqnGTAnYUJ/Kt7omXS64anCckaHcYnHBXq3YA7Vb7gpRsuYF+ir+R1y
 YAmbxVj/I7tOPESZZXD4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJV/GTXPmto=:zzasIR9PCXyvH/ZWPvGTZL
 TZo0iob1htW42HrV1dL5QaOvvfsQGyMjTNil4v9p6E67vdS4iJxD3VKi/WyuHT1LdeVywS1BA
 n8UEDJlwcaFoGGsp+f63hVjkW3vMLhDRfxeRdxneEChHpmhZflhhu/vLQVGS0jrB6/UYpnuHW
 YZYeDcjIxiheZipQmecr+/h6JJzMkTrNnPEn4Zisb5EuFoXh5qoUtYcHzBBRU3zuCaAcMog7m
 sbjB0caYeNYgIP9YHTpYElzK8oNnrIkzlqckTZecejuQpKvy9ESw56tZ5LMedta9B0b45LAOD
 FbhLtYwSfRBLVOtRo8Y1DzkSmYtep4QA1spfvjs7HiRrS26LibKQkwpbxM91f4o/q+Bylc10p
 A/is2L4G+zAmIkIwoPtfFaKd7aUCZas5tlLpB8m/nIaAJQd3j5hCjeavCjCddcnC56Ic0thAQ
 RyP0QORtHx5TqREIV8jg4ZShUE1M3IZZIrnoGPnkUiN7XtHy8Zmw9X0PP27OyPMo8E+5vdr3C
 7p/ug2PPPZJsPuLbg1+p/CS16Knh1Ejl0jT5fOeEEsK4PoVUkEpu7HX2XToeIhyw4Bn19CAlo
 HL372xAUIxjks1sBJsxaX01Vh02WZs+Z4ArS65ZuiqogTfZblVf4lAvISWgrIMx0d1JkOtCJa
 rIjbUh0Ec6GMgBx7y5T4RQkYkvUTefR7Ej3fKaW7/6f6wJnx0FhnPaHskT3j/qlVaFR2KOpXg
 MC+JDNuW337IoQhxaUq8pJRTPF3Km8jFq+pBNsqT6uQl3eVoT/rpiGGokyc0+mhiG8V98L6j7
 Cxs8sptNGh+PF1nk56K/kYqKs5LjkECPBggMPa0F6SR48HqEh68yrY9j00+/9U6vZ3XvN9Svi
 PDx5bBNRhQgEOPRwc9hZlTZ5RdCn6Wr4z+yKx0OFkFEZcKtmku2RGxBYrrVD8J
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2pqsGfrkBNMYQxUpU9rTzaiIJeRshInJA
Content-Type: multipart/mixed; boundary="ql1RHc5b0AWYynPIWgBU2n71Sb9dL07OV";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: "rosysong@rosinson.com" <rosysong@rosinson.com>,
 linux-mips <linux-mips@vger.kernel.org>
Message-ID: <4c79294c-18bc-ba20-bc1c-38c7d40ec71e@rempel-privat.de>
Subject: Re: Kernel hang when replace older uboot with uboot master for ath79
 mips platform
References: <201902221035393424496@rosinson.com>
 <2142641f-fcea-b3da-dfe2-9ae6135f5c1d@rempel-privat.de>
 <2019022217575639196011@rosinson.com>
In-Reply-To: <2019022217575639196011@rosinson.com>

--ql1RHc5b0AWYynPIWgBU2n71Sb9dL07OV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 22.02.19 um 10:57 schrieb rosysong@rosinson.com:
> Thanks for your reply, I see your SoC is AR9331 which supported by u-bo=
ot-master either, and your bootloader is=C2=A0
> barebox-2019. Maybe you can build a u-boot-master image for your AR9331=
 machine and you will know what happen!!! :-)

> My BSP is openwrt-18.06=C2=A0https://github.com/openwrt/openwrt. qca953=
x SoC.

Sorry, I don't use u-boot and have no time to debug it.
My primer interests are barebox and mainlining of ath79 related patches f=
rom OpenWRT to the kernel.

> Am 22.02.19 um 03:35 schrieb rosysong@rosinson.com:> Hi all,
>> =C2=A0=C2=A0=C2=A0=C2=A0 My kernel version is linux-4.9.158, it hangs =
when replace the old u-boot(1.1.4) with
> u-boot-master.
>> =C2=A0=C2=A0=C2=A0=C2=A0 For linux-4.14.xx, When I enable CONFIG_MIPSR=
2_IRQ_VI options, it does hang any longer while
> still hang in linux-4.9.158.
>> =C2=A0=C2=A0=C2=A0=C2=A0 Sometimes it hangs at "random: crng init done=
".
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Any hints will be appreciated!!! Thanks
> It is hard to answer your questions. Many parts play with each other. A=
So far I have following
> questions:
> - why do you change boot loader?
> - why do you use old kernels?
> - why you do not use devicetree?
> - what is your memory layout? Where is loaded u-boot and where should b=
e loaded kernel. Is kernel
> compressed? Where it will be extracted?
> =C2=A0
> Here is boot log on my system:
> barebox 2019.01.0-00526-gdd4b47ab1b #346 Mon Feb 18 08:42:48 CET 2019
> =C2=A0
> Board: DPTechnics DPT-Module
> mdio_bus: miibus0: probed
> ag71xx-gmac 18070000.mac@19000000.of: network device registered
> m25p80 w25q128@00: w25q128 (16384 Kbytes)
> netconsole: registered as netconsole-1
> malloc space: 0x83ba0000 -> 0x83f9ffff (size 4 MiB)
> eth0: got preset MAC address: c4:93:00:00:ae:89
> running /env/bin/init...
> =C2=A0
> Hit any key to stop autoboot:=C2=A0=C2=A0=C2=A0 0
> Booting entry 'net'
> eth0: DHCP client bound to address 192.168.25.20
> =C2=A0
> Loading ELF '/mnt/tftp/ore-linux-dpt-module'
> Loading devicetree from '/mnt/tftp/ore-oftree-dpt-module'
> Starting application at 0x806e0000, dts 0x83bd6120...
> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.0.0-rc1+ (ptxdist@ptxdist=
) (gcc version 8.2.1 20181130 (OSELAS.Toolch$
> in-2018.12.0 8-20181130)) #644 2019-01-11T13:10:06+00:00
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: bootconsole [early0] enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
> [=C2=A0=C2=A0=C2=A0 0.000000] MIPS: machine is DPTechnics DPT-Module
> [=C2=A0=C2=A0=C2=A0 0.000000] SoC: Atheros AR9330 rev 1
> [=C2=A0=C2=A0=C2=A0 0.000000] Determined physical RAM map:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 memory: 04000000 @ 80000000 (usable=
)
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 memory: 04000000 @ 00000000 (usable=
)
> [=C2=A0=C2=A0=C2=A0 0.000000] Primary instruction cache 64kB, VIPT, 4-w=
ay, linesize 32 bytes.
> [=C2=A0=C2=A0=C2=A0 0.000000] Primary data cache 32kB, 4-way, VIPT, cac=
he aliases, linesize 32 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 [mem 0x000=
0000000000000-0x0000000003ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
> [=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x00=
00000000000000-0x0000000003ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Initmem setup node 0 [mem 0x0000000000000=
000-0x0000000003ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] random: get_random_bytes called from star=
t_kernel+0xc4/0x52c with crng_init=3D0
> [=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists, mobility grouping on.=C2=
=A0 Total pages: 16256
> [=C2=A0=C2=A0=C2=A0 0.000000] Kernel command line:=C2=A0=C2=A0 ip=3Ddhc=
p root=3D/dev/nfs nfsroot=3D192.168.23.4:/home/ore/nfsroot/d$
> t-module,v3,tcp
> [=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 8192 (or=
der: 3, 32768 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 4096 (ord=
er: 2, 16384 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] Writing ErrCtl register=3D00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] Readback ErrCtl register=3D00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] Memory: 56624K/65536K available (4883K ke=
rnel code, 398K rwdata, 960K rodata, 1432K i$
> it, 213K bss, 8912K reserved, 0K cma-reserved)
> [=C2=A0=C2=A0=C2=A0 0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D1, Nodes=3D1
> [=C2=A0=C2=A0=C2=A0 0.000000] ftrace: allocating 17594 entries in 35 pa=
ges
> [=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS: 51
> [=C2=A0=C2=A0=C2=A0 0.000000] CPU clock: 400.000 MHz
> [=C2=A0=C2=A0=C2=A0 0.000000] clocksource: MIPS: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 9556302233 n$
> [=C2=A0=C2=A0=C2=A0 0.000014] sched_clock: 32 bits at 200MHz, resolutio=
n 5ns, wraps every 10737418237ns
> [=C2=A0=C2=A0=C2=A0 0.007915] Calibrating delay loop... 265.42 BogoMIPS=
 (lpj=3D1327104)
> [=C2=A0=C2=A0=C2=A0 0.007915] Calibrating delay loop... 265.42 BogoMIPS=
 (lpj=3D1327104)
> [=C2=A0=C2=A0=C2=A0 0.092710] pid_max: default: 32768 minimum: 301
> [=C2=A0=C2=A0=C2=A0 0.097631] Mount-cache hash table entries: 1024 (ord=
er: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 0.103958] Mountpoint-cache hash table entries: 1024=
 (order: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 0.114890] devtmpfs: initialized
> [=C2=A0=C2=A0=C2=A0 0.120178] clocksource: jiffies: mask: 0xffffffff ma=
x_cycles: 0xffffffff, max_idle_ns: 1911260446
> 2750000 ns
> [=C2=A0=C2=A0=C2=A0 0.128639] futex hash table entries: 256 (order: -1,=
 3072 bytes)
> [=C2=A0=C2=A0=C2=A0 0.134860] pinctrl core: initialized pinctrl subsyst=
em
> [=C2=A0=C2=A0=C2=A0 0.141450] NET: Registered protocol family 16
> [=C2=A0=C2=A0=C2=A0 0.222120] clocksource: Switched to clocksource MIPS=

> [=C2=A0=C2=A0=C2=A0 2.172295] NET: Registered protocol family 2
> [=C2=A0=C2=A0=C2=A0 2.176493] tcp_listen_portaddr_hash hash table entri=
es: 512 (order: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.182985] TCP established hash table entries: 1024 =
(order: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.189826] TCP bind hash table entries: 1024 (order:=
 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.196188] TCP: Hash tables configured (established =
1024 bind 1024)
> [=C2=A0=C2=A0=C2=A0 2.202754] UDP hash table entries: 256 (order: 0, 40=
96 bytes)
> [=C2=A0=C2=A0=C2=A0 2.208341] UDP-Lite hash table entries: 256 (order: =
0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.215083] NET: Registered protocol family 1
> [=C2=A0=C2=A0=C2=A0 2.221613] RPC: Registered named UNIX socket transpo=
rt module.
> [=C2=A0=C2=A0=C2=A0 2.226175] RPC: Registered udp transport module.
> [=C2=A0=C2=A0=C2=A0 2.230768] RPC: Registered tcp transport module.
> [=C2=A0=C2=A0=C2=A0 2.235487] RPC: Registered tcp NFSv4.1 backchannel t=
ransport module.
> [=C2=A0=C2=A0=C2=A0 2.245537] workingset: timestamp_bits=3D30 max_order=
=3D14 bucket_order=3D0
> [=C2=A0=C2=A0=C2=A0 2.261046] squashfs: version 4.0 (2009/01/31) Philli=
p Lougher
> [=C2=A0=C2=A0=C2=A0 2.282255] NFS: Registering the id_resolver key type=

> [=C2=A0=C2=A0=C2=A0 2.285902] Key type id_resolver registered
> [=C2=A0=C2=A0=C2=A0 2.290024] Key type id_legacy registered
> [=C2=A0=C2=A0=C2=A0 2.294098] nfs4filelayout_init: NFSv4 File Layout Dr=
iver Registering...
> [=C2=A0=C2=A0=C2=A0 2.300768] jffs2: version 2.2. (NAND) (SUMMARY)=C2=A0=
 =C2=A9 2001-2006 Red Hat, Inc.
> [=C2=A0=C2=A0=C2=A0 2.313723] pinctrl-single 18040028.pinmux: 64 pins, =
size 8
> [=C2=A0=C2=A0=C2=A0 2.323909] Serial: 8250/16550 driver, 1 ports, IRQ s=
haring disabled
> [=C2=A0=C2=A0=C2=A0 2.331142] 18020000.uart: ttyATH0 at MMIO 0x18020000=
 (irq =3D 8, base_baud =3D 1562500) is a AR933X U
> ART
> [=C2=A0=C2=A0=C2=A0 2.339446] printk: console [ttyATH0] enabled
> [=C2=A0=C2=A0=C2=A0 2.339446] printk: console [ttyATH0] enabled
> [=C2=A0=C2=A0=C2=A0 2.347627] printk: bootconsole [early0] disabled
> [=C2=A0=C2=A0=C2=A0 2.347627] printk: bootconsole [early0] disabled
> [=C2=A0=C2=A0=C2=A0 2.363728] m25p80 spi0.0: w25q128 (16384 Kbytes)
> [=C2=A0=C2=A0=C2=A0 2.367039] 4 fixed-partitions partitions found on MT=
D device spi0.0
> [=C2=A0=C2=A0=C2=A0 2.373438] Creating 4 MTD partitions on "spi0.0":
> [=C2=A0=C2=A0=C2=A0 2.378121] 0x000000020000-0x0000003e0000 : "firmware=
"
> [=C2=A0=C2=A0=C2=A0 2.386127] 0x000000000000-0x000000080000 : "barebox"=

> [=C2=A0=C2=A0=C2=A0 2.393122] 0x000000080000-0x000000090000 : "barebox-=
environment"
> [=C2=A0=C2=A0=C2=A0 2.401065] 0x0000007f0000-0x000000800000 : "art"
> [=C2=A0=C2=A0=C2=A0 2.408770] libphy: Fixed MDIO Bus: probed
> [=C2=A0=C2=A0=C2=A0 2.562114] random: fast init done
> [=C2=A0=C2=A0=C2=A0 2.742683] libphy: ag71xx_mdio: probed
> [=C2=A0=C2=A0=C2=A0 3.032223] mdio-bus.0:1f: Found an AR7240/AR9330 bui=
lt-in switch
> [=C2=A0=C2=A0=C2=A0 3.037170] libphy: ar7240sw_mdio: probed
> [=C2=A0=C2=A0=C2=A0 3.086221] ag71xx 19000000.eth: invalid MAC address,=
 using random address
> [=C2=A0=C2=A0=C2=A0 3.423862] ag71xx 19000000.eth: connected to PHY at =
mdio-bus.0:1f:04 [uid=3D004dd041, driver=3DGeneri
> c PHY]
> [=C2=A0=C2=A0=C2=A0 3.433094] eth0: Atheros AG71xx at 0xb9000000, irq 4=
, mode:MII
> [=C2=A0=C2=A0=C2=A0 3.440646] NET: Registered protocol family 10
> =C2=A0
> [=C2=A0=C2=A0=C2=A0 3.449822] Segment Routing with IPv6
> [=C2=A0=C2=A0=C2=A0 3.452310] NET: Registered protocol family 17
> [=C2=A0=C2=A0=C2=A0 3.457295] 8021q: 802.1Q VLAN Support v1.8
> [=C2=A0=C2=A0=C2=A0 3.460718] Key type dns_resolver registered
> [=C2=A0=C2=A0=C2=A0 3.470181] IPv6: ADDRCONF(NETDEV_UP): eth0: link is =
not ready
> [=C2=A0=C2=A0=C2=A0 5.533865] eth0: link up (100Mbps/Full duplex)
> [=C2=A0=C2=A0=C2=A0 5.542180] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link=
 becomes ready
> [=C2=A0=C2=A0=C2=A0 5.572256] Sending DHCP requests ., OK
> [=C2=A0=C2=A0=C2=A0 6.674525] IP-Config: Got DHCP answer from 192.168.2=
3.4, my address is 192.168.25.152
> [=C2=A0=C2=A0=C2=A0 6.682442] IP-Config: Complete:
> [=C2=A0=C2=A0=C2=A0 6.685640]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device=3Det=
h0, hwaddr=3D5a:8e:98:5e:67:91, ipaddr=3D192.168.25.152, mask=3D255.255.0=
=2E0, g
> w=3D192.168.23.254
> [=C2=A0=C2=A0=C2=A0 6.695986]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host=3D192.=
168.25.152, domain=3Dlab.pengutronix.de, nis-domain=3D(none)
> [=C2=A0=C2=A0=C2=A0 6.703544]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootserver=3D=
192.168.23.4, rootserver=3D192.168.23.4, rootpath=3D
> [=C2=A0=C2=A0=C2=A0 6.703554]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nameserver0=
=3D192.168.23.254
> [=C2=A0=C2=A0=C2=A0 6.714748]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ntpserver0=3D=
192.168.23.4
> [=C2=A0=C2=A0=C2=A0 6.747124] VFS: Mounted root (nfs filesystem) readon=
ly on device 0:12.
> [=C2=A0=C2=A0=C2=A0 6.753709] devtmpfs: mounted
> [=C2=A0=C2=A0=C2=A0 6.784596] Freeing unused kernel memory: 1432K
> [=C2=A0=C2=A0=C2=A0 6.787677] This architecture does not have kernel me=
mory protection.
> [=C2=A0=C2=A0=C2=A0 6.794147] Run /sbin/init as init process
> [=C2=A0=C2=A0=C2=A0 7.376070] systemd[1]: System time before build time=
, advancing clock.
> [=C2=A0=C2=A0=C2=A0 7.500128] systemd[1]: Failed to insert module 'auto=
fs4': No such file or directory
> [=C2=A0=C2=A0=C2=A0 7.622546] systemd[1]: systemd 239 running in system=
 mode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -
> SMACK -SYSVINIT -UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 -SEC=
COMP +BLKID -ELFUTILS +KMOD -I
> DN2 -IDN -PCRE2 default-hierarchy=3Dhybrid)
> [=C2=A0=C2=A0=C2=A0 7.643950] systemd[1]: Detected architecture mips.
> =C2=A0
> Welcome to PTXdist / Pengutronix-Freifunk!
> =C2=A0
> [=C2=A0=C2=A0=C2=A0 7.715905] systemd[1]: Set hostname to <Freifunk>.
> =C2=A0
> --
> Regards,
> Oleksij
> =C2=A0
>=20
> =C2=A0
> From:=C2=A0Oleksij Rempel
> Date:=C2=A02019-02-22=C2=A017:06
> To:=C2=A0rosysong@rosinson.com; linux-mips
> Subject:=C2=A0Re: Kernel hang when replace older uboot with uboot maste=
r for ath79 mips platform
> Hi,
> =C2=A0
> Am 22.02.19 um 03:35 schrieb rosysong@rosinson.com:> Hi all,
>> =C2=A0=C2=A0=C2=A0=C2=A0 My kernel version is linux-4.9.158, it hangs =
when replace the old u-boot(1.1.4) with
> u-boot-master.
>> =C2=A0=C2=A0=C2=A0=C2=A0 For linux-4.14.xx, When I enable CONFIG_MIPSR=
2_IRQ_VI options, it does hang any longer while
> still hang in linux-4.9.158.
>> =C2=A0=C2=A0=C2=A0=C2=A0 Sometimes it hangs at "random: crng init done=
".
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Any hints will be appreciated!!! Thanks
> It is hard to answer your questions. Many parts play with each other. A=
So far I have following
> questions:
> - why do you change boot loader?
> - why do you use old kernels?
> - why you do not use devicetree?
> - what is your memory layout? Where is loaded u-boot and where should b=
e loaded kernel. Is kernel
> compressed? Where it will be extracted?
> =C2=A0
> Here is boot log on my system:
> barebox 2019.01.0-00526-gdd4b47ab1b #346 Mon Feb 18 08:42:48 CET 2019
> =C2=A0
> Board: DPTechnics DPT-Module
> mdio_bus: miibus0: probed
> ag71xx-gmac 18070000.mac@19000000.of: network device registered
> m25p80 w25q128@00: w25q128 (16384 Kbytes)
> netconsole: registered as netconsole-1
> malloc space: 0x83ba0000 -> 0x83f9ffff (size 4 MiB)
> eth0: got preset MAC address: c4:93:00:00:ae:89
> running /env/bin/init...
> =C2=A0
> Hit any key to stop autoboot:=C2=A0=C2=A0=C2=A0 0
> Booting entry 'net'
> eth0: DHCP client bound to address 192.168.25.20
> =C2=A0
> Loading ELF '/mnt/tftp/ore-linux-dpt-module'
> Loading devicetree from '/mnt/tftp/ore-oftree-dpt-module'
> Starting application at 0x806e0000, dts 0x83bd6120...
> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.0.0-rc1+ (ptxdist@ptxdist=
) (gcc version 8.2.1 20181130 (OSELAS.Toolch$
> in-2018.12.0 8-20181130)) #644 2019-01-11T13:10:06+00:00
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: bootconsole [early0] enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
> [=C2=A0=C2=A0=C2=A0 0.000000] MIPS: machine is DPTechnics DPT-Module
> [=C2=A0=C2=A0=C2=A0 0.000000] SoC: Atheros AR9330 rev 1
> [=C2=A0=C2=A0=C2=A0 0.000000] Determined physical RAM map:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 memory: 04000000 @ 80000000 (usable=
)
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 memory: 04000000 @ 00000000 (usable=
)
> [=C2=A0=C2=A0=C2=A0 0.000000] Primary instruction cache 64kB, VIPT, 4-w=
ay, linesize 32 bytes.
> [=C2=A0=C2=A0=C2=A0 0.000000] Primary data cache 32kB, 4-way, VIPT, cac=
he aliases, linesize 32 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 [mem 0x000=
0000000000000-0x0000000003ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
> [=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x00=
00000000000000-0x0000000003ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Initmem setup node 0 [mem 0x0000000000000=
000-0x0000000003ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] random: get_random_bytes called from star=
t_kernel+0xc4/0x52c with crng_init=3D0
> [=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists, mobility grouping on.=C2=
=A0 Total pages: 16256
> [=C2=A0=C2=A0=C2=A0 0.000000] Kernel command line:=C2=A0=C2=A0 ip=3Ddhc=
p root=3D/dev/nfs nfsroot=3D192.168.23.4:/home/ore/nfsroot/d$
> t-module,v3,tcp
> [=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 8192 (or=
der: 3, 32768 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 4096 (ord=
er: 2, 16384 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] Writing ErrCtl register=3D00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] Readback ErrCtl register=3D00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] Memory: 56624K/65536K available (4883K ke=
rnel code, 398K rwdata, 960K rodata, 1432K i$
> it, 213K bss, 8912K reserved, 0K cma-reserved)
> [=C2=A0=C2=A0=C2=A0 0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D1, Nodes=3D1
> [=C2=A0=C2=A0=C2=A0 0.000000] ftrace: allocating 17594 entries in 35 pa=
ges
> [=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS: 51
> [=C2=A0=C2=A0=C2=A0 0.000000] CPU clock: 400.000 MHz
> [=C2=A0=C2=A0=C2=A0 0.000000] clocksource: MIPS: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 9556302233 n$
> [=C2=A0=C2=A0=C2=A0 0.000014] sched_clock: 32 bits at 200MHz, resolutio=
n 5ns, wraps every 10737418237ns
> [=C2=A0=C2=A0=C2=A0 0.007915] Calibrating delay loop... 265.42 BogoMIPS=
 (lpj=3D1327104)
> [=C2=A0=C2=A0=C2=A0 0.007915] Calibrating delay loop... 265.42 BogoMIPS=
 (lpj=3D1327104)
> [=C2=A0=C2=A0=C2=A0 0.092710] pid_max: default: 32768 minimum: 301
> [=C2=A0=C2=A0=C2=A0 0.097631] Mount-cache hash table entries: 1024 (ord=
er: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 0.103958] Mountpoint-cache hash table entries: 1024=
 (order: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 0.114890] devtmpfs: initialized
> [=C2=A0=C2=A0=C2=A0 0.120178] clocksource: jiffies: mask: 0xffffffff ma=
x_cycles: 0xffffffff, max_idle_ns: 1911260446
> 2750000 ns
> [=C2=A0=C2=A0=C2=A0 0.128639] futex hash table entries: 256 (order: -1,=
 3072 bytes)
> [=C2=A0=C2=A0=C2=A0 0.134860] pinctrl core: initialized pinctrl subsyst=
em
> [=C2=A0=C2=A0=C2=A0 0.141450] NET: Registered protocol family 16
> [=C2=A0=C2=A0=C2=A0 0.222120] clocksource: Switched to clocksource MIPS=

> [=C2=A0=C2=A0=C2=A0 2.172295] NET: Registered protocol family 2
> [=C2=A0=C2=A0=C2=A0 2.176493] tcp_listen_portaddr_hash hash table entri=
es: 512 (order: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.182985] TCP established hash table entries: 1024 =
(order: 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.189826] TCP bind hash table entries: 1024 (order:=
 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.196188] TCP: Hash tables configured (established =
1024 bind 1024)
> [=C2=A0=C2=A0=C2=A0 2.202754] UDP hash table entries: 256 (order: 0, 40=
96 bytes)
> [=C2=A0=C2=A0=C2=A0 2.208341] UDP-Lite hash table entries: 256 (order: =
0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 2.215083] NET: Registered protocol family 1
> [=C2=A0=C2=A0=C2=A0 2.221613] RPC: Registered named UNIX socket transpo=
rt module.
> [=C2=A0=C2=A0=C2=A0 2.226175] RPC: Registered udp transport module.
> [=C2=A0=C2=A0=C2=A0 2.230768] RPC: Registered tcp transport module.
> [=C2=A0=C2=A0=C2=A0 2.235487] RPC: Registered tcp NFSv4.1 backchannel t=
ransport module.
> [=C2=A0=C2=A0=C2=A0 2.245537] workingset: timestamp_bits=3D30 max_order=
=3D14 bucket_order=3D0
> [=C2=A0=C2=A0=C2=A0 2.261046] squashfs: version 4.0 (2009/01/31) Philli=
p Lougher
> [=C2=A0=C2=A0=C2=A0 2.282255] NFS: Registering the id_resolver key type=

> [=C2=A0=C2=A0=C2=A0 2.285902] Key type id_resolver registered
> [=C2=A0=C2=A0=C2=A0 2.290024] Key type id_legacy registered
> [=C2=A0=C2=A0=C2=A0 2.294098] nfs4filelayout_init: NFSv4 File Layout Dr=
iver Registering...
> [=C2=A0=C2=A0=C2=A0 2.300768] jffs2: version 2.2. (NAND) (SUMMARY)=C2=A0=
 =C2=A9 2001-2006 Red Hat, Inc.
> [=C2=A0=C2=A0=C2=A0 2.313723] pinctrl-single 18040028.pinmux: 64 pins, =
size 8
> [=C2=A0=C2=A0=C2=A0 2.323909] Serial: 8250/16550 driver, 1 ports, IRQ s=
haring disabled
> [=C2=A0=C2=A0=C2=A0 2.331142] 18020000.uart: ttyATH0 at MMIO 0x18020000=
 (irq =3D 8, base_baud =3D 1562500) is a AR933X U
> ART
> [=C2=A0=C2=A0=C2=A0 2.339446] printk: console [ttyATH0] enabled
> [=C2=A0=C2=A0=C2=A0 2.339446] printk: console [ttyATH0] enabled
> [=C2=A0=C2=A0=C2=A0 2.347627] printk: bootconsole [early0] disabled
> [=C2=A0=C2=A0=C2=A0 2.347627] printk: bootconsole [early0] disabled
> [=C2=A0=C2=A0=C2=A0 2.363728] m25p80 spi0.0: w25q128 (16384 Kbytes)
> [=C2=A0=C2=A0=C2=A0 2.367039] 4 fixed-partitions partitions found on MT=
D device spi0.0
> [=C2=A0=C2=A0=C2=A0 2.373438] Creating 4 MTD partitions on "spi0.0":
> [=C2=A0=C2=A0=C2=A0 2.378121] 0x000000020000-0x0000003e0000 : "firmware=
"
> [=C2=A0=C2=A0=C2=A0 2.386127] 0x000000000000-0x000000080000 : "barebox"=

> [=C2=A0=C2=A0=C2=A0 2.393122] 0x000000080000-0x000000090000 : "barebox-=
environment"
> [=C2=A0=C2=A0=C2=A0 2.401065] 0x0000007f0000-0x000000800000 : "art"
> [=C2=A0=C2=A0=C2=A0 2.408770] libphy: Fixed MDIO Bus: probed
> [=C2=A0=C2=A0=C2=A0 2.562114] random: fast init done
> [=C2=A0=C2=A0=C2=A0 2.742683] libphy: ag71xx_mdio: probed
> [=C2=A0=C2=A0=C2=A0 3.032223] mdio-bus.0:1f: Found an AR7240/AR9330 bui=
lt-in switch
> [=C2=A0=C2=A0=C2=A0 3.037170] libphy: ar7240sw_mdio: probed
> [=C2=A0=C2=A0=C2=A0 3.086221] ag71xx 19000000.eth: invalid MAC address,=
 using random address
> [=C2=A0=C2=A0=C2=A0 3.423862] ag71xx 19000000.eth: connected to PHY at =
mdio-bus.0:1f:04 [uid=3D004dd041, driver=3DGeneri
> c PHY]
> [=C2=A0=C2=A0=C2=A0 3.433094] eth0: Atheros AG71xx at 0xb9000000, irq 4=
, mode:MII
> [=C2=A0=C2=A0=C2=A0 3.440646] NET: Registered protocol family 10
> =C2=A0
> [=C2=A0=C2=A0=C2=A0 3.449822] Segment Routing with IPv6
> [=C2=A0=C2=A0=C2=A0 3.452310] NET: Registered protocol family 17
> [=C2=A0=C2=A0=C2=A0 3.457295] 8021q: 802.1Q VLAN Support v1.8
> [=C2=A0=C2=A0=C2=A0 3.460718] Key type dns_resolver registered
> [=C2=A0=C2=A0=C2=A0 3.470181] IPv6: ADDRCONF(NETDEV_UP): eth0: link is =
not ready
> [=C2=A0=C2=A0=C2=A0 5.533865] eth0: link up (100Mbps/Full duplex)
> [=C2=A0=C2=A0=C2=A0 5.542180] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link=
 becomes ready
> [=C2=A0=C2=A0=C2=A0 5.572256] Sending DHCP requests ., OK
> [=C2=A0=C2=A0=C2=A0 6.674525] IP-Config: Got DHCP answer from 192.168.2=
3.4, my address is 192.168.25.152
> [=C2=A0=C2=A0=C2=A0 6.682442] IP-Config: Complete:
> [=C2=A0=C2=A0=C2=A0 6.685640]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device=3Det=
h0, hwaddr=3D5a:8e:98:5e:67:91, ipaddr=3D192.168.25.152, mask=3D255.255.0=
=2E0, g
> w=3D192.168.23.254
> [=C2=A0=C2=A0=C2=A0 6.695986]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host=3D192.=
168.25.152, domain=3Dlab.pengutronix.de, nis-domain=3D(none)
> [=C2=A0=C2=A0=C2=A0 6.703544]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootserver=3D=
192.168.23.4, rootserver=3D192.168.23.4, rootpath=3D
> [=C2=A0=C2=A0=C2=A0 6.703554]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nameserver0=
=3D192.168.23.254
> [=C2=A0=C2=A0=C2=A0 6.714748]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ntpserver0=3D=
192.168.23.4
> [=C2=A0=C2=A0=C2=A0 6.747124] VFS: Mounted root (nfs filesystem) readon=
ly on device 0:12.
> [=C2=A0=C2=A0=C2=A0 6.753709] devtmpfs: mounted
> [=C2=A0=C2=A0=C2=A0 6.784596] Freeing unused kernel memory: 1432K
> [=C2=A0=C2=A0=C2=A0 6.787677] This architecture does not have kernel me=
mory protection.
> [=C2=A0=C2=A0=C2=A0 6.794147] Run /sbin/init as init process
> [=C2=A0=C2=A0=C2=A0 7.376070] systemd[1]: System time before build time=
, advancing clock.
> [=C2=A0=C2=A0=C2=A0 7.500128] systemd[1]: Failed to insert module 'auto=
fs4': No such file or directory
> [=C2=A0=C2=A0=C2=A0 7.622546] systemd[1]: systemd 239 running in system=
 mode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -
> SMACK -SYSVINIT -UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 -SEC=
COMP +BLKID -ELFUTILS +KMOD -I
> DN2 -IDN -PCRE2 default-hierarchy=3Dhybrid)
> [=C2=A0=C2=A0=C2=A0 7.643950] systemd[1]: Detected architecture mips.
> =C2=A0
> Welcome to PTXdist / Pengutronix-Freifunk!
> =C2=A0
> [=C2=A0=C2=A0=C2=A0 7.715905] systemd[1]: Set hostname to <Freifunk>.
> =C2=A0
> --
> Regards,
> Oleksij
> =C2=A0
>=20


--=20
Regards,
Oleksij


--ql1RHc5b0AWYynPIWgBU2n71Sb9dL07OV--

--2pqsGfrkBNMYQxUpU9rTzaiIJeRshInJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlxvzYoACgkQdQOiSHVI
77S9dAf/bffJv/xfDUx2NbAEXV9vSayV/PLUYakpgoMW6rjp+DmQX9QH8ppOgJ96
qlAsMcv16xzZz51+YoeOM1q6t4vt33zh8bycfoznf7hcm+eSMXjtfdf/52Mhrb3M
mYtgFCaYU9Nt3B2XOKrO/Kz9vMgme6FrFQQ0HZh/ZUFNxLJhRNssdzOHVqgxVCFJ
B6wNwwNXXxIJM27Xif/FnPu3G7wFwkPMShtvcDazqiK0Ma6ALbQPy2jDyUDVpoiT
YuQuLEX2mmnOjxTbRp+u77ndn7dB+03WbiOaKF9c9Gxy2ryolUbBP8h9gp6KTSm0
wXoV8RK3fbwExFRJ3rmHiC5XIHqvNA==
=HLSD
-----END PGP SIGNATURE-----

--2pqsGfrkBNMYQxUpU9rTzaiIJeRshInJA--
