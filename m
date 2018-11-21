Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 02:00:18 +0100 (CET)
Received: from mail-eopbgr760114.outbound.protection.outlook.com ([40.107.76.114]:64416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990509AbeKUA6hvMvaM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 01:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWVYXYuk4F0aD3JLV6w/KUPQyqGmPTa5Rqjpjg3Hewo=;
 b=QAzda+Ic2gDnty7xB7zNi2akR9S5GRDYQ9kFx7nUHmzILHBH7ciMyOu/44n57zuOkBMatuiW22GSFJxU41vPsCDe6A8MQTwRgOGhCalnxA1awNga9Q5QQYyLwvrxdAkWghm3l6XIblq3MApG9l+ZiCXlodUdlb2gFDkfdbOm2D8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1166.namprd22.prod.outlook.com (10.174.168.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.36; Wed, 21 Nov 2018 00:58:32 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 00:58:32 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MIPS: Regerate defconfigs
Thread-Topic: [PATCH] MIPS: Regerate defconfigs
Thread-Index: AQHUgTVS3GKroqpOD0iGPcWc8UUUOw==
Date:   Wed, 21 Nov 2018 00:58:31 +0000
Message-ID: <20181121005819.23815-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:300:115::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1166;6:OUE28+I2rrPvbsjWlJ9cz4zQHJbLGXWTwhmusKzO1wmqcyYLuVFRh02xjw0vsD3zGX3z4K33izsNITFQBa3qJ7GMUso/892H/Er8LsYDjOJahEqa1SgpuygILq4+4feP/vZznQd5u+v78YxeT2GmYH8Ck1TSHbDFqZ6IoDisz4lMomPXpgmWTuJ/B8LjoabDlYwIYMkXB2EDeXkmKHepSp/Ej5FVQblrk0hMxTBRAiyiTWMNBPDTMAiE6ceQboxF8KCzpMsxg++4Bb/iNyUDPgHQ/to3pCYCzlTZwPV8/V9JhGk3m59Q97DTwEnZHmG9AHOFMGsyndp+R3vanNS21qr4Ls4AKJ76l3IsnVnw7VgDye8+kI03urtH4zcIzu9E+p2aquMuFNCMtJUAdeVJ1KGd8zL4TBCR6phN3BDzRBd3GYF0h6+k+sn5ZfWeGsWA7UazgvaBfVdXoYMlk7/Xww==;5:BvD4r1PrDUQSPnl/iwVqdJ7wHOmpK7fDXwo97mdzPpz+XLrVTEv94wgU+cRUEUyXzG4gNzJh5ojO/XKd3PwK1/SGIwzNV3WHwnaM2JwEU4JbRrsluoTi9dEVZhfSgxitrDlfRqMPcmCACE8xNt3/+lLUBDlk5ZoDgzp2I/Mx6u8=;7:/vWop80kr6ldxh3iFQDK1KTunukYf5GQI1dsVnVh0FDoXMrXpkt+hnnPZD9eHesiynGYS32qoU7n2wqPp35tUQHshBVo7snvsptDodt4QOGkswtxYFzRukK3+wk6Bxmr0X9om0+HE0Ga2OSEiO4USQ==
x-ms-office365-filtering-correlation-id: 9459f9ec-19f2-4f52-6459-08d64f4c7429
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1166;
x-ms-traffictypediagnostic: MWHPR2201MB1166:
x-microsoft-antispam-prvs: <MWHPR2201MB11669B0532D8A3ABE039945DC1DA0@MWHPR2201MB1166.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192278398808882)(166708455590820)(265634631926514);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1166;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(39840400004)(366004)(396003)(189003)(199004)(3846002)(1076002)(2501003)(6116002)(305945005)(14454004)(4744004)(6436002)(7736002)(5660300001)(966005)(575784001)(508600001)(2906002)(5640700003)(25786009)(486006)(2616005)(44832011)(68736007)(6512007)(105586002)(66066001)(6916009)(476003)(186003)(6306002)(106356001)(81166006)(81156014)(26005)(1857600001)(36756003)(8676002)(52116002)(102836004)(6506007)(42882007)(5024004)(14444005)(386003)(8936002)(2351001)(256004)(99286004)(6486002)(71190400001)(71200400001)(2900100001)(316002)(54906003)(53946003)(53936002)(97736004)(4326008)(959014)(579004)(559001)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1166;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gX3/ijb3sXMA9Tvbj4T9QIGdFCgetH8eGQgfifKECNbe8f22VeZCr1G3+/tZiA4tFpbNM5Ny4kwBsY0POvrEt0J9RdE0NW8UAq/SZj2kxTBgEtQ7yicNSsMI7RtNVT4ytP0DGoyG6XrIUODRiZs646tN1v+r6ZS0mANYJ5UyR+Qobs2OR98Zbqc16hvTBelaagnuc6Z1F+2G5k4vm5V/ttBdNvNOxH+sYLqJp+xlx1SiMlXuuTjxpTvQZCEy3/wz7Qx6lkOnduWsoxt59WZcb0yY9Isq2qGC9VC0HS20ZHvnjlANqRxhTOzsKDrVajOpYFtFz/Ss1dkOioWLZoqivII3XsPXBkYvQW/w5+0VHSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9459f9ec-19f2-4f52-6459-08d64f4c7429
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 00:58:31.9424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1166
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

A couple of patches have come up recently to remove particular instances
of obsolete Kconfig symbols from defconfigs. Rather than doing this
piecemeal, simply regenerate them all.

Signed-off-by: Paul Burton <paul.burton@mips.com>
References: https://patchwork.linux-mips.org/patch/19635/
References: https://patchwork.linux-mips.org/patch/21156/
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>

---
This is the result of running the following script, which verifies that
the defconfigs still produce the same .config they did before:

https://gist.github.com/paulburton/36e9858a90a6391b50c782ada9ebe741

 arch/mips/configs/ar7_defconfig             |  44 +--
 arch/mips/configs/ath25_defconfig           |  25 +-
 arch/mips/configs/ath79_defconfig           |  33 +--
 arch/mips/configs/bcm47xx_defconfig         |  11 +-
 arch/mips/configs/bcm63xx_defconfig         |  37 +--
 arch/mips/configs/bigsur_defconfig          |  65 ++---
 arch/mips/configs/bmips_be_defconfig        |  22 +-
 arch/mips/configs/bmips_stb_defconfig       |  23 +-
 arch/mips/configs/capcella_defconfig        |  24 +-
 arch/mips/configs/cavium_octeon_defconfig   |  42 ++-
 arch/mips/configs/ci20_defconfig            |  27 +-
 arch/mips/configs/cobalt_defconfig          |   8 +-
 arch/mips/configs/db1xxx_defconfig          |  47 +--
 arch/mips/configs/e55_defconfig             |   8 +-
 arch/mips/configs/fuloong2e_defconfig       |  79 ++---
 arch/mips/configs/gcw0_defconfig            |  12 +-
 arch/mips/configs/generic_defconfig         |  26 +-
 arch/mips/configs/gpr_defconfig             | 112 +++----
 arch/mips/configs/ip22_defconfig            |  76 ++---
 arch/mips/configs/ip27_defconfig            | 149 ++++------
 arch/mips/configs/ip28_defconfig            |  26 +-
 arch/mips/configs/ip32_defconfig            |  41 +--
 arch/mips/configs/jazz_defconfig            |  62 +---
 arch/mips/configs/jmr3927_defconfig         |  13 +-
 arch/mips/configs/lasat_defconfig           |  24 +-
 arch/mips/configs/lemote2f_defconfig        | 143 ++-------
 arch/mips/configs/loongson1b_defconfig      |  15 +-
 arch/mips/configs/loongson1c_defconfig      |  17 +-
 arch/mips/configs/loongson3_defconfig       |  70 ++---
 arch/mips/configs/malta_defconfig           |  42 ++-
 arch/mips/configs/malta_kvm_defconfig       |  59 ++--
 arch/mips/configs/malta_kvm_guest_defconfig |  48 ++-
 arch/mips/configs/malta_qemu_32r6_defconfig |  22 +-
 arch/mips/configs/maltaaprp_defconfig       |  25 +-
 arch/mips/configs/maltasmvp_defconfig       |  30 +-
 arch/mips/configs/maltasmvp_eva_defconfig   |  30 +-
 arch/mips/configs/maltaup_defconfig         |  21 +-
 arch/mips/configs/maltaup_xpa_defconfig     |  44 ++-
 arch/mips/configs/markeins_defconfig        |  35 +--
 arch/mips/configs/mips_paravirt_defconfig   |  35 +--
 arch/mips/configs/mpc30x_defconfig          |   7 +-
 arch/mips/configs/msp71xx_defconfig         |  20 +-
 arch/mips/configs/mtx1_defconfig            | 307 +++++++-------------
 arch/mips/configs/nlm_xlp_defconfig         | 112 ++-----
 arch/mips/configs/nlm_xlr_defconfig         | 145 +++------
 arch/mips/configs/omega2p_defconfig         |  28 +-
 arch/mips/configs/pic32mzda_defconfig       |  12 +-
 arch/mips/configs/pistachio_defconfig       |  78 ++---
 arch/mips/configs/pnx8335_stb225_defconfig  |  27 +-
 arch/mips/configs/qi_lb60_defconfig         |  23 +-
 arch/mips/configs/rb532_defconfig           |  49 ++--
 arch/mips/configs/rbtx49xx_defconfig        |  24 +-
 arch/mips/configs/rm200_defconfig           |  79 ++---
 arch/mips/configs/rt305x_defconfig          |  45 ++-
 arch/mips/configs/sb1250_swarm_defconfig    |  36 +--
 arch/mips/configs/tb0219_defconfig          |  32 +-
 arch/mips/configs/tb0226_defconfig          |  17 +-
 arch/mips/configs/tb0287_defconfig          |  29 +-
 arch/mips/configs/vocore2_defconfig         |  28 +-
 arch/mips/configs/workpad_defconfig         |  18 +-
 arch/mips/configs/xway_defconfig            |  32 +-
 61 files changed, 970 insertions(+), 1850 deletions(-)

diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index 5651f4d8f45c..9fbfb6e5c7d2 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -1,29 +1,27 @@
-CONFIG_AR7=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-CONFIG_KEXEC=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_TINY_RCU=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_ELF_CORE is not set
-# CONFIG_PCSPKR_PLATFORM is not set
+# CONFIG_KALLSYMS is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_AR7=y
+CONFIG_HZ_100=y
+CONFIG_KEXEC=y
+# CONFIG_SECCOMP is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -35,7 +33,6 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
@@ -59,13 +56,9 @@ CONFIG_NETFILTER_XT_MATCH_LIMIT=m
 CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_RAW=m
 CONFIG_ATM=m
@@ -79,8 +72,6 @@ CONFIG_NET_ACT_POLICE=y
 CONFIG_HAMRADIO=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
-CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
@@ -91,25 +82,22 @@ CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_NETDEVICES=y
-CONFIG_FIXED_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
 CONFIG_CPMAC=y
+CONFIG_FIXED_PHY=y
 CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
 CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPPOE=m
+CONFIG_PPP_MULTILINK=y
 CONFIG_PPPOATM=m
+CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_HW_RANDOM=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
@@ -131,13 +119,9 @@ CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
+# CONFIG_CRYPTO_HW is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="rootfstype=squashfs,jffs2"
-CONFIG_CRYPTO=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index b8d48038e74f..5dd6b1939e9c 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -1,11 +1,6 @@
-CONFIG_ATH25=y
-# CONFIG_COMPACTION is not set
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
-# CONFIG_FHANDLE is not set
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
@@ -14,16 +9,21 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_FHANDLE is not set
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ATH25=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-# CONFIG_SUSPEND is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -75,7 +75,6 @@ CONFIG_INPUT=m
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
@@ -104,15 +103,15 @@ CONFIG_SQUASHFS_FILE_DIRECT=y
 CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
 # CONFIG_SQUASHFS_ZLIB is not set
 CONFIG_SQUASHFS_XZ=y
-CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
 # CONFIG_XZ_DEC_X86 is not set
 # CONFIG_XZ_DEC_POWERPC is not set
 # CONFIG_XZ_DEC_IA64 is not set
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 951c4231bdb8..4e4ec779f182 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -1,30 +1,29 @@
-CONFIG_ATH79=y
-CONFIG_ATH79_MACH_AP121=y
-CONFIG_ATH79_MACH_AP136=y
-CONFIG_ATH79_MACH_AP81=y
-CONFIG_ATH79_MACH_DB120=y
-CONFIG_ATH79_MACH_PB44=y
-CONFIG_ATH79_MACH_UBNT_XM=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
-CONFIG_RD_LZMA=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_AIO is not set
+# CONFIG_KALLSYMS is not set
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ATH79=y
+CONFIG_ATH79_MACH_AP121=y
+CONFIG_ATH79_MACH_AP136=y
+CONFIG_ATH79_MACH_AP81=y
+CONFIG_ATH79_MACH_DB120=y
+CONFIG_ATH79_MACH_PB44=y
+CONFIG_ATH79_MACH_UBNT_XM=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -52,12 +51,9 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_PACKET_ENGINE is not set
-CONFIG_ATH_COMMON=m
 CONFIG_ATH9K=m
 CONFIG_ATH9K_AHB=y
 CONFIG_INPUT=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO_POLLED=m
 # CONFIG_INPUT_MOUSE is not set
@@ -65,7 +61,6 @@ CONFIG_INPUT_MISC=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
@@ -98,11 +93,9 @@ CONFIG_LEDS_GPIO=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_CRC_ITU_T=m
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
-CONFIG_CRYPTO=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_ITU_T=m
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index ba800a892384..249f5285e343 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -1,16 +1,15 @@
-CONFIG_BCM47XX=y
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_UIDGID_STRICT_TYPE_CHECKS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_BCM47XX=y
+CONFIG_PCI=y
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_PCI=y
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -47,8 +46,6 @@ CONFIG_MTD_NAND_BCM47XXNFLASH=y
 CONFIG_NETDEVICES=y
 CONFIG_B44=y
 CONFIG_TIGON3=y
-CONFIG_BGMAC=y
-CONFIG_ATH_CARDS=y
 CONFIG_ATH5K=y
 CONFIG_B43=y
 CONFIG_B43LEGACY=y
@@ -73,6 +70,7 @@ CONFIG_USB_HCD_BCMA=y
 CONFIG_USB_HCD_SSB=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_CRC32_SARWATE=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_REDUCED=y
@@ -81,4 +79,3 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
-CONFIG_CRC32_SARWATE=y
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 131b350f014f..d22fe62adad3 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -1,16 +1,7 @@
-CONFIG_BCM63XX=y
-CONFIG_BCM63XX_CPU_6338=y
-CONFIG_BCM63XX_CPU_6345=y
-CONFIG_BCM63XX_CPU_6348=y
-CONFIG_BCM63XX_CPU_6358=y
-CONFIG_NO_HZ=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
-CONFIG_TINY_RCU=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_NO_HZ=y
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
@@ -20,12 +11,18 @@ CONFIG_EXPERT=y
 # CONFIG_AIO is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
+CONFIG_BCM63XX=y
+CONFIG_BCM63XX_CPU_6338=y
+CONFIG_BCM63XX_CPU_6345=y
+CONFIG_BCM63XX_CPU_6348=y
+CONFIG_BCM63XX_CPU_6358=y
+# CONFIG_SECCOMP is not set
 CONFIG_PCI=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_BCM63XX=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -37,7 +34,6 @@ CONFIG_INET=y
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
 CONFIG_MAC80211=y
-CONFIG_MAC80211_LEDS=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
@@ -49,18 +45,16 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
-CONFIG_BCM63XX_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_BCM63XX_ENET=y
+CONFIG_BCM63XX_PHY=y
 CONFIG_B43=y
 # CONFIG_B43_PHY_LP is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
+# CONFIG_UNIX98_PTYS is not set
 CONFIG_SERIAL_BCM63XX=y
 CONFIG_SERIAL_BCM63XX_CONSOLE=y
-# CONFIG_UNIX98_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_VGA_ARB is not set
@@ -68,16 +62,11 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_OHCI_HCD=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_GPIO=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_PROC_KCORE=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
+# CONFIG_CRYPTO_HW is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 5e73fe755be6..597bc0aa2653 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -1,45 +1,37 @@
-CONFIG_SIBYTE_BIGSUR=y
-CONFIG_64BIT=y
-CONFIG_SMP=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_1000=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
-CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
-CONFIG_UTS_NS=y
-CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
-CONFIG_PID_NS=y
-CONFIG_NET_NS=y
+CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_SIBYTE_BIGSUR=y
+CONFIG_64BIT=y
+CONFIG_SMP=y
+CONFIG_HZ_1000=y
 CONFIG_PCI=y
 CONFIG_PCI_DEBUG=y
-CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -94,7 +86,6 @@ CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_IP_VS_FTP=m
 CONFIG_IP_DCCP=m
-CONFIG_SCTP_HMAC_SHA1=y
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
@@ -134,20 +125,18 @@ CONFIG_PATA_SIL680=y
 CONFIG_ATA_GENERIC=y
 CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
 CONFIG_SB1250_MAC=y
 CONFIG_CHELSIO_T3=m
 CONFIG_NETXEN_NIC=m
 CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
 CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
 CONFIG_SLIP=m
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_SLIP_SMART=y
@@ -168,13 +157,10 @@ CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=m
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 # CONFIG_PRINT_QUOTA_WARNING is not set
@@ -192,10 +178,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_RPCSEC_GSS_KRB5=m
-CONFIG_RPCSEC_GSS_SPKM3=m
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -234,13 +217,6 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DLM=m
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
-CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_DEBUG_LIST=y
 CONFIG_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
@@ -265,7 +241,6 @@ CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -283,3 +258,7 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRC_T10DIF=m
 CONFIG_CRC7=m
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEBUG_LIST=y
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index a7072a14d396..8a91f0101134 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -1,17 +1,16 @@
-CONFIG_BMIPS_GENERIC=y
-CONFIG_HIGHMEM=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=4
-# CONFIG_SECCOMP is not set
-CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_GZIP=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
+CONFIG_BMIPS_GENERIC=y
+CONFIG_HIGHMEM=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
@@ -32,8 +31,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_PRINTK_TIME=y
-CONFIG_BRCMSTB_GISB_ARB=y
 CONFIG_MTD=y
 CONFIG_MTD_BCM63XX_PARTS=y
 CONFIG_MTD_CFI=y
@@ -50,14 +47,12 @@ CONFIG_USB_USBNET=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_BCM63XX=y
 CONFIG_SERIAL_BCM63XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_BRCMSTB=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
@@ -79,8 +74,9 @@ CONFIG_CIFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon"
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 47aecb8750e6..39adcca46bb0 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -1,10 +1,3 @@
-CONFIG_BMIPS_GENERIC=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_HIGHMEM=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=4
-# CONFIG_SECCOMP is not set
-CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
@@ -12,9 +5,13 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
+CONFIG_BMIPS_GENERIC=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_HIGHMEM=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_O32_FP64_SUPPORT=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
@@ -23,6 +20,9 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_BMIPS_CPUFREQ=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
@@ -61,7 +61,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_BRCMSTB=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
@@ -86,9 +85,9 @@ CONFIG_CIFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+# CONFIG_CRYPTO_HW is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon"
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index bd80b5c852dd..7bf8971af53b 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -1,10 +1,9 @@
-CONFIG_MACH_VR41XX=y
-CONFIG_ZAO_CAPCELLA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
+CONFIG_ZAO_CAPCELLA=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -34,18 +33,15 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
+CONFIG_8139TOO=y
 CONFIG_PHYLIB=m
-CONFIG_MARVELL_PHY=m
+CONFIG_CICADA_PHY=m
 CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
 CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
-CONFIG_8139TOO=y
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_VITESSE_PHY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -67,9 +63,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
@@ -77,7 +70,6 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -95,3 +87,5 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 490b12af103c..c3f6c3488559 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -1,13 +1,6 @@
-CONFIG_CAVIUM_OCTEON_SOC=y
-CONFIG_CAVIUM_CN63XXP1=y
-CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=2
-CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=32
-CONFIG_HZ_100=y
-CONFIG_PREEMPT=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -17,14 +10,20 @@ CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_CAVIUM_OCTEON_SOC=y
+CONFIG_CAVIUM_CN63XXP1=y
+CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=2
+CONFIG_SMP=y
+CONFIG_NR_CPUS=32
+CONFIG_HZ_100=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -42,7 +41,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 # CONFIG_FW_LOADER is not set
@@ -52,7 +50,6 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_SLRAM=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
@@ -74,7 +71,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -84,10 +80,9 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -99,9 +94,9 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_TOSHIBA is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_MARVELL_PHY=y
-CONFIG_BROADCOM_PHY=y
 CONFIG_BCM87XX_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_MARVELL_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -158,10 +153,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_DEBUG_INFO=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_CRYPTO_CBC=y
@@ -171,4 +162,7 @@ CONFIG_CRYPTO_SHA1_OCTEON=m
 CONFIG_CRYPTO_SHA256_OCTEON=m
 CONFIG_CRYPTO_SHA512_OCTEON=m
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 030ff9c205fb..412800d5d7e0 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -1,18 +1,10 @@
-CONFIG_MACH_INGENIC=y
-CONFIG_JZ4780_CI20=y
-CONFIG_HIGHMEM=y
-# CONFIG_COMPACTION is not set
-CONFIG_CMA=y
-CONFIG_HZ_100=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_XZ=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -20,7 +12,6 @@ CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
-CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
@@ -32,8 +23,15 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_MACH_INGENIC=y
+CONFIG_JZ4780_CI20=y
+CONFIG_HIGHMEM=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPACTION is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -59,7 +57,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_DM9000=y
 CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
@@ -76,13 +73,11 @@ CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_LEGACY_PTY_COUNT=2
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=5
@@ -95,7 +90,6 @@ CONFIG_I2C_JZ4780=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_INGENIC=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_JZ4740_WDT=y
@@ -166,9 +160,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=10
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index a9066f300665..20c62841827f 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -1,9 +1,8 @@
-CONFIG_MIPS_COBALT=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
+CONFIG_MIPS_COBALT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -17,7 +16,6 @@ CONFIG_INET=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
@@ -28,11 +26,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_VIA=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_NET_TULIP=y
 CONFIG_DE2104X=y
 CONFIG_TULIP=y
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -72,10 +68,8 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
-CONFIG_CRC16=y
 CONFIG_LIBCRC32C=y
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index 0108bb9f1e37..34633b7611cb 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -1,41 +1,36 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_DB1XXX=y
-CONFIG_CMA=y
-CONFIG_CMA_DEBUG=y
-CONFIG_HZ_100=y
 CONFIG_LOCALVERSION="-db1xxx"
 CONFIG_KERNEL_XZ=y
 CONFIG_DEFAULT_HOSTNAME="db1xxx"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
-CONFIG_CGROUP_FREEZER=y
-CONFIG_CGROUP_DEVICE=y
-CONFIG_CPUSETS=y
-CONFIG_CGROUP_CPUACCT=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
-CONFIG_MEMCG_KMEM=y
+CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CFS_BANDWIDTH=y
 CONFIG_RT_GROUP_SCHED=y
-CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
-CONFIG_BLK_DEV_BSGLIB=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_DEFAULT_NOOP=y
+CONFIG_MIPS_ALCHEMY=y
+CONFIG_HZ_100=y
 CONFIG_PCI=y
-CONFIG_PCI_REALLOC_ENABLE_AUTO=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM=y
+CONFIG_FIRMWARE_MEMMAP=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_DEFAULT_NOOP=y
+CONFIG_CMA=y
+CONFIG_CMA_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
@@ -78,13 +73,6 @@ CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
 CONFIG_IPV6_PIMSM_V2=y
 CONFIG_BRIDGE=y
 CONFIG_NETLINK_DIAG=y
-CONFIG_IRDA=y
-CONFIG_IRLAN=y
-CONFIG_IRCOMM=y
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_AU1000_FIR=y
 CONFIG_BT=y
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_RFCOMM_TTY=y
@@ -116,7 +104,6 @@ CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=y
 CONFIG_PATA_HPT37X=y
 CONFIG_PATA_HPT3X2N=y
@@ -155,9 +142,9 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
 CONFIG_SND_HRTIMER=y
 CONFIG_SND_DYNAMIC_MINORS=y
+CONFIG_SND_SEQUENCER=y
 CONFIG_SND_AC97_POWER_SAVE=y
 CONFIG_SND_AC97_POWER_SAVE_DEFAULT=1
 CONFIG_SND_SOC=y
@@ -180,7 +167,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-CONFIG_MMC_CLKGATE=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_AU1X=y
 CONFIG_NEW_LEDS=y
@@ -188,12 +174,13 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_POSIX_ACL=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
 CONFIG_FANOTIFY=y
 CONFIG_FUSE_FS=y
 CONFIG_CUSE=y
@@ -211,8 +198,6 @@ CONFIG_SQUASHFS_FILE_DIRECT=y
 CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
-CONFIG_F2FS_FS=y
-CONFIG_F2FS_FS_SECURITY=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
@@ -232,7 +217,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_USER=y
 CONFIG_CRYPTO_CRYPTD=y
@@ -241,3 +225,4 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_CRC32_SLICEBY4=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
+CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index c3ac0209457c..fd82b858a8f0 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -1,11 +1,9 @@
-CONFIG_MACH_VR41XX=y
-CONFIG_CASIO_E55=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
+CONFIG_CASIO_E55=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -16,7 +14,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_LEGACY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -38,4 +35,3 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x1f0,0x3f6,40 mem=8M"
-# CONFIG_CRC32 is not set
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 499f51498ecb..8bcb61a6ec15 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -1,39 +1,33 @@
-CONFIG_MACH_LOONGSON64=y
-CONFIG_64BIT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_LOCALVERSION="-fuloong2e"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
-CONFIG_PID_NS=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MACH_LOONGSON64=y
 CONFIG_PCI=y
-CONFIG_BINFMT_MISC=y
-CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
-CONFIG_PM=y
 # CONFIG_SUSPEND is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION="/dev/sda3"
+CONFIG_OPROFILE=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -42,14 +36,11 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPGRE_BROADCAST=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
@@ -78,13 +69,11 @@ CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -120,32 +109,30 @@ CONFIG_PATA_VIA=y
 CONFIG_ATA_GENERIC=y
 CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
+CONFIG_NET_FC=y
 CONFIG_MACVLAN=m
 CONFIG_VETH=m
+CONFIG_8139TOO=y
+# CONFIG_8139TOO_PIO is not set
 CONFIG_PHYLIB=m
-CONFIG_MARVELL_PHY=m
+CONFIG_CICADA_PHY=m
 CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
 CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
-CONFIG_8139TOO=y
-# CONFIG_8139TOO_PIO is not set
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
 CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
 CONFIG_SLIP=m
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_SLIP_SMART=y
 CONFIG_SLIP_MODE_SLIP6=y
-CONFIG_NET_FC=y
 CONFIG_INPUT_FF_MEMLESS=y
 CONFIG_MOUSE_SERIAL=y
 CONFIG_SERIAL_8250=y
@@ -153,7 +140,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 CONFIG_HW_RANDOM=y
-CONFIG_RTC=y
 CONFIG_I2C=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_VIAPRO=m
@@ -167,9 +153,6 @@ CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_SEQUENCER=m
 CONFIG_SND_SEQ_DUMMY=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_VIA82XX=m
 CONFIG_HIDRAW=y
 # CONFIG_USB_HID is not set
@@ -183,7 +166,6 @@ CONFIG_USB_WUSB_CBAF=m
 CONFIG_USB_C67X00_HCD=m
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_ISP1760=m
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_UHCI_HCD=m
 CONFIG_USB_R8A66597_HCD=m
@@ -194,16 +176,13 @@ CONFIG_USB_TMC=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_ONETOUCH=y
 CONFIG_USB_STORAGE_CYPRESS_ATACB=y
+CONFIG_USB_ISP1760=m
 CONFIG_USB_SEVSEG=m
 CONFIG_USB_ISIGHTFW=m
 CONFIG_UIO=m
 CONFIG_UIO_CIF=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
-CONFIG_EXT4_FS=m
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_REISERFS_FS=m
@@ -223,33 +202,22 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_OMFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
-CONFIG_SMB_NLS_REMOTE="cp936"
 CONFIG_CIFS=m
-CONFIG_CIFS_STATS=y
 CONFIG_CIFS_STATS2=y
 CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_CIFS_DEBUG2=y
-CONFIG_CIFS_EXPERIMENTAL=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_936=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_FS=y
-CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_AUTHENC=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_PCBC=m
@@ -266,3 +234,4 @@ CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=y
 CONFIG_CRC7=m
+# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
index 99ac1fa3b35f..a3e3eb3c5a8b 100644
--- a/arch/mips/configs/gcw0_defconfig
+++ b/arch/mips/configs/gcw0_defconfig
@@ -1,14 +1,14 @@
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_EMBEDDED=y
 CONFIG_MACH_INGENIC=y
 CONFIG_JZ4770_GCW0=y
 CONFIG_HIGHMEM=y
-# CONFIG_BOUNCE is not set
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_SECCOMP is not set
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_EMBEDDED=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BOUNCE is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 684c9dcba126..7c138dab87df 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -1,10 +1,3 @@
-CONFIG_MIPS_GENERIC=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_MIPS_CPS=y
-CONFIG_CPU_HAS_MSA=y
-CONFIG_HIGHMEM=y
-CONFIG_NR_CPUS=16
-CONFIG_MIPS_O32_FP64_SUPPORT=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_IKCONFIG=y
@@ -28,7 +21,11 @@ CONFIG_USERFAULTFD=y
 CONFIG_EMBEDDED=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
-CONFIG_CC_STACKPROTECTOR_REGULAR=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_MIPS_CPS=y
+CONFIG_HIGHMEM=y
+CONFIG_NR_CPUS=16
+CONFIG_MIPS_O32_FP64_SUPPORT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_TRIM_UNUSED_KSYMS=y
@@ -43,7 +40,6 @@ CONFIG_NETFILTER=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SCSI=y
-# CONFIG_SERIO is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_MFD_SYSCON=y
@@ -79,6 +75,12 @@ CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_REDUCED=y
@@ -87,9 +89,3 @@ CONFIG_DEBUG_FS=y
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon"
-# CONFIG_XZ_DEC_X86 is not set
-# CONFIG_XZ_DEC_POWERPC is not set
-# CONFIG_XZ_DEC_IA64 is not set
-# CONFIG_XZ_DEC_ARM is not set
-# CONFIG_XZ_DEC_ARMTHUMB is not set
-# CONFIG_XZ_DEC_SPARC is not set
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 55438fc9991e..9d9af5f923c3 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -1,22 +1,21 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_GPR=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
+CONFIG_MIPS_ALCHEMY=y
+CONFIG_MIPS_GPR=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -36,7 +35,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_DSCP=m
@@ -59,13 +57,11 @@ CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -93,7 +89,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_IP_DCCP=m
 CONFIG_IP_SCTP=m
 CONFIG_TIPC=m
@@ -106,14 +101,12 @@ CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_DECNET=m
 CONFIG_LLC2=m
-CONFIG_IPX=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_WAN_ROUTER=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
@@ -173,26 +166,50 @@ CONFIG_TIFM_CORE=m
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
 CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_ISCSI_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=m
+CONFIG_NET_FC=y
+CONFIG_NETCONSOLE=m
+CONFIG_ATM_TCP=m
+CONFIG_ATM_LANAI=m
+CONFIG_ATM_ENI=m
+CONFIG_ATM_FIRESTREAM=m
+CONFIG_ATM_ZATM=m
+CONFIG_ATM_NICSTAR=m
+CONFIG_ATM_IDT77252=m
+CONFIG_ATM_AMBASSADOR=m
+CONFIG_ATM_HORIZON=m
+CONFIG_ATM_IA=m
+CONFIG_ATM_FORE200E=m
+CONFIG_ATM_HE=m
+CONFIG_ATM_HE_USE_SUNI=y
+CONFIG_MIPS_AU1X00_ENET=y
+CONFIG_CICADA_PHY=m
 CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
 CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_AU1X00_ENET=y
-CONFIG_ATH_COMMON=y
+CONFIG_VITESSE_PHY=m
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOATM=m
+CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLIP_SMART=y
+CONFIG_SLIP_MODE_SLIP6=y
 CONFIG_ATH_DEBUG=y
 CONFIG_ATH5K=y
 CONFIG_ATH5K_DEBUG=y
@@ -212,41 +229,8 @@ CONFIG_DSCC4=m
 CONFIG_DSCC4_PCISYNC=y
 CONFIG_DSCC4_PCI_RST=y
 CONFIG_DLCI=m
-CONFIG_WAN_ROUTER_DRIVERS=m
-CONFIG_CYCLADES_SYNC=m
-CONFIG_CYCLOMX_X25=y
 CONFIG_LAPBETHER=m
 CONFIG_X25_ASY=m
-CONFIG_ATM_TCP=m
-CONFIG_ATM_LANAI=m
-CONFIG_ATM_ENI=m
-CONFIG_ATM_FIRESTREAM=m
-CONFIG_ATM_ZATM=m
-CONFIG_ATM_NICSTAR=m
-CONFIG_ATM_IDT77252=m
-CONFIG_ATM_AMBASSADOR=m
-CONFIG_ATM_HORIZON=m
-CONFIG_ATM_IA=m
-CONFIG_ATM_FORE200E=m
-CONFIG_ATM_HE=m
-CONFIG_ATM_HE_USE_SUNI=y
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
-CONFIG_PPPOATM=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
-CONFIG_NET_FC=y
-CONFIG_NETCONSOLE=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -258,7 +242,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
-CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_LM83=y
 CONFIG_WATCHDOG=y
@@ -283,7 +266,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=m
 CONFIG_USB_SERIAL=y
-CONFIG_USB_EZUSB=y
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_SIERRAWIRELESS=y
 CONFIG_LEDS_GPIO=y
@@ -304,26 +286,16 @@ CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_RUBIN=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -336,3 +308,7 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 7ddfb4ef9479..ff40fbc2f439 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -1,35 +1,28 @@
-CONFIG_SGI_IP22=y
-CONFIG_ARC_CONSOLE=y
-CONFIG_CPU_R5000=y
+CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_1000=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
-CONFIG_UTS_NS=y
-CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
-CONFIG_PID_NS=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_RELAY=y
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
-# CONFIG_PCSPKR_PLATFORM is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_SGI_IP22=y
+CONFIG_ARC_CONSOLE=y
+CONFIG_CPU_R5000=y
+CONFIG_HZ_1000=y
+# CONFIG_SUSPEND is not set
+CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -62,12 +55,9 @@ CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_PIMSM_V2=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -77,7 +67,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -136,21 +125,12 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_IP_VS_FTP=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_NF_NAT_SNMP_BASIC=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -159,8 +139,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -222,23 +200,22 @@ CONFIG_SCSI_SPI_ATTRS=m
 CONFIG_ISCSI_TCP=m
 CONFIG_SGIWD93_SCSI=y
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
-CONFIG_MACVLAN=m
+CONFIG_DUMMY=m
 CONFIG_EQUALIZER=m
+CONFIG_MACVLAN=m
 CONFIG_TUN=m
 CONFIG_VETH=m
+CONFIG_SGISEEQ=y
+CONFIG_SMC91X=m
+CONFIG_MDIO_BITBANG=m
 CONFIG_PHYLIB=m
-CONFIG_MARVELL_PHY=m
+CONFIG_CICADA_PHY=m
 CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
 CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_REALTEK_PHY=m
-CONFIG_MDIO_BITBANG=m
-CONFIG_NET_ETHERNET=y
-CONFIG_SMC91X=m
-CONFIG_SGISEEQ=y
 CONFIG_HOSTAP=m
 CONFIG_INPUT_MOUSEDEV=m
 CONFIG_MOUSE_PS2=m
@@ -261,7 +238,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
 CONFIG_HIDRAW=y
-CONFIG_HID_PID=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1286=y
@@ -269,9 +245,6 @@ CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=m
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_QUOTA=y
@@ -294,18 +267,13 @@ CONFIG_MINIX_FS=m
 CONFIG_OMFS_FS=m
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
-CONFIG_RPCSEC_GSS_KRB5=m
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
 CONFIG_CIFS=m
 CONFIG_CIFS_UPCALL=y
 CONFIG_CODA_FS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -344,13 +312,8 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DLM=m
-CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_KEYS=y
-CONFIG_CRYPTO_FIPS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
@@ -358,13 +321,10 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -382,4 +342,4 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_T10DIF=m
-CONFIG_CRC32=m
+CONFIG_DEBUG_MEMORY_INIT=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 91a9c13e2c82..81c47e18131b 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -1,32 +1,28 @@
-CONFIG_SGI_IP27=y
-CONFIG_NUMA=y
-CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
-CONFIG_SMP=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_1000=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_SGI_IP27=y
+CONFIG_NUMA=y
+CONFIG_SMP=y
+CONFIG_HZ_1000=y
 CONFIG_PCI=y
-CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
-CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_PM=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -41,7 +37,6 @@ CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
@@ -95,12 +90,10 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_BLK_DEV_OSD=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
@@ -115,7 +108,6 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
@@ -160,69 +152,56 @@ CONFIG_DM_UEVENT=y
 CONFIG_IFB=m
 CONFIG_MACVLAN=m
 CONFIG_VETH=m
-CONFIG_PHYLIB=y
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_ICPLUS_PHY=m
-CONFIG_REALTEK_PHY=m
-CONFIG_NATIONAL_PHY=m
-CONFIG_STE10XP=m
-CONFIG_LSI_ET1011C_PHY=m
-CONFIG_MDIO_BITBANG=m
-CONFIG_NET_ETHERNET=y
-CONFIG_AX88796=m
-CONFIG_AX88796_93CX6=y
-CONFIG_SGI_IOC3_ETH=y
-CONFIG_SMC91X=m
-CONFIG_ETHOC=m
-CONFIG_SMSC911X=m
-CONFIG_DNET=m
-CONFIG_B44=m
-CONFIG_KS8851_MLL=m
 CONFIG_ATL2=m
-CONFIG_E1000E=m
-CONFIG_IP1000=m
-CONFIG_IGB=m
-CONFIG_IGBVF=m
-CONFIG_VIA_VELOCITY=m
-CONFIG_QLA3XXX=m
 CONFIG_ATL1E=m
 CONFIG_ATL1C=m
-CONFIG_JME=m
+CONFIG_B44=m
+CONFIG_BNX2X=m
 CONFIG_ENIC=m
+CONFIG_DNET=m
+CONFIG_BE2NET=m
+CONFIG_E1000E=m
+CONFIG_IGB=m
+CONFIG_IGBVF=m
 CONFIG_IXGBE=m
+CONFIG_JME=m
+CONFIG_MLX4_EN=m
+# CONFIG_MLX4_DEBUG is not set
+CONFIG_KS8851_MLL=m
 CONFIG_VXGE=m
+CONFIG_AX88796=m
+CONFIG_AX88796_93CX6=y
+CONFIG_ETHOC=m
+CONFIG_QLA3XXX=m
 CONFIG_NETXEN_NIC=m
+CONFIG_SFC=m
+CONFIG_SGI_IOC3_ETH=y
+CONFIG_SMC91X=m
+CONFIG_SMSC911X=m
 CONFIG_NIU=m
-CONFIG_MLX4_EN=m
-# CONFIG_MLX4_DEBUG is not set
 CONFIG_TEHUTI=m
-CONFIG_BNX2X=m
-CONFIG_SFC=m
-CONFIG_BE2NET=m
-CONFIG_LIBERTAS_THINFIRM=m
-CONFIG_ATMEL=m
-CONFIG_PCI_ATMEL=m
-CONFIG_PRISM54=m
-CONFIG_RTL8180=m
+CONFIG_VIA_VELOCITY=m
+CONFIG_PHYLIB=y
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
+CONFIG_ICPLUS_PHY=m
+CONFIG_LSI_ET1011C_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_NATIONAL_PHY=m
+CONFIG_QSEMI_PHY=m
+CONFIG_REALTEK_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_STE10XP=m
+CONFIG_VITESSE_PHY=m
 CONFIG_ADM8211=m
-CONFIG_MWL8K=m
-CONFIG_ATH_COMMON=m
 CONFIG_ATH5K=m
 CONFIG_ATH9K=m
+CONFIG_ATMEL=m
+CONFIG_PCI_ATMEL=m
 CONFIG_B43=m
 CONFIG_B43LEGACY=m
 # CONFIG_B43LEGACY_DEBUG is not set
-CONFIG_HOSTAP=m
-CONFIG_HOSTAP_FIRMWARE=y
-CONFIG_HOSTAP_FIRMWARE_NVRAM=y
-CONFIG_HOSTAP_PLX=m
-CONFIG_HOSTAP_PCI=m
 CONFIG_IPW2100=m
 CONFIG_IPW2100_MONITOR=y
 CONFIG_IPW2100_DEBUG=y
@@ -231,12 +210,14 @@ CONFIG_IPW2200_MONITOR=y
 CONFIG_IPW2200_PROMISCUOUS=y
 CONFIG_IPW2200_QOS=y
 CONFIG_IPW2200_DEBUG=y
-CONFIG_IWLWIFI=m
-CONFIG_IWLAGN=m
-CONFIG_IWL4965=y
-CONFIG_IWL5000=y
+CONFIG_IWL4965=m
 CONFIG_IWL3945=m
-CONFIG_LIBERTAS=m
+CONFIG_IWLWIFI=m
+CONFIG_HOSTAP=m
+CONFIG_HOSTAP_FIRMWARE=y
+CONFIG_HOSTAP_FIRMWARE_NVRAM=y
+CONFIG_HOSTAP_PLX=m
+CONFIG_HOSTAP_PCI=m
 CONFIG_HERMES=m
 # CONFIG_HERMES_CACHE_FW_ON_INIT is not set
 CONFIG_PLX_HERMES=m
@@ -244,13 +225,18 @@ CONFIG_TMD_HERMES=m
 CONFIG_NORTEL_HERMES=m
 CONFIG_P54_COMMON=m
 CONFIG_P54_PCI=m
+CONFIG_PRISM54=m
+CONFIG_LIBERTAS=m
+CONFIG_LIBERTAS_THINFIRM=m
+CONFIG_MWL8K=m
 CONFIG_RT2X00=m
 CONFIG_RT2400PCI=m
 CONFIG_RT2500PCI=m
 CONFIG_RT61PCI=m
 CONFIG_RT2800PCI=m
-CONFIG_WL12XX=m
+CONFIG_RTL8180=m
 CONFIG_WL1251=m
+CONFIG_WL12XX=m
 # CONFIG_INPUT is not set
 CONFIG_SERIO_LIBPS2=m
 CONFIG_SERIO_RAW=m
@@ -262,7 +248,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_ALI1535=m
@@ -285,7 +270,6 @@ CONFIG_I2C_SIMTEC=m
 CONFIG_I2C_PARPORT_LIGHT=m
 CONFIG_I2C_TAOS_EVM=m
 CONFIG_I2C_STUB=m
-CONFIG_PPS=m
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=m
 CONFIG_MFD_PCF50633=m
@@ -310,12 +294,8 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
@@ -334,17 +314,8 @@ CONFIG_SQUASHFS=m
 CONFIG_OMFS_FS=m
 CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_RPCSEC_GSS_KRB5=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_DLM=m
-CONFIG_KEYS=y
 CONFIG_SECURITYFS=y
-CONFIG_CRYPTO_FIPS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
-CONFIG_CRYPTO_CCM=m
-CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
@@ -357,7 +328,6 @@ CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -374,5 +344,4 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRYPTO_DEV_HIFN_795X=m
 CONFIG_CRC_T10DIF=m
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index d0a4c2cfacf8..0921ef38e9fb 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -1,26 +1,24 @@
-CONFIG_SGI_IP28=y
-CONFIG_ARC_CONSOLE=y
-CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
+CONFIG_SGI_IP28=y
+CONFIG_ARC_CONSOLE=y
+CONFIG_EISA=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
+# CONFIG_SUSPEND is not set
+CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_EISA=y
-CONFIG_MIPS32_COMPAT=y
-CONFIG_MIPS32_O32=y
-CONFIG_MIPS32_N32=y
-CONFIG_PM=y
-# CONFIG_SUSPEND is not set
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -43,7 +41,6 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_SGIWD93_SCSI=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
-CONFIG_NET_ETHERNET=y
 CONFIG_SGISEEQ=y
 # CONFIG_MOUSE_PS2_ALPS is not set
 # CONFIG_MOUSE_PS2_SYNAPTICS is not set
@@ -65,11 +62,8 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HW is not set
-# CONFIG_CRC32 is not set
+CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index ebff297328ae..8f6d8af2e3c0 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -1,26 +1,25 @@
-CONFIG_SGI_IP32=y
-# CONFIG_SECCOMP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_AUDIT=y
+CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
+CONFIG_SGI_IP32=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
 CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_SGI_PARTITION=y
 CONFIG_BINFMT_MISC=y
-CONFIG_MIPS32_COMPAT=y
-CONFIG_MIPS32_O32=y
-CONFIG_MIPS32_N32=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -33,7 +32,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
@@ -56,24 +54,20 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_SAS_LIBSAS=y
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 CONFIG_SCSI_AIC7XXX=y
 CONFIG_AIC7XXX_RESET_DELAY_MS=15000
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_SGI_O2MACE_ETH=y
+CONFIG_DUMMY=m
 CONFIG_NET_TULIP=y
 CONFIG_DE2104X=m
 CONFIG_TULIP=m
 CONFIG_TULIP_MMIO=y
+CONFIG_SGI_O2MACE_ETH=y
 CONFIG_INPUT_EVDEV=m
 CONFIG_SERIO_MACEPS2=y
 CONFIG_SERIO_RAW=y
@@ -87,9 +81,6 @@ CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_GBE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
@@ -100,7 +91,6 @@ CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_SYSFS is not set
 # CONFIG_RTC_INTF_PROC is not set
 CONFIG_RTC_DRV_DS1685_FAMILY=y
-CONFIG_RTC_DRV_DS1685=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -124,13 +114,10 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_SGI_PARTITION=y
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
@@ -170,7 +157,6 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_KEYS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_CBC=y
@@ -186,7 +172,6 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_TGR192=y
 CONFIG_CRYPTO_WP512=y
-CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_ANUBIS=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
@@ -200,7 +185,9 @@ CONFIG_CRYPTO_SERPENT=y
 CONFIG_CRYPTO_TEA=y
 CONFIG_CRYPTO_TWOFISH=y
 CONFIG_CRYPTO_DEFLATE=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 CONFIG_LIBCRC32C=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 9ad1c94376c8..328d4dfeb4cb 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -1,22 +1,20 @@
-CONFIG_MACH_JAZZ=y
-CONFIG_OLIVETTI_M700=y
-CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
+CONFIG_MACH_JAZZ=y
+CONFIG_OLIVETTI_M700=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -25,8 +23,6 @@ CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -41,7 +37,6 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -83,20 +78,12 @@ CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_NF_NAT_SNMP_BASIC=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -105,7 +92,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -140,7 +126,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE=m
 CONFIG_DECNET=m
 CONFIG_NET_SCHED=y
@@ -230,24 +215,20 @@ CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
+CONFIG_DUMMY=m
 CONFIG_EQUALIZER=m
 CONFIG_TUN=m
+CONFIG_MIPS_JAZZ_SONIC=y
+CONFIG_NE2000=m
 CONFIG_PHYLIB=m
-CONFIG_MARVELL_PHY=m
+CONFIG_CICADA_PHY=m
 CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
 CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_JAZZ_SONIC=y
-CONFIG_NET_ISA=y
-CONFIG_NE2000=m
-CONFIG_NET_PCI=y
+CONFIG_VITESSE_PHY=m
 CONFIG_PLIP=m
 CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_PARKBD=m
@@ -297,25 +278,11 @@ CONFIG_ROMFS_FS=m
 CONFIG_SYSV_FS=m
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_RPCSEC_GSS_KRB5=m
-CONFIG_RPCSEC_GSS_SPKM3=m
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
-CONFIG_NCP_FS=m
-CONFIG_NCPFS_PACKET_SIGNING=y
-CONFIG_NCPFS_IOCTL_LOCKING=y
-CONFIG_NCPFS_STRONG=y
-CONFIG_NCPFS_NFS_NS=y
-CONFIG_NCPFS_OS2_NS=y
-CONFIG_NCPFS_SMALLDOS=y
-CONFIG_NCPFS_NLS=y
-CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -354,21 +321,14 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DLM=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index af12281a5c33..24b96faf9b4e 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -1,13 +1,10 @@
-CONFIG_MACH_TX39XX=y
-CONFIG_TOSHIBA_JMR3927=y
-# CONFIG_SECCOMP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
+CONFIG_MACH_TX39XX=y
+CONFIG_TOSHIBA_JMR3927=y
+# CONFIG_SECCOMP is not set
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -27,16 +24,14 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_TC35815=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_TXX9_STDSERIAL=y
-# CONFIG_UNIX98_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
diff --git a/arch/mips/configs/lasat_defconfig b/arch/mips/configs/lasat_defconfig
index 947a35c7c46c..c66ca3785655 100644
--- a/arch/mips/configs/lasat_defconfig
+++ b/arch/mips/configs/lasat_defconfig
@@ -1,25 +1,23 @@
-CONFIG_LASAT=y
-CONFIG_PICVUE=y
-CONFIG_PICVUE_PROC=y
-CONFIG_DS1603=y
-CONFIG_LASAT_SYSCTL=y
-CONFIG_HZ_1000=y
-# CONFIG_SECCOMP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_KALLSYMS is not set
-# CONFIG_HOTPLUG is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
 # CONFIG_TIMERFD is not set
 # CONFIG_EVENTFD is not set
+# CONFIG_KALLSYMS is not set
 CONFIG_SLAB=y
+CONFIG_LASAT=y
+CONFIG_PICVUE=y
+CONFIG_PICVUE_PROC=y
+CONFIG_DS1603=y
+CONFIG_LASAT_SYSCTL=y
+CONFIG_HZ_1000=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -39,10 +37,7 @@ CONFIG_PATA_CMD64X=y
 CONFIG_ATA_GENERIC=y
 CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_RAW=y
@@ -55,7 +50,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 02be95c1b712..300127b0f5b7 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -1,48 +1,33 @@
-CONFIG_MACH_LOONGSON64=y
-CONFIG_LEMOTE_MACH2F=y
-CONFIG_CS5536_MFGPT=y
-CONFIG_64BIT=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
-CONFIG_KEXEC=y
-# CONFIG_SECCOMP is not set
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
+CONFIG_MACH_LOONGSON64=y
+CONFIG_LEMOTE_MACH2F=y
+CONFIG_KEXEC=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
+CONFIG_HIBERNATION=y
+CONFIG_PM_STD_PARTITION="/dev/hda3"
 CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_IOSCHED_DEADLINE=m
-CONFIG_PCI=y
 CONFIG_BINFMT_MISC=m
-CONFIG_MIPS32_COMPAT=y
-CONFIG_MIPS32_O32=y
-CONFIG_MIPS32_N32=y
-CONFIG_PM=y
-CONFIG_HIBERNATION=y
-CONFIG_PM_STD_PARTITION="/dev/hda3"
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_STAT=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
-CONFIG_CPU_FREQ_GOV_POWERSAVE=m
-CONFIG_CPU_FREQ_GOV_USERSPACE=m
-CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
-CONFIG_LOONGSON2_CPUFREQ=m
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -55,11 +40,9 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
@@ -76,7 +59,6 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
-CONFIG_IPX=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
@@ -91,8 +73,6 @@ CONFIG_BT_HCIBTUSB=m
 CONFIG_BT_HCIBFUSB=m
 CONFIG_BT_HCIVHCI=m
 CONFIG_CFG80211=m
-CONFIG_LIB80211=m
-CONFIG_LIB80211_DEBUG=y
 CONFIG_MAC80211=m
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=m
@@ -130,18 +110,14 @@ CONFIG_DM_DELAY=m
 CONFIG_DM_UEVENT=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_NETCONSOLE=m
 CONFIG_TUN=m
 CONFIG_VETH=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_R8169=y
-CONFIG_R8169_VLAN=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_CDC_EEM=m
-CONFIG_NETCONSOLE=m
-CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_INPUT_POLLDEV=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_MOUSE_PS2_ALPS is not set
@@ -149,6 +125,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_MOUSE_PS2_TRACKPOINT is not set
 CONFIG_MOUSE_APPLETOUCH=m
 # CONFIG_SERIO_SERPORT is not set
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=m
 # CONFIG_SERIAL_8250_PCI is not set
@@ -156,50 +133,10 @@ CONFIG_SERIAL_8250_NR_UARTS=16
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_FOURPORT=y
-CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_HW_RANDOM=y
-CONFIG_RTC=y
 CONFIG_GPIO_LOONGSON=y
 CONFIG_THERMAL=y
 CONFIG_MEDIA_SUPPORT=m
-CONFIG_VIDEO_DEV=m
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_VIDEO_VIVI=m
-CONFIG_USB_VIDEO_CLASS=m
-CONFIG_USB_M5602=m
-CONFIG_USB_STV06XX=m
-CONFIG_USB_GSPCA_CONEX=m
-CONFIG_USB_GSPCA_ETOMS=m
-CONFIG_USB_GSPCA_FINEPIX=m
-CONFIG_USB_GSPCA_MARS=m
-CONFIG_USB_GSPCA_MR97310A=m
-CONFIG_USB_GSPCA_OV519=m
-CONFIG_USB_GSPCA_OV534=m
-CONFIG_USB_GSPCA_PAC207=m
-CONFIG_USB_GSPCA_PAC7311=m
-CONFIG_USB_GSPCA_SN9C20X=m
-CONFIG_USB_GSPCA_SONIXB=m
-CONFIG_USB_GSPCA_SONIXJ=m
-CONFIG_USB_GSPCA_SPCA500=m
-CONFIG_USB_GSPCA_SPCA501=m
-CONFIG_USB_GSPCA_SPCA505=m
-CONFIG_USB_GSPCA_SPCA506=m
-CONFIG_USB_GSPCA_SPCA508=m
-CONFIG_USB_GSPCA_SPCA561=m
-CONFIG_USB_GSPCA_SQ905=m
-CONFIG_USB_GSPCA_SQ905C=m
-CONFIG_USB_GSPCA_STK014=m
-CONFIG_USB_GSPCA_SUNPLUS=m
-CONFIG_USB_GSPCA_T613=m
-CONFIG_USB_GSPCA_TV8532=m
-CONFIG_USB_GSPCA_VC032X=m
-CONFIG_USB_GSPCA_ZC3XX=m
-CONFIG_USB_ET61X251=m
-CONFIG_USB_SN9C102=m
-CONFIG_USB_ZR364XX=m
-CONFIG_USB_STKWEBCAM=m
-CONFIG_USB_S2255=m
-# CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
@@ -214,27 +151,14 @@ CONFIG_BACKLIGHT_GENERIC=m
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_6x11=y
-CONFIG_FONT_7x14=y
-CONFIG_FONT_PEARL_8x8=y
-CONFIG_FONT_ACORN_8x8=y
-CONFIG_FONT_MINI_4x6=y
-CONFIG_FONT_SUN8x16=y
-CONFIG_FONT_SUN12x22=y
-CONFIG_FONT_10x18=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=m
 CONFIG_SND=m
+CONFIG_SND_HRTIMER=m
 CONFIG_SND_SEQUENCER=m
 CONFIG_SND_SEQ_DUMMY=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
-CONFIG_SND_HRTIMER=m
 CONFIG_SND_DUMMY=m
 CONFIG_SND_VIRMIDI=m
 CONFIG_SND_SERIAL_U16550=m
@@ -247,7 +171,6 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_USB_CAIAQ=m
 CONFIG_SND_USB_CAIAQ_INPUT=y
 CONFIG_HIDRAW=y
-CONFIG_USB_HIDDEV=y
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
 CONFIG_HID_BELKIN=m
@@ -283,6 +206,7 @@ CONFIG_THRUSTMASTER_FF=y
 CONFIG_HID_WACOM=m
 CONFIG_HID_ZEROPLUS=m
 CONFIG_ZEROPLUS_FF=y
+CONFIG_USB_HIDDEV=y
 CONFIG_USB=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_OTG_WHITELIST=y
@@ -292,8 +216,6 @@ CONFIG_USB_EHCI_ROOT_HUB_TT=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_UHCI_HCD=m
-CONFIG_USB_WHCI_HCD=m
-CONFIG_USB_HWA_HCD=m
 CONFIG_USB_ACM=m
 CONFIG_USB_PRINTER=m
 CONFIG_USB_WDM=m
@@ -309,18 +231,13 @@ CONFIG_USB_STORAGE_ALAUDA=m
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_M66592=y
 CONFIG_MMC=m
 CONFIG_LEDS_CLASS=y
 CONFIG_STAGING=y
-# CONFIG_STAGING_EXCLUDE_BUILD is not set
-CONFIG_FB_SM7XX=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
 CONFIG_REISERFS_FS=m
 CONFIG_REISERFS_PROC_INFO=y
 CONFIG_REISERFS_FS_XATTR=y
@@ -349,7 +266,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_EMBEDDED=y
 CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V4=y
@@ -393,32 +309,19 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
-CONFIG_FRAME_WARN=1024
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_FS=y
-CONFIG_KEYS=y
-CONFIG_CRYPTO_FIPS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_CCM=m
-CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
-CONFIG_CRYPTO_HMAC=m
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -435,4 +338,16 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_T10DIF=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_6x11=y
+CONFIG_FONT_7x14=y
+CONFIG_FONT_PEARL_8x8=y
+CONFIG_FONT_ACORN_8x8=y
+CONFIG_FONT_MINI_4x6=y
+CONFIG_FONT_10x18=y
+CONFIG_FONT_SUN8x16=y
+CONFIG_FONT_SUN12x22=y
+CONFIG_PRINTK_TIME=y
+CONFIG_FRAME_WARN=1024
+CONFIG_STRIP_ASM_SYMS=y
diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index 914c867887bd..b064d68a5424 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -1,10 +1,8 @@
-CONFIG_MACH_LOONGSON32=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_XZ=y
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -15,13 +13,15 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_MACH_LOONGSON32=y
+# CONFIG_SECCOMP is not set
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -43,7 +43,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_LOONGSON1=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=m
@@ -67,7 +66,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_LEGACY_PTY_COUNT=8
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
@@ -116,8 +114,9 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
 CONFIG_DYNAMIC_DEBUG=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
@@ -125,5 +124,3 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 # CONFIG_EARLY_PRINTK is not set
-# CONFIG_CRYPTO_ECHAINIV is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
index 68e42eff908e..5d76559b56cd 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -1,11 +1,8 @@
-CONFIG_MACH_LOONGSON32=y
-CONFIG_LOONGSON1_LS1C=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_XZ=y
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -16,13 +13,16 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_MACH_LOONGSON32=y
+CONFIG_LOONGSON1_LS1C=y
+# CONFIG_SECCOMP is not set
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -44,7 +44,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_LOONGSON1=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=m
@@ -68,7 +67,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_LEGACY_PTY_COUNT=8
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
@@ -117,8 +115,9 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
 CONFIG_DYNAMIC_DEBUG=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
@@ -126,5 +125,3 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 # CONFIG_EARLY_PRINTK is not set
-# CONFIG_CRYPTO_ECHAINIV is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 324dfee23dfb..1322adb705c8 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -1,15 +1,3 @@
-CONFIG_MACH_LOONGSON64=y
-CONFIG_SWIOTLB=y
-CONFIG_LOONGSON_MACH3X=y
-CONFIG_CPU_LOONGSON3=y
-CONFIG_64BIT=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_KSM=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=4
-CONFIG_HZ_256=y
-CONFIG_PREEMPT=y
-CONFIG_KEXEC=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
@@ -17,6 +5,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
@@ -24,40 +13,38 @@ CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CPUSETS=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
+CONFIG_CPUSETS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
+CONFIG_MACH_LOONGSON64=y
+CONFIG_LOONGSON_MACH3X=y
+CONFIG_SMP=y
+CONFIG_HZ_256=y
+CONFIG_KEXEC=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_HOTPLUG_PCI_PCIE=y
+# CONFIG_PCIEAER is not set
+CONFIG_PCIEASPM_PERFORMANCE=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_IOSCHED_DEADLINE=m
 CONFIG_CFQ_GROUP_IOSCHED=y
-CONFIG_PCI=y
-CONFIG_HT_PCI=y
-CONFIG_PCIEPORTBUS=y
-CONFIG_HOTPLUG_PCI_PCIE=y
-# CONFIG_PCIEAER is not set
-CONFIG_PCIEASPM_PERFORMANCE=y
-CONFIG_HOTPLUG_PCI=y
-CONFIG_HOTPLUG_PCI_SHPC=m
 CONFIG_BINFMT_MISC=m
-CONFIG_MIPS32_COMPAT=y
-CONFIG_MIPS32_O32=y
-CONFIG_MIPS32_N32=y
-CONFIG_PM=y
+CONFIG_KSM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -123,7 +110,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_SCH=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
@@ -164,7 +150,6 @@ CONFIG_TUN=m
 # CONFIG_NET_VENDOR_AMD is not set
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
@@ -173,14 +158,13 @@ CONFIG_TUN=m
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
+# CONFIG_NET_VENDOR_I825XX is not set
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IXGB=y
 CONFIG_IXGBE=y
-# CONFIG_NET_VENDOR_I825XX is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
 # CONFIG_NET_VENDOR_MICREL is not set
@@ -188,12 +172,11 @@ CONFIG_IXGBE=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_RDC is not set
 CONFIG_8139CP=m
 CONFIG_8139TOO=m
 CONFIG_R8169=y
-# CONFIG_NET_VENDOR_RDC is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -215,7 +198,6 @@ CONFIG_PPPOE=m
 CONFIG_PPPOL2TP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-CONFIG_ATH_CARDS=m
 CONFIG_ATH9K=m
 CONFIG_HOSTAP=m
 CONFIG_INPUT_POLLDEV=m
@@ -296,9 +278,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS4_FS=y
@@ -327,13 +306,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_936=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
-CONFIG_FRAME_WARN=1024
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_MAGIC_SYSRQ=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_FTRACE is not set
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
@@ -345,7 +317,6 @@ CONFIG_DEFAULT_SECURITY_DAC=y
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -357,3 +328,10 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
+CONFIG_PRINTK_TIME=y
+CONFIG_FRAME_WARN=1024
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 81058295d35f..0ee5e677662e 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -1,9 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_NR_CPUS=8
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -13,11 +7,17 @@ CONFIG_RELAY=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_NR_CPUS=8
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -58,8 +58,6 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -124,7 +122,6 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -139,7 +136,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -291,26 +287,26 @@ CONFIG_CHELSIO_T3=m
 CONFIG_AX88796=m
 CONFIG_NETXEN_NIC=m
 CONFIG_TC35815=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
 CONFIG_BROADCOM_PHY=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
 CONFIG_ICPLUS_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_REALTEK_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
 CONFIG_ATMEL=m
 CONFIG_PCI_ATMEL=m
-CONFIG_PRISM54=m
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
 CONFIG_HOSTAP=m
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_IPW2100=m
-CONFIG_IPW2100_MONITOR=y
+CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_MOUSE_PS2_ELANTECH=y
@@ -331,7 +327,6 @@ CONFIG_UIO=m
 CONFIG_UIO_CIF=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-CONFIG_EXT4_FS=y
 CONFIG_REISERFS_FS=m
 CONFIG_REISERFS_PROC_INFO=y
 CONFIG_REISERFS_FS_XATTR=y
@@ -411,14 +406,12 @@ CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -432,4 +425,3 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 5c10cddc39d3..041bffac043b 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -1,9 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_NR_CPUS=8
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -14,11 +8,21 @@ CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_NR_CPUS=8
+CONFIG_HZ_100=y
+CONFIG_PCI=y
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM=m
+CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS=y
+CONFIG_VHOST_NET=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -59,8 +63,6 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -125,7 +127,6 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -140,7 +141,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -174,7 +174,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_SCTP=m
 CONFIG_BRIDGE=m
@@ -219,8 +218,6 @@ CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_CLS_IND=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
-CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -254,7 +251,6 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -297,32 +293,31 @@ CONFIG_IFB=m
 CONFIG_MACVLAN=m
 CONFIG_TUN=m
 CONFIG_VETH=m
-CONFIG_VHOST_NET=m
 CONFIG_PCNET32=y
 CONFIG_CHELSIO_T3=m
 CONFIG_AX88796=m
 CONFIG_NETXEN_NIC=m
 CONFIG_TC35815=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
 CONFIG_BROADCOM_PHY=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
 CONFIG_ICPLUS_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_REALTEK_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
 CONFIG_ATMEL=m
 CONFIG_PCI_ATMEL=m
-CONFIG_PRISM54=m
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
 CONFIG_HOSTAP=m
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_IPW2100=m
-CONFIG_IPW2100_MONITOR=y
+CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
@@ -422,16 +417,12 @@ CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
-CONFIG_RCU_CPU_STALL_TIMEOUT=60
-CONFIG_ENABLE_DEFAULT_TRACERS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -445,9 +436,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC16=m
-CONFIG_VIRTUALIZATION=y
-CONFIG_KVM=m
-CONFIG_KVM_MIPS_DYN_TRANS=y
-CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_ENABLE_DEFAULT_TRACERS=y
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index bb694f5065f1..511065e62182 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -1,10 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_KVM_GUEST=y
-CONFIG_PAGE_SIZE_16KB=y
-# CONFIG_MIPS_MT_SMP is not set
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -15,11 +8,18 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_KVM_GUEST=y
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_MIPS_MT_SMP is not set
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,8 +60,6 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -126,7 +124,6 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -141,7 +138,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -175,7 +171,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_SCTP=m
 CONFIG_BRIDGE=m
@@ -220,8 +215,6 @@ CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_CLS_IND=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
-CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -256,7 +249,6 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -305,26 +297,26 @@ CONFIG_CHELSIO_T3=m
 CONFIG_AX88796=m
 CONFIG_NETXEN_NIC=m
 CONFIG_TC35815=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
 CONFIG_BROADCOM_PHY=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
 CONFIG_ICPLUS_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_REALTEK_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
 CONFIG_ATMEL=m
 CONFIG_PCI_ATMEL=m
-CONFIG_PRISM54=m
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
 CONFIG_HOSTAP=m
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_IPW2100=m
-CONFIG_IPW2100_MONITOR=y
+CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
@@ -426,14 +418,12 @@ CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -447,5 +437,3 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC16=m
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 5b5306b80576..299088043164 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -1,8 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R6=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -13,12 +8,17 @@ CONFIG_LOG_BUF_SHIFT=15
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R6=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -100,7 +100,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -110,10 +109,9 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -157,7 +155,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
@@ -175,12 +172,9 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -191,5 +185,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 85543599448f..2b4b3a24f637 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -1,9 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_MIPS_VPE_LOADER=y
-CONFIG_MIPS_VPE_APSP_API=y
-CONFIG_HZ_100=y
 CONFIG_LOCALVERSION="aprp"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -14,12 +8,19 @@ CONFIG_LOG_BUF_SHIFT=15
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_MIPS_VPE_LOADER=y
+CONFIG_MIPS_VPE_APSP_API=y
+CONFIG_NR_CPUS=2
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -101,7 +102,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -111,10 +111,9 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -157,7 +156,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
@@ -175,12 +173,9 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -191,5 +186,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 067bb84ac916..425ddfd7cd78 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -1,11 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_SCHED_SMT=y
-CONFIG_MIPS_CPS=y
-CONFIG_NR_CPUS=8
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -16,12 +8,20 @@ CONFIG_LOG_BUF_SHIFT=15
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_SCHED_SMT=y
+CONFIG_MIPS_CPS=y
+CONFIG_NR_CPUS=8
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -101,7 +101,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -111,10 +110,9 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -159,9 +157,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
@@ -179,12 +174,9 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -195,5 +187,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index dfc78c3172a3..8beaa7ba1e52 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -1,12 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_CPU_MIPS32_3_5_FEATURES=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_SCHED_SMT=y
-CONFIG_MIPS_CPS=y
-CONFIG_NR_CPUS=8
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -17,12 +8,21 @@ CONFIG_LOG_BUF_SHIFT=15
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_CPU_MIPS32_3_5_FEATURES=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_SCHED_SMT=y
+CONFIG_MIPS_CPS=y
+CONFIG_NR_CPUS=8
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -104,7 +104,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -114,10 +113,9 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -161,7 +159,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
@@ -179,12 +176,9 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -195,5 +189,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 50a2288c69f8..6e8b95ceb54a 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -1,7 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_HZ_100=y
 CONFIG_LOCALVERSION="up"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -13,12 +9,17 @@ CONFIG_LOG_BUF_SHIFT=15
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_NR_CPUS=2
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -100,7 +101,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -110,10 +110,9 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -156,7 +155,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
@@ -174,12 +172,9 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -190,5 +185,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 99a19cf5f9ba..6c026db96ff9 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -1,10 +1,3 @@
-CONFIG_MIPS_MALTA=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_CPU_MIPS32_R5_FEATURES=y
-CONFIG_CPU_MIPS32_R5_XPA=y
-CONFIG_PAGE_SIZE_16KB=y
-CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -16,11 +9,19 @@ CONFIG_RELAY=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_CPU_MIPS32_R5_FEATURES=y
+CONFIG_CPU_MIPS32_R5_XPA=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_NR_CPUS=2
+CONFIG_HZ_100=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -61,8 +62,6 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -125,7 +124,6 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -140,7 +138,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -300,26 +297,26 @@ CONFIG_CHELSIO_T3=m
 CONFIG_AX88796=m
 CONFIG_NETXEN_NIC=m
 CONFIG_TC35815=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
 CONFIG_BROADCOM_PHY=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
 CONFIG_ICPLUS_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_REALTEK_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
 CONFIG_ATMEL=m
 CONFIG_PCI_ATMEL=m
-CONFIG_PRISM54=m
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
 CONFIG_HOSTAP=m
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_IPW2100=m
-CONFIG_IPW2100_MONITOR=y
+CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_MOUSE_PS2_ELANTECH=y
@@ -425,7 +422,6 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -439,5 +435,3 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC16=m
diff --git a/arch/mips/configs/markeins_defconfig b/arch/mips/configs/markeins_defconfig
index 43ce6576ab1c..ae93a94f8c71 100644
--- a/arch/mips/configs/markeins_defconfig
+++ b/arch/mips/configs/markeins_defconfig
@@ -1,21 +1,19 @@
-CONFIG_NEC_MARKEINS=y
-CONFIG_HZ_1000=y
-CONFIG_PREEMPT=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
+CONFIG_NEC_MARKEINS=y
+CONFIG_HZ_1000=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-CONFIG_PCI=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -82,20 +80,12 @@ CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_NF_NAT_SNMP_BASIC=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -104,7 +94,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -134,23 +123,18 @@ CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_SCAN_ASYNC=y
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 CONFIG_SCSI_AIC94XX=m
 # CONFIG_AIC94XX_DEBUG is not set
 CONFIG_NETDEVICES=y
 CONFIG_TUN=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_NET_PCI=y
+CONFIG_CHELSIO_T3=m
 CONFIG_NATSEMI=y
 CONFIG_QLA3XXX=m
-CONFIG_CHELSIO_T3=m
 CONFIG_NETXEN_NIC=m
 CONFIG_PPP=m
+CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -182,20 +166,15 @@ CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_SMB_FS=m
 CONFIG_NLS_DEFAULT=""
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
-CONFIG_DLM=m
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200 mem=192m ip=bootp root=/dev/nfs rw"
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
@@ -203,3 +182,5 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_FCRYPT=m
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,115200 mem=192m ip=bootp root=/dev/nfs rw"
diff --git a/arch/mips/configs/mips_paravirt_defconfig b/arch/mips/configs/mips_paravirt_defconfig
index accf0db1dc6f..8dc5d96a08de 100644
--- a/arch/mips/configs/mips_paravirt_defconfig
+++ b/arch/mips/configs/mips_paravirt_defconfig
@@ -1,11 +1,5 @@
-CONFIG_MIPS_PARAVIRT=y
-CONFIG_CPU_MIPS64_R2=y
-CONFIG_64BIT=y
-CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_SMP=y
-CONFIG_HZ_1000=y
-CONFIG_PREEMPT=y
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
@@ -15,13 +9,18 @@ CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_MIPS_PARAVIRT=y
+CONFIG_CPU_MIPS64_R2=y
+CONFIG_64BIT=y
+CONFIG_SMP=y
+CONFIG_HZ_1000=y
 CONFIG_PCI=y
-CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -39,7 +38,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-CONFIG_IPV6=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -58,9 +56,9 @@ CONFIG_VIRTIO_NET=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PHYLIB=y
-CONFIG_MARVELL_PHY=y
-CONFIG_BROADCOM_PHY=y
 CONFIG_BCM87XX_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_MARVELL_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -90,13 +88,12 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_DES=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 3486b034f726..d4e038802510 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -1,11 +1,10 @@
-CONFIG_MACH_VR41XX=y
-CONFIG_VICTOR_MPC30X=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
+CONFIG_VICTOR_MPC30X=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
@@ -31,7 +30,6 @@ CONFIG_ATA=y
 CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_USB_PEGASUS=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -53,4 +51,3 @@ CONFIG_CONFIGFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="mem=32M console=ttyVR0,19200 ide0=0x170,0x376,73"
-# CONFIG_CRC32 is not set
diff --git a/arch/mips/configs/msp71xx_defconfig b/arch/mips/configs/msp71xx_defconfig
index 3c8c16b10732..0fdc03fda12e 100644
--- a/arch/mips/configs/msp71xx_defconfig
+++ b/arch/mips/configs/msp71xx_defconfig
@@ -1,21 +1,21 @@
-CONFIG_PMC_MSP=y
-CONFIG_PMC_MSP7120_GW=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_PREEMPT=y
 CONFIG_LOCALVERSION="-pmc"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 # CONFIG_SHMEM is not set
 CONFIG_SLAB=y
+CONFIG_PMC_MSP=y
+CONFIG_PMC_MSP7120_GW=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_NR_CPUS=2
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
@@ -47,18 +47,15 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
 CONFIG_PPP=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -80,6 +77,3 @@ CONFIG_SQUASHFS_EMBEDDED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_CRYPTO_NULL=y
-CONFIG_CRYPTO_AES=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index c3d0d0a6e044..16bef819fe98 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -1,31 +1,45 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_MTX1=y
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_AUDIT=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_MIPS_ALCHEMY=y
+CONFIG_MIPS_MTX1=y
 CONFIG_PCI=y
 CONFIG_PCCARD=m
 CONFIG_YENTA=m
 CONFIG_PD6729=m
 CONFIG_I82092=m
+CONFIG_OPROFILE=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ACORN_PARTITION=y
+CONFIG_ACORN_PARTITION_ICS=y
+CONFIG_ACORN_PARTITION_RISCIX=y
+CONFIG_OSF_PARTITION=y
+CONFIG_AMIGA_PARTITION=y
+CONFIG_ATARI_PARTITION=y
+CONFIG_MAC_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_UNIXWARE_DISKLABEL=y
+CONFIG_LDM_PARTITION=y
+CONFIG_SGI_PARTITION=y
+CONFIG_ULTRIX_PARTITION=y
+CONFIG_SUN_PARTITION=y
+CONFIG_KARMA_PARTITION=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -38,8 +52,6 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -57,7 +69,6 @@ CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_DSCP=m
@@ -81,13 +92,11 @@ CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -128,7 +137,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_IP_DCCP=m
 CONFIG_IP_SCTP=m
 CONFIG_TIPC=m
@@ -141,14 +149,12 @@ CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_DECNET=m
 CONFIG_LLC2=m
-CONFIG_IPX=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_WAN_ROUTER=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
@@ -191,30 +197,6 @@ CONFIG_BPQETHER=m
 CONFIG_BAYCOM_SER_FDX=m
 CONFIG_BAYCOM_SER_HDX=m
 CONFIG_YAM=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_IRTTY_SIR=m
-CONFIG_DONGLE=y
-CONFIG_ESI_DONGLE=m
-CONFIG_ACTISYS_DONGLE=m
-CONFIG_TEKRAM_DONGLE=m
-CONFIG_LITELINK_DONGLE=m
-CONFIG_MA600_DONGLE=m
-CONFIG_GIRBIL_DONGLE=m
-CONFIG_MCP2120_DONGLE=m
-CONFIG_OLD_BELKIN_DONGLE=m
-CONFIG_ACT200L_DONGLE=m
-CONFIG_USB_IRDA=m
-CONFIG_SIGMATEL_FIR=m
-CONFIG_TOSHIBA_FIR=m
-CONFIG_VLSI_FIR=m
-CONFIG_MCS_FIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
@@ -231,7 +213,6 @@ CONFIG_BT_HCIBFUSB=m
 CONFIG_BT_HCIDTL1=m
 CONFIG_BT_HCIBT3C=m
 CONFIG_BT_HCIBLUECARD=m
-CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
@@ -248,18 +229,18 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
 CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_ISCSI_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
+CONFIG_DUMMY=m
 CONFIG_EQUALIZER=m
+CONFIG_NET_FC=y
+CONFIG_NETCONSOLE=m
 CONFIG_TUN=m
 CONFIG_ARCNET=m
 CONFIG_ARCNET_1201=m
@@ -271,20 +252,33 @@ CONFIG_ARCNET_COM90xxIO=m
 CONFIG_ARCNET_RIM_I=m
 CONFIG_ARCNET_COM20020=m
 CONFIG_ARCNET_COM20020_PCI=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_HAPPYMEAL=m
-CONFIG_SUNGEM=m
-CONFIG_CASSINI=m
-CONFIG_NET_VENDOR_3COM=y
+CONFIG_ARCNET_COM20020_CS=m
+CONFIG_ATM_TCP=m
+CONFIG_ATM_LANAI=m
+CONFIG_ATM_ENI=m
+CONFIG_ATM_FIRESTREAM=m
+CONFIG_ATM_ZATM=m
+CONFIG_ATM_NICSTAR=m
+CONFIG_ATM_IDT77252=m
+CONFIG_ATM_AMBASSADOR=m
+CONFIG_ATM_HORIZON=m
+CONFIG_ATM_IA=m
+CONFIG_ATM_FORE200E=m
+CONFIG_ATM_HE=m
+CONFIG_ATM_HE_USE_SUNI=y
+CONFIG_PCMCIA_3C574=m
+CONFIG_PCMCIA_3C589=m
 CONFIG_VORTEX=m
 CONFIG_TYPHOON=m
+CONFIG_ADAPTEC_STARFIRE=m
+CONFIG_ACENIC=m
+CONFIG_AMD8111_ETH=m
+CONFIG_PCNET32=m
+CONFIG_PCMCIA_NMCLAN=m
+CONFIG_B44=m
+CONFIG_BNX2=m
+CONFIG_TIGON3=m
+CONFIG_CHELSIO_T1=m
 CONFIG_NET_TULIP=y
 CONFIG_DE2104X=m
 CONFIG_TULIP=m
@@ -293,49 +287,69 @@ CONFIG_WINBOND_840=m
 CONFIG_DM9102=m
 CONFIG_ULI526X=m
 CONFIG_PCMCIA_XIRCOM=m
+CONFIG_DL2K=m
+CONFIG_SUNDANCE=m
+CONFIG_PCMCIA_FMVJ18X=m
 CONFIG_HP100=m
-CONFIG_NET_PCI=y
-CONFIG_PCNET32=m
-CONFIG_AMD8111_ETH=m
-CONFIG_ADAPTEC_STARFIRE=m
-CONFIG_B44=m
-CONFIG_FORCEDETH=m
 CONFIG_E100=m
+CONFIG_E1000=m
+CONFIG_IXGB=m
+CONFIG_SKGE=m
+CONFIG_SKY2=m
+CONFIG_MYRI10GE=m
 CONFIG_FEALNX=m
 CONFIG_NATSEMI=m
+CONFIG_NS83820=m
+CONFIG_S2IO=m
+CONFIG_PCMCIA_AXNET=m
 CONFIG_NE2K_PCI=m
+CONFIG_PCMCIA_PCNET=m
+CONFIG_FORCEDETH=m
+CONFIG_HAMACHI=m
+CONFIG_YELLOWFIN=m
+CONFIG_QLA3XXX=m
 CONFIG_8139CP=m
 CONFIG_8139TOO=m
 # CONFIG_8139TOO_PIO is not set
 CONFIG_8139TOO_8129=y
+CONFIG_R8169=m
 CONFIG_SIS900=m
+CONFIG_SIS190=m
+CONFIG_PCMCIA_SMC91C92=m
 CONFIG_EPIC100=m
-CONFIG_SUNDANCE=m
+CONFIG_HAPPYMEAL=m
+CONFIG_SUNGEM=m
+CONFIG_CASSINI=m
 CONFIG_TLAN=m
 CONFIG_VIA_RHINE=m
-CONFIG_ACENIC=m
-CONFIG_DL2K=m
-CONFIG_E1000=m
-CONFIG_NS83820=m
-CONFIG_HAMACHI=m
-CONFIG_YELLOWFIN=m
-CONFIG_R8169=m
-CONFIG_R8169_VLAN=y
-CONFIG_SIS190=m
-CONFIG_SKGE=m
-CONFIG_SKY2=m
 CONFIG_VIA_VELOCITY=m
-CONFIG_TIGON3=m
-CONFIG_BNX2=m
-CONFIG_QLA3XXX=m
-CONFIG_CHELSIO_T1=m
-CONFIG_IXGB=m
-CONFIG_S2IO=m
-CONFIG_MYRI10GE=m
-CONFIG_IBMOL=m
-CONFIG_IBMLS=m
-CONFIG_TMSPCI=m
-CONFIG_ABYSS=m
+CONFIG_PCMCIA_XIRC2PS=m
+CONFIG_FDDI=y
+CONFIG_DEFXX=m
+CONFIG_SKFP=m
+CONFIG_HIPPI=y
+CONFIG_ROADRUNNER=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOATM=m
+CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLIP_SMART=y
+CONFIG_SLIP_MODE_SLIP6=y
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
@@ -349,16 +363,6 @@ CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
 CONFIG_USB_EPSON2888=y
 CONFIG_USB_SIERRA_NET=m
-CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_3C589=m
-CONFIG_PCMCIA_3C574=m
-CONFIG_PCMCIA_FMVJ18X=m
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PCMCIA_NMCLAN=m
-CONFIG_PCMCIA_SMC91C92=m
-CONFIG_PCMCIA_XIRC2PS=m
-CONFIG_PCMCIA_AXNET=m
-CONFIG_ARCNET_COM20020_CS=m
 CONFIG_WAN=y
 CONFIG_LANMEDIA=m
 CONFIG_HDLC=m
@@ -375,46 +379,8 @@ CONFIG_DSCC4=m
 CONFIG_DSCC4_PCISYNC=y
 CONFIG_DSCC4_PCI_RST=y
 CONFIG_DLCI=m
-CONFIG_WAN_ROUTER_DRIVERS=m
-CONFIG_CYCLADES_SYNC=m
-CONFIG_CYCLOMX_X25=y
 CONFIG_LAPBETHER=m
 CONFIG_X25_ASY=m
-CONFIG_ATM_TCP=m
-CONFIG_ATM_LANAI=m
-CONFIG_ATM_ENI=m
-CONFIG_ATM_FIRESTREAM=m
-CONFIG_ATM_ZATM=m
-CONFIG_ATM_NICSTAR=m
-CONFIG_ATM_IDT77252=m
-CONFIG_ATM_AMBASSADOR=m
-CONFIG_ATM_HORIZON=m
-CONFIG_ATM_IA=m
-CONFIG_ATM_FORE200E=m
-CONFIG_ATM_HE=m
-CONFIG_ATM_HE_USE_SUNI=y
-CONFIG_FDDI=y
-CONFIG_DEFXX=m
-CONFIG_SKFP=m
-CONFIG_HIPPI=y
-CONFIG_ROADRUNNER=m
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
-CONFIG_PPPOATM=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
-CONFIG_NET_FC=y
-CONFIG_NETCONSOLE=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -440,7 +406,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_GPIO=m
-CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_ADM1021=m
 CONFIG_SENSORS_ADM1025=m
@@ -453,6 +418,7 @@ CONFIG_SENSORS_F71805F=m
 CONFIG_SENSORS_GL518SM=m
 CONFIG_SENSORS_GL520SM=m
 CONFIG_SENSORS_IT87=m
+CONFIG_SENSORS_MAX1619=m
 CONFIG_SENSORS_LM63=m
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM77=m
@@ -463,7 +429,6 @@ CONFIG_SENSORS_LM85=m
 CONFIG_SENSORS_LM87=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_LM92=m
-CONFIG_SENSORS_MAX1619=m
 CONFIG_SENSORS_PC87360=m
 CONFIG_SENSORS_PCF8591=m
 CONFIG_SENSORS_SIS5595=m
@@ -491,23 +456,17 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_SEQUENCER=m
 CONFIG_SND_SEQ_DUMMY=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_DUMMY=m
 CONFIG_SND_VIRMIDI=m
 CONFIG_SND_MTPAV=m
 CONFIG_SND_SERIAL_U16550=m
 CONFIG_SND_MPU401=m
 CONFIG_SND_AD1889=m
-CONFIG_SND_ALS300=m
-CONFIG_SND_ALI5451=m
 CONFIG_SND_ATIIXP=m
 CONFIG_SND_ATIIXP_MODEM=m
 CONFIG_SND_AU8810=m
 CONFIG_SND_AU8820=m
 CONFIG_SND_AU8830=m
-CONFIG_SND_AZT3328=m
 CONFIG_SND_BT87X=m
 CONFIG_SND_CA0106=m
 CONFIG_SND_CMIPCI=m
@@ -525,22 +484,15 @@ CONFIG_SND_ECHO3G=m
 CONFIG_SND_INDIGO=m
 CONFIG_SND_INDIGOIO=m
 CONFIG_SND_INDIGODJ=m
-CONFIG_SND_EMU10K1=m
-CONFIG_SND_EMU10K1X=m
 CONFIG_SND_ENS1370=m
 CONFIG_SND_ENS1371=m
-CONFIG_SND_ES1938=m
-CONFIG_SND_ES1968=m
 CONFIG_SND_FM801=m
-CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_HDSP=m
 CONFIG_SND_HDSPM=m
-CONFIG_SND_ICE1712=m
 CONFIG_SND_ICE1724=m
 CONFIG_SND_INTEL8X0=m
 CONFIG_SND_INTEL8X0M=m
 CONFIG_SND_KORG1212=m
-CONFIG_SND_MAESTRO3=m
 CONFIG_SND_MIXART=m
 CONFIG_SND_NM256=m
 CONFIG_SND_PCXHR=m
@@ -548,16 +500,14 @@ CONFIG_SND_RIPTIDE=m
 CONFIG_SND_RME32=m
 CONFIG_SND_RME96=m
 CONFIG_SND_RME9652=m
-CONFIG_SND_SONICVIBES=m
-CONFIG_SND_TRIDENT=m
 CONFIG_SND_VIA82XX=m
 CONFIG_SND_VIA82XX_MODEM=m
 CONFIG_SND_VX222=m
 CONFIG_SND_YMFPCI=m
+CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_VXPOCKET=m
 CONFIG_SND_PDAUDIOCF=m
-CONFIG_SOUND_PRIME=m
 CONFIG_USB_HIDDEV=y
 CONFIG_USB_KBD=m
 CONFIG_USB_MOUSE=m
@@ -566,7 +516,7 @@ CONFIG_USB_MON=m
 CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=m
-CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD_PLATFORM=m
 CONFIG_USB_UHCI_HCD=m
 CONFIG_USB_U132_HCD=m
 CONFIG_USB_SL811_HCD=m
@@ -595,7 +545,6 @@ CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
 CONFIG_USB_SERIAL_CYPRESS_M8=m
 CONFIG_USB_SERIAL_EMPEG=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
-CONFIG_USB_SERIAL_FUNSOFT=m
 CONFIG_USB_SERIAL_VISOR=m
 CONFIG_USB_SERIAL_IPAQ=m
 CONFIG_USB_SERIAL_IR=m
@@ -612,7 +561,6 @@ CONFIG_USB_SERIAL_MOS7720=m
 CONFIG_USB_SERIAL_MOS7840=m
 CONFIG_USB_SERIAL_NAVMAN=m
 CONFIG_USB_SERIAL_PL2303=m
-CONFIG_USB_SERIAL_HP4X=m
 CONFIG_USB_SERIAL_SAFE=m
 CONFIG_USB_SERIAL_SIERRAWIRELESS=m
 CONFIG_USB_SERIAL_TI=m
@@ -641,7 +589,6 @@ CONFIG_USB_CXACRU=m
 CONFIG_USB_UEAGLEATM=m
 CONFIG_USB_XUSBATM=m
 CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_NET2280=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
@@ -677,7 +624,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_QUOTA=y
@@ -692,48 +638,18 @@ CONFIG_VFAT_FS=m
 CONFIG_NTFS_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
-CONFIG_CONFIGFS_FS=m
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_XATTR=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_CRAMFS=y
 CONFIG_SQUASHFS=y
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFSD=m
 CONFIG_NFSD_V4=y
-CONFIG_RPCSEC_GSS_SPKM3=m
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
-CONFIG_NCP_FS=m
-CONFIG_NCPFS_PACKET_SIGNING=y
-CONFIG_NCPFS_IOCTL_LOCKING=y
-CONFIG_NCPFS_STRONG=y
-CONFIG_NCPFS_NFS_NS=y
-CONFIG_NCPFS_OS2_NS=y
-CONFIG_NCPFS_NLS=y
-CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ACORN_PARTITION=y
-CONFIG_ACORN_PARTITION_ICS=y
-CONFIG_ACORN_PARTITION_RISCIX=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_ATARI_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_LDM_PARTITION=y
-CONFIG_SGI_PARTITION=y
-CONFIG_ULTRIX_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=m
@@ -774,18 +690,11 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -795,3 +704,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index e8e1dd8e0e99..72a211d2d556 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -1,32 +1,35 @@
-CONFIG_NLM_XLP_BOARD=y
-CONFIG_64BIT=y
-CONFIG_PAGE_SIZE_16KB=y
-# CONFIG_HW_PERF_EVENTS is not set
-CONFIG_KSM=y
-CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
-CONFIG_SMP=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
-CONFIG_AUDIT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+CONFIG_NLM_XLP_BOARD=y
+CONFIG_64BIT=y
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_HW_PERF_EVENTS is not set
+CONFIG_SMP=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PCI_STUB=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
+CONFIG_PM=y
+CONFIG_PM_DEBUG=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
@@ -49,19 +52,11 @@ CONFIG_SGI_PARTITION=y
 CONFIG_ULTRIX_PARTITION=y
 CONFIG_SUN_PARTITION=y
 CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_SYSV68_PARTITION=y
-CONFIG_PCI=y
-CONFIG_PCI_DEBUG=y
-CONFIG_PCI_REALLOC_ENABLE_AUTO=y
-CONFIG_PCI_STUB=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=y
-CONFIG_MIPS32_COMPAT=y
-CONFIG_MIPS32_O32=y
-CONFIG_MIPS32_N32=y
-CONFIG_PM=y
-CONFIG_PM_DEBUG=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -93,7 +88,6 @@ CONFIG_TCP_CONG_VENO=m
 CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -104,12 +98,10 @@ CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_NETLABEL=y
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -120,7 +112,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -180,18 +171,12 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_IP_VS_FTP=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -201,8 +186,6 @@ CONFIG_IP_NF_SECURITY=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -238,7 +221,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_DCCP=m
 CONFIG_RDS=m
@@ -254,14 +236,12 @@ CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_DECNET=m
 CONFIG_LLC2=m
-CONFIG_IPX=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_WAN_ROUTER=m
 CONFIG_PHONET=m
 CONFIG_IEEE802154=m
 CONFIG_NET_SCHED=y
@@ -324,7 +304,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_CDROM_PKTCDVD=y
@@ -335,7 +314,6 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_SCH=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -343,7 +321,6 @@ CONFIG_SCSI_SPI_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
 CONFIG_SCSI_SRP_ATTRS=m
 CONFIG_ISCSI_TCP=m
-CONFIG_LIBFCOE=m
 CONFIG_SCSI_DEBUG=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
@@ -368,10 +345,9 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
 # CONFIG_NET_VENDOR_HP is not set
-CONFIG_E1000E=y
 # CONFIG_NET_VENDOR_I825XX is not set
+CONFIG_E1000E=y
 CONFIG_SKY2=y
 # CONFIG_NET_VENDOR_MELLANOX is not set
 # CONFIG_NET_VENDOR_MICREL is not set
@@ -379,10 +355,9 @@ CONFIG_SKY2=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
@@ -394,7 +369,6 @@ CONFIG_SKY2=y
 # CONFIG_NET_VENDOR_TOSHIBA is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
 # CONFIG_INPUT_KEYBOARD is not set
@@ -403,12 +377,9 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
-# CONFIG_DEVKMEM is not set
-CONFIG_STALDRV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=48
@@ -430,7 +401,6 @@ CONFIG_THERMAL=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_UIO=y
-CONFIG_UIO_PDRV=m
 CONFIG_UIO_PDRV_GENIRQ=m
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
@@ -440,9 +410,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_GFS2_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
@@ -487,7 +454,7 @@ CONFIG_UFS_FS=m
 CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFS_FSCACHE=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
@@ -498,14 +465,6 @@ CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_CIFS_DFS_UPCALL=y
-CONFIG_NCP_FS=m
-CONFIG_NCPFS_PACKET_SIGNING=y
-CONFIG_NCPFS_IOCTL_LOCKING=y
-CONFIG_NCPFS_STRONG=y
-CONFIG_NCPFS_NFS_NS=y
-CONFIG_NCPFS_OS2_NS=y
-CONFIG_NCPFS_NLS=y
-CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
 CONFIG_NLS=y
@@ -547,19 +506,6 @@ CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
-CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_FRAME_WARN=1024
-CONFIG_UNUSED_SYMBOLS=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_SCHED_TRACER=y
-CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_KGDB=y
 CONFIG_SECURITY=y
 CONFIG_LSM_MMAP_MIN_ADDR=0
 CONFIG_SECURITY_SELINUX=y
@@ -568,10 +514,8 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_SMACK=y
 CONFIG_SECURITY_TOMOYO=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
@@ -585,8 +529,6 @@ CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -602,5 +544,15 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_CCITT=m
 CONFIG_CRC7=m
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_SCHEDSTATS=y
+CONFIG_SCHED_TRACER=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_KGDB=y
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index c4477a4d40c1..4ecb157e56d4 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -1,47 +1,60 @@
-CONFIG_NLM_XLR_BOARD=y
-CONFIG_HIGHMEM=y
-CONFIG_KSM=y
-CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
-CONFIG_SMP=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_KEXEC=y
-CONFIG_CROSS_COMPILE=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
-CONFIG_AUDIT=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
-CONFIG_INITRAMFS_COMPRESSION_GZIP=y
 CONFIG_EXPERT=y
-CONFIG_KALLSYMS_ALL=y
 # CONFIG_ELF_CORE is not set
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_PERF_EVENTS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+CONFIG_NLM_XLR_BOARD=y
+CONFIG_HIGHMEM=y
+CONFIG_SMP=y
+CONFIG_KEXEC=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PM=y
+CONFIG_PM_DEBUG=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_BLK_DEV_INTEGRITY=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCI_DEBUG=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ACORN_PARTITION=y
+CONFIG_ACORN_PARTITION_ICS=y
+CONFIG_ACORN_PARTITION_RISCIX=y
+CONFIG_OSF_PARTITION=y
+CONFIG_AMIGA_PARTITION=y
+CONFIG_ATARI_PARTITION=y
+CONFIG_MAC_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_UNIXWARE_DISKLABEL=y
+CONFIG_LDM_PARTITION=y
+CONFIG_SGI_PARTITION=y
+CONFIG_ULTRIX_PARTITION=y
+CONFIG_SUN_PARTITION=y
+CONFIG_KARMA_PARTITION=y
+CONFIG_SYSV68_PARTITION=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
-CONFIG_PM_DEBUG=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -73,7 +86,6 @@ CONFIG_TCP_CONG_VENO=m
 CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -84,12 +96,10 @@ CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_NETLABEL=y
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
@@ -100,7 +110,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -160,19 +169,12 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_IP_VS_FTP=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -182,8 +184,6 @@ CONFIG_IP_NF_SECURITY=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -219,7 +219,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_DCCP=m
 CONFIG_RDS=m
@@ -235,14 +234,12 @@ CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_DECNET=m
 CONFIG_LLC2=m
-CONFIG_IPX=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_WAN_ROUTER=m
 CONFIG_PHONET=m
 CONFIG_IEEE802154=m
 CONFIG_NET_SCHED=y
@@ -295,7 +292,6 @@ CONFIG_CONNECTOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_CDROM_PKTCDVD=y
@@ -307,7 +303,6 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_SCH=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -315,7 +310,6 @@ CONFIG_SCSI_SPI_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
 CONFIG_SCSI_SRP_ATTRS=m
 CONFIG_ISCSI_TCP=m
-CONFIG_LIBFCOE=m
 CONFIG_SCSI_DEBUG=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
@@ -327,7 +321,6 @@ CONFIG_SCSI_OSD_ULD=m
 CONFIG_NETDEVICES=y
 CONFIG_E1000E=y
 CONFIG_SKY2=y
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
 # CONFIG_INPUT_KEYBOARD is not set
@@ -336,12 +329,9 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
-# CONFIG_DEVKMEM is not set
-CONFIG_STALDRV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=48
@@ -354,13 +344,12 @@ CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_RAW_DRIVER=m
 CONFIG_I2C=y
 CONFIG_I2C_XLR=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1374=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1374=y
 CONFIG_UIO=y
-CONFIG_UIO_PDRV=m
 CONFIG_UIO_PDRV_GENIRQ=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
@@ -369,11 +358,7 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
 CONFIG_GFS2_FS=m
-CONFIG_GFS2_FS_LOCKING_DLM=y
 CONFIG_OCFS2_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
@@ -420,9 +405,8 @@ CONFIG_SYSV_FS=m
 CONFIG_UFS_FS=m
 CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFS_FSCACHE=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
@@ -433,35 +417,8 @@ CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_CIFS_DFS_UPCALL=y
-CONFIG_NCP_FS=m
-CONFIG_NCPFS_PACKET_SIGNING=y
-CONFIG_NCPFS_IOCTL_LOCKING=y
-CONFIG_NCPFS_STRONG=y
-CONFIG_NCPFS_NFS_NS=y
-CONFIG_NCPFS_OS2_NS=y
-CONFIG_NCPFS_NLS=y
-CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ACORN_PARTITION=y
-CONFIG_ACORN_PARTITION_ICS=y
-CONFIG_ACORN_PARTITION_RISCIX=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_ATARI_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_LDM_PARTITION=y
-CONFIG_SGI_PARTITION=y
-CONFIG_ULTRIX_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
-CONFIG_SYSV68_PARTITION=y
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=m
@@ -501,20 +458,7 @@ CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
-CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_UNUSED_SYMBOLS=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_SCHED_TRACER=y
-CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_KGDB=y
 CONFIG_SECURITY=y
-CONFIG_SECURITY_NETWORK=y
 CONFIG_LSM_MMAP_MIN_ADDR=0
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
@@ -522,10 +466,8 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_SMACK=y
 CONFIG_SECURITY_TOMOYO=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
@@ -539,8 +481,6 @@ CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -556,5 +496,14 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_CCITT=m
 CONFIG_CRC7=m
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_SCHEDSTATS=y
+CONFIG_SCHED_TRACER=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_KGDB=y
diff --git a/arch/mips/configs/omega2p_defconfig b/arch/mips/configs/omega2p_defconfig
index e2731c3cc7e7..0649b8f06b7c 100644
--- a/arch/mips/configs/omega2p_defconfig
+++ b/arch/mips/configs/omega2p_defconfig
@@ -1,17 +1,9 @@
-CONFIG_RALINK=y
-CONFIG_SOC_MT7620=y
-CONFIG_DTB_OMEGA2P=y
-CONFIG_CPU_MIPS32_R2=y
-# CONFIG_COMPACTION is not set
-CONFIG_HZ_100=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
-CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -30,8 +22,16 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_RALINK=y
+CONFIG_SOC_MT7620=y
+CONFIG_DTB_OMEGA2P=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_SUSPEND is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -113,6 +113,10 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRC16=y
+CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_STRIP_ASM_SYMS=y
@@ -123,7 +127,3 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
-CONFIG_CRC16=y
-CONFIG_XZ_DEC=y
diff --git a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic32mzda_defconfig
index 41190c2036e6..63fe2da1b37f 100644
--- a/arch/mips/configs/pic32mzda_defconfig
+++ b/arch/mips/configs/pic32mzda_defconfig
@@ -1,11 +1,7 @@
-CONFIG_MACH_PIC32=y
-CONFIG_DTB_PIC32_MZDA_SK=y
-CONFIG_HZ_100=y
-CONFIG_PREEMPT_VOLUNTARY=y
-# CONFIG_SECCOMP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -14,6 +10,11 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MACH_PIC32=y
+CONFIG_DTB_PIC32_MZDA_SK=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+# CONFIG_SUSPEND is not set
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -23,7 +24,6 @@ CONFIG_BLK_DEV_BSGLIB=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_SGI_PARTITION=y
 CONFIG_BINFMT_MISC=m
-# CONFIG_SUSPEND is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_ALLOW_DEV_COREDUMP is not set
diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index b22a3cf149b6..2f08d071ada6 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -1,23 +1,16 @@
-CONFIG_MACH_PISTACHIO=y
-CONFIG_MIPS_MT_SMP=y
-CONFIG_MIPS_CPS=y
-# CONFIG_COMPACTION is not set
-CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
-CONFIG_ZSMALLOC=y
-CONFIG_NR_CPUS=4
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_DEFAULT_HOSTNAME="localhost"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_IKCONFIG=m
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
-CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CFS_BANDWIDTH=y
+CONFIG_CGROUP_FREEZER=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
@@ -29,14 +22,20 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
+CONFIG_MACH_PISTACHIO=y
+CONFIG_MIPS_CPS=y
+CONFIG_NR_CPUS=4
 CONFIG_PM_DEBUG=y
 CONFIG_PM_ADVANCED_DEBUG=y
 CONFIG_CPU_IDLE=y
 # CONFIG_MIPS_CPS_CPUIDLE is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_COMPACTION is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
+CONFIG_ZSMALLOC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -66,7 +65,6 @@ CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_HTCP is not set
 CONFIG_TCP_CONG_LP=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_XFRM_MODE_TRANSPORT=m
@@ -89,13 +87,11 @@ CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
 CONFIG_NETFILTER_XT_MATCH_DSCP=y
 CONFIG_NETFILTER_XT_MATCH_POLICY=y
 CONFIG_NETFILTER_XT_MATCH_STATE=y
-CONFIG_NF_CONNTRACK_IPV4=y
 CONFIG_NF_NAT_IPV4=m
 CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_REJECT=y
 CONFIG_IP_NF_MANGLE=y
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_NAT_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_IPV6HEADER=m
@@ -167,15 +163,14 @@ CONFIG_USB_NET_SMSC95XX=m
 CONFIG_USB_NET_MCS7830=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
-CONFIG_LIBERTAS_THINFIRM=m
-CONFIG_USB_NET_RNDIS_WLAN=m
-CONFIG_MAC80211_HWSIM=m
 CONFIG_HOSTAP=m
 CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
+CONFIG_LIBERTAS_THINFIRM=m
 CONFIG_RT2X00=m
 CONFIG_RT2800USB=m
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_MAC80211_HWSIM=m
+CONFIG_USB_NET_RNDIS_WLAN=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -183,7 +178,6 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -204,13 +198,10 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_CORE=y
 CONFIG_IMGPDC_WDT=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
-CONFIG_MEDIA_SUPPORT=y
 CONFIG_RC_CORE=y
-# CONFIG_RC_DECODERS is not set
 CONFIG_RC_DEVICES=y
 CONFIG_IR_IMG=y
 CONFIG_IR_IMG_NEC=y
@@ -220,8 +211,7 @@ CONFIG_IR_IMG_SHARP=y
 CONFIG_IR_IMG_SANYO=y
 CONFIG_IR_IMG_RC5=y
 CONFIG_IR_IMG_RC6=y
-# CONFIG_DVB_TUNER_DIB0070 is not set
-# CONFIG_DVB_TUNER_DIB0090 is not set
+CONFIG_MEDIA_SUPPORT=y
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
@@ -229,10 +219,10 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_SEQ_DUMMY=m
 CONFIG_SND_HRTIMER=m
 CONFIG_SND_DYNAMIC_MINORS=y
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
 # CONFIG_SND_SPI is not set
 CONFIG_SND_USB_AUDIO=m
 CONFIG_USB=y
@@ -300,27 +290,9 @@ CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_CREDENTIALS=y
-CONFIG_FUNCTION_TRACER=y
-CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_LKDTM=y
-CONFIG_TEST_UDELAY=m
-CONFIG_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_YAMA=y
-CONFIG_DEFAULT_SECURITY_DAC=y
 CONFIG_CRYPTO_AUTHENC=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA1=y
@@ -328,9 +300,19 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=m
 CONFIG_CRC7=m
-CONFIG_LIBCRC32C=m
 # CONFIG_XZ_DEC_X86 is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_SCHEDSTATS=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_CREDENTIALS=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_LKDTM=y
+CONFIG_TEST_UDELAY=m
diff --git a/arch/mips/configs/pnx8335_stb225_defconfig b/arch/mips/configs/pnx8335_stb225_defconfig
index e73cdb08fc6e..aa0b169800e0 100644
--- a/arch/mips/configs/pnx8335_stb225_defconfig
+++ b/arch/mips/configs/pnx8335_stb225_defconfig
@@ -1,23 +1,21 @@
-CONFIG_NXP_STB225=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_128=y
-CONFIG_PREEMPT_VOLUNTARY=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
+CONFIG_NXP_STB225=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_HZ_128=y
+# CONFIG_SECCOMP is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -42,17 +40,14 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_EVBUG=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_VT_CONSOLE is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PNX8XXX=y
 CONFIG_SERIAL_PNX8XXX_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -61,12 +56,9 @@ CONFIG_FB=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
+CONFIG_SND_SEQUENCER=m
 CONFIG_EXT2_FS=m
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=m
@@ -75,7 +67,6 @@ CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index d8b7211a7b0f..7671fe6a8042 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -1,11 +1,7 @@
-CONFIG_MACH_INGENIC=y
-# CONFIG_COMPACTION is not set
-# CONFIG_CROSS_MEMORY_ATTACH is not set
-CONFIG_HZ_100=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS_ALL=y
@@ -13,6 +9,9 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MACH_INGENIC=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -20,6 +19,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -49,7 +49,6 @@ CONFIG_MTD_NAND_JZ4740=y
 CONFIG_MTD_UBI=y
 CONFIG_NETDEVICES=y
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -58,7 +57,6 @@ CONFIG_KEYBOARD_MATRIX=y
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=2
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_DMA is not set
@@ -109,7 +107,6 @@ CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_ETH=y
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_JZ4740=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_JZ4740=y
@@ -119,8 +116,6 @@ CONFIG_PWM=y
 CONFIG_PWM_JZ4740=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -171,6 +166,8 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
+CONFIG_FONTS=y
+CONFIG_FONT_SUN8x16=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_STRIP_ASM_SYMS=y
@@ -181,7 +178,3 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_FTRACE is not set
 CONFIG_KGDB=y
-CONFIG_RUNTIME_DEBUG=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_FONTS=y
-CONFIG_FONT_SUN8x16=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 6fa56c6e53f5..7befe05fd813 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -1,29 +1,30 @@
-CONFIG_MIKROTIK_RB532=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_TINY_RCU=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_ELF_CORE is not set
+# CONFIG_KALLSYMS is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_PCI_QUIRKS is not set
 CONFIG_SLAB=y
+CONFIG_MIKROTIK_RB532=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
+# CONFIG_PCI_QUIRKS is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_MAC_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -33,7 +34,6 @@ CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
@@ -70,13 +70,9 @@ CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_STATE=y
 CONFIG_NETFILTER_XT_MATCH_U32=m
-CONFIG_NF_CONNTRACK_IPV4=y
 CONFIG_IP_NF_IPTABLES=y
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_REJECT=y
-CONFIG_NF_NAT=y
-CONFIG_IP_NF_TARGET_MASQUERADE=y
 CONFIG_IP_NF_MANGLE=y
 CONFIG_IP_NF_RAW=m
 CONFIG_BRIDGE=y
@@ -122,31 +118,27 @@ CONFIG_ATA=y
 CONFIG_PATA_RB532=y
 CONFIG_NETDEVICES=y
 CONFIG_IFB=m
-CONFIG_NET_ETHERNET=y
 CONFIG_KORINA=y
-CONFIG_NET_PCI=y
 CONFIG_VIA_RHINE=y
-CONFIG_ATMEL=m
 CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MULTILINK=y
 CONFIG_PPPOE=m
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_PPP_ASYNC=m
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_RB532_BUTTON=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_HW_RANDOM=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
@@ -171,13 +163,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_CRYPTO=y
 CONFIG_CRYPTO_TEST=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC16=m
-CONFIG_LIBCRC32C=m
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index fb195e29e449..50a2c9ad583f 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -1,27 +1,24 @@
-CONFIG_MACH_TX49XX=y
-CONFIG_TOSHIBA_RBTX4927=y
-CONFIG_TOSHIBA_RBTX4938=y
-CONFIG_TOSHIBA_RBTX4939=y
-CONFIG_TOSHIBA_RBTX4938_MPLEX_KEEP=y
+CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-# CONFIG_SECCOMP is not set
-CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
-# CONFIG_PCSPKR_PLATFORM is not set
 # CONFIG_EPOLL is not set
 CONFIG_SLAB=y
+CONFIG_MACH_TX49XX=y
+CONFIG_TOSHIBA_RBTX4927=y
+CONFIG_TOSHIBA_RBTX4938=y
+CONFIG_TOSHIBA_RBTX4939=y
+CONFIG_TOSHIBA_RBTX4938_MPLEX_KEEP=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -52,10 +49,8 @@ CONFIG_IDE=y
 CONFIG_BLK_DEV_IDE_TX4938=y
 CONFIG_BLK_DEV_IDE_TX4939=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_SMC91X=y
 CONFIG_NE2000=y
-CONFIG_NET_PCI=y
+CONFIG_SMC91X=y
 CONFIG_TC35815=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
@@ -99,7 +94,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_JFFS2_FS=m
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 5f71aa598b06..0f4b09f8a0ee 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -1,24 +1,23 @@
-CONFIG_SNI_RM=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_ARC_CONSOLE=y
-CONFIG_HZ_1000=y
-CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
+CONFIG_SNI_RM=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_ARC_CONSOLE=y
+CONFIG_HZ_1000=y
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-CONFIG_PCI=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -27,8 +26,6 @@ CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -48,7 +45,6 @@ CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -92,20 +88,12 @@ CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_NF_NAT_SNMP_BASIC=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -114,7 +102,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -149,7 +136,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE=m
 CONFIG_DECNET=m
 CONFIG_NET_SCHED=y
@@ -222,7 +208,6 @@ CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_FC_ATTRS=y
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_AIC94XX=m
 # CONFIG_AIC94XX_DEBUG is not set
@@ -247,34 +232,30 @@ CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
+CONFIG_DUMMY=m
 CONFIG_EQUALIZER=m
 CONFIG_TUN=m
-CONFIG_PHYLIB=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_ISA=y
-CONFIG_NE2000=m
-CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
-CONFIG_VIA_VELOCITY=m
-CONFIG_QLA3XXX=m
 CONFIG_CHELSIO_T3=m
+CONFIG_NE2000=m
+CONFIG_QLA3XXX=m
 CONFIG_NETXEN_NIC=m
+CONFIG_VIA_VELOCITY=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
+CONFIG_PLIP=m
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_PLIP=m
 CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_PARKBD=m
 CONFIG_SERIO_RAW=m
@@ -329,7 +310,6 @@ CONFIG_USB_SERIAL_KLSI=m
 CONFIG_USB_SERIAL_KOBIL_SCT=m
 CONFIG_USB_SERIAL_MCT_U232=m
 CONFIG_USB_SERIAL_PL2303=m
-CONFIG_USB_SERIAL_HP4X=m
 CONFIG_USB_SERIAL_SAFE=m
 CONFIG_USB_SERIAL_SAFE_PADDED=y
 CONFIG_USB_SERIAL_CYBERJACK=m
@@ -377,25 +357,11 @@ CONFIG_ROMFS_FS=m
 CONFIG_SYSV_FS=m
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_RPCSEC_GSS_KRB5=m
-CONFIG_RPCSEC_GSS_SPKM3=m
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
-CONFIG_NCP_FS=m
-CONFIG_NCPFS_PACKET_SIGNING=y
-CONFIG_NCPFS_IOCTL_LOCKING=y
-CONFIG_NCPFS_STRONG=y
-CONFIG_NCPFS_NFS_NS=y
-CONFIG_NCPFS_OS2_NS=y
-CONFIG_NCPFS_SMALLDOS=y
-CONFIG_NCPFS_NLS=y
-CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -434,21 +400,14 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DLM=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index dbe6a4639d05..0392e38010e6 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -1,32 +1,29 @@
-CONFIG_RALINK=y
-CONFIG_DTB_RT305X_EVAL=y
-CONFIG_CPU_MIPS32_R2=y
-# CONFIG_COMPACTION is not set
-# CONFIG_CROSS_MEMORY_ATTACH is not set
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
-CONFIG_INITRAMFS_ROOT_UID=1000
-CONFIG_INITRAMFS_ROOT_GID=1000
 # CONFIG_RD_GZIP is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_KALLSYMS_ALL=y
 # CONFIG_AIO is not set
+CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_RALINK=y
+CONFIG_DTB_RT305X_EVAL=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_COREDUMP is not set
-# CONFIG_SUSPEND is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -38,7 +35,6 @@ CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
@@ -63,8 +59,6 @@ CONFIG_NETFILTER_XT_MATCH_LIMIT=m
 CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NF_CONNTRACK_IPV4=m
-# CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
@@ -100,14 +94,12 @@ CONFIG_PPP_ASYNC=m
 CONFIG_ISDN=y
 CONFIG_INPUT=m
 CONFIG_INPUT_POLLDEV=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
@@ -142,17 +134,7 @@ CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
 # CONFIG_SQUASHFS_ZLIB is not set
 CONFIG_SQUASHFS_XZ=y
-CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CRYPTO_MANAGER=m
 CONFIG_CRYPTO_ARC4=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_ITU_T=m
 CONFIG_CRC32_SARWATE=y
 # CONFIG_XZ_DEC_X86 is not set
@@ -161,4 +143,11 @@ CONFIG_CRC32_SARWATE=y
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
-CONFIG_AVERAGE=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 1edd8430ad61..ad8981666ee4 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -1,30 +1,29 @@
-CONFIG_SIBYTE_SWARM=y
-CONFIG_CPU_SB1_PASS_2_2=y
-CONFIG_64BIT=y
-CONFIG_SMP=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_1000=y
 CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
+CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_SIBYTE_SWARM=y
+CONFIG_CPU_SB1_PASS_2_2=y
+CONFIG_64BIT=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_HZ_1000=y
+CONFIG_PCI=y
+CONFIG_MIPS32_O32=y
+CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PCI=y
-CONFIG_MIPS32_COMPAT=y
-CONFIG_MIPS32_O32=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -43,8 +42,6 @@ CONFIG_TCP_MD5SIG=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
-CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_FW_LOADER=m
@@ -60,10 +57,8 @@ CONFIG_BLK_DEV_IDETAPE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_NETDEVICES=y
 CONFIG_MACVLAN=m
-CONFIG_BROADCOM_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
 CONFIG_SB1250_MAC=y
+CONFIG_BROADCOM_PHY=y
 # CONFIG_INPUT is not set
 CONFIG_SERIO_RAW=m
 # CONFIG_VT is not set
@@ -81,15 +76,9 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_DLM=m
-CONFIG_KEYS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_AUTHENC=m
-CONFIG_CRYPTO_CCM=m
-CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
@@ -98,7 +87,6 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
index 4041597e3170..f0a11a72307e 100644
--- a/arch/mips/configs/tb0219_defconfig
+++ b/arch/mips/configs/tb0219_defconfig
@@ -1,12 +1,9 @@
-CONFIG_MACH_VR41XX=y
-CONFIG_TANBAC_TB0219=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
+CONFIG_TANBAC_TB0219=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -25,7 +22,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
@@ -33,33 +29,26 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_FW_LOADER=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_XIP=y
 CONFIG_NETDEVICES=y
-CONFIG_PHYLIB=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
+CONFIG_R8169=y
 CONFIG_VIA_RHINE=y
 CONFIG_VIA_RHINE_MMIO=y
-CONFIG_R8169=y
 CONFIG_VIA_VELOCITY=y
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_VR41XX=y
 CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
@@ -82,7 +71,6 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=m
 CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 565f0441c50d..025e45656359 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -1,18 +1,14 @@
-CONFIG_MACH_VR41XX=y
-CONFIG_TANBAC_TB0226=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
+CONFIG_TANBAC_TB0226=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -34,28 +30,21 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_XIP=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_SAS_LIBSAS=m
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_E100=y
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_VR41XX=y
 CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
@@ -77,10 +66,8 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=m
 CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=32M console=ttyVR0,115200"
-CONFIG_CRC32=m
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index a702be602fb9..68490248e3f1 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -1,12 +1,8 @@
-CONFIG_MACH_VR41XX=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -25,7 +21,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
@@ -36,36 +31,23 @@ CONFIG_TCP_CONG_CUBIC=m
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_FW_LOADER=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_XIP=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_PATA_SIL680=y
-CONFIG_IEEE1394=m
-CONFIG_IEEE1394_OHCI1394=m
-CONFIG_IEEE1394_SBP2=m
-CONFIG_IEEE1394_ETH1394=m
-CONFIG_IEEE1394_RAWIO=m
-CONFIG_IEEE1394_VIDEO1394=m
-CONFIG_IEEE1394_DV1394=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
+CONFIG_R8169=y
 CONFIG_VIA_RHINE=y
 CONFIG_VIA_RHINE_MMIO=y
-CONFIG_R8169=y
 CONFIG_VIA_VELOCITY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_VR41XX=y
 CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
@@ -76,9 +58,6 @@ CONFIG_FB=y
 CONFIG_FB_SM501=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_EHCI_HCD=m
@@ -97,9 +76,11 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=m
 CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/vocore2_defconfig b/arch/mips/configs/vocore2_defconfig
index 9121e4194a63..ded3dce911d5 100644
--- a/arch/mips/configs/vocore2_defconfig
+++ b/arch/mips/configs/vocore2_defconfig
@@ -1,17 +1,9 @@
-CONFIG_RALINK=y
-CONFIG_SOC_MT7620=y
-CONFIG_DTB_VOCORE2=y
-CONFIG_CPU_MIPS32_R2=y
-# CONFIG_COMPACTION is not set
-CONFIG_HZ_100=y
-CONFIG_PREEMPT=y
-# CONFIG_SECCOMP is not set
-CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -30,8 +22,16 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_RALINK=y
+CONFIG_SOC_MT7620=y
+CONFIG_DTB_VOCORE2=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_SUSPEND is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -113,6 +113,10 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRC16=y
+CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_STRIP_ASM_SYMS=y
@@ -123,7 +127,3 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
-CONFIG_CRC16=y
-CONFIG_XZ_DEC=y
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index a84eac409c9c..891a5f77305d 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -1,18 +1,17 @@
-CONFIG_MACH_VR41XX=y
-CONFIG_IBM_WORKPAD=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
+CONFIG_MACH_VR41XX=y
+CONFIG_IBM_WORKPAD=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_VRC4171=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_VRC4171=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -31,16 +30,14 @@ CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECS=m
 CONFIG_IDE_GENERIC=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_3C589=m
 CONFIG_PCMCIA_3C574=m
+CONFIG_PCMCIA_3C589=m
+CONFIG_PCMCIA_NMCLAN=m
 CONFIG_PCMCIA_FMVJ18X=m
+CONFIG_PCMCIA_AXNET=m
 CONFIG_PCMCIA_PCNET=m
-CONFIG_PCMCIA_NMCLAN=m
 CONFIG_PCMCIA_SMC91C92=m
 CONFIG_PCMCIA_XIRC2PS=m
-CONFIG_PCMCIA_AXNET=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -62,7 +59,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index fa750d501c11..c3cac29e8414 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -1,13 +1,3 @@
-CONFIG_LANTIQ=y
-CONFIG_PCI_LANTIQ=y
-CONFIG_XRX200_PHY_FW=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_MIPS_MT_SMP=y
-CONFIG_MIPS_VPE_LOADER=y
-# CONFIG_COMPACTION is not set
-CONFIG_NR_CPUS=2
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
@@ -15,19 +5,28 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_KALLSYMS_ALL=y
 # CONFIG_AIO is not set
+CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_LANTIQ=y
+CONFIG_PCI_LANTIQ=y
+CONFIG_XRX200_PHY_FW=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_MIPS_VPE_LOADER=y
+CONFIG_NR_CPUS=2
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
 # CONFIG_COREDUMP is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -63,7 +62,6 @@ CONFIG_NETFILTER_XT_MATCH_LIMIT=m
 CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
@@ -102,14 +100,12 @@ CONFIG_PPP_ASYNC=m
 CONFIG_ISDN=y
 CONFIG_INPUT=m
 CONFIG_INPUT_POLLDEV=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
@@ -150,6 +146,9 @@ CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
 # CONFIG_SQUASHFS_ZLIB is not set
 CONFIG_SQUASHFS_XZ=y
+CONFIG_CRYPTO_ARC4=m
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC32_SARWATE=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
@@ -158,6 +157,3 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRC_ITU_T=m
-CONFIG_CRC32_SARWATE=y
-- 
2.19.1
