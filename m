Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 22:25:00 +0200 (CEST)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:43840
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992514AbcISUYuJqtG4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Sep 2016 22:24:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VQgcCQsTt6AnqC0AwZ7AAm3/kGHM48kY5jovdsIsONU=;
 b=nw7tGqm8WOAnTSMoJMQqOhOiKS5M/0Tcb3YAnUTN1QyAznI5idz1Kf2skwstDXWw0SjycbTHNYB4Iy+uV9YrpA13wpXYkJCz8Y6B5bMz9pnLEsPFOQKPzMnd7dEG/bE63ZzpI8qOF5/5cl9FVD0fw9g4NhXVOQ6bx4rCJYCNc2c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.629.8; Mon, 19 Sep 2016 20:24:41 +0000
Subject: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC controller.
To:     <linux-mips@linux-mips.org>, <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
Date:   Mon, 19 Sep 2016 15:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BLUPR15CA0056.namprd15.prod.outlook.com (10.162.95.152) To
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147)
X-MS-Office365-Filtering-Correlation-Id: 7ad06e86-cfe0-48f5-8a4e-08d3e0cafd19
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;2:hFssoI04e62IYWJe1z/HwsGpfzuWjP9jutZ+bWGdFTLTbBEMbZDccwwVaHjfrll2m878X9bMzH6K+n+Nn1uBffMf/d1JBVdgOnJaEbwKW5JcJm5Nv/o7f8LPMu0GrXnwM3i4HMBw7ODdSMuixFtLu1+ZsKi3zN7yIuEAVenXlKdE8f9ilpjm30ZDXf7+WMot;3:sqzowJp/Oz7eOSyDa+v5v4qJJMbclhfs98Dn0U3xxkqU5IqKmTQKF32Xp80j6lu+ih0P1qF436bLlb3pGITXeRwzWwKeDeyxNHsFMaTqO7wj55P0eD7ci1K/Add9hXAb;25:h7EBnhyuBe1EYIXBnueLS5D8dSxt1boSDTRoY1TMDsNigDIYM7G6csTWLThFQP23mBqmVoSxPZcWTbqiXo2mPWnb5b5FCfBT1LvUiSd6PQjnGNqyf4gBzcq1jAJdrXDpuCw8nVCqRLnj6pAShuxYxcsfqX5PKDO9B41axtJKi7f9bmSpadDLvLFSxRAe4W0CYS8idbjkDvJHxggRmq53QgMEEY2Z0dJopmoMgRBryulA6KeH0F7KMc0zcvNWZlHLlEhLFhtAJKYv0E0UHAcP7l9iP9n4dA3aCeBjydhyVGmKyxoaEKFFrlHWIPikRgpUQrwWFahdlQewfWYCO2GxIKg2bXJFQLU1XIoCDWd+pvaRDQkeinfSheP1L2YIouzy4zGzqEsPVWwumqM5I7C0ny78WM1E8hyaSf2wBCOQaBU=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;31:4+VfjZpShrVbdiQf0qjOQYZPvQxA3/xyo1DKyRv0UXLzRGBy2myQho988+HYwKcQ/MlF1dmEf8K+smGyH50gZj2s+JTUasen2ataplxMVuZWByTrQBoaA2W02+xfjIm97Ct27qwjaj0uA/yAcXfS5ffnuGux76NYjfqzOC/x+wL6zCjRX5pRTBwMLOxVvGvFXTPlLszsEp0WNdARS0rUBSCTQ9JfDtDb27QwjZjggoM=;20:hUAC/6Jcdz2f+ZH7rNpp69E/H0QmNeV/LKFHgYj3VX7Pb/nhHrYOIzlp3XA15rxZPqDDvVze0vePYb66OM7uF5HgupkWmdvgfdxPVuchzH4vj3SvJSTNa21IA37S/h9MR3eVlWXF71b0miIrhnONRTfceZ6elIS5loh6eiO7UqTzJUBKZ5XpCoaDFkLac1wvM4MJ7yf04x8QENaw98CLfHm+SiuBDEZ2VE0QEed4cM9+zlBXAHQ96ls/kGkxxJ+K2MpVkIQIKH9azFAguvjhFcJOjWXoe7WaBY7vtQYkL5SpQ4UEnsHu9oIC1hq+bQuRHZoO9uV757reXmkz7XUGNzXELMukg/Q67xpKxvVuOEOjBLx3ub0bMbabVgDqYD44+V1YC8jjSegDOuxpYXRAeStJm+xCmuZAUPnTXgKupuuWWnfi/QS/G+zLI0K84yw9p7mVBPkBiQhanZydR87xIjgmzey+ZXQo9DCXUGtqys+aLjgYB3Kh7elKryMfk7Rb
X-Microsoft-Antispam-PRVS: <CY4PR07MB3205ECD635FD65DB533C1CEC80F40@CY4PR07MB3205.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CY4PR07MB3205;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;4:AFcQgD0ZX8trq1TKo+Pm1xNQ9kTSNi31xWPyHj7dZptWcBfrmzg8bsYUvJXMw9JDhZnxuatOki/gb/MG6pFRH0kwnkNlqhOJkIU1g4j2lB4er5rl4Sx4TmSKTqT27vzCg/XaqsSFqq+iodV66gpfS4/yMoZLXAmW31mcTJ5/b3H1FoRH6xooAbLwK1MiFEE1LGmcBDsx/P78C+P7Ulqc9xOSLDaVh7TT0a8m2glF3cyZusDTDso32PDwunba4QfuMfkqGgdlONh2oaVlC2Gh2gs+fALQb+VoeFiHHyb0W11qoEAyK3yasBjMUloG4a0Fzbiekxegeam78bTQvUCprLrQ++26npm0B+tdpbfjXq2pLXwvZJXNzB4VUL0SCxrftCKv7p0AC2Y69KUpfUoLKA==
X-Forefront-PRVS: 0070A8666B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(209900001)(199003)(189002)(86362001)(575784001)(3846002)(31696002)(101416001)(42186005)(68736007)(586003)(2906002)(31686004)(6116002)(64126003)(107886002)(47776003)(65956001)(65806001)(66066001)(5001770100001)(189998001)(50466002)(4001430100002)(54356999)(50986999)(36756003)(97736004)(4001350100001)(4326007)(5660300001)(83506001)(81166006)(65826007)(81156014)(23676002)(229853001)(92566002)(15395725005)(106356001)(7846002)(7736002)(19580405001)(19580395003)(33646002)(230700001)(8676002)(77096005)(105586002)(305945005)(15975445007)(217873001)(2101003)(579004)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3205;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA1OzIzOlRuTzd1WTRRVEkrU29QL0pCdkl3Q3Vkc1NI?=
 =?utf-8?B?eFNPZm9CbGw4Y2J6cmtZejAxalhIdnNNSnZEaTUwTlNyanRSUytzZ2MwcGtm?=
 =?utf-8?B?Z2pSSXU5dUpjbmxaUGRJcHJBWEFHaG4xY3UrNXVpa2tXUTE2ZGtEa0FjY0hH?=
 =?utf-8?B?R1FsSTdudExqM0tWVWt4Zk5qcmR0RzRlZ20vUGhwWklrQXFsdm1uMEZKMU9D?=
 =?utf-8?B?QW9FQ1dBL3ZKZVFKeEhjRUZjZkdkNy8ra0FPWG1TQzNPNXJvdktpOTJpRi9L?=
 =?utf-8?B?Zk8ySlVBTFBpdS9YbUpONnNKcGFXWFpteDZSbHBzamUyeGYwKytRVC9JOUpY?=
 =?utf-8?B?VUxSc1F3blRqZzFSV0dHU2RweG9GR0RPSnlqblkreG5seWZDMnZKdjRMTUxZ?=
 =?utf-8?B?YlJlY2Z2UTVseDB0a1ZPZzBNLzIvWFc0bzZsTkdYSUNUaXR5bFA2ME0vcC90?=
 =?utf-8?B?RmhwMlZaaElXRUxsdDJoMjRSZytLdkJsSDZ2UG1TQzJ3RFQzalR1bHhZWGJQ?=
 =?utf-8?B?VEFIR0Mra0RWMkl6dnhFRmFER1dMQTVKSFZCV0x0QXFxMUNLY2JWRFBCa1RB?=
 =?utf-8?B?M3VIZkExdWN3dS9aN0pqakFFTEpEVVJ4YmJ5T0I2bExaMlhUYmRoVEozT2lk?=
 =?utf-8?B?d3ZGOEpiR29RL0ZzMHA4dlBLbDk3NnhzWFVFNkF2b0ZTQUZyeXR2TVFhZ2Y1?=
 =?utf-8?B?eFg3b1k0dUFYV3NGam85eWlMbm0wMVVvcHpDUEY4SjNBSkFDSDFhRVcxU2kx?=
 =?utf-8?B?OFBzLzZjbmpIZCtpOUpwdWxmSnBkbTJqR3B1b0Izc05qalNCeEJzdjNIZHZm?=
 =?utf-8?B?Z1B0QTNLb3FWQ3J0S1A1M2JTMFVSdUQ2VFhqUDlOZitTRmFJZmVZZVh4amI5?=
 =?utf-8?B?WEFucmxDSTVxdHFwVi9zUlZkVFdMb0F6cHRFN0pxc3pCaGJLa2JjVmF3MXF4?=
 =?utf-8?B?WndJMUV5YlFpZWgyc2dPS1BlcGRuNnJBbEdVZWFQbW00clhMOU92SHloOXV4?=
 =?utf-8?B?czJia2J1eS9qZ21vU3FRK3BBME42elZhWVFKNmVsM096VVd6YVp6ZzVDNm13?=
 =?utf-8?B?M0lmclcrOXNFQWU5aFB2aUZoYStDNmw4Mkw2bmZkYnNzSFVKdEFUSUNsYTF2?=
 =?utf-8?B?T3YrN2d4SkV4Q1RBbHpqWGZRa2c1a3pHbDlLbmJaSXJWc2E5eFJiaVpDL2RC?=
 =?utf-8?B?dUtTRE9Jb082Mk95aE54YnJrWEkxdXd1VmZsVzU1OEI0b2Q1NTVOQlV6T1hD?=
 =?utf-8?B?WHY4djdvSUZ5NEFyY2VXU2NRNkZMRnlpQ2VLSlFmTzdEUFc0TjhqNmNPNUVi?=
 =?utf-8?B?cHpGZ3BvZXRsQXVySlU1dnRocHBZWHYyUDJ0eDNLZGlvaC9zcEhldW5nM2V4?=
 =?utf-8?B?MnVpVW9jRTlYV0k2ejRSUnlGNlMwZ0VkNlVYeWxhWXdPWVVhK2lqNzlTVnhL?=
 =?utf-8?B?R1k0RW9qMS9aZzZVOUl3SEtRajlIbkorQS8rR2NCYVdzRmgwa003d0h2SW9E?=
 =?utf-8?B?SHc5QklFd1RYcFNRU21pbXpBeWxjNG8vdzRjbjZEZXRBcGw3RWVKd0pVaTIv?=
 =?utf-8?B?UkdsT1BFNDNyQ3BIRDdIamlkTFIxUFRpWGhWRENCUjRGSWdWTnFlb1E4OVdr?=
 =?utf-8?B?LzBOOStiNzQrK3laSGhtUUUwcWxSZ0FiZUZyTmdCdDQvMmdMZ2VlVmh4ZnVr?=
 =?utf-8?B?OWtFeFhsMGRoSjhmdlJ6MGRONE5wWGFwVXJLOVB5NjlmZFptN1VhbGtFNzVX?=
 =?utf-8?B?SmdFdEZLMUJpbFcySHYyS0ZqREF6ZTltcFpPQ0FCN1JVZzdQOFlmMFhDUjRh?=
 =?utf-8?B?VE45MkR3eFZlOUs3L2lJRWVBbk9nZERLSlhISCt0NlEvNmNFVUFHUjlTY3lY?=
 =?utf-8?B?ckliZWhacHZRSms1L2hpcE9uK09BTjlpTzlveGsxVkt4T3MzUTBKdkhNS3Bz?=
 =?utf-8?B?c3VsaExzeVRXT2FNVG42WlluTWtNdVdSUzJLV2dKTDhoci9TTk4vZytmcjRT?=
 =?utf-8?Q?9RtgQs?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;6:nJUocogivqMyhw8cgRhiFoRQ9l6JrlhgbU06eZtwQPwAq4B8z979Ws++Pzez7LVuTu3/I/tfft39x2RdDqnqr8ssZHD6zi1+Ka/W8/WoeyUYNti6HRMULXJqFNT5PzXybI2xJJql97X0HNQsw5jlGdhO+zXFcfV53swtppvUzNBHVW/e93YsRcGPtctFxBIucjtyTwHKS9K4BlKcdVtX8OPDHrClTe9y3xzP+h2s9ITT0Fyrd9f2ipM+9X0+Q3NUr1XnckvjfoVUY+CF6rmn/6AkRn8aEq+YYIk7k2mSN74=;5:I+Mdk9q0crRvnl1oJOZzUh5bUFO8ylZKz6CvLjlxcjo7QqYu7PQDyOGFuE1YyukPYikfDm4xevBYa0x1YYwQvm44BUApaCLt9ZVF34ODmJKAKYFjoxAiQ+wQdl6QoRXx4QaRAsjBmUdujDVyiUHesw==;24:DHF8YwZDleCThrZ8yO9k43dLb3A/mbk9Gxwp28kmttZ7/JHDKkR0OxLoGhKp+dniOb9dzlrkAjoPpoF3DlkzaQYq1x/StxNDuDn84Ladbys=;7:TKBzfSZMtx9r8ZW07qDtMHiXVdmjjIhdLIcNVIWRtuNcQJOIzXn/dKoTy0xCqHfrHXseEz3L38yPFXplhZdjvTSOIh89PX6hMgCPmdf/jBmxtZ6jYwSKn2puD7W0wHfSKdBCrxt/5ev5KYVo34lKgeJzkus8oV28MTWw34xVPSjB958UIsIWIOPjHUnHp5edCmnPnRGQbRmKOQSX5qdciVsAvAueNIZWahHQ3vUqlMpoOcH6ItlKJEZHoiYp3Um5AIbltD23HQYlH+3nspp76UmIwN8DkFca9B66pl00rjxihXxKZQLbQgMJmI9lc+VL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2016 20:24:41.6871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3205
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

The OCTEON MMC controller is currently found on cn61XX and cn71XX
devices. Device parameters are configured from device tree data.
eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>

---
v9:
- Implemented changes found in mailing list discussions:

  http://marc.info/?l=linux-mmc&m=147196443305853&w=4
  http://marc.info/?l=linux-mmc&m=147198719513204&w=4
  http://marc.info/?l=linux-mmc&m=147198158311531&w=4

v8:
- Convert driver to use readq()/writeq() functions.
- Work around legacy u-boot device trees.
- Enable EMMC interrupts properly.
- Support DDR signalling. The timings are tighter, so
  there may be failures with some FDT settings.
- Quiesce the device by calling mmc_remove_host() and
  mmc_free_host() when unloading the driver.
- Set MIO_BOOT_CTL on cn70xx to select proper mmc mode
  which is part of acquiring the bus.
- Use of_property_read_u32() helper for cleaner device
  tree accesses.
- Properly implement multi-block DMA. The Octeon's DMA
  enginer cannot do scatter-gather.
- Add driver parameters to limit multi-block transfers.
- Use octeon_bootbus_sem.
- Improve GPIO support and make actual requests to use the
  GPIO lines before using and freeing them after.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/cavium-octeon/Makefile     |    1 +
 arch/mips/cavium-octeon/octeon-mmc.c |  117 ++++
 drivers/mmc/host/Kconfig             |   10 +
 drivers/mmc/host/Makefile            |    1 +
 drivers/mmc/host/octeon_mmc.c        | 1122 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/octeon_mmc.h       |   93 +++
 6 files changed, 1344 insertions(+)
 create mode 100644 arch/mips/cavium-octeon/octeon-mmc.c
 create mode 100644 drivers/mmc/host/octeon_mmc.c
 create mode 100644 include/linux/mmc/octeon_mmc.h

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 2a59265..5f09d26 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -18,3 +18,4 @@ obj-y += crypto/
 obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
+obj-$(CONFIG_MMC_OCTEON)	      += octeon-mmc.o
diff --git a/arch/mips/cavium-octeon/octeon-mmc.c b/arch/mips/cavium-octeon/octeon-mmc.c
new file mode 100644
index 0000000..61ca1c6
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-mmc.c
@@ -0,0 +1,117 @@
+/*
+ * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2016 Cavium Inc.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <linux/mmc/octeon_mmc.h>
+
+#define CVMX_MIO_BOOT_CTL      CVMX_ADD_IO_SEG(0x00011800000000D0ull)
+
+/*
+ * The functions below are used for the EMMC-17978 workaround.
+ *
+ * Due to an imperfection in the design of the MMC bus hardware,
+ * the 2nd to last cache block of a DMA read must be locked into the L2 Cache.
+ * Otherwise, data corruption may occur.
+ */
+
+static inline void *phys_to_ptr(u64 address)
+{
+	return (void *)(address | (1ull<<63)); /* XKPHYS */
+}
+
+/**
+ * Lock a single line into L2. The line is zeroed before locking
+ * to make sure no dram accesses are made.
+ *
+ * @addr   Physical address to lock
+ */
+static void l2c_lock_line(u64 addr)
+{
+	char *addr_ptr = phys_to_ptr(addr);
+	asm volatile (
+		"cache 31, %[line]"	/* Unlock the line */
+		:: [line] "m" (*addr_ptr));
+}
+
+/**
+ * Unlock a single line in the L2 cache.
+ *
+ * @addr	Physical address to unlock
+ *
+ * Return Zero on success
+ */
+static void l2c_unlock_line(u64 addr)
+{
+	char *addr_ptr = phys_to_ptr(addr);
+	asm volatile (
+		"cache 23, %[line]"	/* Unlock the line */
+		:: [line] "m" (*addr_ptr));
+}
+
+/**
+ * Locks a memory region in the L2 cache
+ *
+ * @start - start address to begin locking
+ * @len - length in bytes to lock
+ */
+void l2c_lock_mem_region(u64 start, u64 len)
+{
+	u64 end;
+
+	/* Round start/end to cache line boundaries */
+	end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
+	start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
+
+	while (start <= end) {
+		l2c_lock_line(start);
+		start += CVMX_CACHE_LINE_SIZE;
+	}
+	asm volatile("sync");
+}
+
+/**
+ * Unlock a memory region in the L2 cache
+ *
+ * @start - start address to unlock
+ * @len - length to unlock in bytes
+ */
+void l2c_unlock_mem_region(u64 start, u64 len)
+{
+	u64 end;
+
+	/* Round start/end to cache line boundaries */
+	end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
+	start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
+
+	while (start <= end) {
+		l2c_unlock_line(start);
+		start += CVMX_CACHE_LINE_SIZE;
+	}
+}
+
+void octeon_mmc_acquire_bus(struct octeon_mmc_host *host)
+{
+	if (!host->has_ciu3) {
+		/* Switch the MMC controller onto the bus. */
+		down(&octeon_bootbus_sem);
+		writeq(0, (void __iomem *)CVMX_MIO_BOOT_CTL);
+	} else {
+		down(&host->mmc_serializer);
+	}
+}
+
+void octeon_mmc_release_bus(struct octeon_mmc_host *host)
+{
+	if (!host->has_ciu3)
+		up(&octeon_bootbus_sem);
+	else
+		up(&host->mmc_serializer);
+}
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5274f50..63ac742 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -322,6 +322,16 @@ config MMC_SDHCI_IPROC

 	  If unsure, say N.

+config MMC_OCTEON
+	tristate "Cavium OCTEON Multimedia Card Interface support"
+	depends on CAVIUM_OCTEON_SOC
+	help
+	  This selects Cavium OCTEON Multimedia card Interface.
+	  If you have an OCTEON board with a Multimedia Card slot,
+	  say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_MOXART
 	tristate "MOXART SD/MMC Host Controller support"
 	depends on ARCH_MOXART && MMC
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e2bdaaf..ae6bfb7 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_MTK)		+= mtk-sd.o
+obj-$(CONFIG_MMC_OCTEON)	+= octeon_mmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_OMAP_HS)	+= omap_hsmmc.o
 obj-$(CONFIG_MMC_ATMELMCI)	+= atmel-mci.o
diff --git a/drivers/mmc/host/octeon_mmc.c b/drivers/mmc/host/octeon_mmc.c
new file mode 100644
index 0000000..73f5155
--- /dev/null
+++ b/drivers/mmc/host/octeon_mmc.c
@@ -0,0 +1,1122 @@
+/*
+ * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2016 Cavium Inc.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+#include <linux/gpio/consumer.h>
+
+#include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/octeon_mmc.h>
+
+#define DRV_NAME	"octeon_mmc"
+
+/*
+ * The OCTEON MMC host hardware assumes that all commands have fixed
+ * command and response types.  These are correct if MMC devices are
+ * being used.  However, non-MMC devices like SD use command and
+ * response types that are unexpected by the host hardware.
+ *
+ * The command and response types can be overridden by supplying an
+ * XOR value that is applied to the type.  We calculate the XOR value
+ * from the values in this table and the flags passed from the MMC
+ * core.
+ */
+static struct octeon_mmc_cr_type octeon_mmc_cr_types[] = {
+	{0, 0},		/* CMD0 */
+	{0, 3},		/* CMD1 */
+	{0, 2},		/* CMD2 */
+	{0, 1},		/* CMD3 */
+	{0, 0},		/* CMD4 */
+	{0, 1},		/* CMD5 */
+	{0, 1},		/* CMD6 */
+	{0, 1},		/* CMD7 */
+	{1, 1},		/* CMD8 */
+	{0, 2},		/* CMD9 */
+	{0, 2},		/* CMD10 */
+	{1, 1},		/* CMD11 */
+	{0, 1},		/* CMD12 */
+	{0, 1},		/* CMD13 */
+	{1, 1},		/* CMD14 */
+	{0, 0},		/* CMD15 */
+	{0, 1},		/* CMD16 */
+	{1, 1},		/* CMD17 */
+	{1, 1},		/* CMD18 */
+	{3, 1},		/* CMD19 */
+	{2, 1},		/* CMD20 */
+	{0, 0},		/* CMD21 */
+	{0, 0},		/* CMD22 */
+	{0, 1},		/* CMD23 */
+	{2, 1},		/* CMD24 */
+	{2, 1},		/* CMD25 */
+	{2, 1},		/* CMD26 */
+	{2, 1},		/* CMD27 */
+	{0, 1},		/* CMD28 */
+	{0, 1},		/* CMD29 */
+	{1, 1},		/* CMD30 */
+	{1, 1},		/* CMD31 */
+	{0, 0},		/* CMD32 */
+	{0, 0},		/* CMD33 */
+	{0, 0},		/* CMD34 */
+	{0, 1},		/* CMD35 */
+	{0, 1},		/* CMD36 */
+	{0, 0},		/* CMD37 */
+	{0, 1},		/* CMD38 */
+	{0, 4},		/* CMD39 */
+	{0, 5},		/* CMD40 */
+	{0, 0},		/* CMD41 */
+	{2, 1},		/* CMD42 */
+	{0, 0},		/* CMD43 */
+	{0, 0},		/* CMD44 */
+	{0, 0},		/* CMD45 */
+	{0, 0},		/* CMD46 */
+	{0, 0},		/* CMD47 */
+	{0, 0},		/* CMD48 */
+	{0, 0},		/* CMD49 */
+	{0, 0},		/* CMD50 */
+	{0, 0},		/* CMD51 */
+	{0, 0},		/* CMD52 */
+	{0, 0},		/* CMD53 */
+	{0, 0},		/* CMD54 */
+	{0, 1},		/* CMD55 */
+	{0xff, 0xff},	/* CMD56 */
+	{0, 0},		/* CMD57 */
+	{0, 0},		/* CMD58 */
+	{0, 0},		/* CMD59 */
+	{0, 0},		/* CMD60 */
+	{0, 0},		/* CMD61 */
+	{0, 0},		/* CMD62 */
+	{0, 0}		/* CMD63 */
+};
+
+static struct octeon_mmc_cr_mods octeon_mmc_get_cr_mods(struct mmc_command *cmd)
+{
+	struct octeon_mmc_cr_type *cr;
+	u8 desired_ctype, hardware_ctype;
+	u8 desired_rtype, hardware_rtype;
+	struct octeon_mmc_cr_mods r;
+
+	desired_ctype = desired_rtype = 0;
+
+	cr = octeon_mmc_cr_types + (cmd->opcode & 0x3f);
+	hardware_ctype = cr->ctype;
+	hardware_rtype = cr->rtype;
+	if (cmd->opcode == MMC_GEN_CMD)
+		hardware_ctype = (cmd->arg & 1) ? 1 : 2;
+
+	switch (mmc_cmd_type(cmd)) {
+	case MMC_CMD_ADTC:
+		desired_ctype = (cmd->data->flags & MMC_DATA_WRITE) ? 2 : 1;
+		break;
+	case MMC_CMD_AC:
+	case MMC_CMD_BC:
+	case MMC_CMD_BCR:
+		desired_ctype = 0;
+		break;
+	}
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		desired_rtype = 0;
+		break;
+	case MMC_RSP_R1:/* MMC_RSP_R5, MMC_RSP_R6, MMC_RSP_R7 */
+	case MMC_RSP_R1B:
+		desired_rtype = 1;
+		break;
+	case MMC_RSP_R2:
+		desired_rtype = 2;
+		break;
+	case MMC_RSP_R3: /* MMC_RSP_R4 */
+		desired_rtype = 3;
+		break;
+	}
+	r.ctype_xor = desired_ctype ^ hardware_ctype;
+	r.rtype_xor = desired_rtype ^ hardware_rtype;
+	return r;
+}
+
+static bool octeon_mmc_switch_val_changed(struct octeon_mmc_slot *slot,
+					  u64 new_val)
+{
+	/* Match BUS_ID, HS_TIMING, BUS_WIDTH, POWER_CLASS, CLK_HI, CLK_LO */
+	u64 m = 0x3001070fffffffffull;
+	return (slot->cached_switch & m) != (new_val & m);
+}
+
+static unsigned int octeon_mmc_timeout_to_wdog(struct octeon_mmc_slot *slot,
+					       unsigned int ns)
+{
+	u64 bt = (u64)slot->clock * (u64)ns;
+	return (unsigned int)(bt / 1000000000);
+}
+
+static irqreturn_t octeon_mmc_interrupt(int irq, void *dev_id)
+{
+	struct octeon_mmc_host *host = dev_id;
+	union cvmx_mio_emm_int emm_int;
+	struct mmc_request	*req;
+	bool host_done;
+	union cvmx_mio_emm_rsp_sts rsp_sts;
+	unsigned long flags = 0;
+
+	if (host->need_irq_handler_lock)
+		spin_lock_irqsave(&host->irq_handler_lock, flags);
+	else
+		__acquire(&host->irq_handler_lock);
+	emm_int.u64 = readq(host->base + OCT_MIO_EMM_INT);
+	req = host->current_req;
+	writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT);
+
+	if (!req)
+		goto out;
+
+	rsp_sts.u64 = readq(host->base + OCT_MIO_EMM_RSP_STS);
+
+	if (host->dma_err_pending) {
+		host->current_req = NULL;
+		host->dma_err_pending = false;
+		req->done(req);
+		host_done = true;
+		goto no_req_done;
+	}
+
+	if (!host->dma_active && emm_int.s.buf_done && req->data) {
+		unsigned int type = (rsp_sts.u64 >> 7) & 3;
+
+		if (type == 1) {
+			/* Read */
+			int dbuf = rsp_sts.s.dbuf;
+			struct sg_mapping_iter *smi = &host->smi;
+			unsigned int data_len =
+				req->data->blksz * req->data->blocks;
+			unsigned int bytes_xfered;
+			u64 dat = 0;
+			int shift = -1;
+
+			/* Auto inc from offset zero */
+			writeq((u64)(0x10000 | (dbuf << 6)),
+			       host->base + OCT_MIO_EMM_BUF_IDX);
+
+			for (bytes_xfered = 0; bytes_xfered < data_len;) {
+				if (smi->consumed >= smi->length) {
+					if (!sg_miter_next(smi))
+						break;
+					smi->consumed = 0;
+				}
+				if (shift < 0) {
+					dat = readq(host->base +
+						    OCT_MIO_EMM_BUF_DAT);
+					shift = 56;
+				}
+
+				while (smi->consumed < smi->length &&
+					shift >= 0) {
+					((u8 *)(smi->addr))[smi->consumed] =
+						(dat >> shift) & 0xff;
+					bytes_xfered++;
+					smi->consumed++;
+					shift -= 8;
+				}
+			}
+			sg_miter_stop(smi);
+			req->data->bytes_xfered = bytes_xfered;
+			req->data->error = 0;
+		} else if (type == 2) {
+			/* write */
+			req->data->bytes_xfered = req->data->blksz *
+				req->data->blocks;
+			req->data->error = 0;
+		}
+	}
+	host_done = emm_int.s.cmd_done || emm_int.s.dma_done ||
+		emm_int.s.cmd_err || emm_int.s.dma_err;
+	if (host_done && req->done) {
+		if (rsp_sts.s.rsp_bad_sts ||
+		    rsp_sts.s.rsp_crc_err ||
+		    rsp_sts.s.rsp_timeout ||
+		    rsp_sts.s.blk_crc_err ||
+		    rsp_sts.s.blk_timeout ||
+		    rsp_sts.s.dbuf_err) {
+			req->cmd->error = -EILSEQ;
+		} else {
+			req->cmd->error = 0;
+		}
+
+		if (host->dma_active && req->data) {
+			req->data->error = 0;
+			req->data->bytes_xfered = req->data->blocks *
+				req->data->blksz;
+			if (!(req->data->flags & MMC_DATA_WRITE) &&
+				req->data->sg_len > 1) {
+				size_t r = sg_copy_from_buffer(req->data->sg,
+					req->data->sg_len, host->linear_buf,
+					req->data->bytes_xfered);
+				WARN_ON(r != req->data->bytes_xfered);
+			}
+		}
+		if (rsp_sts.s.rsp_val) {
+			u64 rsp_hi;
+			u64 rsp_lo = readq(host->base + OCT_MIO_EMM_RSP_LO);
+
+			switch (rsp_sts.s.rsp_type) {
+			case 1:
+			case 3:
+				req->cmd->resp[0] = (rsp_lo >> 8) & 0xffffffff;
+				req->cmd->resp[1] = 0;
+				req->cmd->resp[2] = 0;
+				req->cmd->resp[3] = 0;
+				break;
+			case 2:
+				req->cmd->resp[3] = rsp_lo & 0xffffffff;
+				req->cmd->resp[2] = (rsp_lo >> 32) & 0xffffffff;
+				rsp_hi = readq(host->base + OCT_MIO_EMM_RSP_HI);
+				req->cmd->resp[1] = rsp_hi & 0xffffffff;
+				req->cmd->resp[0] = (rsp_hi >> 32) & 0xffffffff;
+			default:
+				break;
+			}
+		}
+		if (emm_int.s.dma_err && rsp_sts.s.dma_pend) {
+			/* Try to clean up failed DMA */
+			union cvmx_mio_emm_dma emm_dma;
+
+			emm_dma.u64 = readq(host->base + OCT_MIO_EMM_DMA);
+			emm_dma.s.dma_val = 1;
+			emm_dma.s.dat_null = 1;
+			emm_dma.s.bus_id = rsp_sts.s.bus_id;
+			writeq(emm_dma.u64, host->base + OCT_MIO_EMM_DMA);
+			host->dma_err_pending = true;
+			host_done = false;
+			goto no_req_done;
+		}
+
+		host->current_req = NULL;
+		req->done(req);
+	}
+no_req_done:
+	if (host->n_minus_one) {
+		l2c_unlock_mem_region(host->n_minus_one, 512);
+		host->n_minus_one = 0;
+	}
+	if (host_done)
+		octeon_mmc_release_bus(host);
+out:
+	if (host->need_irq_handler_lock)
+		spin_unlock_irqrestore(&host->irq_handler_lock, flags);
+	else
+		__release(&host->irq_handler_lock);
+	return IRQ_RETVAL(emm_int.u64 != 0);
+}
+
+static void octeon_mmc_switch_to(struct octeon_mmc_slot	*slot)
+{
+	struct octeon_mmc_host *host = slot->host;
+	struct octeon_mmc_slot *old_slot;
+	union cvmx_mio_emm_switch sw;
+	union cvmx_mio_emm_sample samp;
+
+	octeon_mmc_acquire_bus(host);
+	if (slot->bus_id == host->last_slot)
+		goto out;
+
+	if (host->last_slot >= 0 && host->slot[host->last_slot]) {
+		old_slot = host->slot[host->last_slot];
+		old_slot->cached_switch = readq(host->base + OCT_MIO_EMM_SWITCH);
+		old_slot->cached_rca = readq(host->base + OCT_MIO_EMM_RCA);
+	}
+	writeq(slot->cached_rca, host->base + OCT_MIO_EMM_RCA);
+	sw.u64 = slot->cached_switch;
+	sw.s.bus_id = 0;
+	writeq(sw.u64, host->base + OCT_MIO_EMM_SWITCH);
+	sw.s.bus_id = slot->bus_id;
+	writeq(sw.u64, host->base + OCT_MIO_EMM_SWITCH);
+
+	samp.u64 = 0;
+	samp.s.cmd_cnt = slot->cmd_cnt;
+	samp.s.dat_cnt = slot->dat_cnt;
+	writeq(samp.u64, host->base + OCT_MIO_EMM_SAMPLE);
+out:
+	host->last_slot = slot->bus_id;
+}
+
+static void octeon_mmc_dma_request(struct mmc_host *mmc,
+				   struct mmc_request *mrq)
+{
+	struct octeon_mmc_slot	*slot;
+	struct octeon_mmc_host	*host;
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+	union cvmx_mio_emm_int emm_int;
+	union cvmx_mio_emm_dma emm_dma;
+	union cvmx_mio_ndf_dma_cfg dma_cfg;
+
+	cmd = mrq->cmd;
+	if (mrq->data == NULL || mrq->data->sg == NULL || !mrq->data->sg_len ||
+	    mrq->stop == NULL || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
+		dev_err(&mmc->card->dev,
+			"Error: octeon_mmc_dma_request no data\n");
+		cmd->error = -EINVAL;
+		if (mrq->done)
+			mrq->done(mrq);
+		return;
+	}
+
+	slot = mmc_priv(mmc);
+	host = slot->host;
+
+	/* Only a single user of the bootbus at a time. */
+	octeon_mmc_switch_to(slot);
+
+	data = mrq->data;
+
+	if (data->timeout_ns)
+		writeq(octeon_mmc_timeout_to_wdog(slot, data->timeout_ns),
+		       host->base + OCT_MIO_EMM_WDOG);
+
+	WARN_ON(host->current_req);
+	host->current_req = mrq;
+
+	host->sg_idx = 0;
+
+	WARN_ON(data->blksz * data->blocks > host->linear_buf_size);
+
+	if ((data->flags & MMC_DATA_WRITE) && data->sg_len > 1) {
+		size_t r = sg_copy_to_buffer(data->sg, data->sg_len,
+			 host->linear_buf, data->blksz * data->blocks);
+		WARN_ON(data->blksz * data->blocks != r);
+	}
+
+	dma_cfg.u64 = 0;
+	dma_cfg.s.en = 1;
+	dma_cfg.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+#ifdef __LITTLE_ENDIAN
+	dma_cfg.s.endian = 1;
+#endif
+	dma_cfg.s.size = ((data->blksz * data->blocks) / 8) - 1;
+	if (!host->big_dma_addr) {
+		if (data->sg_len > 1)
+			dma_cfg.s.adr = virt_to_phys(host->linear_buf);
+		else
+			dma_cfg.s.adr = sg_phys(data->sg);
+	}
+	writeq(dma_cfg.u64, host->ndf_base + OCT_MIO_NDF_DMA_CFG);
+	if (host->big_dma_addr) {
+		u64 addr;
+
+		if (data->sg_len > 1)
+			addr = virt_to_phys(host->linear_buf);
+		else
+			addr = sg_phys(data->sg);
+		writeq(addr, host->ndf_base + OCT_MIO_EMM_DMA_ADR);
+	}
+
+	/*
+	 * Our MMC host hardware does not issue single commands,
+	 * because that would require the driver and the MMC core
+	 * to do work to determine the proper sequence of commands.
+	 * Instead, our hardware is superior to most other MMC bus
+	 * hosts. The sequence of MMC commands required to execute
+	 * a transfer are issued automatically by the bus hardware.
+	 *
+	 * - David Daney <ddaney@cavium.com>
+	 */
+	emm_dma.u64 = 0;
+	emm_dma.s.bus_id = slot->bus_id;
+	emm_dma.s.dma_val = 1;
+	emm_dma.s.sector = mmc_card_blockaddr(mmc->card) ? 1 : 0;
+	emm_dma.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+	if (mmc_card_mmc(mmc->card) ||
+	    (mmc_card_sd(mmc->card) &&
+		(mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
+		emm_dma.s.multi = 1;
+	emm_dma.s.block_cnt = data->blocks;
+	emm_dma.s.card_addr = cmd->arg;
+
+	emm_int.u64 = 0;
+	emm_int.s.dma_done = 1;
+	emm_int.s.cmd_err = 1;
+	emm_int.s.dma_err = 1;
+
+	/* Clear the bit. */
+	writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT);
+	if (!host->has_ciu3)
+		writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT_EN);
+	host->dma_active = true;
+
+	if ((OCTEON_IS_MODEL(OCTEON_CN6XXX) ||
+		OCTEON_IS_MODEL(OCTEON_CNF7XXX)) &&
+	    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK &&
+	    (data->blksz * data->blocks) > 1024) {
+		host->n_minus_one = dma_cfg.s.adr +
+			(data->blksz * data->blocks) - 1024;
+		l2c_lock_mem_region(host->n_minus_one, 512);
+	}
+
+	/*
+	 * If we have a valid SD card in the slot, we
+	 * set the response bit mask to check for CRC
+	 * errors and timeouts only. Otherwise, use the
+	 * default power reset value.
+	 */
+	if (mmc->card && mmc_card_sd(mmc->card))
+		writeq(0x00b00000ull, host->base + OCT_MIO_EMM_STS_MASK);
+	else
+		writeq(0xe4390080ull, host->base + OCT_MIO_EMM_STS_MASK);
+	writeq(emm_dma.u64, host->base + OCT_MIO_EMM_DMA);
+}
+
+static void octeon_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct octeon_mmc_slot	*slot;
+	struct octeon_mmc_host	*host;
+	struct mmc_command *cmd;
+	union cvmx_mio_emm_int emm_int;
+	union cvmx_mio_emm_cmd emm_cmd;
+	struct octeon_mmc_cr_mods mods;
+
+	cmd = mrq->cmd;
+
+	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+		cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+		octeon_mmc_dma_request(mmc, mrq);
+		return;
+	}
+
+	mods = octeon_mmc_get_cr_mods(cmd);
+
+	slot = mmc_priv(mmc);
+	host = slot->host;
+
+	/* Only a single user of the bootbus at a time. */
+	octeon_mmc_switch_to(slot);
+
+	WARN_ON(host->current_req);
+	host->current_req = mrq;
+
+	emm_int.u64 = 0;
+	emm_int.s.cmd_done = 1;
+	emm_int.s.cmd_err = 1;
+	if (cmd->data) {
+		if (cmd->data->flags & MMC_DATA_READ) {
+			sg_miter_start(&host->smi, mrq->data->sg,
+				       mrq->data->sg_len,
+				       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		} else {
+			struct sg_mapping_iter *smi = &host->smi;
+			unsigned int data_len =
+				mrq->data->blksz * mrq->data->blocks;
+			unsigned int bytes_xfered;
+			u64 dat = 0;
+			int shift = 56;
+			/*
+			 * Copy data to the xmit buffer before
+			 * issuing the command
+			 */
+			sg_miter_start(smi, mrq->data->sg,
+				       mrq->data->sg_len, SG_MITER_FROM_SG);
+			/* Auto inc from offset zero, dbuf zero */
+			writeq(0x10000ull, host->base + OCT_MIO_EMM_BUF_IDX);
+
+			for (bytes_xfered = 0; bytes_xfered < data_len;) {
+				if (smi->consumed >= smi->length) {
+					if (!sg_miter_next(smi))
+						break;
+					smi->consumed = 0;
+				}
+
+				while (smi->consumed < smi->length &&
+					shift >= 0) {
+
+					dat |= (u64)(((u8 *)(smi->addr))
+						[smi->consumed]) << shift;
+					bytes_xfered++;
+					smi->consumed++;
+					shift -= 8;
+				}
+				if (shift < 0) {
+					writeq(dat, host->base +
+					       OCT_MIO_EMM_BUF_DAT);
+					shift = 56;
+					dat = 0;
+				}
+			}
+			sg_miter_stop(smi);
+		}
+		if (cmd->data->timeout_ns)
+			writeq(octeon_mmc_timeout_to_wdog(slot,
+			       cmd->data->timeout_ns),
+			       host->base + OCT_MIO_EMM_WDOG);
+	} else {
+		writeq(((u64)slot->clock * 850ull) / 1000ull,
+		       host->base + OCT_MIO_EMM_WDOG);
+	}
+	/* Clear the bit. */
+	writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT);
+	writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT_EN);
+	host->dma_active = false;
+
+	emm_cmd.u64 = 0;
+	emm_cmd.s.cmd_val = 1;
+	emm_cmd.s.ctype_xor = mods.ctype_xor;
+	emm_cmd.s.rtype_xor = mods.rtype_xor;
+	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
+		emm_cmd.s.offset = 64 -
+			((cmd->data->blksz * cmd->data->blocks) / 8);
+	emm_cmd.s.bus_id = slot->bus_id;
+	emm_cmd.s.cmd_idx = cmd->opcode;
+	emm_cmd.s.arg = cmd->arg;
+	writeq(0, host->base + OCT_MIO_EMM_STS_MASK);
+	writeq(emm_cmd.u64, host->base + OCT_MIO_EMM_CMD);
+}
+
+static void octeon_mmc_reset_bus(struct octeon_mmc_slot *slot)
+{
+	union cvmx_mio_emm_cfg emm_cfg;
+	union cvmx_mio_emm_switch emm_switch;
+	u64 wdog = 0;
+
+	emm_cfg.u64 = readq(slot->host->base + OCT_MIO_EMM_CFG);
+	emm_switch.u64 = readq(slot->host->base + OCT_MIO_EMM_SWITCH);
+	wdog = readq(slot->host->base + OCT_MIO_EMM_WDOG);
+
+	emm_switch.s.switch_exe = 0;
+	emm_switch.s.switch_err0 = 0;
+	emm_switch.s.switch_err1 = 0;
+	emm_switch.s.switch_err2 = 0;
+	emm_switch.s.bus_id = 0;
+	writeq(emm_switch.u64, slot->host->base + OCT_MIO_EMM_SWITCH);
+	emm_switch.s.bus_id = slot->bus_id;
+	writeq(emm_switch.u64, slot->host->base + OCT_MIO_EMM_SWITCH);
+
+	slot->cached_switch = emm_switch.u64;
+
+	msleep(20);
+
+	writeq(wdog, slot->host->base + OCT_MIO_EMM_WDOG);
+}
+
+static void octeon_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct octeon_mmc_slot	*slot;
+	struct octeon_mmc_host	*host;
+	int bus_width;
+	int clock;
+	int power_class = 10;
+	int clk_period;
+	int timeout = 2000;
+	union cvmx_mio_emm_switch emm_switch;
+	union cvmx_mio_emm_rsp_sts emm_sts;
+
+	slot = mmc_priv(mmc);
+	host = slot->host;
+
+	/* Only a single user of the bootbus at a time. */
+	octeon_mmc_switch_to(slot);
+
+	/*
+	 * Reset the chip on each POWER_OFF.
+	 */
+	if (ios->power_mode == MMC_POWER_OFF) {
+		octeon_mmc_reset_bus(slot);
+		gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+	} else
+		gpiod_set_value_cansleep(host->global_pwr_gpiod, 1);
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_8:
+		bus_width = 2;
+		break;
+	case MMC_BUS_WIDTH_4:
+		bus_width = 1;
+		break;
+	case MMC_BUS_WIDTH_1:
+		bus_width = 0;
+		break;
+	default:
+		bus_width = 0;
+		break;
+	}
+	slot->bus_width = bus_width;
+
+	if (ios->clock) {
+		/* Change the clock frequency. */
+		clock = ios->clock;
+		if (clock > 52000000)
+			clock = 52000000;
+		slot->clock = clock;
+		clk_period = (octeon_get_io_clock_rate() + clock - 1) /
+			(2 * clock);
+
+		emm_switch.u64 = 0;
+		emm_switch.s.hs_timing = (ios->timing == MMC_TIMING_MMC_HS);
+		emm_switch.s.bus_width = bus_width;
+		emm_switch.s.power_class = power_class;
+		emm_switch.s.clk_hi = clk_period;
+		emm_switch.s.clk_lo = clk_period;
+
+		if (!octeon_mmc_switch_val_changed(slot, emm_switch.u64))
+			goto out;
+
+		writeq(((u64)clock * 850ull) / 1000ull,
+		       host->base + OCT_MIO_EMM_WDOG);
+		writeq(emm_switch.u64, host->base + OCT_MIO_EMM_SWITCH);
+		emm_switch.s.bus_id = slot->bus_id;
+		writeq(emm_switch.u64, host->base + OCT_MIO_EMM_SWITCH);
+		slot->cached_switch = emm_switch.u64;
+
+		do {
+			emm_sts.u64 = readq(host->base + OCT_MIO_EMM_RSP_STS);
+			if (!emm_sts.s.switch_val)
+				break;
+			udelay(100);
+		} while (timeout-- > 0);
+
+		if (timeout <= 0)
+			goto out;
+	}
+out:
+	octeon_mmc_release_bus(host);
+}
+
+static const struct mmc_host_ops octeon_mmc_ops = {
+	.request        = octeon_mmc_request,
+	.set_ios        = octeon_mmc_set_ios,
+	.get_ro		= mmc_gpio_get_ro,
+	.get_cd		= mmc_gpio_get_cd,
+};
+
+static void octeon_mmc_set_clock(struct octeon_mmc_slot *slot,
+				 unsigned int clock)
+{
+	struct mmc_host *mmc = slot->mmc;
+
+	clock = min(clock, mmc->f_max);
+	clock = max(clock, mmc->f_min);
+	slot->clock = clock;
+}
+
+static int octeon_mmc_initlowlevel(struct octeon_mmc_slot *slot)
+{
+	union cvmx_mio_emm_switch emm_switch;
+	struct octeon_mmc_host *host = slot->host;
+
+	/* Enable this bus slot. */
+	host->emm_cfg |= (1ull << slot->bus_id);
+	writeq(host->emm_cfg, slot->host->base + OCT_MIO_EMM_CFG);
+
+	/* Program initial clock speed and power. */
+	octeon_mmc_set_clock(slot, slot->mmc->f_min);
+	emm_switch.u64 = 0;
+	emm_switch.s.power_class = 10;
+	emm_switch.s.clk_hi = (slot->sclock / slot->clock) / 2;
+	emm_switch.s.clk_lo = (slot->sclock / slot->clock) / 2;
+	writeq(emm_switch.u64, host->base + OCT_MIO_EMM_SWITCH);
+
+	/* Make the changes take effect on this bus slot. */
+	emm_switch.s.bus_id = slot->bus_id;
+	writeq(emm_switch.u64, host->base + OCT_MIO_EMM_SWITCH);
+	slot->cached_switch = emm_switch.u64;
+
+	/*
+	 * Set watchdog timeout value and default reset value
+	 * for the mask register. Finally, set the CARD_RCA
+	 * bit so that we can get the card address relative
+	 * to the CMD register for CMD7 transactions.
+	 */
+	writeq(((u64)slot->clock * 850ull) / 1000ull,
+	       host->base + OCT_MIO_EMM_WDOG);
+	writeq(0xe4390080ull, host->base + OCT_MIO_EMM_STS_MASK);
+	writeq(1, host->base + OCT_MIO_EMM_RCA);
+	return 0;
+}
+
+static int octeon_mmc_slot_probe(struct platform_device *slot_pdev,
+				 struct octeon_mmc_host *host)
+{
+	struct mmc_host *mmc;
+	struct octeon_mmc_slot *slot;
+	struct device *dev = &slot_pdev->dev;
+	struct device_node *node = slot_pdev->dev.of_node;
+	u32 id, bus_width, cmd_skew, dat_skew;
+	u64 clock_period;
+	int ret;
+
+	ret = of_property_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_err(dev, "Missing or invalid reg property on %s\n",
+			of_node_full_name(node));
+		return ret;
+	}
+
+	if (id >= OCTEON_MAX_MMC || host->slot[id]) {
+		dev_err(dev, "Invalid reg property on %s\n",
+			of_node_full_name(node));
+		return -EINVAL;
+	}
+
+	mmc = mmc_alloc_host(sizeof(struct octeon_mmc_slot), dev);
+	if (!mmc) {
+		dev_err(dev, "alloc host failed\n");
+		return -ENOMEM;
+	}
+
+	slot = mmc_priv(mmc);
+	slot->mmc = mmc;
+	slot->host = host;
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto err;
+
+	/*
+	 * The "cavium,bus-max-width" property is DEPRECATED and should
+	 * not be used. We handle it here to support older firmware.
+	 * Going forward, the standard "bus-width" property is used
+	 * instead of the Cavium-specific property.
+	 */
+	if (!(mmc->caps & (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA))) {
+		/* Try legacy "cavium,bus-max-width" property. */
+		ret = of_property_read_u32(node, "cavium,bus-max-width",
+					   &bus_width);
+		if (ret) {
+			/* No bus width specified, use default. */
+			bus_width = 8;
+			dev_info(dev, "Default width 8 used for slot %u\n", id);
+		}
+	} else {
+		/* Hosts capable of 8-bit transfers can also do 4 bits */
+		bus_width = (mmc->caps & MMC_CAP_8_BIT_DATA) ? 8 : 4;
+	}
+
+	switch (bus_width) {
+	case 8:
+		slot->bus_width = (MMC_BUS_WIDTH_8 - 1);
+		mmc->caps = MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
+		break;
+	case 4:
+		slot->bus_width = (MMC_BUS_WIDTH_4 - 1);
+		mmc->caps = MMC_CAP_4_BIT_DATA;
+		break;
+	case 1:
+		slot->bus_width = MMC_BUS_WIDTH_1;
+		break;
+	default:
+		dev_err(dev, "Invalid bus width for slot %u\n", id);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * The "spi-max-frequency" property is DEPRECATED and should
+	 * not be used. We handle it here to support older firmware.
+	 * Going forward, the standard "max-frequency" property is
+	 * used instead of the Cavium-specific property.
+	 */
+	if (mmc->f_max == 0) {
+		/* Try legacy "spi-max-frequency" property. */
+		ret = of_property_read_u32(node, "spi-max-frequency",
+					   &mmc->f_max);
+		if (ret) {
+			/* No frequency properties found, use default. */
+			mmc->f_max = 52000000;
+			dev_info(dev, "Default %u frequency used for slot %u\n",
+				 mmc->f_max, id);
+		}
+	} else if (mmc->f_max > 52000000)
+		mmc->f_max = 52000000;
+
+	/* Set minimum frequency. */
+	mmc->f_min = 400000;
+
+	/* Octeon-specific DT properties. */
+	ret = of_property_read_u32(node, "cavium,cmd-clk-skew", &cmd_skew);
+	if (ret)
+		cmd_skew = 0;
+	ret = of_property_read_u32(node, "cavium,dat-clk-skew", &dat_skew);
+	if (ret)
+		dat_skew = 0;
+
+	/*
+	 * We only have a 3.3v supply, so we are calling this mostly
+	 * to get a sane OCR mask for other parts of the MMC subsytem.
+	 */
+	ret = mmc_of_parse_voltage(node, &mmc->ocr_avail);
+	if (ret == -EINVAL)
+		goto err;
+
+	/*
+	 * We do not have a voltage regulator, just a single
+	 * GPIO line to control power to all of the slots. It
+	 * is registered in the platform code. We can, however,
+	 * still set the POWER_OFF capability as long as the
+	 * GPIO was registered correctly.
+	 */
+	if (!IS_ERR(host->global_pwr_gpiod)) {
+		mmc->caps |= MMC_CAP_POWER_OFF_CARD;
+		dev_info(dev, "Got GLOBAL POWER GPIO\n");
+	}
+	else
+		dev_info(dev, "Did not get GLOBAL POWER GPIO\n");
+
+	/* Set up host parameters. */
+	mmc->ops = &octeon_mmc_ops;
+
+	/*
+	 * We only have a 3.3v supply, we cannot support any
+	 & of the UHS modes. We do support the high speed DDR
+	 * modes up to 52MHz.
+	 */
+	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+		     MMC_CAP_ERASE;
+
+	mmc->max_segs = 64;
+	mmc->max_seg_size = host->linear_buf_size;
+	mmc->max_req_size = host->linear_buf_size;
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = mmc->max_req_size / 512;
+
+	slot->clock = mmc->f_min;
+	slot->sclock = octeon_get_io_clock_rate();
+
+	/* Period in picoseconds. */
+	clock_period = 1000000000000ull / slot->sclock;
+	slot->cmd_cnt = (cmd_skew + clock_period / 2) / clock_period;
+	slot->dat_cnt = (dat_skew + clock_period / 2) / clock_period;
+
+	slot->bus_id = id;
+	slot->cached_rca = 1;
+
+	/* Only a single user of the bootbus at a time. */
+	host->slot[id] = slot;
+	octeon_mmc_switch_to(slot);
+
+	/* Initialize MMC Block. */
+	octeon_mmc_initlowlevel(slot);
+
+	octeon_mmc_release_bus(host);
+
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(dev, "mmc_add_host() returned %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	slot->host->slot[id] = NULL;
+
+	gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+
+	mmc_free_host(slot->mmc);
+	return ret;
+}
+
+static int octeon_mmc_slot_remove(struct octeon_mmc_slot *slot)
+{
+	mmc_remove_host(slot->mmc);
+	slot->host->slot[slot->bus_id] = NULL;
+	gpiod_set_value_cansleep(slot->host->global_pwr_gpiod, 0);
+	mmc_free_host(slot->mmc);
+
+	return 0;
+}
+
+static int octeon_mmc_probe(struct platform_device *pdev)
+{
+	struct octeon_mmc_host *host;
+	struct resource	*res;
+	void __iomem *base;
+	int mmc_irq[9];
+	int i;
+	int ret = 0;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *cn;
+	u64 t;
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host) {
+		dev_err(&pdev->dev, "devm_kzalloc failed\n");
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&host->irq_handler_lock);
+	sema_init(&host->mmc_serializer, 1);
+
+	if (of_device_is_compatible(node, "cavium,octeon-7890-mmc")) {
+		host->big_dma_addr = true;
+		host->need_irq_handler_lock = true;
+		host->has_ciu3 = true;
+		/*
+		 * First seven are the EMM_INT bits 0..6, then two for
+		 * the EMM_DMA_INT bits
+		 */
+		for (i = 0; i < 9; i++) {
+			mmc_irq[i] = platform_get_irq(pdev, i);
+			if (mmc_irq[i] < 0)
+				return mmc_irq[i];
+
+			/* work around legacy u-boot device trees */
+			irq_set_irq_type(mmc_irq[i], IRQ_TYPE_EDGE_RISING);
+		}
+	} else {
+		host->big_dma_addr = false;
+		host->need_irq_handler_lock = false;
+		host->has_ciu3 = false;
+		/* First one is EMM second NDF_DMA */
+		for (i = 0; i < 2; i++) {
+			mmc_irq[i] = platform_get_irq(pdev, i);
+			if (mmc_irq[i] < 0)
+				return mmc_irq[i];
+		}
+	}
+	host->last_slot = -1;
+
+	/* 256KB DMA linearized buffer (maximum transfer size). */
+	host->linear_buf_size = (1 << 18);
+	host->linear_buf = devm_kzalloc(&pdev->dev, host->linear_buf_size,
+					GFP_KERNEL);
+
+	if (!host->linear_buf) {
+		dev_err(&pdev->dev, "devm_kzalloc failed\n");
+		return -ENOMEM;
+	}
+
+	host->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
+		return -ENXIO;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	host->base = (void __iomem *)base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[1] is missing\n");
+		return -EINVAL;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	host->ndf_base = (void __iomem *)base;
+
+	/*
+	 * Clear out any pending interrupts that may be left over from
+	 * bootloader.
+	 */
+	t = readq(host->base + OCT_MIO_EMM_INT);
+	writeq(t, host->base + OCT_MIO_EMM_INT);
+	if (host->has_ciu3) {
+		/* Only CMD_DONE, DMA_DONE, CMD_ERR, DMA_ERR */
+		for (i = 1; i <= 4; i++) {
+			ret = devm_request_irq(&pdev->dev, mmc_irq[i],
+					       octeon_mmc_interrupt,
+					       0, DRV_NAME, host);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+					mmc_irq[i]);
+				return ret;
+			}
+		}
+	} else {
+		ret = devm_request_irq(&pdev->dev, mmc_irq[0],
+				       octeon_mmc_interrupt, 0, DRV_NAME, host);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+				mmc_irq[0]);
+			return ret;
+		}
+	}
+
+	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev, "power",
+								GPIOD_OUT_HIGH);
+	if (IS_ERR(host->global_pwr_gpiod)) {
+		dev_err(&host->pdev->dev, "Invalid POWER GPIO\n");
+		return PTR_ERR(host->global_pwr_gpiod);
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	for_each_child_of_node(node, cn) {
+		struct platform_device *slot_pdev;
+
+		slot_pdev = of_platform_device_create(cn, NULL, &pdev->dev);
+		ret = octeon_mmc_slot_probe(slot_pdev, host);
+		if (ret) {
+			dev_err(&host->pdev->dev, "Error populating slots\n");
+			gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int octeon_mmc_remove(struct platform_device *pdev)
+{
+	union cvmx_mio_ndf_dma_cfg ndf_dma_cfg;
+	struct octeon_mmc_host *host = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < OCTEON_MAX_MMC; i++) {
+		if (host->slot[i])
+			octeon_mmc_slot_remove(host->slot[i]);
+	}
+
+	ndf_dma_cfg.u64 = readq(host->ndf_base + OCT_MIO_NDF_DMA_CFG);
+	ndf_dma_cfg.s.en = 0;
+	writeq(ndf_dma_cfg.u64, host->ndf_base + OCT_MIO_NDF_DMA_CFG);
+
+	gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+
+	return 0;
+}
+
+static const struct of_device_id octeon_mmc_match[] = {
+	{
+		.compatible = "cavium,octeon-6130-mmc",
+	},
+	{
+		.compatible = "cavium,octeon-7890-mmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mmc_match);
+
+static struct platform_driver octeon_mmc_driver = {
+	.probe		= octeon_mmc_probe,
+	.remove		= octeon_mmc_remove,
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = octeon_mmc_match,
+	},
+};
+
+static int __init octeon_mmc_init(void)
+{
+	return platform_driver_register(&octeon_mmc_driver);
+}
+
+static void __exit octeon_mmc_cleanup(void)
+{
+	platform_driver_unregister(&octeon_mmc_driver);
+}
+
+module_init(octeon_mmc_init);
+module_exit(octeon_mmc_cleanup);
+
+MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("low-level driver for Cavium OCTEON MMC/SSD card");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mmc/octeon_mmc.h b/include/linux/mmc/octeon_mmc.h
new file mode 100644
index 0000000..d650ab1
--- /dev/null
+++ b/include/linux/mmc/octeon_mmc.h
@@ -0,0 +1,93 @@
+/*
+ * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2016 Cavium Inc.
+ */
+#include <linux/io.h>
+#include <linux/scatterlist.h>
+#include <linux/mmc/host.h>
+
+#include <asm/octeon/octeon.h>
+
+#define OCTEON_MAX_MMC			4
+
+#define OCT_MIO_NDF_DMA_CFG		0x00
+#define OCT_MIO_EMM_DMA_ADR		0x08
+
+#define OCT_MIO_EMM_CFG			0x00
+#define OCT_MIO_EMM_SWITCH		0x48
+#define OCT_MIO_EMM_DMA			0x50
+#define OCT_MIO_EMM_CMD			0x58
+#define OCT_MIO_EMM_RSP_STS		0x60
+#define OCT_MIO_EMM_RSP_LO		0x68
+#define OCT_MIO_EMM_RSP_HI		0x70
+#define OCT_MIO_EMM_INT			0x78
+#define OCT_MIO_EMM_INT_EN		0x80
+#define OCT_MIO_EMM_WDOG		0x88
+#define OCT_MIO_EMM_SAMPLE		0x90
+#define OCT_MIO_EMM_STS_MASK		0x98
+#define OCT_MIO_EMM_RCA			0xa0
+#define OCT_MIO_EMM_BUF_IDX		0xe0
+#define OCT_MIO_EMM_BUF_DAT		0xe8
+
+struct octeon_mmc_host {
+	void __iomem	*base;
+	void __iomem	*ndf_base;
+	u64	emm_cfg;
+	u64	n_minus_one;  /* OCTEON II workaround location */
+	int	last_slot;
+
+	struct semaphore mmc_serializer;
+	struct mmc_request	*current_req;
+	unsigned int		linear_buf_size;
+	void			*linear_buf;
+	struct sg_mapping_iter smi;
+	int sg_idx;
+	bool dma_active;
+
+	struct platform_device	*pdev;
+	struct gpio_desc *global_pwr_gpiod;
+	bool dma_err_pending;
+	bool big_dma_addr;
+	bool need_irq_handler_lock;
+	spinlock_t irq_handler_lock;
+	bool has_ciu3;
+
+	struct octeon_mmc_slot	*slot[OCTEON_MAX_MMC];
+};
+
+struct octeon_mmc_slot {
+	struct mmc_host         *mmc;	/* slot-level mmc_core object */
+	struct octeon_mmc_host	*host;	/* common hw for all 4 slots */
+
+	unsigned int		clock;
+	unsigned int		sclock;
+
+	u64			cached_switch;
+	u64			cached_rca;
+
+	unsigned int		cmd_cnt; /* sample delay */
+	unsigned int		dat_cnt; /* sample delay */
+
+	int			bus_width;
+	int			bus_id;
+};
+
+struct octeon_mmc_cr_type {
+	u8 ctype;
+	u8 rtype;
+};
+
+struct octeon_mmc_cr_mods {
+	u8 ctype_xor;
+	u8 rtype_xor;
+};
+
+extern void l2c_lock_mem_region(u64 start, u64 len);
+extern void l2c_unlock_mem_region(u64 start, u64 len);
+extern void octeon_mmc_acquire_bus(struct octeon_mmc_host *host);
+extern void octeon_mmc_release_bus(struct octeon_mmc_host *host);
-- 
1.9.1
