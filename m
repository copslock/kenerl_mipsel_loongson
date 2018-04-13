Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 22:41:54 +0200 (CEST)
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:7166
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994649AbeDMUkqLAgU3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Apr 2018 22:40:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MAP47Ts93PzxnIjTw8E1a4XNE5/Ov6wp/SxzWltbvK0=;
 b=Y3UN0C7Yeyy5+EQ6oGPolLIXc0h3wKAv1s44/apt/ThkmZ5ktZgOWPLHzoPs13IByXv5SX2hapLJCkyxSpzMQPwnwjjLaninjm/MXX/BZLzT/68Krf/dbIHUKAItqmB59husKO2RopxMHNsiDmNsJhw2sFnC+pWUVmthFbFHfDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3612.namprd07.prod.outlook.com (2603:10b6:4:68::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.653.12; Fri, 13
 Apr 2018 20:40:32 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH 4/4] MIPS: Octeon: Whitespace and formatting clean-ups.
Date:   Fri, 13 Apr 2018 15:20:20 -0500
Message-Id: <1523650820-18134-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
References: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To DM5PR07MB3612.namprd07.prod.outlook.com
 (2603:10b6:4:68::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3612;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;3:BaWdg2AT2e1q1svNc5ipEtvjk970saIeszDa+SokUHL2DIn+pGBfl1ZGg1YrFwdkGsjiGMWULkaylAUwoPtRNSOJrnrv3eKNrHKpHD+Y7z8kb4KH/nM7BQ8ALNjOq0v5ivMwDxUWA8g4ZFF1ntlW8VWTV2+rWktbkNJ/KMHMJzaCjGug8bxT/Ex60pAvXykEIG23/fCb53XINupCGSZaiKkshjboYB0bA8cFPZCwfkcttJSLSl6slfv3cUFtWhT4;25:m+GeDhtNVZfxelO8WqsRj52HQkFxoIKyAK2cvgcHwXDJQD+/PlQzqGj9Zjn8WNus7nSx/Oy5LvdgI4+Rl2zXqZZeQ/duPF6jomPSPDi6dMXrO+857UxSyTiAnRT6CZoe9WYJdf3hWRUGRjN7SfERwJHd8fe1gj91LIq/HzeR92khjmAouA3sRJZqqeD3BtTYRfaNE8oRtLWavnTWihgbEkkXzEry5bvwsUJti4j1CQy7+y2giO0EmUGkA/m3QJwZy1JiQDmn5zNjwAwLYa+krfJ2KhZOXAOaShrz5o6Fj+1sDJPQ7WSgoPip6iOf9SEn1XVrPlwT34YX90o6nxF5RA==;31:38K3vaZQV2MNNNTZoVOMVt9sSWsja/yUyxltpUT8J9TBiz9trhdc7rj0RdCVWeOecLXPXMiztYS/YZystaNaHh4OcTGFNDAflmRn4tnEzU1/eUXM4phxuIwJqgjKAK6tkFsMwtRE+FvneF9+uBaOuOs6IDakx85FJZO0L6mMstphvbHfcFbouy1Y0wRCLjeA+Az/fqQgLAS9ztKEeoHdBWlzP7P3rioVstP/4mOx0sY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3612:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;20:fq1GpQDA+yl0qEHuJ87/jWUPXyZ6yGUBvbam1tupZtZoDLciJViVFjtamX/UCbIvt5isVzaC3u4kdtKyVLqtaK7KoAjb2g5sgPID4/SnTg3hX4mpbz0iAEem6sfq97YnId4FjIPKZF3ONhQxOiV8lVvvrWLeB2ZOB3WhDbiMKezrMQpUfQ9Ljp7eOnb4U80ZWnYxyRqJ9gOiy5S4OBSg5tE9V7CGewZ4vKZpINfqXF0dlJ7/t/+kxChOGaFOGLJnpLVAfgqBhZ91WsQCDqGbmMnKHMQMLiDzuB/+H1RzmoQT8yNYwDKI4ySVF693seN62kbMsmr9CrN7drGQ3UlYzQWbcFC5fRO21C7AcX7JDmImZ8v2KEqkpro+pWz9l3xu6Q4tj0edyxnKeHfzKg1COw2ldOdyuQzaXHakHywBIEaHaDFFgKfUAKy1QVPhbd6YO2FmJOr5TGfpoXNMhrf9EZqpDcpuWpNNZKK+onZ3/KCuuPuMbDNiiUJa4SP3Xq/p;4:G1/Co59Yovmp/Qc/k1/4phb1ZBwRM65sm+FMDjBIwuN0F8MNIN5dTq9dRXUg/spBBDW7sh9ejwsYgzBzf9xxbhPZdyVSIpc6aHjdzjg8EofN9MCjVFoACD1z8oRmNUfIXm9N3KenNw/m7XXDGtbEmxTZQW+0rDb5JUjQB47AbB2G5mY0TzQ4mR5iJB3YavzGUVlceAnR65K+I2bm5TW9U2T7sklIvC5v4Kl9yhssaO0kAVfQUDNBP0AJZUkIi97JpWUNpxzROgjgbwhuxxf7p5lhOooIuyGgIIDDeNbZ39qoD4AA+SzL/84AeaFlf8sG
X-Microsoft-Antispam-PRVS: <DM5PR07MB36123CE1011FB43301EA43E480B30@DM5PR07MB3612.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3612;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(189003)(199004)(6486002)(486006)(446003)(69596002)(47776003)(16586007)(105586002)(25786009)(6916009)(66066001)(11346002)(956004)(68736007)(2616005)(16200700003)(478600001)(6506007)(59450400001)(48376002)(2906002)(575784001)(476003)(86362001)(51416003)(2351001)(53416004)(2361001)(5660300001)(81156014)(76176011)(6666003)(386003)(305945005)(6512007)(36756003)(52116002)(8936002)(50226002)(26005)(6116002)(8676002)(53946003)(72206003)(81166006)(3846002)(186003)(316002)(97736004)(7736002)(50466002)(53936002)(106356001)(16526019)(2004002)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3612;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3612;23:LAg41VJ3eaim0qn9CAYu2f8hATWWw42iVUiodFhh8?=
 =?us-ascii?Q?5yGwk98majaDs9e8/cMdmup2xui+e01ek0DgQRWwrjtKBZY1+kYjYxYlg5NZ?=
 =?us-ascii?Q?LdUd1W9CH3MBCMr60CfX5Ca/Lycm0JYsPLe/ctGn1mCp1xL8Q6q+Buf3r2GC?=
 =?us-ascii?Q?3mDN5OGdiICAJtJnfM6VSfhdogdiT8oXlHDaikhfXGtS+UAvOpn942bsxP0L?=
 =?us-ascii?Q?ayHJVbDVdftbRqbYgUlOp4OJHIe/HvfsC01iHg0AJVW1oirvKNai36BMRmVs?=
 =?us-ascii?Q?PaJdOGaRoF1QJkna2wu/57JjZKEbpdVY1tzYIlQkEChqahr5MRoBTljSNOrU?=
 =?us-ascii?Q?ni0Kx3vX56PJIuBlDWWyzOEixTuup5vntEgJH1Gp3l3LVNDX7E/saHim99sw?=
 =?us-ascii?Q?yR8nXB28/zcJYpm0aYEOiVyR4vnRCmSjfmL3fxoqVrRTe5o0+0MGL6Yhmgs6?=
 =?us-ascii?Q?21C8jDnsFxzRZzdg40iczclutUks6QL9t4a7k0uK2cfVuZtY+T/17JFxFXWG?=
 =?us-ascii?Q?RXSU+KevM9r4XTtxjPbXdZWtQSqfMIzxq6lEFe5YyuUfaHrwSSWuTa/CRqhl?=
 =?us-ascii?Q?7Vti0M4ifRhaXOtxUYkjNmO+6xLh76VT8i5bh8d3fNi/YyCw4xAoDkDSFqOn?=
 =?us-ascii?Q?vcUwJWi8/1RGentjVITg9tFGT+0KspEgDu14OwtIKYS9DpDnWiPBDHsz+EU7?=
 =?us-ascii?Q?FRyFfmXBxev9sJtJYVHYJ7+svQetw3i3gAarN0LW2Xm4u/LB+ICBtXqrqpYW?=
 =?us-ascii?Q?L2rpEGirtQq7J9ctREYOd7yezBvKc0EpEUwliUjqkjY6qhjvnj+cc+rTkSyn?=
 =?us-ascii?Q?WFoJPEos1+GEGBBbD4p122LPVLdUHV/USBHz2t0P3+IkSgESYmlE9w8mpSLB?=
 =?us-ascii?Q?kuuKrbcZ7DZVHAGwHt9c39yQc+M6uBQR/NtzCODfoUAsdzvEq6Fpr58PTzbi?=
 =?us-ascii?Q?ulX5GWgtBt7dLSQ+M/7/cS+oZmT9K+KlvjQYpQ/9yERzsUSAVf4CK/+Q3YTq?=
 =?us-ascii?Q?MKGjDRyVLuaRP/7cx0sf5x9TJxUa82hiY4I2QZbUo8dgXHkCAxVrhl7JtzdZ?=
 =?us-ascii?Q?hQ+1dYjFXSD42bNpWWeI7aYlkCtBGqr/hOdx2eODqe0e0UTJ7iL9lopW/Ku+?=
 =?us-ascii?Q?7S52iKh0tLB2qikNccoZ+r3RTMqMVs6LO6dx/TH2K8xpPoatN6KH3BM44z9M?=
 =?us-ascii?Q?lV+QTE1orgcdC6DHT8qh53Ubjr75Q2yUUUfxjKYs3qrfeIiANxNKcFg5F0Lc?=
 =?us-ascii?Q?iBM3384FDzeUAB7N0GvWaaDbW7hBu0RfHM6F6qsz4qrGpU24KpGBeoKoHTVe?=
 =?us-ascii?Q?P5UXNWC+VkAs1hC227bdqoK9kNKATpXMVWz7pvHqqp+CUfqAJa1fZxnVa0U9?=
 =?us-ascii?Q?bnhzW+iegKeve9LGNogoE0XHkmUP54EnQgK6h/zQ4Zi8OQuj5N1nX8JrQpkk?=
 =?us-ascii?Q?CIJrGyWlw=3D=3D?=
X-Microsoft-Antispam-Message-Info: oREt2UxLLeyoSjxOUUFO9YkZGad5ensWmMvuZN38kTL2roIBNjI6efaVJz7AEcaSzg9KUouJIballIcHLInJVzE/kDauBlUsX0Googr/tuuQsO91Inb0c5upq9VrqvXWdlBFaVxQ9OXSGk6xopCBmlQVKVyFix3TkBX6D7EJqUPoWn/kBMFgRs5kQE/te+rv
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;6:CloVAuE/C/ZuqB9snkwdKyEbK7pxDzXOP/WTx4+8Ec/YPXiSNZaJpOKOt/o2Re4otOG/hzE4UF8jbmGgYme3tpWuTO5bpaI3eNOY1gRJjcmnNtn+gQpN9SiwL32hDlwsDoxH6xHuH+lkIpxqLexE4niOVGz+xnSMgiGlfHWK7IL1d7SjVQU1Aj4a82I+EZBNOVDsfOqW2lXOZDjWajSEieO14BPAIEzg76FNgej10XE7fC9xJy/O5aXbJ9ba0EWhBUCcbv05E+ztT3o020UMKGN37vhwvyl+ksQeHje8XHgP69DavZB55UaHlSGwT6FlD8AElE3avaemOEeG6Ai9SzA8ck7uSDi4eiR9nE9QMNB+7PP7+ntMBuoCR3jouv+YAkctiRm+gNYAr26qG/l5CocBll2dbtYG39B5FUQXXMT0zHKa6dLTcdYX9H6A/5J1bjOynfN4DtRyUhtisxooqA==;5:jZP0gysCsGK7I7y4Pmupb1Whrl5/5J88Kq3sJ+SzEqwDQjpNomub4/asFmPP298bv8ni+y7TfIdUzgmHpdS8XtOKqyneZj3F2UEUPqMlHiyaATHiykrYr1SkWKa5qYp2Qqrw7bNAvzorErJlMjrPDFGdlbMBgtIzBPB1kbpXYsI=;24:g5vAZGk+s1yWGL3RDr8LSG7avcEiDgAlimAUnOS8C5KT/CE/XDrPXbHQH1815+A8O1Gdn2eCrcC3vX3Ie9JzHQHJrfIRdTeOOPLfK565y7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;7:mz3Q0ZNearKXDV7tsB6gbNggkLUGas5nL/799QF/DDfTNwSxL0MIJZiMFDKTgF9SYcwvxo3claH8C0LfcMPQRjCMxORgFdSDJ1XtbEg89Pm3mxN48suHj4IRPoY62BFlM2SddO+IlYvZQhq0jgD96piNTUisNJgDwxFg+eabEvS5NZAnoBhDbQL3i4ZGkuvS6DnK25lR+c2w6AHjyt8R6vDJReMXqgusOQlV+O3irhserx7qXdJ11fR2auK0SqPu
X-MS-Office365-Filtering-Correlation-Id: bea87501-2343-4ebf-8465-08d5a17ecdf8
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 20:40:32.8391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea87501-2343-4ebf-8465-08d5a17ecdf8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3612
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

All of these files will be touched by the forthcoming CPU hotplug
and PCIe patchsets. Ran checkpatch and updated copyright dates.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    |  20 +--
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   3 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |  54 ++++----
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |  16 ++-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |  19 ++-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   3 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  41 +++---
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |  55 +++-----
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |  98 ++++++++++----
 arch/mips/cavium-octeon/executive/octeon-model.c   |  29 ++++-
 arch/mips/cavium-octeon/octeon-platform.c          |  69 ++++++----
 arch/mips/cavium-octeon/octeon_boot.h              |  10 +-
 arch/mips/cavium-octeon/setup.c                    | 142 +++++++++++++--------
 arch/mips/cavium-octeon/smp.c                      |  48 +++----
 arch/mips/include/asm/bootinfo.h                   |   3 +-
 arch/mips/include/asm/octeon/cvmx-asm.h            |  93 +++++++-------
 arch/mips/include/asm/octeon/cvmx.h                | 117 +++++++++--------
 arch/mips/include/asm/octeon/octeon.h              | 129 ++++++++++++-------
 18 files changed, 563 insertions(+), 386 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index b6281e0..ba50051 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -181,9 +181,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */
-	cvmx_dprintf
-	    ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
-	     cvmx_sysinfo_get()->board_type);
+	cvmx_dprintf("%s: Unknown board type %d\n", __func__,
+		      cvmx_sysinfo_get()->board_type);
 	return -1;
 }
 
@@ -250,15 +249,13 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 		if (ipd_port == 2) {
 			/* Port 2 is not hooked up */
 			result.u64 = 0;
-			return result;
 		} else {
 			/* Ports 0 and 1 connect to the switch */
 			result.s.link_up = 1;
 			result.s.full_duplex = 1;
 			result.s.speed = 1000;
-			return result;
 		}
-		break;
+		return result;
 	}
 
 	if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
@@ -274,6 +271,7 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 		union cvmx_gmxx_rxx_rx_inbnd inband_status;
 		int interface = cvmx_helper_get_interface_num(ipd_port);
 		int index = cvmx_helper_get_interface_index_num(ipd_port);
+
 		inband_status.u64 =
 		    cvmx_read_csr(CVMX_GMXX_RXX_RX_INBND(index, interface));
 
@@ -346,8 +344,11 @@ int __cvmx_helper_board_interface_probe(int interface, int supported_ports)
 		if (interface == 0)
 			return 0;
 		break;
-		/* The 2nd interface on the EBH5600 is connected to the Marvel switch,
-		   which we don't support. Disable ports connected to it */
+		/*
+		 * The 2nd interface on the EBH5600 is connected to the
+		 * Marvel switch, which we don't support. Disable ports
+		 * connected to it.
+		 */
 	case CVMX_BOARD_TYPE_EBH5600:
 		if (interface == 1)
 			return 0;
@@ -401,7 +402,8 @@ int __cvmx_helper_board_hardware_enable(int interface)
  *
  * Return USB clock type enumeration
  */
-enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(void)
+enum cvmx_helper_board_usb_clock_types
+__cvmx_helper_board_usb_get_clock_type(void)
 {
 	switch (cvmx_sysinfo_get()->board_type) {
 	case CVMX_BOARD_TYPE_BBGW_REF:
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 54237d4..fd5a6be 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -49,6 +49,7 @@ void cvmx_helper_qlm_jtag_init(void)
 	union cvmx_ciu_qlm_jtgc jtgc;
 	uint32_t clock_div = 0;
 	uint32_t divisor = cvmx_sysinfo_get()->cpu_clock_hz / (25 * 1000000);
+
 	divisor = (divisor - 1) >> 2;
 	/* Convert the divisor into a power of 2 shift */
 	while (divisor) {
@@ -88,6 +89,7 @@ void cvmx_helper_qlm_jtag_init(void)
 uint32_t cvmx_helper_qlm_jtag_shift(int qlm, int bits, uint32_t data)
 {
 	union cvmx_ciu_qlm_jtgd jtgd;
+
 	jtgd.u64 = 0;
 	jtgd.s.shift = 1;
 	jtgd.s.shft_cnt = bits - 1;
@@ -115,6 +117,7 @@ void cvmx_helper_qlm_jtag_shift_zeros(int qlm, int bits)
 {
 	while (bits > 0) {
 		int n = bits;
+
 		if (n > 32)
 			n = 32;
 		cvmx_helper_qlm_jtag_shift(qlm, n, 0);
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index 3980570..f978f7b 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -53,13 +53,12 @@ int __cvmx_helper_rgmii_probe(int interface)
 {
 	int num_ports = 0;
 	union cvmx_gmxx_inf_mode mode;
-	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
 
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
 	if (mode.s.type) {
 		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
 		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
-			cvmx_dprintf("ERROR: RGMII initialize called in "
-				     "SPI interface\n");
+			cvmx_dprintf("ERROR: RGMII initialize called in SPI\n");
 		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
 			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
 			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
@@ -100,8 +99,8 @@ void cvmx_helper_rgmii_internal_loopback(int port)
 	int interface = (port >> 4) & 1;
 	int index = port & 0xf;
 	uint64_t tmp;
-
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
+
 	gmx_cfg.u64 = 0;
 	gmx_cfg.s.duplex = 1;
 	gmx_cfg.s.slottime = 1;
@@ -142,9 +141,10 @@ static int __cvmx_helper_errata_asx_pass1(int interface, int port,
 		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 10);
 	else if (cpu_clock_hz >= 550000000 && cpu_clock_hz < 687000000)
 		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 9);
-	else
-		cvmx_dprintf("Illegal clock frequency (%d). "
-			"CVMX_ASXX_TX_HI_WATERX not set\n", cpu_clock_hz);
+	else {
+		cvmx_dprintf("Illegal clock frequency (%d). ", cpu_clock_hz);
+		cvmx_dprintf("CVMX_ASXX_TX_HI_WATERX not set\n");
+	}
 	return 0;
 }
 
@@ -185,13 +185,13 @@ int __cvmx_helper_rgmii_enable(int interface)
 
 	/* Configure the GMX registers needed to use the RGMII ports */
 	for (port = 0; port < num_ports; port++) {
-		/* Setting of CVMX_GMXX_TXX_THRESH has been moved to
-		   __cvmx_helper_setup_gmx() */
-
+		/*
+		 * Setting of CVMX_GMXX_TXX_THRESH has been moved to
+		 * __cvmx_helper_setup_gmx()
+		 */
 		if (cvmx_octeon_is_pass1())
 			__cvmx_helper_errata_asx_pass1(interface, port,
-						       sys_info_ptr->
-						       cpu_clock_hz);
+				sys_info_ptr->cpu_clock_hz);
 		else {
 			/*
 			 * Configure more flexible RGMII preamble
@@ -199,9 +199,9 @@ int __cvmx_helper_rgmii_enable(int interface)
 			 * feature.
 			 */
 			union cvmx_gmxx_rxx_frm_ctl frm_ctl;
-			frm_ctl.u64 =
-			    cvmx_read_csr(CVMX_GMXX_RXX_FRM_CTL
-					  (port, interface));
+
+			frm_ctl.u64 = cvmx_read_csr(CVMX_GMXX_RXX_FRM_CTL
+						    (port, interface));
 			/* New field, so must be compile time */
 			frm_ctl.s.pre_free = 1;
 			cvmx_write_csr(CVMX_GMXX_RXX_FRM_CTL(port, interface),
@@ -271,6 +271,7 @@ cvmx_helper_link_info_t __cvmx_helper_rgmii_link_get(int ipd_port)
 	if (asxx_prt_loop.s.int_loop & (1 << index)) {
 		/* Force 1Gbps full duplex on internal loopback */
 		cvmx_helper_link_info_t result;
+
 		result.u64 = 0;
 		result.s.full_duplex = 1;
 		result.s.link_up = 1;
@@ -323,6 +324,7 @@ int __cvmx_helper_rgmii_link_set(int ipd_port,
 	/* Disable all queues so that TX should become idle */
 	for (i = 0; i < cvmx_pko_get_num_queues(ipd_port); i++) {
 		int queue = cvmx_pko_get_base_queue(ipd_port) + i;
+
 		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, queue);
 		pko_mem_queue_qos.u64 = cvmx_read_csr(CVMX_PKO_MEM_QUEUE_QOS);
 		pko_mem_queue_qos.s.pid = ipd_port;
@@ -396,21 +398,22 @@ int __cvmx_helper_rgmii_link_set(int ipd_port,
 		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0x2000);
 	}
 
-	if (OCTEON_IS_MODEL(OCTEON_CN30XX) || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
-		if ((link_info.s.speed == 10) || (link_info.s.speed == 100)) {
-			union cvmx_gmxx_inf_mode mode;
-			mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
-
 	/*
 	 * Port	 .en  .type  .p0mii  Configuration
 	 * ----	 ---  -----  ------  -----------------------------------------
 	 *  X	   0	 X	X    All links are disabled.
 	 *  0	   1	 X	0    Port 0 is RGMII
 	 *  0	   1	 X	1    Port 0 is MII
-	 *  1	   1	 0	X    Ports 1 and 2 are configured as RGMII ports.
-	 *  1	   1	 1	X    Port 1: GMII/MII; Port 2: disabled. GMII or
-	 *			     MII port is selected by GMX_PRT1_CFG[SPEED].
+	 *  1	   1	 0	X    Ports 1 and 2 are configured as RGMII.
+	 *  1	   1	 1	X    Port 1: GMII/MII; Port 2: disabled. GMII
+	 *			     or MII port is selected by
+	 *			     GMX_PRT1_CFG[SPEED].
 	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN30XX) || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		if ((link_info.s.speed == 10) || (link_info.s.speed == 100)) {
+			union cvmx_gmxx_inf_mode mode;
+
+			mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
 
 			/* In MII mode, CLK_CNT = 1. */
 			if (((index == 0) && (mode.s.p0mii == 1))
@@ -435,6 +438,7 @@ int __cvmx_helper_rgmii_link_set(int ipd_port,
 	/* Re-enable the TX path */
 	for (i = 0; i < cvmx_pko_get_num_queues(ipd_port); i++) {
 		int queue = cvmx_pko_get_base_queue(ipd_port) + i;
+
 		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, queue);
 		cvmx_write_csr(CVMX_PKO_MEM_QUEUE_QOS,
 			       pko_mem_queue_qos_save[i].u64);
@@ -502,8 +506,8 @@ int __cvmx_helper_rgmii_configure_loopback(int ipd_port, int enable_internal,
 
 	/* Force enables in internal loopback */
 	if (enable_internal) {
-		uint64_t tmp;
-		tmp = cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(interface));
+		uint64_t tmp = cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(interface));
+
 		cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(interface),
 			       (1 << index) | tmp);
 		tmp = cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(interface));
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index aeca94e..4b29d1c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -94,6 +94,7 @@ static int __cvmx_helper_sgmii_hardware_init_one_time(int interface, int index)
 	if (pcs_misc_ctl_reg.s.mode) {
 		/* 1000BASE-X */
 		union cvmx_pcsx_anx_adv_reg pcsx_anx_adv_reg;
+
 		pcsx_anx_adv_reg.u64 =
 		    cvmx_read_csr(CVMX_PCSX_ANX_ADV_REG(index, interface));
 		pcsx_anx_adv_reg.s.rem_flt = 0;
@@ -104,11 +105,13 @@ static int __cvmx_helper_sgmii_hardware_init_one_time(int interface, int index)
 			       pcsx_anx_adv_reg.u64);
 	} else {
 		union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
+
 		pcsx_miscx_ctl_reg.u64 =
 		    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
 		if (pcsx_miscx_ctl_reg.s.mac_phy) {
 			/* PHY Mode */
 			union cvmx_pcsx_sgmx_an_adv_reg pcsx_sgmx_an_adv_reg;
+
 			pcsx_sgmx_an_adv_reg.u64 =
 			    cvmx_read_csr(CVMX_PCSX_SGMX_AN_ADV_REG
 					  (index, interface));
@@ -155,9 +158,8 @@ static int __cvmx_helper_sgmii_hardware_init_link(int interface, int index)
 		if (CVMX_WAIT_FOR_FIELD64
 		    (CVMX_PCSX_MRX_CONTROL_REG(index, interface),
 		     union cvmx_pcsx_mrx_control_reg, reset, ==, 0, 10000)) {
-			cvmx_dprintf("SGMII%d: Timeout waiting for port %d "
-				     "to finish reset\n",
-			     interface, index);
+			cvmx_dprintf("SGMII%d: Timeout for port %d to reset.",
+				     interface, index);
 			return -1;
 		}
 	}
@@ -180,9 +182,7 @@ static int __cvmx_helper_sgmii_hardware_init_link(int interface, int index)
 	 */
 	if ((cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) &&
 	    CVMX_WAIT_FOR_FIELD64(CVMX_PCSX_MRX_STATUS_REG(index, interface),
-				  union cvmx_pcsx_mrx_status_reg, an_cpt, ==, 1,
-				  10000)) {
-		/* cvmx_dprintf("SGMII%d: Port %d link timeout\n", interface, index); */
+		union cvmx_pcsx_mrx_status_reg, an_cpt, ==, 1, 10000)) {
 		return -1;
 	}
 	return 0;
@@ -312,6 +312,7 @@ static int __cvmx_helper_sgmii_hardware_init(int interface, int num_ports)
 
 	for (index = 0; index < num_ports; index++) {
 		int ipd_port = cvmx_helper_get_ipd_port(interface, index);
+
 		__cvmx_helper_sgmii_hardware_init_one_time(interface, index);
 		/* Linux kernel driver will call ....link_set with the
 		 * proper link state. In the simulator there is no
@@ -372,6 +373,7 @@ int __cvmx_helper_sgmii_enable(int interface)
 
 	for (index = 0; index < num_ports; index++) {
 		union cvmx_gmxx_prtx_cfg gmxx_prtx_cfg;
+
 		gmxx_prtx_cfg.u64 =
 		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
 		gmxx_prtx_cfg.s.en = 1;
@@ -429,6 +431,7 @@ cvmx_helper_link_info_t __cvmx_helper_sgmii_link_get(int ipd_port)
 		/* FIXME */
 	} else {
 		union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
+
 		pcsx_miscx_ctl_reg.u64 =
 		    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
 		if (pcsx_miscx_ctl_reg.s.mac_phy) {
@@ -509,6 +512,7 @@ int __cvmx_helper_sgmii_link_set(int ipd_port,
 {
 	int interface = cvmx_helper_get_interface_num(ipd_port);
 	int index = cvmx_helper_get_interface_index_num(ipd_port);
+
 	__cvmx_helper_sgmii_hardware_init_link(interface, index);
 	return __cvmx_helper_sgmii_hardware_init_link_speed(interface, index,
 							    link_info);
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index 8e027e6..816c41b 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -78,6 +78,7 @@ int __cvmx_helper_spi_probe(int interface)
 		num_ports = 10;
 	} else {
 		union cvmx_pko_reg_crc_enable enable;
+
 		num_ports = 16;
 		/*
 		 * Unlike the SPI4000, most SPI devices don't
@@ -111,9 +112,11 @@ int __cvmx_helper_spi_enable(int interface)
 	 */
 	int num_ports = cvmx_helper_ports_on_interface(interface);
 	int ipd_port;
+
 	for (ipd_port = interface * 16; ipd_port < interface * 16 + num_ports;
 	     ipd_port++) {
 		union cvmx_pip_prt_cfgx port_config;
+
 		port_config.u64 = cvmx_read_csr(CVMX_PIP_PRT_CFGX(ipd_port));
 		port_config.s.crc_en = 1;
 		cvmx_write_csr(CVMX_PIP_PRT_CFGX(ipd_port), port_config.u64);
@@ -146,8 +149,8 @@ cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port)
 	cvmx_helper_link_info_t result;
 	int interface = cvmx_helper_get_interface_num(ipd_port);
 	int index = cvmx_helper_get_interface_index_num(ipd_port);
-	result.u64 = 0;
 
+	result.u64 = 0;
 	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_SIM) {
 		/* The simulator gives you a simulated full duplex link */
 		result.s.link_up = 1;
@@ -174,8 +177,10 @@ cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port)
 			break;
 		}
 	} else {
-		/* For generic SPI we can't determine the link, just return some
-		   sane results */
+		/*
+		 * For generic SPI we can't determine the link, just
+		 * return some sane results.
+		 */
 		result.s.link_up = 1;
 		result.s.full_duplex = 1;
 		result.s.speed = 10000;
@@ -196,8 +201,10 @@ cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port)
  */
 int __cvmx_helper_spi_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
 {
-	/* Nothing to do. If we have a SPI4000 then the setup was already performed
-	   by cvmx_spi4000_check_speed(). If not then there isn't any link
-	   info */
+	/*
+	 * Nothing to do. If we have a SPI4000 then the setup was
+	 * already performed by cvmx_spi4000_check_speed(). If not
+	 * then there isn't any link info
+	 */
 	return 0;
 }
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index f694f75..32e735e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -87,11 +87,12 @@ int __cvmx_helper_xaui_probe(int interface)
 	 */
 	for (i = 0; i < 16; i++) {
 		union cvmx_pko_mem_port_ptrs pko_mem_port_ptrs;
-		pko_mem_port_ptrs.u64 = 0;
+
 		/*
 		 * We set each PKO port to have equal priority in a
 		 * round robin fashion.
 		 */
+		pko_mem_port_ptrs.u64 = 0;
 		pko_mem_port_ptrs.s.static_p = 0;
 		pko_mem_port_ptrs.s.qos_mask = 0xff;
 		/* All PKO ports map to the same XAUI hardware port */
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 35c99db..76d24bb 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -54,8 +54,7 @@
  * number. Users should set this pointer to a function before
  * calling any cvmx-helper operations.
  */
-void (*cvmx_override_pko_queue_priority) (int pko_port,
-					  uint64_t priorities[16]);
+void (*cvmx_override_pko_queue_priority)(int pko_port, uint64_t priorities[16]);
 
 /**
  * cvmx_override_ipd_port_setup(int ipd_port) is a function
@@ -65,7 +64,7 @@ void (*cvmx_override_pko_queue_priority) (int pko_port,
  * before IPD is enabled. Users should set this pointer to a
  * function before calling any cvmx-helper operations.
  */
-void (*cvmx_override_ipd_port_setup) (int ipd_port);
+void (*cvmx_override_ipd_port_setup)(int ipd_port);
 
 /* Port count per interface */
 static int interface_port_count[5];
@@ -113,6 +112,7 @@ EXPORT_SYMBOL_GPL(cvmx_helper_ports_on_interface);
 static cvmx_helper_interface_mode_t __cvmx_get_mode_cn68xx(int interface)
 {
 	union cvmx_mio_qlmx_cfg qlm_cfg;
+
 	switch (interface) {
 	case 0:
 		qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(0));
@@ -226,6 +226,7 @@ static cvmx_helper_interface_mode_t __cvmx_get_mode_octeon2(int interface)
 	} else if (OCTEON_IS_MODEL(OCTEON_CNF71XX)) {
 		if (interface == 0) {
 			union cvmx_mio_qlmx_cfg qlm_cfg;
+
 			qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(0));
 			if (qlm_cfg.s.qlm_cfg == 2)
 				return CVMX_HELPER_INTERFACE_MODE_SGMII;
@@ -532,9 +533,11 @@ int cvmx_helper_interface_enumerate(int interface)
 int cvmx_helper_interface_probe(int interface)
 {
 	cvmx_helper_interface_enumerate(interface);
-	/* At this stage in the game we don't want packets to be moving yet.
-	   The following probe calls should perform hardware setup
-	   needed to determine port counts. Receive must still be disabled */
+	/*
+	 * At this stage in the game we don't want packets to be moving yet.
+	 * The following probe calls should perform hardware setup needed
+	 * to determine port counts. Receive must still be disabled.
+	 */
 	switch (cvmx_helper_interface_get_mode(interface)) {
 		/* These types don't support ports to IPD/PKO */
 	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
@@ -653,8 +656,9 @@ static int __cvmx_helper_interface_setup_pko(int interface)
 	 * the second half.  With per-core PKO queues (PKO lockless
 	 * operation) all queues have the same priority.
 	 */
-	uint64_t priorities[16] =
-	    { 8, 7, 6, 5, 4, 3, 2, 1, 8, 7, 6, 5, 4, 3, 2, 1 };
+	uint64_t priorities[16] = {
+		8, 7, 6, 5, 4, 3, 2, 1, 8, 7, 6, 5, 4, 3, 2, 1
+	};
 
 	/*
 	 * Setup the IPD/PIP and PKO for the ports discovered
@@ -663,6 +667,7 @@ static int __cvmx_helper_interface_setup_pko(int interface)
 	 */
 	int ipd_port = cvmx_helper_get_ipd_port(interface, 0);
 	int num_ports = interface_port_count[interface];
+
 	while (num_ports--) {
 		/*
 		 * Give the user a chance to override the per queue
@@ -694,6 +699,7 @@ static int __cvmx_helper_global_setup_pko(void)
 	 * anyone might start packet output using tags.
 	 */
 	union cvmx_iob_fau_timeout fau_to;
+
 	fau_to.u64 = 0;
 	fau_to.s.tout_val = 0xfff;
 	fau_to.s.tout_enb = 0;
@@ -728,6 +734,7 @@ static int __cvmx_helper_global_setup_backpressure(void)
 	/* Disable backpressure (pause frame) generation */
 	int num_interfaces = cvmx_helper_get_number_of_interfaces();
 	int interface;
+
 	for (interface = 0; interface < num_interfaces; interface++) {
 		switch (cvmx_helper_interface_get_mode(interface)) {
 		case CVMX_HELPER_INTERFACE_MODE_DISABLED:
@@ -764,6 +771,7 @@ static int __cvmx_helper_global_setup_backpressure(void)
 static int __cvmx_helper_packet_hardware_enable(int interface)
 {
 	int result = 0;
+
 	switch (cvmx_helper_interface_get_mode(interface)) {
 		/* These types don't support ports to IPD/PKO */
 	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
@@ -822,7 +830,7 @@ static int __cvmx_helper_packet_hardware_enable(int interface)
 int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 {
 #define FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES \
-     (CVMX_FPA_PACKET_POOL_SIZE-8-CVMX_HELPER_FIRST_MBUFF_SKIP)
+	(CVMX_FPA_PACKET_POOL_SIZE-8-CVMX_HELPER_FIRST_MBUFF_SKIP)
 #define FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES \
 	(CVMX_FPA_PACKET_POOL_SIZE-8-CVMX_HELPER_NOT_FIRST_MBUFF_SKIP)
 #define FIX_IPD_OUTPORT 0
@@ -891,8 +899,7 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 		g_buffer.s.addr =
 		    cvmx_ptr_to_phys(cvmx_fpa_alloc(CVMX_FPA_WQE_POOL));
 		if (g_buffer.s.addr == 0) {
-			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
-				     "buffer allocation failure.\n");
+			cvmx_dprintf("%s: buffer allocation fail.\n", __func__);
 			goto fix_ipd_exit;
 		}
 
@@ -903,8 +910,7 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 		pkt_buffer.s.addr =
 		    cvmx_ptr_to_phys(cvmx_fpa_alloc(CVMX_FPA_PACKET_POOL));
 		if (pkt_buffer.s.addr == 0) {
-			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
-				     "buffer allocation failure.\n");
+			cvmx_dprintf("%s: buffer allocation fail.\n", __func__);
 			goto fix_ipd_exit;
 		}
 		pkt_buffer.s.i = 1;
@@ -973,8 +979,7 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 		} while ((work == NULL) && (retry_cnt > 0));
 
 		if (!retry_cnt)
-			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
-				     "get_work() timeout occurred.\n");
+			cvmx_dprintf("%s: timeout occurred.\n", __func__);
 
 		/* Free packet */
 		if (work)
@@ -1148,8 +1153,10 @@ cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
 	int interface = cvmx_helper_get_interface_num(ipd_port);
 	int index = cvmx_helper_get_interface_index_num(ipd_port);
 
-	/* The default result will be a down link unless the code below
-	   changes it */
+	/*
+	 * The default result will be a down link unless the code
+	 * below changes it.
+	 */
 	result.u64 = 0;
 
 	if (index >= cvmx_helper_ports_on_interface(interface))
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 2312f2c..18668e4 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -273,6 +273,7 @@ void cvmx_pko_enable(void)
 void cvmx_pko_disable(void)
 {
 	union cvmx_pko_reg_flags pko_reg_flags;
+
 	pko_reg_flags.u64 = cvmx_read_csr(CVMX_PKO_REG_FLAGS);
 	pko_reg_flags.s.ena_pko = 0;
 	cvmx_write_csr(CVMX_PKO_REG_FLAGS, pko_reg_flags.u64);
@@ -285,6 +286,7 @@ EXPORT_SYMBOL_GPL(cvmx_pko_disable);
 static void __cvmx_pko_reset(void)
 {
 	union cvmx_pko_reg_flags pko_reg_flags;
+
 	pko_reg_flags.u64 = cvmx_read_csr(CVMX_PKO_REG_FLAGS);
 	pko_reg_flags.s.reset = 1;
 	cvmx_write_csr(CVMX_PKO_REG_FLAGS, pko_reg_flags.u64);
@@ -310,6 +312,7 @@ void cvmx_pko_shutdown(void)
 		config.s.buf_ptr = 0;
 		if (!OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
 			union cvmx_pko_reg_queue_ptrs1 config1;
+
 			config1.u64 = 0;
 			config1.s.qid7 = queue >> 7;
 			cvmx_write_csr(CVMX_PKO_REG_QUEUE_PTRS1, config1.u64);
@@ -354,15 +357,14 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 
 	if ((port >= CVMX_PKO_NUM_OUTPUT_PORTS)
 	    && (port != CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID)) {
-		cvmx_dprintf("ERROR: cvmx_pko_config_port: Invalid port %llu\n",
+		cvmx_dprintf("%s: Invalid port %llu\n", __func__,
 			     (unsigned long long)port);
 		return CVMX_PKO_INVALID_PORT;
 	}
 
 	if (base_queue + num_queues > CVMX_PKO_MAX_OUTPUT_QUEUES) {
-		cvmx_dprintf
-		    ("ERROR: cvmx_pko_config_port: Invalid queue range %llu\n",
-		     (unsigned long long)(base_queue + num_queues));
+		cvmx_dprintf("%s: Invalid queue range %llu\n", __func__,
+			     (unsigned long long)(base_queue + num_queues));
 		return CVMX_PKO_INVALID_QUEUE;
 	}
 
@@ -399,26 +401,14 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 			    && (int)queue > static_priority_end
 			    && priority[queue] ==
 			    CVMX_PKO_QUEUE_STATIC_PRIORITY) {
-				cvmx_dprintf("ERROR: cvmx_pko_config_port: "
-					     "Static priority queues aren't "
-					     "contiguous or don't start at "
-					     "base queue. q: %d, eq: %d\n",
-					(int)queue, static_priority_end);
+				cvmx_dprintf("%s: Static priority queues aren't contiguous or don't start at base queue. q: %d, eq: %d\n", __func__, (int)queue, static_priority_end);
 				return CVMX_PKO_INVALID_PRIORITY;
 			}
 		}
 		if (static_priority_base > 0) {
-			cvmx_dprintf("ERROR: cvmx_pko_config_port: Static "
-				     "priority queues don't start at base "
-				     "queue. sq: %d\n",
-				static_priority_base);
+			cvmx_dprintf("%s: Static priority queues don't start at base queue. sq: %d\n", __func__, static_priority_base);
 			return CVMX_PKO_INVALID_PRIORITY;
 		}
-#if 0
-		cvmx_dprintf("Port %d: Static priority queue base: %d, "
-			     "end: %d\n", port,
-			static_priority_base, static_priority_end);
-#endif
 	}
 	/*
 	 * At this point, static_priority_base and static_priority_end
@@ -492,9 +482,8 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 				break;
 			}
 		default:
-			cvmx_dprintf("ERROR: cvmx_pko_config_port: Invalid "
-				     "priority %llu\n",
-				(unsigned long long)priority[queue]);
+			cvmx_dprintf("%s: Invalid priority %llu\n", __func__,
+				     (unsigned long long)priority[queue]);
 			config.s.qos_mask = 0xff;
 			result_code = CVMX_PKO_INVALID_PRIORITY;
 			break;
@@ -503,29 +492,21 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 		if (port != CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID) {
 			cvmx_cmd_queue_result_t cmd_res =
 			    cvmx_cmd_queue_initialize(CVMX_CMD_QUEUE_PKO
-						      (base_queue + queue),
-						      CVMX_PKO_MAX_QUEUE_DEPTH,
-						      CVMX_FPA_OUTPUT_BUFFER_POOL,
-						      CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE
-						      -
-						      CVMX_PKO_COMMAND_BUFFER_SIZE_ADJUST
-						      * 8);
+				(base_queue + queue), CVMX_PKO_MAX_QUEUE_DEPTH,
+				CVMX_FPA_OUTPUT_BUFFER_POOL,
+				CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE -
+				CVMX_PKO_COMMAND_BUFFER_SIZE_ADJUST * 8);
 			if (cmd_res != CVMX_CMD_QUEUE_SUCCESS) {
 				switch (cmd_res) {
 				case CVMX_CMD_QUEUE_NO_MEMORY:
-					cvmx_dprintf("ERROR: "
-						     "cvmx_pko_config_port: "
-						     "Unable to allocate "
-						     "output buffer.\n");
+					cvmx_dprintf("%s: Unable to allocate output buffer.\n", __func__);
 					return CVMX_PKO_NO_MEMORY;
 				case CVMX_CMD_QUEUE_ALREADY_SETUP:
-					cvmx_dprintf
-					    ("ERROR: cvmx_pko_config_port: Port already setup.\n");
+					cvmx_dprintf("%s: Port already setup.\n", __func__);
 					return CVMX_PKO_PORT_ALREADY_SETUP;
 				case CVMX_CMD_QUEUE_INVALID_PARAM:
 				default:
-					cvmx_dprintf
-					    ("ERROR: cvmx_pko_config_port: Command queue initialization failed.\n");
+					cvmx_dprintf("%s: Command queue initialization failed.\n", __func__);
 					return CVMX_PKO_CMD_QUEUE_INIT_ERROR;
 				}
 			}
@@ -552,7 +533,7 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 /**
  * Show map of ports -> queues for different cores.
  */
-void cvmx_pko_show_queue_map()
+void cvmx_pko_show_queue_map(void)
 {
 	int core, port;
 	int pko_output_ports = 36;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index 6582d34..fa35163 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -30,6 +30,7 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
+
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-sysinfo.h>
 
@@ -40,18 +41,10 @@
 #include <asm/octeon/cvmx-srxx-defs.h>
 #include <asm/octeon/cvmx-stxx-defs.h>
 
-#define INVOKE_CB(function_p, args...)		\
-	do {					\
-		if (function_p) {		\
-			res = function_p(args); \
-			if (res)		\
-				return res;	\
-		}				\
-	} while (0)
-
 #if CVMX_ENABLE_DEBUG_PRINTS
-static const char *modes[] =
-    { "UNKNOWN", "TX Halfplex", "Rx Halfplex", "Duplex" };
+static const char * const modes[] = {
+	"UNKNOWN", "TX Halfplex", "Rx Halfplex", "Duplex"
+};
 #endif
 
 /* Default callbacks, can be overridden
@@ -111,24 +104,46 @@ int cvmx_spi_start_interface(int interface, cvmx_spi_mode_t mode, int timeout,
 		return res;
 
 	/* Callback to perform SPI4 reset */
-	INVOKE_CB(cvmx_spi_callbacks.reset_cb, interface, mode);
+	if (cvmx_spi_callbacks.reset_cb) {
+		res = cvmx_spi_callbacks.reset_cb(interface, mode);
+		if (res)
+			return res;
+	}
 
 	/* Callback to perform calendar setup */
-	INVOKE_CB(cvmx_spi_callbacks.calendar_setup_cb, interface, mode,
-		  num_ports);
+	if (cvmx_spi_callbacks.calendar_setup_cb) {
+		res = cvmx_spi_callbacks.calendar_setup_cb(interface,
+							   mode, num_ports);
+		if (res)
+			return res;
+	}
 
 	/* Callback to perform clock detection */
-	INVOKE_CB(cvmx_spi_callbacks.clock_detect_cb, interface, mode, timeout);
+	if (cvmx_spi_callbacks.clock_detect_cb) {
+		res = cvmx_spi_callbacks.clock_detect_cb(interface,
+							 mode, num_ports);
+		if (res)
+			return res;
+	}
 
 	/* Callback to perform SPI4 link training */
-	INVOKE_CB(cvmx_spi_callbacks.training_cb, interface, mode, timeout);
+	if (cvmx_spi_callbacks.training_cb) {
+		res = cvmx_spi_callbacks.training_cb(interface, mode, timeout);
+		if (res)
+			return res;
+	}
 
 	/* Callback to perform calendar sync */
-	INVOKE_CB(cvmx_spi_callbacks.calendar_sync_cb, interface, mode,
-		  timeout);
+	if (cvmx_spi_callbacks.calendar_sync_cb) {
+		res = cvmx_spi_callbacks.calendar_sync_cb(interface,
+							  mode, timeout);
+		if (res)
+			return res;
+	}
 
 	/* Callback to handle interface coming up */
-	INVOKE_CB(cvmx_spi_callbacks.interface_up_cb, interface, mode);
+	if (cvmx_spi_callbacks.interface_up_cb)
+		res = cvmx_spi_callbacks.interface_up_cb(interface, mode);
 
 	return res;
 }
@@ -157,23 +172,44 @@ int cvmx_spi_restart_interface(int interface, cvmx_spi_mode_t mode, int timeout)
 	cvmx_dprintf("SPI%d: Restart %s\n", interface, modes[mode]);
 
 	/* Callback to perform SPI4 reset */
-	INVOKE_CB(cvmx_spi_callbacks.reset_cb, interface, mode);
+	if (cvmx_spi_callbacks.reset_cb) {
+		res = cvmx_spi_callbacks.reset_cb(interface, mode);
+		if (res)
+			return res;
+	}
 
 	/* NOTE: Calendar setup is not performed during restart */
 	/*	 Refer to cvmx_spi_start_interface() for the full sequence */
 
 	/* Callback to perform clock detection */
-	INVOKE_CB(cvmx_spi_callbacks.clock_detect_cb, interface, mode, timeout);
+	if (cvmx_spi_callbacks.clock_detect_cb) {
+		res = cvmx_spi_callbacks.clock_detect_cb(interface, mode,
+							 timeout);
+		if (res)
+			return res;
+	}
 
 	/* Callback to perform SPI4 link training */
-	INVOKE_CB(cvmx_spi_callbacks.training_cb, interface, mode, timeout);
+	if (cvmx_spi_callbacks.training_cb) {
+		res = cvmx_spi_callbacks.training_cb(interface, mode, timeout);
+		if (res)
+			return res;
+	}
 
 	/* Callback to perform calendar sync */
-	INVOKE_CB(cvmx_spi_callbacks.calendar_sync_cb, interface, mode,
-		  timeout);
+	if (cvmx_spi_callbacks.calendar_sync_cb) {
+		res = cvmx_spi_callbacks.calendar_sync_cb(interface, mode,
+							  timeout);
+		if (res)
+			return res;
+	}
 
 	/* Callback to handle interface coming up */
-	INVOKE_CB(cvmx_spi_callbacks.interface_up_cb, interface, mode);
+	if (cvmx_spi_callbacks.interface_up_cb) {
+		res = cvmx_spi_callbacks.interface_up_cb(interface, mode);
+		if (res)
+			return res;
+	}
 
 	return res;
 }
@@ -311,8 +347,8 @@ int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode)
 int cvmx_spi_calendar_setup_cb(int interface, cvmx_spi_mode_t mode,
 			       int num_ports)
 {
-	int port;
-	int index;
+	int port, index;
+
 	if (mode & CVMX_SPI_MODE_RX_HALFPLEX) {
 		union cvmx_srxx_com_ctl srxx_com_ctl;
 		union cvmx_srxx_spi4_stat srxx_spi4_stat;
@@ -329,6 +365,7 @@ int cvmx_spi_calendar_setup_cb(int interface, cvmx_spi_mode_t mode,
 		index = 0;
 		while (port < num_ports) {
 			union cvmx_srxx_spi4_calx srxx_spi4_calx;
+
 			srxx_spi4_calx.u64 = 0;
 			srxx_spi4_calx.s.prt0 = port++;
 			srxx_spi4_calx.s.prt1 = port++;
@@ -392,6 +429,7 @@ int cvmx_spi_calendar_setup_cb(int interface, cvmx_spi_mode_t mode,
 		index = 0;
 		while (port < num_ports) {
 			union cvmx_stxx_spi4_calx stxx_spi4_calx;
+
 			stxx_spi4_calx.u64 = 0;
 			stxx_spi4_calx.s.prt0 = port++;
 			stxx_spi4_calx.s.prt1 = port++;
@@ -515,6 +553,7 @@ int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
 
 	/* SRX0 & STX0 Inf0 Links are configured - begin training */
 	union cvmx_spxx_clk_ctl spxx_clk_ctl;
+
 	spxx_clk_ctl.u64 = 0;
 	spxx_clk_ctl.s.seetrn = 0;
 	spxx_clk_ctl.s.clkdly = 0x10;
@@ -577,9 +616,11 @@ int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
 int cvmx_spi_calendar_sync_cb(int interface, cvmx_spi_mode_t mode, int timeout)
 {
 	uint64_t MS = cvmx_sysinfo_get()->cpu_clock_hz / 1000;
+
 	if (mode & CVMX_SPI_MODE_RX_HALFPLEX) {
 		/* SRX0 interface should be good, send calendar data */
 		union cvmx_srxx_com_ctl srxx_com_ctl;
+
 		cvmx_dprintf
 		    ("SPI%d: Rx is synchronized, start sending calendar data\n",
 		     interface);
@@ -596,6 +637,7 @@ int cvmx_spi_calendar_sync_cb(int interface, cvmx_spi_mode_t mode, int timeout)
 		union cvmx_spxx_clk_stat stat;
 		uint64_t timeout_time;
 		union cvmx_stxx_com_ctl stxx_com_ctl;
+
 		stxx_com_ctl.u64 = 0;
 		stxx_com_ctl.s.st_en = 1;
 		cvmx_write_csr(CVMX_STXX_COM_CTL(interface), stxx_com_ctl.u64);
@@ -638,6 +680,7 @@ int cvmx_spi_interface_up_cb(int interface, cvmx_spi_mode_t mode)
 
 	if (mode & CVMX_SPI_MODE_RX_HALFPLEX) {
 		union cvmx_srxx_com_ctl srxx_com_ctl;
+
 		srxx_com_ctl.u64 = cvmx_read_csr(CVMX_SRXX_COM_CTL(interface));
 		srxx_com_ctl.s.inf_en = 1;
 		cvmx_write_csr(CVMX_SRXX_COM_CTL(interface), srxx_com_ctl.u64);
@@ -646,6 +689,7 @@ int cvmx_spi_interface_up_cb(int interface, cvmx_spi_mode_t mode)
 
 	if (mode & CVMX_SPI_MODE_TX_HALFPLEX) {
 		union cvmx_stxx_com_ctl stxx_com_ctl;
+
 		stxx_com_ctl.u64 = cvmx_read_csr(CVMX_STXX_COM_CTL(interface));
 		stxx_com_ctl.s.inf_en = 1;
 		cvmx_write_csr(CVMX_STXX_COM_CTL(interface), stxx_com_ctl.u64);
diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index 3410523..a7f8c86 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2017 Cavium, Inc.
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -455,6 +455,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	clock_mhz = octeon_get_clock_rate() / 1000000;
 	if (family[0] != '3') {
 		int fuse_base = 384 / 8;
+
 		if (family[0] == '6')
 			fuse_base = 832 / 8;
 
@@ -470,24 +471,37 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		if (fuse_data & 0x7ffff) {
 			int model = fuse_data & 0x3fff;
 			int suffix = (fuse_data >> 14) & 0x1f;
+
 			if (suffix && model) {
-				/* Have both number and suffix in fuses, so both */
-				sprintf(fuse_model, "%d%c", model, 'A' + suffix - 1);
+				/*
+				 * Have both number and suffix in fuses,
+				 * so both.
+				 */
+				sprintf(fuse_model, "%d%c", model,
+					'A' + suffix - 1);
 				core_model = "";
 				family = fuse_model;
 			} else if (suffix && !model) {
-				/* Only have suffix, so add suffix to 'normal' model number */
-				sprintf(fuse_model, "%s%c", core_model, 'A' + suffix - 1);
+				/*
+				 * Only have suffix, so add suffix to
+				 * 'normal' model number.
+				 */
+				sprintf(fuse_model, "%s%c", core_model,
+					'A' + suffix - 1);
 				core_model = fuse_model;
 			} else {
-				/* Don't have suffix, so just use model from fuses */
+				/*
+				 * Don't have suffix, so just use model
+				 * from fuses.
+				 */
 				sprintf(fuse_model, "%d", model);
 				core_model = "";
 				family = fuse_model;
 			}
 		}
 	}
-	sprintf(buffer, "CN%s%sp%s-%d-%s", family, core_model, pass, clock_mhz, suffix);
+	sprintf(buffer, "CN%s%sp%s-%d-%s", family, core_model, pass,
+		clock_mhz, suffix);
 	return buffer;
 }
 
@@ -507,5 +521,6 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 const char *__init octeon_model_get_string(uint32_t chip_id)
 {
 	static char buffer[32];
+
 	return octeon_model_get_string_buffer(chip_id, buffer);
 }
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 1a52f23..60798ea 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,7 +13,6 @@
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 #ifdef CONFIG_USB
@@ -476,11 +475,13 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 	phandle = be32_to_cpup(phy_handle);
 	phy = fdt_node_offset_by_phandle(initial_boot_params, phandle);
 
-	alt_phy_handle = fdt_getprop(initial_boot_params, eth, "cavium,alt-phy-handle", NULL);
+	alt_phy_handle = fdt_getprop(initial_boot_params, eth,
+				     "cavium,alt-phy-handle", NULL);
 	if (alt_phy_handle) {
 		u32 alt_phandle = be32_to_cpup(alt_phy_handle);
 
-		alt_phy = fdt_node_offset_by_phandle(initial_boot_params, alt_phandle);
+		alt_phy = fdt_node_offset_by_phandle(initial_boot_params,
+						     alt_phandle);
 	} else {
 		alt_phy = -1;
 	}
@@ -489,7 +490,8 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 		/* Delete the PHY things */
 		fdt_nop_property(initial_boot_params, eth, "phy-handle");
 		/* This one may fail */
-		fdt_nop_property(initial_boot_params, eth, "cavium,alt-phy-handle");
+		fdt_nop_property(initial_boot_params, eth,
+				 "cavium,alt-phy-handle");
 		if (phy >= 0)
 			fdt_nop_node(initial_boot_params, phy);
 		if (alt_phy >= 0)
@@ -503,11 +505,13 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 		u32 phy_handle_name;
 
 		/* Use the alt phy node instead.*/
-		phy_prop = fdt_get_property(initial_boot_params, eth, "phy-handle", NULL);
+		phy_prop = fdt_get_property(initial_boot_params, eth,
+					    "phy-handle", NULL);
 		phy_handle_name = phy_prop->nameoff;
 		fdt_nop_node(initial_boot_params, phy);
 		fdt_nop_property(initial_boot_params, eth, "phy-handle");
-		alt_prop = fdt_get_property_w(initial_boot_params, eth, "cavium,alt-phy-handle", NULL);
+		alt_prop = fdt_get_property_w(initial_boot_params, eth,
+					      "cavium,alt-phy-handle", NULL);
 		alt_prop->nameoff = phy_handle_name;
 		phy = alt_phy;
 	}
@@ -718,7 +722,8 @@ int __init octeon_prune_device_tree(void)
 
 	if (OCTEON_IS_MODEL(OCTEON_CN52XX) || OCTEON_IS_MODEL(OCTEON_CN63XX))
 		max_port = 2;
-	else if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN68XX))
+	else if (OCTEON_IS_MODEL(OCTEON_CN56XX) ||
+		 OCTEON_IS_MODEL(OCTEON_CN68XX))
 		max_port = 1;
 	else
 		max_port = 0;
@@ -871,7 +876,7 @@ int __init octeon_prune_device_tree(void)
 
 		base_ptr = 0;
 		if (octeon_bootinfo->major_version == 1
-			&& octeon_bootinfo->minor_version >= 1) {
+		    && octeon_bootinfo->minor_version >= 1) {
 			if (octeon_bootinfo->compact_flash_common_base_addr)
 				base_ptr = octeon_bootinfo->compact_flash_common_base_addr;
 		} else {
@@ -883,7 +888,8 @@ int __init octeon_prune_device_tree(void)
 
 		/* Find CS0 region. */
 		for (cs = 0; cs < 8; cs++) {
-			mio_boot_reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
+			mio_boot_reg_cfg.u64 =
+				cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
 			region_base = mio_boot_reg_cfg.s.base << 16;
 			region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
 			if (mio_boot_reg_cfg.s.en && base_ptr >= region_base
@@ -893,7 +899,10 @@ int __init octeon_prune_device_tree(void)
 			}
 		}
 		if (cs >= 7) {
-			/* cs and cs + 1 are CS0 and CS1, both must be less than 8. */
+			/*
+			 * cs and cs + 1 are CS0 and CS1, both must be
+			 * less than 8.
+			 */
 			goto no_cf;
 		}
 
@@ -914,13 +923,16 @@ int __init octeon_prune_device_tree(void)
 			is_true_ide = true;
 
 		} else {
-			fdt_nop_property(initial_boot_params, cf, "cavium,true-ide");
-			fdt_nop_property(initial_boot_params, cf, "cavium,dma-engine-handle");
+			fdt_nop_property(initial_boot_params, cf,
+					 "cavium,true-ide");
+			fdt_nop_property(initial_boot_params, cf,
+					 "cavium,dma-engine-handle");
 			if (!is_16bit) {
 				__be32 width = cpu_to_be32(8);
 
 				fdt_setprop_inplace(initial_boot_params, cf,
-						"cavium,bus-width", &width, sizeof(width));
+						    "cavium,bus-width",
+						    &width, sizeof(width));
 			}
 		}
 		new_reg[0] = cpu_to_be32(cs);
@@ -935,7 +947,8 @@ int __init octeon_prune_device_tree(void)
 		bootbus = fdt_parent_offset(initial_boot_params, cf);
 		if (bootbus < 0)
 			goto no_cf;
-		ranges = fdt_getprop_w(initial_boot_params, bootbus, "ranges", &len);
+		ranges = fdt_getprop_w(initial_boot_params, bootbus, "ranges",
+				       &len);
 		if (!ranges || len < (5 * 8 * sizeof(__be32)))
 			goto no_cf;
 
@@ -945,7 +958,8 @@ int __init octeon_prune_device_tree(void)
 		if (is_true_ide) {
 			cs++;
 			ranges[(cs * 5) + 2] = cpu_to_be32(region1_base >> 32);
-			ranges[(cs * 5) + 3] = cpu_to_be32(region1_base & 0xffffffff);
+			ranges[(cs * 5) + 3] = cpu_to_be32(region1_base &
+				0xffffffff);
 			ranges[(cs * 5) + 4] = cpu_to_be32(region1_size);
 		}
 		goto end_cf;
@@ -973,7 +987,8 @@ int __init octeon_prune_device_tree(void)
 			goto no_led;
 		/* Find CS0 region. */
 		for (cs = 0; cs < 8; cs++) {
-			mio_boot_reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
+			mio_boot_reg_cfg.u64 =
+				cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
 			region_base = mio_boot_reg_cfg.s.base << 16;
 			region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
 			if (mio_boot_reg_cfg.s.en && base_ptr >= region_base
@@ -996,7 +1011,8 @@ int __init octeon_prune_device_tree(void)
 		bootbus = fdt_parent_offset(initial_boot_params, led);
 		if (bootbus < 0)
 			goto no_led;
-		ranges = fdt_getprop_w(initial_boot_params, bootbus, "ranges", &len);
+		ranges = fdt_getprop_w(initial_boot_params, bootbus, "ranges",
+				       &len);
 		if (!ranges || len < (5 * 8 * sizeof(__be32)))
 			goto no_led;
 
@@ -1019,14 +1035,17 @@ int __init octeon_prune_device_tree(void)
 		int uctl = fdt_path_offset(initial_boot_params, alias_prop);
 
 		if (uctl >= 0 && (!OCTEON_IS_MODEL(OCTEON_CN6XXX) ||
-				  octeon_bootinfo->board_type == CVMX_BOARD_TYPE_NIC2E)) {
+		    octeon_bootinfo->board_type == CVMX_BOARD_TYPE_NIC2E)) {
 			pr_debug("Deleting uctl\n");
 			fdt_nop_node(initial_boot_params, uctl);
 			fdt_nop_property(initial_boot_params, aliases, "uctl");
-		} else if (octeon_bootinfo->board_type == CVMX_BOARD_TYPE_NIC10E ||
-			   octeon_bootinfo->board_type == CVMX_BOARD_TYPE_NIC4E) {
+		} else if (octeon_bootinfo->board_type ==
+			   CVMX_BOARD_TYPE_NIC10E ||
+			   octeon_bootinfo->board_type ==
+			   CVMX_BOARD_TYPE_NIC4E) {
 			/* Missing "refclk-type" defaults to crystal. */
-			fdt_nop_property(initial_boot_params, uctl, "refclk-type");
+			fdt_nop_property(initial_boot_params, uctl,
+					 "refclk-type");
 		}
 	}
 
@@ -1050,11 +1069,13 @@ int __init octeon_prune_device_tree(void)
 			case USB_CLOCK_TYPE_REF_48:
 				new_f[0] = cpu_to_be32(48000000);
 				fdt_setprop_inplace(initial_boot_params, usbn,
-						    "refclk-frequency",  new_f, sizeof(new_f));
+						    "refclk-frequency",
+						    new_f, sizeof(new_f));
 				/* Fall through ...*/
 			case USB_CLOCK_TYPE_REF_12:
-				/* Missing "refclk-type" defaults to external. */
-				fdt_nop_property(initial_boot_params, usbn, "refclk-type");
+				/* Missing "refclk-type" defaults external. */
+				fdt_nop_property(initial_boot_params, usbn,
+						 "refclk-type");
 				break;
 			default:
 				break;
diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
index a6ce7c4..46ca705 100644
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ b/arch/mips/cavium-octeon/octeon_boot.h
@@ -74,8 +74,10 @@ struct linux_app_boot_info {
 #endif
 };
 
-/* If not to copy a lot of bootloader's structures
-   here is only offset of requested member */
+/*
+ * If not to copy a lot of bootloader's structures
+ * here is only offset of requested member.
+ */
 #define AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK	 0x765c
 
 /* hardcoded in bootloader */
@@ -85,9 +87,9 @@ struct linux_app_boot_info {
 
 #define LABI_SIGNATURE 0xAABBCC01
 
-/*  from uboot-headers/octeon_mem_map.h */
+/* from uboot-headers/octeon_mem_map.h */
 #define EXCEPTION_BASE_INCR	(4 * 1024)
-			       /* Increment size for exception base addresses (4k minimum) */
+/* Increment size for exception base addresses (4k minimum) */
 #define EXCEPTION_BASE_BASE	0
 #define BOOTLOADER_PRIV_DATA_BASE	(EXCEPTION_BASE_BASE + 0x800)
 #define BOOTLOADER_BOOT_VECTOR		(BOOTLOADER_PRIV_DATA_BASE)
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 09696cf..4a6bf71 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -92,9 +92,10 @@ static void octeon_kexec_smp_down(void *ignored)
 	while (!atomic_read(&kexec_ready_to_reboot))
 		cpu_relax();
 
-	asm volatile (
-	"	sync						\n"
-	"	synci	($0)					\n");
+	__asm__ __volatile__ (
+		"sync\n"
+		"synci	($0)\n"
+	);
 
 	relocated_kexec_smp_wait(NULL);
 }
@@ -119,8 +120,7 @@ static void kexec_bootmem_init(uint64_t mem_size, uint32_t low_reserved_bytes)
 
 	if (mem_size > OCTEON_MAX_PHY_MEM_SIZE) {
 		mem_size = OCTEON_MAX_PHY_MEM_SIZE;
-		pr_err("Error: requested memory too large,"
-		       "truncating to maximum size\n");
+		pr_err("Requested memory too big, truncate to maximum size\n");
 	}
 
 	bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
@@ -166,7 +166,8 @@ static int octeon_kexec_prepare(struct kimage *image)
 			int argc = 0, offt;
 			char *str = (char *)image->segment[i].buf;
 			char *ptr = strchr(str, ' ');
-			while (ptr && (OCTEON_ARGV_MAX_ARGS > argc)) {
+
+			while (ptr && (argc < OCTEON_ARGV_MAX_ARGS)) {
 				*ptr = '\0';
 				if (ptr[1] != ' ') {
 					offt = (int)(ptr - str + 1);
@@ -254,7 +255,7 @@ static void octeon_shutdown(void)
 	octeon_generic_shutdown();
 #ifdef CONFIG_SMP
 	smp_call_function(octeon_kexec_smp_down, NULL, 0);
-	smp_wmb();
+	smp_wmb();	/* */
 	while (num_online_cpus() > 1) {
 		cpu_relax();
 		mdelay(1);
@@ -287,8 +288,10 @@ EXPORT_SYMBOL(octeon_reserve32_memory);
 #endif
 
 #ifdef CONFIG_KEXEC
-/* crashkernel cmdline parameter is parsed _after_ memory setup
- * we also parse it here (workaround for EHB5200) */
+/*
+ * crashkernel cmdline parameter is parsed _after_ memory setup
+ * we also parse it here (workaround for EHB5200)
+ */
 static uint64_t crashk_size, crashk_base;
 #endif
 
@@ -358,6 +361,7 @@ void octeon_write_lcd(const char *s)
 			ioremap_nocache(octeon_bootinfo->led_display_base_addr,
 					8);
 		int i;
+
 		for (i = 0; i < 8; i++, s++) {
 			if (*s)
 				iowrite8(*s, lcd_address + i);
@@ -407,8 +411,7 @@ void octeon_check_cpu_bist(void)
 
 	bist_val = read_octeon_c0_dcacheerr();
 	if (bist_val & 1)
-		pr_err("Core%d L1 Dcache parity error: "
-		       "CacheErr(dcache) = 0x%llx\n",
+		pr_err("Core%d L1 D$ parity error: CacheErr(dcache) = 0x%llx\n",
 		       coreid, bist_val);
 
 	mask = 0xfc00000000000000ull;
@@ -430,13 +433,14 @@ static void octeon_restart(char *command)
 	/* Disable all watchdogs before soft reset. They don't get cleared */
 #ifdef CONFIG_SMP
 	int cpu;
+
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
 	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
 #endif
 
-	mb();
+	mb();	/* */
 	while (1)
 		if (OCTEON_IS_OCTEON3())
 			cvmx_write_csr(CVMX_RST_SOFT_RST, 1);
@@ -527,21 +531,28 @@ void octeon_user_io_init(void)
 
 	/* Get the current settings for CP0_CVMMEMCTL_REG */
 	cvmmemctl.u64 = read_c0_cvmmemctl();
-	/* R/W If set, marked write-buffer entries time out the same
+	/*
+	 * R/W If set, marked write-buffer entries time out the same
 	 * as as other entries; if clear, marked write-buffer entries
-	 * use the maximum timeout. */
+	 * use the maximum timeout.
+	 */
 	cvmmemctl.s.dismarkwblongto = 1;
-	/* R/W If set, a merged store does not clear the write-buffer
-	 * entry timeout state. */
+	/*
+	 * R/W If set, a merged store does not clear the write-buffer
+	 * entry timeout state.
+	 */
 	cvmmemctl.s.dismrgclrwbto = 0;
-	/* R/W Two bits that are the MSBs of the resultant CVMSEG LM
+	/*
+	 * R/W Two bits that are the MSBs of the resultant CVMSEG LM
 	 * word location for an IOBDMA. The other 8 bits come from the
-	 * SCRADDR field of the IOBDMA. */
+	 * SCRADDR field of the IOBDMA.
+	 */
 	cvmmemctl.s.iobdmascrmsb = 0;
-	/* R/W If set, SYNCWS and SYNCS only order marked stores; if
+	/*
+	 * R/W If set, SYNCWS and SYNCS only order marked stores; if
 	 * clear, SYNCWS and SYNCS only order unmarked
-	 * stores. SYNCWSMARKED has no effect when DISSYNCWS is
-	 * set. */
+	 * stores. SYNCWSMARKED has no effect when DISSYNCWS is set.
+	 */
 	cvmmemctl.s.syncwsmarked = 0;
 	/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as SYNC. */
 	cvmmemctl.s.dissyncws = 0;
@@ -550,44 +561,60 @@ void octeon_user_io_init(void)
 		cvmmemctl.s.diswbfst = 1;
 	else
 		cvmmemctl.s.diswbfst = 0;
-	/* R/W If set (and SX set), supervisor-level loads/stores can
-	 * use XKPHYS addresses with <48>==0 */
+	/*
+	 * R/W If set (and SX set), supervisor-level loads/stores can
+	 * use XKPHYS addresses with <48>==0
+	 */
 	cvmmemctl.s.xkmemenas = 0;
 
-	/* R/W If set (and UX set), user-level loads/stores can use
-	 * XKPHYS addresses with VA<48>==0 */
+	/*
+	 * R/W If set (and UX set), user-level loads/stores can use
+	 * XKPHYS addresses with VA<48>==0
+	 */
 	cvmmemctl.s.xkmemenau = 0;
 
-	/* R/W If set (and SX set), supervisor-level loads/stores can
-	 * use XKPHYS addresses with VA<48>==1 */
+	/*
+	 * R/W If set (and SX set), supervisor-level loads/stores can
+	 * use XKPHYS addresses with VA<48>==1
+	 */
 	cvmmemctl.s.xkioenas = 0;
 
-	/* R/W If set (and UX set), user-level loads/stores can use
-	 * XKPHYS addresses with VA<48>==1 */
+	/*
+	 * R/W If set (and UX set), user-level loads/stores can use
+	 * XKPHYS addresses with VA<48>==1
+	 */
 	cvmmemctl.s.xkioenau = 0;
 
-	/* R/W If set, all stores act as SYNCW (NOMERGE must be set
-	 * when this is set) RW, reset to 0. */
+	/*
+	 * R/W If set, all stores act as SYNCW (NOMERGE must be set
+	 * when this is set) RW, reset to 0.
+	 */
 	cvmmemctl.s.allsyncw = 0;
 
-	/* R/W If set, no stores merge, and all stores reach the
-	 * coherent bus in order. */
+	/*
+	 * R/W If set, no stores merge, and all stores reach the
+	 * coherent bus in order.
+	 */
 	cvmmemctl.s.nomerge = 0;
-	/* R/W Selects the bit in the counter used for DID time-outs 0
+	/*
+	 * R/W Selects the bit in the counter used for DID time-outs 0
 	 * = 231, 1 = 230, 2 = 229, 3 = 214. Actual time-out is
 	 * between 1x and 2x this interval. For example, with
-	 * DIDTTO=3, expiration interval is between 16K and 32K. */
+	 * DIDTTO=3, expiration interval is between 16K and 32K.
+	 */
 	cvmmemctl.s.didtto = 0;
 	/* R/W If set, the (mem) CSR clock never turns off. */
 	cvmmemctl.s.csrckalwys = 0;
 	/* R/W If set, mclk never turns off. */
 	cvmmemctl.s.mclkalwys = 0;
-	/* R/W Selects the bit in the counter used for write buffer
+	/*
+	 * R/W Selects the bit in the counter used for write buffer
 	 * flush time-outs (WBFLT+11) is the bit position in an
 	 * internal counter used to determine expiration. The write
 	 * buffer expires between 1x and 2x this interval. For
 	 * example, with WBFLT = 0, a write buffer expires between 2K
-	 * and 4K cycles after the write buffer entry is allocated. */
+	 * and 4K cycles after the write buffer entry is allocated.
+	 */
 	cvmmemctl.s.wbfltime = 0;
 	/* R/W If set, do not put Istream in the L2 cache. */
 	cvmmemctl.s.istrnol2 = 0;
@@ -603,18 +630,24 @@ void octeon_user_io_init(void)
 	else
 		cvmmemctl.s.wbthresh = 10;
 
-	/* R/W If set, CVMSEG is available for loads/stores in
-	 * kernel/debug mode. */
+	/*
+	 * R/W If set, CVMSEG is available for loads/stores in
+	 * kernel/debug mode.
+	 */
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	cvmmemctl.s.cvmsegenak = 1;
 #else
 	cvmmemctl.s.cvmsegenak = 0;
 #endif
-	/* R/W If set, CVMSEG is available for loads/stores in
-	 * supervisor mode. */
+	/*
+	 * R/W If set, CVMSEG is available for loads/stores in
+	 * supervisor mode.
+	 */
 	cvmmemctl.s.cvmsegenas = 0;
-	/* R/W If set, CVMSEG is available for loads/stores in user
-	 * mode. */
+	/*
+	 * R/W If set, CVMSEG is available for loads/stores in user
+	 * mode.
+	 */
 	cvmmemctl.s.cvmsegenau = 0;
 
 	write_c0_cvmmemctl(cvmmemctl.u64);
@@ -677,7 +710,8 @@ void __init prom_init(void)
 	sysinfo = cvmx_sysinfo_get();
 	memset(sysinfo, 0, sizeof(*sysinfo));
 	sysinfo->system_dram_size = octeon_bootinfo->dram_size << 20;
-	sysinfo->phy_mem_desc_addr = (u64)phys_to_virt(octeon_bootinfo->phy_mem_desc_addr);
+	sysinfo->phy_mem_desc_addr =
+		(u64)phys_to_virt(octeon_bootinfo->phy_mem_desc_addr);
 
 	if ((octeon_bootinfo->major_version > 1) ||
 	    (octeon_bootinfo->major_version == 1 &&
@@ -716,11 +750,13 @@ void __init prom_init(void)
 	if (OCTEON_IS_OCTEON2()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_mio_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else if (OCTEON_IS_OCTEON3()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else {
@@ -928,6 +964,7 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 {
 	if (addr > *mem && addr < *mem + *size) {
 		u64 inc = addr - *mem;
+
 		add_memory_region(*mem, inc, BOOT_MEM_RAM);
 		*mem += inc;
 		*size -= inc;
@@ -1052,7 +1089,7 @@ void __init plat_mem_setup(void)
 			if (memory >= crashk_base && end <= crashk_end)
 				/*
 				 * Entire memory region is within the new
-				 *  kernel's memory, ignore it.
+				 * kernel's memory, ignore it.
 				 */
 				continue;
 
@@ -1061,7 +1098,7 @@ void __init plat_mem_setup(void)
 				/*
 				 * Overlap with the beginning of the region,
 				 * reserve the beginning.
-				  */
+				 */
 				mem_alloc_size -= crashk_end - memory;
 				memory = crashk_end;
 			} else if (memory < crashk_base && end > crashk_base &&
@@ -1101,8 +1138,7 @@ void __init plat_mem_setup(void)
 #endif /* CONFIG_CAVIUM_RESERVE32 */
 
 	if (total == 0)
-		panic("Unable to allocate memory from "
-		      "cvmx_bootmem_phy_alloc");
+		panic("Unable to allocate memory from cvmx_bootmem_phy_alloc");
 }
 
 /*
@@ -1168,9 +1204,11 @@ void __init device_tree_init(void)
 		do_prune = false;
 		fill_mac = true;
 		pr_info("Using appended Device Tree.\n");
-	} else
-#endif
+	} else if (octeon_bootinfo->minor_version >= 3 &&
+		   octeon_bootinfo->fdt_addr) {
+#else
 	if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
+#endif
 		fdt = phys_to_virt(octeon_bootinfo->fdt_addr);
 		if (fdt_check_header(fdt))
 			panic("Corrupt Device Tree passed to kernel.");
@@ -1199,7 +1237,7 @@ void __init device_tree_init(void)
 	init_octeon_system_type();
 }
 
-static int __initdata disable_octeon_edac_p;
+static int disable_octeon_edac_p __initdata;
 
 static int __init disable_octeon_edac(char *str)
 {
@@ -1238,7 +1276,7 @@ static int __init edac_devinit(void)
 		dev = platform_device_register_simple("octeon_lmc_edac",
 						      i, NULL, 0);
 		if (IS_ERR(dev)) {
-			pr_err("Registration of octeon_lmc_edac %d failed!\n", i);
+			pr_err("octeon_lmc_edac %d registration failed!\n", i);
 			err = PTR_ERR(dev);
 		}
 	}
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index f08f175..8e6c484 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -99,10 +99,7 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 void octeon_send_ipi_single(int cpu, unsigned int action)
 {
 	int coreid = cpu_logical_map(cpu);
-	/*
-	pr_info("SMP: Mailbox send cpu=%d, coreid=%d, action=%u\n", cpu,
-	       coreid, action);
-	*/
+
 	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
 }
 
@@ -126,9 +123,10 @@ static void octeon_smp_hotplug_setup(void)
 	if (!setup_max_cpus)
 		return;
 
-	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
+	labi = (struct linux_app_boot_info *)
+			PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
 	if (labi->labi_signature != LABI_SIGNATURE) {
-		pr_info("The bootloader on this board does not support HOTPLUG_CPU.");
+		pr_info("Bootloader does not support HOTPLUG_CPU.");
 		return;
 	}
 
@@ -160,7 +158,8 @@ static void __init octeon_smp_setup(void)
 	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
 	for (id = 0; id < NR_CPUS; id++) {
-		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
+		if (cvmx_coremask_is_core_set(&sysinfo->core_mask, id) &&
+		    (id != coreid)) {
 			set_cpu_possible(cpus, true);
 			set_cpu_present(cpus, true);
 			__cpu_number_map[id] = cpus;
@@ -216,7 +215,7 @@ static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 	octeon_processor_sp = __KSTK_TOS(idle);
 	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
 	octeon_processor_boot = cpu_logical_map(cpu);
-	mb();
+	mb();	/* */
 
 	count = 10000;
 	while (octeon_processor_sp && count) {
@@ -327,19 +326,21 @@ static void octeon_cpu_die(unsigned int cpu)
 	if (!block_desc) {
 		struct linux_app_boot_info *labi;
 
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
+		labi = (struct linux_app_boot_info *)
+			PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
 
 		labi->avail_coremask |= mask;
 		new_mask = labi->avail_coremask;
 	} else {		       /* alternative, already initialized */
-		uint32_t *p = (uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
-							       AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
+		uint32_t *p =
+			(uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
+			AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
 		*p |= mask;
 		new_mask = *p;
 	}
 
-	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
-	mb();
+	pr_info("Reset core %d. Available Coremask = 0x%x\n", coreid, new_mask);
+	mb();	/* */
 	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
 	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
@@ -351,9 +352,7 @@ void play_dead(void)
 	idle_task_exit();
 	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
-
-	mb();
-
+	mb();	/* */
 	while (1)	/* core will be reset here */
 		;
 }
@@ -369,25 +368,26 @@ static int octeon_update_boot_vector(unsigned int cpu)
 	int coreid = cpu_logical_map(cpu);
 	uint32_t avail_coremask;
 	const struct cvmx_bootmem_named_block_desc *block_desc;
-	struct boot_init_vector *boot_vect =
-		(struct boot_init_vector *)PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
+	struct boot_init_vector *boot_vect = (struct boot_init_vector *)
+		PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
 
 	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
 
 	if (!block_desc) {
 		struct linux_app_boot_info *labi;
 
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
+		labi = (struct linux_app_boot_info *)
+			PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
 		avail_coremask = labi->avail_coremask;
 		labi->avail_coremask &= ~(1 << coreid);
 	} else {		       /* alternative, already initialized */
-		avail_coremask = *(uint32_t *)PHYS_TO_XKSEG_CACHED(
-			block_desc->base_addr + AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
+		avail_coremask = *(uint32_t *)
+			PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
+			AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
 	}
 
 	if (!(avail_coremask & (1 << coreid))) {
-		/* core not available, assume, that caught by simple-executive */
+		/* core not available, assume caught by simple-executive */
 		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
 		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 	}
@@ -396,7 +396,7 @@ static int octeon_update_boot_vector(unsigned int cpu)
 		(uint32_t) (unsigned long) start_after_reset;
 	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
 
-	mb();
+	mb();	/* */
 
 	cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid) & avail_coremask);
 
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index a301a8f..07c3242 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -109,7 +109,8 @@ struct boot_mem_map {
 extern struct boot_mem_map boot_mem_map;
 
 extern void add_memory_region(phys_addr_t start, phys_addr_t size, long type);
-extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,  phys_addr_t sz_max);
+extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,
+				 phys_addr_t sz_max);
 
 extern void prom_init(void);
 extern void prom_free_prom_memory(void);
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
index 31eacc2..1d6237f 100644
--- a/arch/mips/include/asm/octeon/cvmx-asm.h
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -24,29 +24,29 @@
  * This file may also be available under a different license from Cavium.
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
-
-/*
- *
- * This is file defines ASM primitives for the executive.
- */
 #ifndef __CVMX_ASM_H__
 #define __CVMX_ASM_H__
 
 #include <asm/octeon/octeon-model.h>
 
 /* other useful stuff */
-#define CVMX_SYNC asm volatile ("sync" : : : "memory")
+#define CVMX_SYNC	__asm__ __volatile__("sync" : : : "memory")
 /* String version of SYNCW macro for using in inline asm constructs */
-#define CVMX_SYNCW_STR "syncw\nsyncw\n"
+#define CVMX_SYNCW_STR	"syncw\nsyncw\n"
+
+#define CVMX_SYNCWS	CVMX_SYNCW
+#define CVMX_SYNCS	CVMX_SYNC
+#define CVMX_SYNCWS_STR	CVMX_SYNCW_STR
+
 #ifdef __OCTEON__
 
 /* Deprecated, will be removed in future release */
-#define CVMX_SYNCIO asm volatile ("nop")
+#define CVMX_SYNCIO	__asm__ __volatile__("nop")
 
-#define CVMX_SYNCIOBDMA asm volatile ("synciobdma" : : : "memory")
+#define CVMX_SYNCIOBDMA	__asm__ __volatile__("synciobdma" : : : "memory")
 
 /* Deprecated, will be removed in future release */
-#define CVMX_SYNCIOALL asm volatile ("nop")
+#define CVMX_SYNCIOALL	__asm__ __volatile__("nop")
 
 /*
  * We actually use two syncw instructions in a row when we need a write
@@ -55,32 +55,26 @@
  * ordering under very rare conditions. Even if it is rare, better safe
  * than sorry.
  */
-#define CVMX_SYNCW asm volatile ("syncw\n\tsyncw" : : : "memory")
+#define CVMX_SYNCW	__asm__ __volatile__("syncw\n\tsyncw" : : : "memory")
 
 /*
  * Define new sync instructions to be normal SYNC instructions for
  * operating systems that use threads.
  */
-#define CVMX_SYNCWS CVMX_SYNCW
-#define CVMX_SYNCS  CVMX_SYNC
-#define CVMX_SYNCWS_STR CVMX_SYNCW_STR
 #else
 /*
  * Not using a Cavium compiler, always use the slower sync so the
  * assembler stays happy.
  */
 /* Deprecated, will be removed in future release */
-#define CVMX_SYNCIO asm volatile ("nop")
+#define CVMX_SYNCIO	__asm__ __volatile__("nop")
 
-#define CVMX_SYNCIOBDMA asm volatile ("sync" : : : "memory")
+#define CVMX_SYNCIOBDMA	__asm__ __volatile__("sync" : : : "memory")
 
 /* Deprecated, will be removed in future release */
-#define CVMX_SYNCIOALL asm volatile ("nop")
+#define CVMX_SYNCIOALL	__asm__ __volatile__("nop")
 
-#define CVMX_SYNCW asm volatile ("sync" : : : "memory")
-#define CVMX_SYNCWS CVMX_SYNCW
-#define CVMX_SYNCS  CVMX_SYNC
-#define CVMX_SYNCWS_STR CVMX_SYNCW_STR
+#define CVMX_SYNCW	__asm__ __volatile__("sync" : : : "memory")
 #endif
 
 /*
@@ -90,50 +84,61 @@
  * unpredictable, but may also change again - up until the point when one
  * of the cores stores to the byte.
  */
-#define CVMX_PREPARE_FOR_STORE(address, offset) \
-	asm volatile ("pref 30, " CVMX_TMP_STR(offset) "(%[rbase])" : : \
-	[rbase] "d" (address))
+#define CVMX_PREPARE_FOR_STORE(address, offset)				       \
+	__asm__ __volatile__("pref 30, " CVMX_TMP_STR(offset) "(%[rbase])" : : \
+		[rbase] "d" (address))
 /*
  * This is a command headed to the L2 controller to tell it to clear
  * its dirty bit for a block. Basically, SW is telling HW that the
  * current version of the block will not be used.
  */
-#define CVMX_DONT_WRITE_BACK(address, offset) \
-	asm volatile ("pref 29, " CVMX_TMP_STR(offset) "(%[rbase])" : : \
-	[rbase] "d" (address))
+#define CVMX_DONT_WRITE_BACK(address, offset)				       \
+	__asm__ __volatile__("pref 29, " CVMX_TMP_STR(offset) "(%[rbase])" : : \
+		[rbase] "d" (address))
 
 /* flush stores, invalidate entire icache */
 #define CVMX_ICACHE_INVALIDATE \
-	{ CVMX_SYNC; asm volatile ("synci 0($0)" : : ); }
+	CVMX_SYNC; __asm__ __volatile__("synci 0($0)" : : );
 
 /* flush stores, invalidate entire icache */
 #define CVMX_ICACHE_INVALIDATE2 \
-	{ CVMX_SYNC; asm volatile ("cache 0, 0($0)" : : ); }
+	CVMX_SYNC; __asm__ __volatile__("cache 0, 0($0)" : : );
 
 /* complete prefetches, invalidate entire dcache */
-#define CVMX_DCACHE_INVALIDATE \
-	{ CVMX_SYNC; asm volatile ("cache 9, 0($0)" : : ); }
+#define CVMX_DCACHE_INVALIDATE	\
+	CVMX_SYNC; __asm__ __volatile__("cache 9, 0($0)" : : );
+
+#define CVMX_CACHE(op, address, offset)					       \
+	__asm__ __volatile__("cache " CVMX_TMP_STR(op) ", "		       \
+		CVMX_TMP_STR(offset) "(%[rbase])" : :			       \
+		[rbase] "d" (address))
 
-#define CVMX_CACHE(op, address, offset)					\
-	asm volatile ("cache " CVMX_TMP_STR(op) ", " CVMX_TMP_STR(offset) "(%[rbase])" \
-		: : [rbase] "d" (address) )
 /* fetch and lock the state. */
 #define CVMX_CACHE_LCKL2(address, offset) CVMX_CACHE(31, address, offset)
 /* unlock the state. */
 #define CVMX_CACHE_WBIL2(address, offset) CVMX_CACHE(23, address, offset)
 /* invalidate the cache block and clear the USED bits for the block */
 #define CVMX_CACHE_WBIL2I(address, offset) CVMX_CACHE(3, address, offset)
-/* load virtual tag and data for the L2 cache block into L2C_TAD0_TAG register */
+/* load virtual tag and data for L2 cache block into L2C_TAD0_TAG register */
 #define CVMX_CACHE_LTGL2I(address, offset) CVMX_CACHE(7, address, offset)
 
-#define CVMX_POP(result, input) \
-	asm ("pop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
-#define CVMX_DPOP(result, input) \
-	asm ("dpop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+#define CVMX_POP(result, input)						       \
+	__asm__ __volatile__("pop %[rd],%[rs]" :			       \
+		[rd] "=d" (result) :					       \
+		[rs] "d" (input))
+
+#define CVMX_DPOP(result, input)					       \
+	__asm__ __volatile__("dpop %[rd],%[rs]" :			       \
+		[rd] "=d" (result) :					       \
+		[rs] "d" (input))
 
 /* some new cop0-like stuff */
-#define CVMX_RDHWR(result, regstr) \
-	asm volatile ("rdhwr %[rt],$" CVMX_TMP_STR(regstr) : [rt] "=d" (result))
-#define CVMX_RDHWRNV(result, regstr) \
-	asm ("rdhwr %[rt],$" CVMX_TMP_STR(regstr) : [rt] "=d" (result))
+#define CVMX_RDHWR(result, regstr)					       \
+	__asm__ __volatile__("rdhwr %[rt],$" CVMX_TMP_STR(regstr) :	       \
+		[rt] "=d" (result))
+
+#define CVMX_RDHWRNV(result, regstr)					       \
+	__asm__ __volatile__("rdhwr %[rt],$" CVMX_TMP_STR(regstr) :	       \
+		[rt] "=d" (result))					       \
+
 #endif /* __CVMX_ASM_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 25854ab..075c381 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2017 Cavium, Inc.
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -86,7 +86,7 @@ enum cvmx_mips_space {
 #define CVMX_MAX_CORES		(16)
 #define CVMX_CACHE_LINE_SIZE	(128)	/* In bytes */
 #define CVMX_CACHE_LINE_MASK	(CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
-#define CVMX_CACHE_LINE_ALIGNED __attribute__ ((aligned(CVMX_CACHE_LINE_SIZE)))
+#define CVMX_CACHE_LINE_ALIGNED __aligned(CVMX_CACHE_LINE_SIZE)
 #define CAST64(v) ((long long)(long)(v))
 #define CASTPTR(type, v) ((type *)(long)(v))
 
@@ -98,6 +98,7 @@ static inline uint32_t cvmx_get_proc_id(void) __attribute__ ((pure));
 static inline uint32_t cvmx_get_proc_id(void)
 {
 	uint32_t id;
+
 	asm("mfc0 %0, $15,0" : "=r"(id));
 	return id;
 }
@@ -180,7 +181,7 @@ static inline uint64_t cvmx_ptr_to_phys(void *ptr)
 	}
 }
 
-/**
+/*
  * Convert a hardware physical address (uint64_t) into a
  * memory pointer (void *).
  *
@@ -202,40 +203,38 @@ static inline void *cvmx_phys_to_ptr(uint64_t physical_address)
 	}
 }
 
-/* The following #if controls the definition of the macro
-    CVMX_BUILD_WRITE64. This macro is used to build a store operation to
-    a full 64bit address. With a 64bit ABI, this can be done with a simple
-    pointer access. 32bit ABIs require more complicated assembly */
-
-/* We have a full 64bit ABI. Writing to a 64bit address can be done with
-    a simple volatile pointer */
+/*
+ * This macro is used to build a store operation to a full 64bit
+ * address. With a 64bit ABI, this can be done with a simple
+ * pointer access. 32bit ABIs require more complicated assembly.
+ */
 #define CVMX_BUILD_WRITE64(TYPE, ST)					\
 static inline void cvmx_write64_##TYPE(uint64_t addr, TYPE##_t val)	\
 {									\
-    *CASTPTR(volatile TYPE##_t, addr) = val;				\
+	*CASTPTR(TYPE##_t, addr) = val;					\
 }
 
 
-/* The following #if controls the definition of the macro
-    CVMX_BUILD_READ64. This macro is used to build a load operation from
-    a full 64bit address. With a 64bit ABI, this can be done with a simple
-    pointer access. 32bit ABIs require more complicated assembly */
-
-/* We have a full 64bit ABI. Writing to a 64bit address can be done with
-    a simple volatile pointer */
-#define CVMX_BUILD_READ64(TYPE, LT)					\
+/*
+ * This macro is used to build a load operation from a full 64bit
+ * address. With a 64bit ABI, this can be done with a simple
+ *  pointer access. 32bit ABIs require more complicated assembly.
+ */
+#define CVMX_BUILD_READ64(TYPE, LD)					\
 static inline TYPE##_t cvmx_read64_##TYPE(uint64_t addr)		\
 {									\
-	return *CASTPTR(volatile TYPE##_t, addr);			\
-}
+	return *CASTPTR(TYPE##_t, addr);				\
+}									\
 
 
-/* The following defines 8 functions for writing to a 64bit address. Each
-    takes two arguments, the address and the value to write.
-    cvmx_write64_int64	    cvmx_write64_uint64
-    cvmx_write64_int32	    cvmx_write64_uint32
-    cvmx_write64_int16	    cvmx_write64_uint16
-    cvmx_write64_int8	    cvmx_write64_uint8 */
+/*
+ * The following defines 8 functions for writing to a 64bit address. Each
+ * takes two arguments, the address and the value to write.
+ *	cvmx_write64_int64	    cvmx_write64_uint64
+ *	cvmx_write64_int32	    cvmx_write64_uint32
+ *	cvmx_write64_int16	    cvmx_write64_uint16
+ *	cvmx_write64_int8	    cvmx_write64_uint8
+ */
 CVMX_BUILD_WRITE64(int64, "sd");
 CVMX_BUILD_WRITE64(int32, "sw");
 CVMX_BUILD_WRITE64(int16, "sh");
@@ -246,12 +245,15 @@ CVMX_BUILD_WRITE64(uint16, "sh");
 CVMX_BUILD_WRITE64(uint8, "sb");
 #define cvmx_write64 cvmx_write64_uint64
 
-/* The following defines 8 functions for reading from a 64bit address. Each
-    takes the address as the only argument
-    cvmx_read64_int64	    cvmx_read64_uint64
-    cvmx_read64_int32	    cvmx_read64_uint32
-    cvmx_read64_int16	    cvmx_read64_uint16
-    cvmx_read64_int8	    cvmx_read64_uint8 */
+/*
+ * The following defines 8 functions for reading from a 64bit address. Each
+ * takes the address as the only argument.
+ *
+ *	cvmx_read64_int64	    cvmx_read64_uint64
+ *	cvmx_read64_int32	    cvmx_read64_uint32
+ *	cvmx_read64_int16	    cvmx_read64_uint16
+ *	cvmx_read64_int8	    cvmx_read64_uint8
+ */
 CVMX_BUILD_READ64(int64, "ld");
 CVMX_BUILD_READ64(int32, "lw");
 CVMX_BUILD_READ64(int16, "lh");
@@ -302,6 +304,7 @@ static inline uint64_t cvmx_readq_csr(void __iomem *csr_addr)
 static inline void cvmx_send_single(uint64_t data)
 {
 	const uint64_t CVMX_IOBDMA_SENDSINGLE = 0xffffffffffffa200ull;
+
 	cvmx_write64(CVMX_IOBDMA_SENDSINGLE, data);
 }
 
@@ -339,6 +342,7 @@ static inline int cvmx_octeon_is_pass1(void)
 static inline unsigned int cvmx_get_core_num(void)
 {
 	unsigned int core_num;
+
 	CVMX_RDHWRNV(core_num, 0);
 	return core_num;
 }
@@ -397,6 +401,7 @@ static inline uint64_t cvmx_read_csr_node(uint64_t node, uint64_t csr_addr)
 static inline uint32_t cvmx_pop(uint32_t val)
 {
 	uint32_t pop;
+
 	CVMX_POP(pop, val);
 	return pop;
 }
@@ -412,6 +417,7 @@ static inline uint32_t cvmx_pop(uint32_t val)
 static inline int cvmx_dpop(uint64_t val)
 {
 	int pop;
+
 	CVMX_DPOP(pop, val);
 	return pop;
 }
@@ -425,6 +431,7 @@ static inline int cvmx_dpop(uint64_t val)
 static inline uint64_t cvmx_get_cycle(void)
 {
 	uint64_t cycle;
+
 	CVMX_RDHWR(cycle, 31);
 	return cycle;
 }
@@ -440,8 +447,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
 {
 	if (cvmx_octeon_is_pass1())
 		return 0;
-	else
-		return cvmx_read64(CVMX_IPD_CLK_COUNT);
+	return cvmx_read64(CVMX_IPD_CLK_COUNT);
 }
 
 /**
@@ -453,27 +459,26 @@ static inline uint64_t cvmx_get_cycle_global(void)
  * 2) Check if ("type".s."field" "op" "value")
  * 3) If #2 isn't true loop to #1 unless too much time has passed.
  */
-#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec)\
-    (									\
-{									\
-	int result;							\
-	do {								\
-		uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec * \
-			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	\
-		type c;							\
-		while (1) {						\
-			c.u64 = cvmx_read_csr(address);			\
-			if ((c.s.field) op(value)) {			\
-				result = 0;				\
-				break;					\
-			} else if (cvmx_get_cycle() > done) {		\
-				result = -1;				\
-				break;					\
-			} else						\
-				__delay(100);				\
-		}							\
-	} while (0);							\
-	result;								\
+#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec)  \
+({									      \
+	int result;							      \
+	do {								      \
+		uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec *   \
+			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	      \
+		type c;							      \
+		while (1) {						      \
+			c.u64 = cvmx_read_csr(address);			      \
+			if ((c.s.field) op(value)) {			      \
+				result = 0;				      \
+				break;					      \
+			} else if (cvmx_get_cycle() > done) {		      \
+				result = -1;				      \
+				break;					      \
+			} else						      \
+				__delay(100);				      \
+		}							      \
+	} while (0);							      \
+	result;								      \
 })
 
 /***************************************************************************/
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 6048150..e9ed14b 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -3,13 +3,13 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008 Cavium Networks
+ * Copyright (C) 2004-2018 Cavium, Inc.
  */
 #ifndef __ASM_OCTEON_OCTEON_H
 #define __ASM_OCTEON_OCTEON_H
 
-#include <asm/octeon/cvmx.h>
 #include <asm/bitfield.h>
+#include <asm/octeon/cvmx.h>
 
 extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
 						uint64_t alignment,
@@ -48,7 +48,7 @@ extern void octeon_user_io_init(void);
 
 extern void octeon_init_cvmcount(void);
 extern void octeon_setup_delays(void);
-extern void octeon_io_clk_delay(unsigned long);
+extern void octeon_io_clk_delay(unsigned long count);
 
 #define OCTEON_ARGV_MAX_ARGS	64
 #define OCTOEN_SERIAL_LEN	20
@@ -180,82 +180,110 @@ union octeon_cvmemctl {
 		__BITFIELD_FIELD(uint64_t wbfbist:1,
 		/* Reserved */
 		__BITFIELD_FIELD(uint64_t reserved:17,
-		/* OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
+		/*
+		 * OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
 		 * This field selects between the TLB replacement policies:
 		 * bitmask LRU or NLU. Bitmask LRU maintains a mask of
 		 * recently used TLB entries and avoids them as new entries
 		 * are allocated. NLU simply guarantees that the next
-		 * allocation is not the last used TLB entry. */
+		 * allocation is not the last used TLB entry.
+		 */
 		__BITFIELD_FIELD(uint64_t tlbnlu:1,
-		/* OCTEON II - Selects the bit in the counter used for
+		/*
+		 * OCTEON II - Selects the bit in the counter used for
 		 * releasing a PAUSE. This counter trips every 2(8+PAUSETIME)
 		 * cycles. If not already released, the cnMIPS II core will
 		 * always release a given PAUSE instruction within
 		 * 2(8+PAUSETIME). If the counter trip happens to line up,
-		 * the cnMIPS II core may release the PAUSE instantly. */
+		 * the cnMIPS II core may release the PAUSE instantly.
+		 */
 		__BITFIELD_FIELD(uint64_t pausetime:3,
-		/* OCTEON II - This field is an extension of
-		 * CvmMemCtl[DIDTTO] */
+		/*
+		 * OCTEON II - This field is an extension of
+		 * CvmMemCtl[DIDTTO]
+		 */
 		__BITFIELD_FIELD(uint64_t didtto2:1,
-		/* R/W If set, marked write-buffer entries time out
+		/*
+		 * R/W If set, marked write-buffer entries time out
 		 * the same as as other entries; if clear, marked
-		 * write-buffer entries use the maximum timeout. */
+		 * write-buffer entries use the maximum timeout.
+		 */
 		__BITFIELD_FIELD(uint64_t dismarkwblongto:1,
-		/* R/W If set, a merged store does not clear the
-		 * write-buffer entry timeout state. */
+		/*
+		 * R/W If set, a merged store does not clear the
+		 * write-buffer entry timeout state.
+		 */
 		__BITFIELD_FIELD(uint64_t dismrgclrwbto:1,
-		/* R/W Two bits that are the MSBs of the resultant
+		/*
+		 * R/W Two bits that are the MSBs of the resultant
 		 * CVMSEG LM word location for an IOBDMA. The other 8
-		 * bits come from the SCRADDR field of the IOBDMA. */
+		 * bits come from the SCRADDR field of the IOBDMA.
+		 */
 		__BITFIELD_FIELD(uint64_t iobdmascrmsb:2,
-		/* R/W If set, SYNCWS and SYNCS only order marked
+		/*
+		 * R/W If set, SYNCWS and SYNCS only order marked
 		 * stores; if clear, SYNCWS and SYNCS only order
 		 * unmarked stores. SYNCWSMARKED has no effect when
-		 * DISSYNCWS is set. */
+		 * DISSYNCWS is set.
+		 */
 		__BITFIELD_FIELD(uint64_t syncwsmarked:1,
-		/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as
-		 * SYNC. */
+		/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as SYNC. */
 		__BITFIELD_FIELD(uint64_t dissyncws:1,
-		/* R/W If set, no stall happens on write buffer
-		 * full. */
+		/* R/W If set, no stall happens on write buffer full. */
 		__BITFIELD_FIELD(uint64_t diswbfst:1,
-		/* R/W If set (and SX set), supervisor-level
+		/*
+		 * R/W If set (and SX set), supervisor-level
 		 * loads/stores can use XKPHYS addresses with
-		 * VA<48>==0 */
+		 * VA<48>==0
+		 */
 		__BITFIELD_FIELD(uint64_t xkmemenas:1,
-		/* R/W If set (and UX set), user-level loads/stores
-		 * can use XKPHYS addresses with VA<48>==0 */
+		/*
+		 * R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==0
+		 */
 		__BITFIELD_FIELD(uint64_t xkmemenau:1,
-		/* R/W If set (and SX set), supervisor-level
+		/*
+		 * R/W If set (and SX set), supervisor-level
 		 * loads/stores can use XKPHYS addresses with
-		 * VA<48>==1 */
+		 * VA<48>==1
+		 */
 		__BITFIELD_FIELD(uint64_t xkioenas:1,
-		/* R/W If set (and UX set), user-level loads/stores
-		 * can use XKPHYS addresses with VA<48>==1 */
+		/*
+		 * R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==1
+		 */
 		__BITFIELD_FIELD(uint64_t xkioenau:1,
-		/* R/W If set, all stores act as SYNCW (NOMERGE must
-		 * be set when this is set) RW, reset to 0. */
+		/*
+		 * R/W If set, all stores act as SYNCW (NOMERGE must
+		 * be set when this is set) RW, reset to 0.
+		 */
 		__BITFIELD_FIELD(uint64_t allsyncw:1,
-		/* R/W If set, no stores merge, and all stores reach
-		 * the coherent bus in order. */
+		/*
+		 * R/W If set, no stores merge, and all stores reach
+		 * the coherent bus in order.
+		 */
 		__BITFIELD_FIELD(uint64_t nomerge:1,
-		/* R/W Selects the bit in the counter used for DID
+		/*
+		 * R/W Selects the bit in the counter used for DID
 		 * time-outs 0 = 231, 1 = 230, 2 = 229, 3 =
 		 * 214. Actual time-out is between 1x and 2x this
 		 * interval. For example, with DIDTTO=3, expiration
-		 * interval is between 16K and 32K. */
+		 * interval is between 16K and 32K.
+		 */
 		__BITFIELD_FIELD(uint64_t didtto:2,
 		/* R/W If set, the (mem) CSR clock never turns off. */
 		__BITFIELD_FIELD(uint64_t csrckalwys:1,
 		/* R/W If set, mclk never turns off. */
 		__BITFIELD_FIELD(uint64_t mclkalwys:1,
-		/* R/W Selects the bit in the counter used for write
+		/*
+		 * R/W Selects the bit in the counter used for write
 		 * buffer flush time-outs (WBFLT+11) is the bit
 		 * position in an internal counter used to determine
 		 * expiration. The write buffer expires between 1x and
 		 * 2x this interval. For example, with WBFLT = 0, a
 		 * write buffer expires between 2K and 4K cycles after
-		 * the write buffer entry is allocated. */
+		 * the write buffer entry is allocated.
+		 */
 		__BITFIELD_FIELD(uint64_t wbfltime:3,
 		/* R/W If set, do not put Istream in the L2 cache. */
 		__BITFIELD_FIELD(uint64_t istrnol2:1,
@@ -263,17 +291,25 @@ union octeon_cvmemctl {
 		__BITFIELD_FIELD(uint64_t wbthresh:4,
 		/* Reserved */
 		__BITFIELD_FIELD(uint64_t reserved2:2,
-		/* R/W If set, CVMSEG is available for loads/stores in
-		 * kernel/debug mode. */
+		/*
+		 * R/W If set, CVMSEG is available for loads/stores in
+		 * kernel/debug mode.
+		 */
 		__BITFIELD_FIELD(uint64_t cvmsegenak:1,
-		/* R/W If set, CVMSEG is available for loads/stores in
-		 * supervisor mode. */
+		/*
+		 * R/W If set, CVMSEG is available for loads/stores in
+		 * supervisor mode.
+		 */
 		__BITFIELD_FIELD(uint64_t cvmsegenas:1,
-		/* R/W If set, CVMSEG is available for loads/stores in
-		 * user mode. */
+		/*
+		 * R/W If set, CVMSEG is available for loads/stores in
+		 * user mode.
+		 */
 		__BITFIELD_FIELD(uint64_t cvmsegenau:1,
-		/* R/W Size of local memory in cache blocks, 54 (6912
-		 * bytes) is max legal value. */
+		/*
+		 * R/W Size of local memory in cache blocks, 54 (6912
+		 * bytes) is max legal value.
+		 */
 		__BITFIELD_FIELD(uint64_t lmemsz:6,
 		;)))))))))))))))))))))))))))))))))
 	} s;
@@ -355,7 +391,8 @@ extern uint64_t octeon_bootloader_entry_addr;
 extern void (*octeon_irq_setup_secondary)(void);
 
 typedef void (*octeon_irq_ip4_handler_t)(void);
-void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t);
+
+void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t h);
 
 extern void octeon_fixup_irqs(void);
 
-- 
2.1.4
