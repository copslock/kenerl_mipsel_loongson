Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 18:37:12 +0100 (CET)
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:1444
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993890AbdAQRhFLmxr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 18:37:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dMZRV6horAbNQ5aMCgmB99iCm8TOQR4dSIs2Ht5IllI=;
 b=UqIiI0AX+joeYEyw3bN1EkGSNEDyzuMlCRHlvTiLZyON+kk74fHpGnaxBOSzB6Ui+cslP4Nyge1X/F2Y6Fjnhh1Y0Gviw6OcUDPiZqHEpXxe9sJaQwGpryYeI3tewTlAwivvdKqxopdYjODm3B0+TrXzfdb401KNU6ITibkJqsw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.9) by
 VI1PR07MB1328.eurprd07.prod.outlook.com (10.164.92.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.6; Tue, 17 Jan 2017 17:36:58 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Alexander Sverdlin <alexander.sverdlin@nsn.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] octeon: prom_putchar() must be void
Date:   Tue, 17 Jan 2017 18:36:44 +0100
Message-ID: <20170117173644.27984-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.9]
X-ClientProxiedBy: AM4PR0501CA0028.eurprd05.prod.outlook.com (10.167.83.166)
 To VI1PR07MB1328.eurprd07.prod.outlook.com (10.164.92.142)
X-MS-Office365-Filtering-Correlation-Id: db8abcc4-9675-42e9-1e70-08d43eff706f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:VI1PR07MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;3:4LHYeUsIbOduCKFbxh+s/IjuxOj5690wi18dZNN4zp82DSniSJN7Xi0Fj0Enyxq8KQaxjfxU42Yl9PWGWz7tRMz7/F88TPMrz92o72v113rpwevXvb8cR1euPiVCjV4ufPoXXu4r8n0+EkgCcwdzO8Qk9sDwjNqR6+V+ukTSUwxaGz7ZQxoB25ZSdXeMW6s7OgYmhUVkRVz3y8ezRvoi0ShBJaAtQ+yCnX9iwG4o3FBqnpTm30XgjmrW4qdnvWc7N8+oxCGc+PlgwR0P6APDzg==;25:S5bG8mzCVUE5jGBLXwAfHkXSNcW6jdPm+hrwi0QSi35Y0pYqpKejjLt0VvQb3kr20kx9WcWxCwDFEdzcqOqOiRp1r7bSK8QjqBuaWyj7uyuXU/DCjDMFnZ018rJQ0FQW+fCh/m2QkTEgaBHDiFWlk7iCAmLNqApwEzuRmoS2rmFbxG4LhvknoU/DCBFFQEBDp88O83a2Iu7ApNd5cyswcoZqoR9RCewIiC6f/985Z+3/HdnJY4YsR28WE//zSvObQ4qGVdF6b5ZR5XmoTh1JO4iWOB3mV1hiaz6covEG0G7pX0ChyeqV9nlSi3TJ6u/bK6hmopRGlw7lo061+q/Csihir+ZcKmJo/bi49P7iu5ZHAA8ddIoBQgcDvC8SpFuwM5jdLjONx+9xYE/mMR23rPS8eEZjn4JjrRRprvE2VloHP6FcT6kQlc1w6q40ZcK68cAKB2Z/WYWhH8TnfkMlCQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;31:NvvbvoMNkWJDH9R0gWql5T8JjRFCS4FHp5ZFWa8RN2vx5IHCTX2J0qj8Wq7gEPr5u7dok9kp3eof8b71WvyHMrRR7VAwdzpo/l9kuc5/J9M/b236hVlPouTyc0P0gQRhGxOyxU2FLN5Y84VAkXU2kh2rIPlzXsZWmowfrj5uzIDJVFWqVcXVKjpXKnp3VHISwubHuSKFNHti4E2OUWwJCKGdypiUc+JdFj0gPtQqZnlNxjHVJRRDYAPlMWk/bWYm;20:7Zu8EoBzSwFtCNdd5Edvu73BhJuqFnerH46w8uiDG+zavjbUC1sYzDq/hgd8i3Lk1NVbRw015ycIWbu4ZFW6tLRt6LS8XsLv8ot6OjKCKqgdeYWWakAxHagngD5W5iJQPCQMwzinikOq9ws63KAKKv3e8uD9vCqQY7OxgJ1RgHC4W4CCVceEycgKBIU2WEtG3KhgIBsLK3cWj3uwGgpYejhSsHCK6nXCtxp329H51bIz0AglcZbsc/prYEJFn8OA/D6lUdr9KpU4X437C3dmTc0s59V6yROca8GNA3hAcI/ET1Czv1dMTFSmPHaaWi/eoL1QkO/ktY7roD3AhiXuvPjkCUP9UAVGj7eksHdypJQWCVYFvAnM4NkIp6uwB/r9IzDa9erofJL6dBITLO1UqUEC/0qpZ9Ah75xienhk5AExCDGdO/XBz9UpKmfZ5Kcxm506LhqFYrJzyx2PL3lteFwaSxDlEZ5AgCavV1nqNIHvNx8kzlyNxXtG5h0nm7rxtjkS0o1sFrXEmAQylDtNGMCQTrYIj30F96sd8hZMbbtI9a6sLrlfdNw5BFMRxb65Nad5ylt2kPBmGZ9JyMG8bSMEM4WtiG3KMAljhEPKBOI=
X-Microsoft-Antispam-PRVS: <VI1PR07MB13281087BBF43844D1751613887C0@VI1PR07MB1328.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:VI1PR07MB1328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;4:IG4uKaosxrTMZqFMeVBxzxgQoC7ssRK5wPUQhcAOz9i/zIqtur8/uv33UItmEt8mR/NGtARCUJJvMTeZbb/ez8JMEVPXrahRLa5KKfdo0vbqzK18YACpi1oaEIUHzT5ps2iZhNNrW28RYqpzZ76e30afR0nGc3ig4E+mdwQtTEhJ2WQ+I69Yji+5yO3QvWxNuyeo+Dx0fl28CY6DlRsVEh9h9Xd1zkxg+1K5zLy7wbsO5pbkcR8gmF06ibhj9nb5ltqRTd8M1gs7/1c4DKylnnrALdAKe/GxSXJ/SFoK0Uka3WDpu3St3lj3bf+9OqNC9iOZJB3lh62k2Xfzyh3TbRy6Ei5GfK7bdng713ao7eqSNrZ5TdgWa+EnK7nXaz/vQdwuCw2DU1/x8TXa2NFSnmByh3plDJFIrEZYxyOt0fMBtfAS4Db5g6cHrMER3E+Yd4K+NYXj40s5glo3Ahjkvd+dn0IzS7GicigMfgUjedXzBGIUsjk3ZCbe1XmlIBZouzp8owUKVfO9aclOZUwV670hRvmQUWDyRmvFUzjnvKYkLdAeEFYEhz43XYt7EURXn5sitNHjaMPrnsJ5kKK+75VHPmMQFgvxbBnHUX6Ct8EpdKI8XWP3ywliTRFgL479HkfQx0yQvGypw1nIrjPJYQ==
X-Forefront-PRVS: 01901B3451
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(39450400003)(39410400002)(39850400002)(39860400002)(39840400002)(199003)(189002)(110136003)(5660300001)(81166006)(7736002)(50986999)(36756003)(5003940100001)(8676002)(81156014)(50226002)(6666003)(92566002)(4326007)(2906002)(6512007)(106356001)(109986004)(105586002)(68736007)(38730400001)(25786008)(1671002)(3846002)(50466002)(6116002)(6506006)(48376002)(1076002)(101416001)(6486002)(33646002)(305945005)(86362001)(54906002)(97736004)(42186005)(66066001)(47776003)(189998001)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1328;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1328;23:wUGxNYNz5kXTY0txVjpSCHrQJ8IvnqQ5r995auCPr?=
 =?us-ascii?Q?Hq/VNs2OhSdq5RzL5lxH0bGukvCFSiK/A64lHNJAFRuJUPQD3k+D35lmihCC?=
 =?us-ascii?Q?s7seVSQ79YHDiae97MKPKu2RqHti6+e60+pY7Fn11adsqnTeToXWR7w3Vl7E?=
 =?us-ascii?Q?bS7B2vnlyDCBFSAR0y6UDKq2qna7WmJikSH8b6M/xTDY/YgzZC3Q575GnrmD?=
 =?us-ascii?Q?H0HFeU0ogYU2+2bwuOJsqcnCr0Xow7sr31mSR2qJqNHDG4VaZqR2o+Dy5YMT?=
 =?us-ascii?Q?cVWZYsK5hY1UmKZ2nGKA+3yqLx8Fx59OrG+uD8FwLPeL3bY6/xxQNz0+RMt5?=
 =?us-ascii?Q?M+9xEjdoxxcYruvWfGhHLHaA0DsR1LZAfLiGI+6Rcg+134dxm3Y3gNoS6FNp?=
 =?us-ascii?Q?pWBzgbrYcNtwGO2g5Fyofupr7UOE/NzVYUZviWMGOFXDN+d2I5dfWSM8Wm7W?=
 =?us-ascii?Q?yErZPH4qzZVFh0LUNV7UUrnX0OkY/zgnVcM62JdmzBaIH4WBcDCDCsWe8756?=
 =?us-ascii?Q?Px/ak+CY4ATVSlNWq24kV3ORlqTGeM3cWE3Bqzv2MYhI6VsXIrJFy5IGMfZ1?=
 =?us-ascii?Q?mzbTPIZSVvzpb6HL4nm29fdXEHySkYBtRXUk/P0fyMmim+zD8YmjJ9fEZF4Q?=
 =?us-ascii?Q?YwqdE0okNQ4yw1fIMviPCN1SvtapCyWG39FJy8/tqN3lJweuuXYzJannHdm+?=
 =?us-ascii?Q?k51+SAzGSU/n+cdcZoju8HZCdIb0vfouccoLAwsJH/ks6wD4IG9a4XLZjMy1?=
 =?us-ascii?Q?mMQMchb4jgX6ykue7XopwZq4FavKkB4huDJZnqItXw30eULc+x5U5T/uFZnv?=
 =?us-ascii?Q?CN96crLWPHQOX20jXuFnxP2m9Pc+NDXo0EFdGC3LJHGXUQdouhVDhlTCKo9n?=
 =?us-ascii?Q?2G5SLJ7E2hYkzGvgyUGLzrdflaglOWFG3uviRY1Ia1cvcqx+oM+j5SldvN9C?=
 =?us-ascii?Q?MICWvM67kbCl51zKg6wqfGE8n9brG+psnqUAZmiz41uSxlV0XItzOT8kiQjm?=
 =?us-ascii?Q?UXOb6GVO28Mka5Wo3fNA7bEbeZkuwTUjAnDwTBoc47eMw2HAwHquJ+fatQnO?=
 =?us-ascii?Q?WpoXa3B/DPzgX2ZEwNQnnnnHZrpQDM9hnr6e94DfgduWrv6zugY4EURIaLP1?=
 =?us-ascii?Q?TEc6HkUaRrcMrYTF4pvpbzHC5gZuSSMz9kuvrWkA8JtqBRjg6X3qENf8ZMl8?=
 =?us-ascii?Q?6VqRcIeyj80d5nk3s4wgoBlfKBYdyhSiptl?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;6:Wlfp0U+GrrMMq4aSNmGeobtdeWF1oyi+VzhmzvWfB5SFYc59hpTeB//EBORhe5/wYcLlnE0S006Npwyuj+PB0v/hNhWoQz6iPbD/yRJCnfX5QukK1n2XjjZqJPJK4P66wn5XFERq5FNtlunLKNR9a4m5HgE3bysLBZTZZKgYhMOhr7yPq1MXFBgPx7BkL7YOVPyy4a96svqtSrRy9mDrF3ffFy8OZ2A3PASoLOhBuJY0hXiXSp7dN0F0h0HiTLxnTcPPqzZlrLjczixfoNBMhM8kdIiA8mInvUjCRVyOEO23adHHB2BBWIYMDA1Efn4qpcBY/Ue2xJs+Ob/f63uVZmChjVRefq2suKMFfnyT2NQSFLi/L3vE+U4Ahwrd95fzkhk/ccDjjkwkP00+fQ/VspV5qiOQNYh0lXfzFW2SHX2HoNTX5V6R5x4Ao0TtDXtulLyg/rPGu22WuWEoy2VxCw==;5:oA4hXOztXwjfLD46EA0jSqei/IDkOljSC4t8v1YxOn6z/9eajc+JeQ/1+s0uvCu6Tgo3dmAsOOpicaBxfQxklTqHd/LTc2LicYQUj7vK2JPwb79bAtoPoxcsZSP6hShFsIoqX6sR92nyzpS6mL1eTQ==;24:1z4NcaoTtsun+rDVcO5kujjtHS8xuoBTLVVxsg/X6MwMpm0XoyegETggEDsCFyDOEPNMiMmlf79mQEDrSKSx58WDxmq3Rz7bg4wkofhkYe4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;7:rX8SQMt2HbBzmqjUv1K4Gn3aaaUpoagFsrsAD7kKGAeEfS61vyzblWjAPfV1ytH5UmsENtK0QndtDlWPQi9xnmnKG+AI2u+yQjX4pPobpuMG37RDfqKwYhhVGvAQfMhaIcP29+G7KzuZA3EvAElKhz1JwtXcYnbIBp2mAOIDcd1KEHZTFAaIRE/SE3jmLjwDL1PGPag3OIw0ZP46DMerrY+EJKVy6WRApomvZ/g1awUUrdwRswN7MZEaKVAwWWTvNuae16wu7Jg+R9aY2TkbHp3WGeD8bcKNW3I1gx6ZASojzZdTGZstG1tiYjG35KwZJ/G9nKUDXKYEBhcOsTYcVFrDfKFDGi406UYHwvH7JCZHEYfHhCE8crOyrSYgGo2UCVu5uHcsYrTcq1xVpmkAcJ6E5S5LF2hWWHqGkIxg9lJj0pGjAglascX23utvCVEsyzkuZSHcG9EzBAirHfzCkw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2017 17:36:58.2569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1328
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

From: Alexander Sverdlin <alexander.sverdlin@nsn.com>

Correct the function return type.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "Steven J. Hill" <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/cavium-octeon/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 9a2db1c013d9..bb613d3e5246 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1095,7 +1095,7 @@ void __init plat_mem_setup(void)
  * Emit one character to the boot UART.	 Exported for use by the
  * watchdog timer.
  */
-int prom_putchar(char c)
+void prom_putchar(char c)
 {
 	uint64_t lsrval;
 
@@ -1106,7 +1106,6 @@ int prom_putchar(char c)
 
 	/* Write the byte */
 	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c & 0xffull);
-	return 1;
 }
 EXPORT_SYMBOL(prom_putchar);
 
-- 
2.11.0
