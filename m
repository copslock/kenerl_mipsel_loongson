Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08314C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04412077B
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 09:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfBVJHD (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:07:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:36565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBVJHC (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Feb 2019 04:07:02 -0500
Received: from [192.168.178.38] ([31.18.251.131]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4Gup-1hDoIY2s8B-00rpGV; Fri, 22
 Feb 2019 10:06:53 +0100
Subject: Re: Kernel hang when replace older uboot with uboot master for ath79
 mips platform
To:     "rosysong@rosinson.com" <rosysong@rosinson.com>,
        linux-mips <linux-mips@vger.kernel.org>
References: <201902221035393424496@rosinson.com>
From:   Oleksij Rempel <linux@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
 8VXa+gkZKRSnZTvVMAriaQwqKog=
Message-ID: <2142641f-fcea-b3da-dfe2-9ae6135f5c1d@rempel-privat.de>
Date:   Fri, 22 Feb 2019 10:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <201902221035393424496@rosinson.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jJmfaho23M5TrOZdGDlfqqEBpZRFgNbi5"
X-Provags-ID: V03:K1:DYxbuWgZMfqUXl76BRAzeXpZJI79phJwYmjLq91cXRThaQ9ZTtL
 YKhhbaxM7+YPLueUA6J++/OhJ8GneTJGenmJrLfMmV+bDFTcy+ZKr42MD/ypf08N6ydVC4U
 nsL0xrVpjYaRbNIlUDjHrP5y9sOy1zTldvjB4rDtteV/bCUtaEpIqNupn80OlKWJAR5WPC/
 JvxsO6GJwEvdphZOyXTFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yDMTxxnh2OY=:A7qIhkZoGQjU4MNdo/yNCv
 qbEvPOebvAd0kHN2SPyrBUQtDE1m0CIQg/Nol+bExTVCs7wI1btmaoiqJRAA3drhjLf6l+xPg
 vA9WZ0FKHUd1W6dp7H3o3NixiO5/OBSb3YRaoxlLdUGEy96BgnAbTpfo1hP5TSErH1fx1hBDk
 EXJJu98B6N5rj9zzQBuuDuePqg2jgusBaQDRJgNbBkUYNW4EMyQCoFL4NSF7Mq1LWB1oc9ZDL
 T3y0yAV5Uz7DgW1tDWPhYTiXmqG2WjERxo5gaZE5YKs8tLeW+87QvuefexHEKLKH2TE1jqVhv
 TITMsDn0/VVISXC+PD2Ovw2qZATorW2ZbSDXDw4D+mnMKRhj0lJQJ4LDH0Sek7VfqDozzRHRh
 ned6orHhwQAnSOXAcHTvGmwcCgc7pc0rhp1aDOeGRn4PujIBRLcJ7HvPynu4t1g9Xn5MhHgS+
 B59pr/60am2ZTX7J9o1DRAZocYoijpwa3WO7Y5bAsNkii+i5WRLX0DwoPP6ID6RtTYX/XSrcU
 4gT/jb+T/+i6GiyqN+CXkAsL7qN9GtLm1ZH4zlvtqCAsYeisGhyvNHz8/egLoiPdQX9N/hZG+
 dkPYvXnSTxaSwUVdS/JGsqZ1SUzsMSKvTDtojiGnb4z0aFRta7YYgmv+Hr+MRQtEsfP+OE00I
 TbkDwq3A3tBZvavRVOxlEXd9S3fg0CzMvNkkL7StP1PIjJ0KrGAgncuwnRR3gz4s+GUt9N4BZ
 wgxCSE+Prda1OJ4v038XFYvkVc8vSIkJ4w/RX9pN55tsHLVqBUDXwkn/dUzfjcISnXCqvVoDm
 I8eQCja3KROwP6kVcLn7Bg9kCP++3DerTLu5thArjNGio9Y0pLiGuE/x7Ay6rdXriDQp5o+UX
 52ib9a+M0Mlif54bjOcTqJcPx62tAEwo6faCNoJ0gDlgYQ8jVuYQwYT0PP9AGV
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jJmfaho23M5TrOZdGDlfqqEBpZRFgNbi5
Content-Type: multipart/mixed; boundary="mHb3EPDTQ35yvdLQtZtcNWhXdSF8vMC74";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: "rosysong@rosinson.com" <rosysong@rosinson.com>,
 linux-mips <linux-mips@vger.kernel.org>
Message-ID: <2142641f-fcea-b3da-dfe2-9ae6135f5c1d@rempel-privat.de>
Subject: Re: Kernel hang when replace older uboot with uboot master for ath79
 mips platform
References: <201902221035393424496@rosinson.com>
In-Reply-To: <201902221035393424496@rosinson.com>

--mHb3EPDTQ35yvdLQtZtcNWhXdSF8vMC74
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: quoted-printable

Hi,

Am 22.02.19 um 03:35 schrieb rosysong@rosinson.com:> Hi all,
>     My kernel version is linux-4.9.158, it hangs when replace the old u=
-boot(1.1.4) with
u-boot-master.
>     For linux-4.14.xx, When I enable CONFIG_MIPSR2_IRQ_VI options, it d=
oes hang any longer while
still hang in linux-4.9.158.
>     Sometimes it hangs at "random: crng init done".
>
>     Any hints will be appreciated!!! Thanks
It is hard to answer your questions. Many parts play with each other. ASo=
 far I have following
questions:
- why do you change boot loader?
- why do you use old kernels?
- why you do not use devicetree?
- what is your memory layout? Where is loaded u-boot and where should be =
loaded kernel. Is kernel
compressed? Where it will be extracted?

Here is boot log on my system:
barebox 2019.01.0-00526-gdd4b47ab1b #346 Mon Feb 18 08:42:48 CET 2019

Board: DPTechnics DPT-Module
mdio_bus: miibus0: probed
ag71xx-gmac 18070000.mac@19000000.of: network device registered
m25p80 w25q128@00: w25q128 (16384 Kbytes)
netconsole: registered as netconsole-1
malloc space: 0x83ba0000 -> 0x83f9ffff (size 4 MiB)
eth0: got preset MAC address: c4:93:00:00:ae:89
running /env/bin/init...

Hit any key to stop autoboot:    0
Booting entry 'net'
eth0: DHCP client bound to address 192.168.25.20

Loading ELF '/mnt/tftp/ore-linux-dpt-module'
Loading devicetree from '/mnt/tftp/ore-oftree-dpt-module'
Starting application at 0x806e0000, dts 0x83bd6120...
[    0.000000] Linux version 5.0.0-rc1+ (ptxdist@ptxdist) (gcc version 8.=
2.1 20181130 (OSELAS.Toolch$
in-2018.12.0 8-20181130)) #644 2019-01-11T13:10:06+00:00
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
[    0.000000] MIPS: machine is DPTechnics DPT-Module
[    0.000000] SoC: Atheros AR9330 rev 1
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 04000000 @ 80000000 (usable)
[    0.000000]  memory: 04000000 @ 00000000 (usable)
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 b=
ytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lines=
ize 32 bytes
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000003ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000003ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000003f=
fffff]
[    0.000000] random: get_random_bytes called from start_kernel+0xc4/0x5=
2c with crng_init=3D0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 162=
56
[    0.000000] Kernel command line:   ip=3Ddhcp root=3D/dev/nfs nfsroot=3D=
192.168.23.4:/home/ore/nfsroot/d$
t-module,v3,tcp
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 byt=
es)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 byte=
s)
[    0.000000] Writing ErrCtl register=3D00000000
[    0.000000] Readback ErrCtl register=3D00000000
[    0.000000] Memory: 56624K/65536K available (4883K kernel code, 398K r=
wdata, 960K rodata, 1432K i$
it, 213K bss, 8912K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.000000] ftrace: allocating 17594 entries in 35 pages
[    0.000000] NR_IRQS: 51
[    0.000000] CPU clock: 400.000 MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 9556302233 n$
[    0.000014] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps ever=
y 10737418237ns
[    0.007915] Calibrating delay loop... 265.42 BogoMIPS (lpj=3D1327104)
[    0.007915] Calibrating delay loop... 265.42 BogoMIPS (lpj=3D1327104)
[    0.092710] pid_max: default: 32768 minimum: 301
[    0.097631] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes=
)
[    0.103958] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.114890] devtmpfs: initialized
[    0.120178] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446
2750000 ns
[    0.128639] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.134860] pinctrl core: initialized pinctrl subsystem
[    0.141450] NET: Registered protocol family 16
[    0.222120] clocksource: Switched to clocksource MIPS
[    2.172295] NET: Registered protocol family 2
[    2.176493] tcp_listen_portaddr_hash hash table entries: 512 (order: 0=
, 4096 bytes)
[    2.182985] TCP established hash table entries: 1024 (order: 0, 4096 b=
ytes)
[    2.189826] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    2.196188] TCP: Hash tables configured (established 1024 bind 1024)
[    2.202754] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    2.208341] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    2.215083] NET: Registered protocol family 1
[    2.221613] RPC: Registered named UNIX socket transport module.
[    2.226175] RPC: Registered udp transport module.
[    2.230768] RPC: Registered tcp transport module.
[    2.235487] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.245537] workingset: timestamp_bits=3D30 max_order=3D14 bucket_orde=
r=3D0
[    2.261046] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.282255] NFS: Registering the id_resolver key type
[    2.285902] Key type id_resolver registered
[    2.290024] Key type id_legacy registered
[    2.294098] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
=2E.
[    2.300768] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red=
 Hat, Inc.
[    2.313723] pinctrl-single 18040028.pinmux: 64 pins, size 8
[    2.323909] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    2.331142] 18020000.uart: ttyATH0 at MMIO 0x18020000 (irq =3D 8, base=
_baud =3D 1562500) is a AR933X U
ART
[    2.339446] printk: console [ttyATH0] enabled
[    2.339446] printk: console [ttyATH0] enabled
[    2.347627] printk: bootconsole [early0] disabled
[    2.347627] printk: bootconsole [early0] disabled
[    2.363728] m25p80 spi0.0: w25q128 (16384 Kbytes)
[    2.367039] 4 fixed-partitions partitions found on MTD device spi0.0
[    2.373438] Creating 4 MTD partitions on "spi0.0":
[    2.378121] 0x000000020000-0x0000003e0000 : "firmware"
[    2.386127] 0x000000000000-0x000000080000 : "barebox"
[    2.393122] 0x000000080000-0x000000090000 : "barebox-environment"
[    2.401065] 0x0000007f0000-0x000000800000 : "art"
[    2.408770] libphy: Fixed MDIO Bus: probed
[    2.562114] random: fast init done
[    2.742683] libphy: ag71xx_mdio: probed
[    3.032223] mdio-bus.0:1f: Found an AR7240/AR9330 built-in switch
[    3.037170] libphy: ar7240sw_mdio: probed
[    3.086221] ag71xx 19000000.eth: invalid MAC address, using random add=
ress
[    3.423862] ag71xx 19000000.eth: connected to PHY at mdio-bus.0:1f:04 =
[uid=3D004dd041, driver=3DGeneri
c PHY]
[    3.433094] eth0: Atheros AG71xx at 0xb9000000, irq 4, mode:MII
[    3.440646] NET: Registered protocol family 10

[    3.449822] Segment Routing with IPv6
[    3.452310] NET: Registered protocol family 17
[    3.457295] 8021q: 802.1Q VLAN Support v1.8
[    3.460718] Key type dns_resolver registered
[    3.470181] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.533865] eth0: link up (100Mbps/Full duplex)
[    5.542180] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    5.572256] Sending DHCP requests ., OK
[    6.674525] IP-Config: Got DHCP answer from 192.168.23.4, my address i=
s 192.168.25.152
[    6.682442] IP-Config: Complete:
[    6.685640]      device=3Deth0, hwaddr=3D5a:8e:98:5e:67:91, ipaddr=3D1=
92.168.25.152, mask=3D255.255.0.0, g
w=3D192.168.23.254
[    6.695986]      host=3D192.168.25.152, domain=3Dlab.pengutronix.de, n=
is-domain=3D(none)
[    6.703544]      bootserver=3D192.168.23.4, rootserver=3D192.168.23.4,=
 rootpath=3D
[    6.703554]      nameserver0=3D192.168.23.254
[    6.714748]      ntpserver0=3D192.168.23.4
[    6.747124] VFS: Mounted root (nfs filesystem) readonly on device 0:12=
=2E
[    6.753709] devtmpfs: mounted
[    6.784596] Freeing unused kernel memory: 1432K
[    6.787677] This architecture does not have kernel memory protection.
[    6.794147] Run /sbin/init as init process
[    7.376070] systemd[1]: System time before build time, advancing clock=
=2E
[    7.500128] systemd[1]: Failed to insert module 'autofs4': No such fil=
e or directory
[    7.622546] systemd[1]: systemd 239 running in system mode. (-PAM -AUD=
IT -SELINUX -IMA -APPARMOR -
SMACK -SYSVINIT -UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 -SECCO=
MP +BLKID -ELFUTILS +KMOD -I
DN2 -IDN -PCRE2 default-hierarchy=3Dhybrid)
[    7.643950] systemd[1]: Detected architecture mips.

Welcome to PTXdist / Pengutronix-Freifunk!

[    7.715905] systemd[1]: Set hostname to <Freifunk>.

--=20
Regards,
Oleksij


--mHb3EPDTQ35yvdLQtZtcNWhXdSF8vMC74--

--jJmfaho23M5TrOZdGDlfqqEBpZRFgNbi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlxvu6sACgkQdQOiSHVI
77TA6Af/bGZVwQAzVhfns9/frF9i0NvhHB5odrrKlP+3wxEh9e7/vBpreUfkF49D
lwSrxL/rjVWIYyKrtgfE51JklMxFxU+j8Cxv9aGDWfzURtDqFILCk7hDmvdKoSDP
v0QFuffQQQlC8rr2pbQKfsq+ou/CclkwRoYK+MOljMZIx439lEShiwbVhCLtUFgl
tAYGUr+nrhCUypvAZcUhnWx5Fq3s+2w5Cgin3Nmg2Lwe5jB/ZEK62tulVq97+czo
wHjnUoRLnV2xcDW6WhkXkd0F/kMOyZ7aZMiMqCzPtQDPsHm6paPc0wTEwn1kUBTP
17UVbS8Yd6Jlu5gBa+Ru+q7WMIEYvQ==
=7Ss+
-----END PGP SIGNATURE-----

--jJmfaho23M5TrOZdGDlfqqEBpZRFgNbi5--
