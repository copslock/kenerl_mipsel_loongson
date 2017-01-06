Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2017 00:42:45 +0100 (CET)
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:58048
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992328AbdAFXmgLLOBM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 7 Jan 2017 00:42:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gC1YPSgk4Ff1ckSWVl2YJdN44npsVjS5rkoA9zM9+3E=;
 b=X15im6UdAPJa72MealczpdVsrhD/84m5tZvgz42ZmI8su8eNtU3DI2e+lhpXU0OLTGLiKA/PpFukrrNuVJa3otUDOPVwbMbMuUfclul2rj+q4SU1Qg8sN6hRdoCcfVGZZhyoYQxsdp5oIbPEqo1MijpDrvSA8tJp8HOnHHs6z+k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.817.10; Fri, 6 Jan 2017 23:42:28 +0000
Subject: [PATCH] MIPS: OCTEON: Platform support for DWC3 USB controller.
To:     <linux-mips@linux-mips.org>
CC:     <linux-usb@vger.kernel.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <ee4bb10f-aa3e-3f22-4ee1-7d2d397c466c@cavium.com>
Date:   Fri, 6 Jan 2017 17:42:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BY2PR02CA0104.namprd02.prod.outlook.com (10.163.44.158) To
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150)
X-MS-Office365-Filtering-Correlation-Id: eb6e9cd7-191f-4ff4-d7b1-08d4368dad0c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;3:7v1dDgTZ/lgdRngUVcuVD/qf/C9XDOx9NTFERA35XVv1HP3yIRYsyr6QAJ2HrYVtdCn4MM+rHJQS9XRpyECI7BrlWA3RmRgMEdky9Xx8spvPtoUFzhZFvVpjfKne087qGJcBUwJ+suNMaREaF/91kM6eb/s1iW3+TTW+sT1apsI6hEazFZ8VuZa8nCVvgj/lqKpCF95pZ/EouWSRhm1DsZQcMxBL9d9qCTgh+qid07sk+nyHv1u3VlwyWphmMO7MOk5jcfG8qXMw8I75sY5h1A==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;25:OrmEY6xcYid7ckgzV5s5pR96DdzUc5Tarmfm2zBhMUBQkkhiEwPuy+oMdFyGGMC5dcM2DjGXz9T6dDjeEsEZmmI6gEsfhp0KMowgU+3ZWbKiYkSYO/PM7NplxeEDciHkWFF3WDEc0BgRTylhTx5wTRvHWkw36DpHT8WQKK4wI+HCg3hwiS31bqPBlqFgwK8iIr2BH0kcRSTv84LRooKLJTupa2OeATp3OX2YjucUje7hKQulIsaSHtlT+hLoHJ8buHlqKr/ACdzXOdcLR5HKarJG5dde7FT7lIVr1n0B6FyAfWGMGW0hdeINGMeaEeIOkL9dxwbuPpT6D7QNF0gcPNYR0zQCH12yE9UI21vKa3FLaRdGOSCFEV1PybX4t53h+8alszGJQw8FPSSRLCHGL1ve0vZBD1c0RS/tyW2dlqEqTuKafHNXrs/mjdpfy/mpJcUGBKYMJnVCBkbSG8p/fwws9NzErhpjIEw3BveHwz0ewWm7j1qHJvySiD1O7ll6h4Xrxuko3/VAmjfqD+eLMpaEmP4pKNZIq/8Fm70lDOfrmC0IKO6WUTVNJP+pBV4oJZcxf0IRa24j00+U1MHhVzB7ywNCr8c50ZTZ9j+v48uGujT/ptchYPYCwfTQPPdc9uiVIuig1epWJ7CHEUMEzMpkfSIPDvH9Uac7c1rq3ePiZVwkX7hUgw4BpeB4PedTXeNAvcFBertDQXnrez2w9xADnT677sBitXUx8Ss4GnXBS14N7PcomYWTMu0/owkxAArqkXoUFQQg4+RMpphaAM5ksJ80bSJ3NG0YXqFzbtE=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;31:vMatsmDdkbAqP2mLMP6HFdEKS4hNk+umkrhKG+ynfnjNOcHUTpmiBnvjve0MVF+5Tg5YbSJ8w3HRNe18eFU3XuayOFGooDQcP/hxop1a+ftGaael6BjT2Khh5qr6M8QocnIZgm6V3c7J5q8Ooz2f6iuWHk0DzFDxcA3m3rgzLON5PdZjtNL+ah8hyod0xZiynHm1SVhetXus82MwXzRsBuhoJeD88vQN+Cwx4SEdMivO05UVtDsHxZyPjqtsGfm9S3KwO1dZJ5Lx3vV76k06RM8Pqo4Y+yCTRTgT5+GMYMQ=;20:PW/vwbFc3u1J8mVeInFpWvJVuBGaym70lBcCIBZIgYWBaXw+p+rU1w18zfg3AP7TqEvvxfX6lqt4pcV4JCCpD66VO9rwrb0Uh4WWm77gSd1/E7/Ug6zLBad963q5pvWicOeVXap065GCoErHZ0tETL0HZGrhN2geRtSF9Jzr38MAptZubF3jGV45cRXQ7fM9SA43sguvczJRcK9Nd9mjEobKwxd4l0MR6CJowjUbAxS+Ktc+ZM89XOmFi1xaIWtntLBO7YyeI0+OvRo/LAj6774vmy6+BnexCHuCDZ5RvAC4gAHxZ7MP+3/t06/0rrfry47uoUPjrrU7taIQeM6orMEIOyVAfiDsM1LH00BXBZxy5AMKeYQyy/nF5gxxu1IN6oDB3ZoSYg4l7gykGYqihRVlNvDyZ1kCZOLaUg7ABKSPzJj9nN/+MU8jdyh1rkYSTq4pAhHZ2NjSgEWudOlfTJcolXTI7vchFYiSY60x9lb1kMzT6Hli+Re3mYUAZI8q
X-Microsoft-Antispam-PRVS: <CY4PR07MB3208B12672ED0ED8E51EBA2180630@CY4PR07MB3208.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY4PR07MB3208;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;4:BxrVzrNyFr7LzUlY0t9uWjkfcRPspt8HqIOGd3ve2y6RQZqrd8dJPjvTOt1oiyoEHYUFxtS1VjEVoxeypQl4ZiiK1P3e6D4J9GRRL8uauOwtrpZ1ebA945zFYJMzmLCHPIixIoXbzK7IA6Ig2D+NxXRs102pX3SEf4/l7xcDugbLashypoGwh1DSAxZwiMJWtx3KL07rg4Q9JakMENb9vzzYAjcGzggHxJ+nhu1vgygZM7CurlMpNBdB5o4NbHVY7ija3ujBzXcBnSBHMZ/N4DR8Yo7ikuseZuzXgvuDy16S5+xA0kUNPcL/iBCZmChJIEpJ9d1Vu3wnLdEtYAUy/SnGQf2H8ogMPqQCVrS9scr50QXvzJ3YXBLb2WVs2Zwwg4wTYegFSOiIEMKIEhYLLLqD3BMBQpW95x2NcpOBivYmKeYwn180dOqqzr/DGX6hoaz0ZQJejnDScU5j7RIhRUi517zHpAnsPJGaFA/c4NcBlKuJHxd72xxpKf0XY7rEyknWUuHjDMElxKNw8B5v6I6O0IQPjDiMI2JAvRdLT7iGDr7osmbeldyuv8n1VApCU6eTVpSLB4cQFRV0AnZfjw==
X-Forefront-PRVS: 01792087B6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(39450400003)(189002)(199003)(288314003)(97736004)(4001350100001)(31696002)(47776003)(65956001)(65806001)(66066001)(5660300001)(2906002)(65826007)(92566002)(64126003)(6916009)(38730400001)(230700001)(4326007)(86362001)(23676002)(50466002)(6666003)(305945005)(25786008)(90366009)(6486002)(110136003)(36756003)(6116002)(105586002)(106356001)(3846002)(42186005)(2351001)(7736002)(33646002)(77096006)(31686004)(101416001)(189998001)(5890100001)(68736007)(54356999)(81166006)(50986999)(81156014)(83506001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3208;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA4OzIzOm5iZStHc2VSbUg2Z1ZBNmQ5dWdrU25kYyt5?=
 =?utf-8?B?cnJQb1F1cEhoa3VyYW5lUDlVUWJocnR6WEdTMU1OQzh4RlBtT05IMXMyRWVY?=
 =?utf-8?B?RTNydHVzUEQ5QStGZVdRZXFxRktrVW9yVGlGS2ZaaE1oZ3lKZUF4ekVyNk1h?=
 =?utf-8?B?cjhUejlRa0dXdDhUaFp2YmxsYS96cDBCV0dCU3F0ZVhrVzVxclQ1bGJlV0lk?=
 =?utf-8?B?eFFRUmZ6S3pubXF1NkpLb0VLd0xSa3M3cHYzdkF1RkYzbmRMNjROVlZRR3Vt?=
 =?utf-8?B?dEUzZjU3QndaaXU5SkIwT2JDaU9ObG1XWlFNMUZHVlpxYnlDNWx3bHp1VEVX?=
 =?utf-8?B?d1lDdTdmVmN2Wjh6SzFLMXB1L2NFWlZZOW9iM3UzNGpDdE9rc3UrWGYrRVo2?=
 =?utf-8?B?V3IwZEtVQzhyak95YVpueVpPdk5NNURBKzQwT3AzeXRLcjdUeXp2SWhIZDdK?=
 =?utf-8?B?QnZ1TVlBU0JIVzlxV292NitMS1U0V0NaNFlxeW5GUXU2ak1rZm5qcU9NaXY0?=
 =?utf-8?B?TW4vUmhxTkFDRkFnbWl1SWpmbmQzcGdPY1FUd2R1cjlHcmhuNFdYOStBaTJp?=
 =?utf-8?B?eFZLRlJuYnNZZ2NFT0VGR0kwRlpLLzBGbGVudzN6VWNkbHJLZVdEYUN2SGg2?=
 =?utf-8?B?SU9nUXhPczFEMHA2V0lHMnZ5aCtEMjQ4VHQveEtSZ043bzQxMnNRZzlxUnM4?=
 =?utf-8?B?aVBwNjJtaG9LbzdWWTZIenF4SXVrT0ZXZHRDU1pRQW5rQ1FockZUeFFyaFNB?=
 =?utf-8?B?ZjQrMEFPbVpJR05URnE0Y3lOQ1hsdXR5ejlvS3NNQmNIMXJlTFFPTnhQZ0g2?=
 =?utf-8?B?Q2pRNUVoSjNjaE1sYU05WUxyb2hSM1lrSmY1OVdWbHU3eHdwRUN1S0JGb1Ux?=
 =?utf-8?B?QWxnRWJmRVRQWXZUVktYemMzZURRb05rTlV6cTBJQ3hXRGxvL2tad3FSMnZa?=
 =?utf-8?B?ajk1K0ZYcHplMHQ5Y1FZVVZQZUh5dkFKUm92MUlrYWpYT0MyQjBDVWozeVBr?=
 =?utf-8?B?RzBYTWNLN2h3UmVBYTI0T3p3aUFOS0I4b3FKQkNteURtZFhQKzVGOWFQZmxG?=
 =?utf-8?B?YkNlbUhETFNyeG5pSldyRjVHZzFRUjQwV3crSDZiVVdCYitiMlZrZlBsZ1FW?=
 =?utf-8?B?bWZSL09TM25EcUNhc2ZDQTFlYlc0aHBmOHRESm40WDJtVmpYdUNDS1M0eDNP?=
 =?utf-8?B?NDZ6eDZtOG5hNjJ6aVB1ZTY1bk5uVWcvdWs0UDlOYmhJaEhnRkFGR2tTYkNX?=
 =?utf-8?B?Y3hyNmRIeFR1Zm1qRWtnY0haelY3SExMcG00eE1vMFRsN0MvN2Z6TWRVcWxJ?=
 =?utf-8?B?NW5ndXFLN0NON29mYTd4VmorQUIwZlRSb0YvdXkxOTJsQ3BGSWNsZUkyWXBT?=
 =?utf-8?B?TWkxeGExelNJUjNFeWpuOS9pOENsS1VnelBlRmgxUDI4T1hwWVhFTzRVc2pn?=
 =?utf-8?B?UGJTSnRtekQ0TzhsQXJldGN0UG9kZWxaQVlFaEZ5dTA1emJia0VkaC9id0Rp?=
 =?utf-8?B?VGJKV2VQbzFkN3BnVjlHenp5REtwdUlIYSthekZSZjFmSG5KUXJrUEdvU0Rt?=
 =?utf-8?B?VmZqL1ZLSTBZQlVsOGhjNTUxRXc3VE1sRm80QjN0VjloSmRFWFo5cGdKU1Jn?=
 =?utf-8?B?VWNPNXBmRjVIbjVXMXJPRnF2WXE0S1FmYnJFZGJhL1B5MWRBdlgzK09KMUlZ?=
 =?utf-8?B?V1VhbE9sbnpRMHVzNnZ0bE10QlJERjNVMkxkUnlrbE5CNEFuc2tkZTYxU3Rh?=
 =?utf-8?B?NWpHZ1RjdDM5VnkzZG02UT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;6:w6gi2dPNHVw/ZMayh8/0MPTvTsg7dkqPQzyc5zZ96ay3DTPJN29Hw3xZUnN0JgD4XvFkODt/jdAZCDfTN1wUC68IfHpaPNyiX2gKje6svNeBDLWKFvO0COOHqnKkqqBy1CvFaRy0NluusN29EV0Kk0auJyllJttcCK049do73MqEdTih3CHA0aXNYYqgABd70RIHvC7aOTvxsWpIkp9le6lBmoliKZq0gPJBNSyLyhTJejnPmInKCe/LApshPhXGokRCNzQRy78J9hlgrXp0E5AV4c3iPHj0J7wuNEhsa0ShQbtSjfnNAwOT+dwdBlUlyRwhWFM9C9iyQpTaBMIDvjmG5x+6SjUTdLlBpc8zRxA04LU9r7Xej6PGuqF5PXSAUfAe/W7ZE99PQn9x3/01LPm/YEDN91l99kYw6OdMki0=;5:6vQc2YkFalBB09Vi87VYaDHEGl8Z9iJ4bmszL0Fr7X2cJE6VsmfUYJ0A6iaQNQpRT+loXMvBkZhVsBL/KjQJ/587Mue2B3Sr3uWJ+ZJ5Vwy/K7kHvcBHsKWOOo5gtc2P8P7JQ7GKrF4U82MMVtzvoaxsOa5ag2IpKBLTpZ3fayI=;24:INZ+Fa2ho+tJAvPUsniF3geW5hE7dNQ/F9mkYcvG9XpYWIfDNVlNJh38ngyVa2xKyeg3qBjyylhxCnXOgRZitP+nF5MrIOOh8pGKq8YaBFY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;7:HyPJwJP9ruHW3gExEceTTNAUuMQupGMU24ZlBYmQVG7FHF+wgQIUTwHEaTPQJrP19pb4R/CjW952wJiNa609BRoX/5vG1Ofp98qKH8L/YICjJvg7SVZ1Mz2LX52l9v7GC9SWzrBzdBm2V/0UiQCUI5Bw8QW/YdYnjLB4I/Gj3xwceTIa33ZP6ZNn/a4FsgloQkNIaTwFTVX2gfqgyvcJr1L4HvDmBaQtEC4VcB7OajGAaYCyRQ+XXRTP9qMEx8V5me0JAhSnA0O60zIhXDEFxlRUaXKVCb56IRaK73EsEPWLrxkvrLu5DOpk/KOIEMDBCkC5IhX8aRr7OEkJ8JThKwjaDNcaJjPW+LGmi5luv7LRpB7ygSjqywFZB1YuBmLYcv9xTQthxW1rSt61NhhCvGijuQ6Qzs7PR8ZGRCYNYNoHkWzjofmjNezK8zJdh/vlh9/A4A9sA/fmpidEa7XHWA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2017 23:42:28.2997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3208
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56223
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

Add all the necessary platform code to initialize the dwc3
USB host controller found on OCTEON III processors. This
code initializes the clocks and resets the USB core with
PHYs. It is then passed off to the platform independent
DWC3 driver found in the 'drivers/usb/dwc3' directory.
Based off code written by David Daney.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/cavium-octeon/Makefile              |   1 +
 arch/mips/cavium-octeon/octeon-platform.c     |   1 +
 arch/mips/cavium-octeon/octeon-usb.c          | 555 ++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h |   8 +-
 4 files changed, 563 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/octeon-usb.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 2a59265..a3d6ad8 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -18,3 +18,4 @@ obj-y += crypto/
 obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
+obj-$(CONFIG_USB)		+= octeon-usb.o
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 37a932d..16083cf 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -448,6 +448,7 @@ static int __init octeon_ohci_device_init(void)
 	{ .compatible = "cavium,octeon-3860-bootbus", },
 	{ .compatible = "cavium,mdio-mux", },
 	{ .compatible = "gpio-leds", },
+	{ .compatible = "cavium,octeon-7130-usb-uctl", },
 	{},
 };

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
new file mode 100644
index 0000000..773272d
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -0,0 +1,555 @@
+/*
+ * XHCI HCD glue for Cavium Octeon III SOCs.
+ *
+ * Copyright (C) 2010-2017 Cavium Networks
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/of_platform.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-gpio-defs.h>
+
+/* USB Control Register */
+union cvm_usbdrd_uctl_ctl {
+	uint64_t u64;
+	struct cvm_usbdrd_uctl_ctl_s {
+	/* 1 = BIST and set all USB RAMs to 0x0, 0 = BIST */
+	__BITFIELD_FIELD(uint64_t clear_bist:1,
+	/* 1 = Start BIST and cleared by hardware */
+	__BITFIELD_FIELD(uint64_t start_bist:1,
+	/* Reference clock select for SuperSpeed and HighSpeed PLLs:
+	 *	0x0 = Both PLLs use DLMC_REF_CLK0 for reference clock
+	 *	0x1 = Both PLLs use DLMC_REF_CLK1 for reference clock
+	 *	0x2 = SuperSpeed PLL uses DLMC_REF_CLK0 for reference clock &
+	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
+	 *	0x3 = SuperSpeed PLL uses DLMC_REF_CLK1 for reference clock &
+	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
+	 */
+	__BITFIELD_FIELD(uint64_t ref_clk_sel:2,
+	/* 1 = Spread-spectrum clock enable, 0 = SS clock disable */
+	__BITFIELD_FIELD(uint64_t ssc_en:1,
+	/* Spread-spectrum clock modulation range:
+	 *	0x0 = -4980 ppm downspread
+	 *	0x1 = -4492 ppm downspread
+	 *	0x2 = -4003 ppm downspread
+	 *	0x3 - 0x7 = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t ssc_range:3,
+	/* Enable non-standard oscillator frequencies:
+	 *	[55:53] = modules -1
+	 *	[52:47] = 2's complement push amount, 0 = Feature disabled
+	 */
+	__BITFIELD_FIELD(uint64_t ssc_ref_clk_sel:9,
+	/* Reference clock multiplier for non-standard frequencies:
+	 *	0x19 = 100MHz on DLMC_REF_CLK* if REF_CLK_SEL = 0x0 or 0x1
+	 *	0x28 = 125MHz on DLMC_REF_CLK* if REF_CLK_SEL = 0x0 or 0x1
+	 *	0x32 =  50MHz on DLMC_REF_CLK* if REF_CLK_SEL = 0x0 or 0x1
+	 *	Other Values = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t mpll_multiplier:7,
+	/* Enable reference clock to prescaler for SuperSpeed functionality.
+	 * Should always be set to "1"
+	 */
+	__BITFIELD_FIELD(uint64_t ref_ssp_en:1,
+	/* Divide the reference clock by 2 before entering the
+	 * REF_CLK_FSEL divider:
+	 *	If REF_CLK_SEL = 0x0 or 0x1, then only 0x0 is legal
+	 *	If REF_CLK_SEL = 0x2 or 0x3, then:
+	 *		0x1 = DLMC_REF_CLK* is 125MHz
+	 *		0x0 = DLMC_REF_CLK* is another supported frequency
+	 */
+	__BITFIELD_FIELD(uint64_t ref_clk_div2:1,
+	/* Select reference clock freqnuency for both PLL blocks:
+	 *	0x27 = REF_CLK_SEL is 0x0 or 0x1
+	 *	0x07 = REF_CLK_SEL is 0x2 or 0x3
+	 */
+	__BITFIELD_FIELD(uint64_t ref_clk_fsel:6,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_31_31:1,
+	/* Controller clock enable. */
+	__BITFIELD_FIELD(uint64_t h_clk_en:1,
+	/* Select bypass input to controller clock divider:
+	 *	0x0 = Use divided coprocessor clock from H_CLKDIV
+	 *	0x1 = Use clock from GPIO pins
+	 */
+	__BITFIELD_FIELD(uint64_t h_clk_byp_sel:1,
+	/* Reset controller clock divider. */
+	__BITFIELD_FIELD(uint64_t h_clkdiv_rst:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_27_27:1,
+	/* Clock divider select:
+	 *	0x0 = divide by 1
+	 *	0x1 = divide by 2
+	 *	0x2 = divide by 4
+	 *	0x3 = divide by 6
+	 *	0x4 = divide by 8
+	 *	0x5 = divide by 16
+	 *	0x6 = divide by 24
+	 *	0x7 = divide by 32
+	 */
+	__BITFIELD_FIELD(uint64_t h_clkdiv_sel:3,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_22_23:2,
+	/* USB3 port permanently attached: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb3_port_perm_attach:1,
+	/* USB2 port permanently attached: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb2_port_perm_attach:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_19_19:1,
+	/* Disable SuperSpeed PHY: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb3_port_disable:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_17_17:1,
+	/* Disable HighSpeed PHY: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb2_port_disable:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_15_15:1,
+	/* Enable PHY SuperSpeed block power: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t ss_power_en:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_13_13:1,
+	/* Enable PHY HighSpeed block power: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t hs_power_en:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_5_11:7,
+	/* Enable USB UCTL interface clock: 0xx = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t csclk_en:1,
+	/* Controller mode: 0x0 = Host, 0x1 = Device */
+	__BITFIELD_FIELD(uint64_t drd_mode:1,
+	/* PHY reset */
+	__BITFIELD_FIELD(uint64_t uphy_rst:1,
+	/* Software reset UAHC */
+	__BITFIELD_FIELD(uint64_t uahc_rst:1,
+	/* Software resets UCTL */
+	__BITFIELD_FIELD(uint64_t uctl_rst:1,
+	;)))))))))))))))))))))))))))))))))
+	} s;
+};
+typedef union cvm_usbdrd_uctl_ctl cvm_usbdrd_uctl_ctl_t;
+
+/* UAHC Configuration Register */
+union cvm_usbdrd_uctl_host_cfg {
+	uint64_t u64;
+	struct cvm_usbdrd_uctl_host_cfg_s {
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_60_63:4,
+	/* Indicates minimum value of all received BELT values */
+	__BITFIELD_FIELD(uint64_t host_current_belt:12,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_38_47:10,
+	/* HS jitter adjustment */
+	__BITFIELD_FIELD(uint64_t fla:6,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_29_31:3,
+	/* Bus-master enable: 0x0 = Disabled (stall DMAs), 0x1 = enabled */
+	__BITFIELD_FIELD(uint64_t bme:1,
+	/* Overcurrent protection enable: 0x0 = unavailable, 0x1 = available */
+	__BITFIELD_FIELD(uint64_t oci_en:1,
+	/* Overcurrent sene selection:
+	 *	0x0 = Overcurrent indication from off-chip is active-low
+	 *	0x1 = Overcurrent indication from off-chip is active-high
+	 */
+	__BITFIELD_FIELD(uint64_t oci_active_high_en:1,
+	/* Port power control enable: 0x0 = unavailable, 0x1 = available */
+	__BITFIELD_FIELD(uint64_t ppc_en:1,
+	/* Port power control sense selection:
+	 *	0x0 = Port power to off-chip is active-low
+	 *	0x1 = Port power to off-chip is active-high
+	 */
+	__BITFIELD_FIELD(uint64_t ppc_active_high_en:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_0_23:24,
+	;)))))))))))
+	} s;
+};
+typedef union cvm_usbdrd_uctl_host_cfg cvm_usbdrd_uctl_host_cfg_t;
+
+/* UCTL Shim Features Register */
+union cvm_usbdrd_uctl_shim_cfg {
+	uint64_t u64;
+	struct cvm_usbdrd_uctl_shim_cfg_s {
+	/* Out-of-bound UAHC register access: 0 = read, 1 = write */
+	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_60_62:3,
+	/* SRCID error log for out-of-bound UAHC register access:
+	 *	[59:58] = chipID
+	 *	[57] = Request source: 0 = core, 1 = NCB-device
+	 *	[56:51] = Core/NCB-device number, [56] always 0 for NCB devices
+	 *	[50:48] = SubID
+	 */
+	__BITFIELD_FIELD(uint64_t xs_ncb_oob_osrc:12,
+	/* Error log for bad UAHC DMA access: 0 = Read log, 1 = Write log */
+	__BITFIELD_FIELD(uint64_t xm_bad_dma_wrn:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_44_46:3,
+	/* Encoded error type for bad UAHC DMA */
+	__BITFIELD_FIELD(uint64_t xm_bad_dma_type:4,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_13_39:27,
+	/* Select the IOI read command used by DMA accesses */
+	__BITFIELD_FIELD(uint64_t dma_read_cmd:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_10_11:2,
+	/* Select endian format for DMA accesses to the L2c:
+	 *	0x0 = Little endian
+	 *`	0x1 = Big endian
+	 *	0x2 = Reserved
+	 *	0x3 = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t dma_endian_mode:2,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_2_7:6,
+	/* Select endian format for IOI CSR access to UAHC:
+	 *	0x0 = Little endian
+	 *`	0x1 = Big endian
+	 *	0x2 = Reserved
+	 *	0x3 = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t csr_endian_mode:2,
+	;))))))))))))
+	} s;
+};
+typedef union cvm_usbdrd_uctl_shim_cfg cvm_usbdrd_uctl_shim_cfg_t;
+
+#define OCTEON_H_CLKDIV_SEL		8
+#define OCTEON_MIN_H_CLK_RATE		150000000
+#define OCTEON_MAX_H_CLK_RATE		300000000
+
+static DEFINE_MUTEX(dwc3_octeon_clocks_mutex);
+static uint8_t clk_div[OCTEON_H_CLKDIV_SEL] = {1, 2, 4, 6, 8, 16, 24, 32};
+
+
+static int dwc3_octeon_config_power(struct device *dev, u64 base)
+{
+#define UCTL_HOST_CFG	0xe0
+	union cvm_usbdrd_uctl_host_cfg uctl_host_cfg;
+	union cvmx_gpio_bit_cfgx gpio_bit;
+	uint32_t gpio_pwr[3];
+	int gpio, len, power_active_low;
+	struct device_node *node = dev->of_node;
+	int index = (base >> 24) & 1;
+
+	if (of_find_property(node, "power", &len) != NULL) {
+		if (len == 12) {
+			of_property_read_u32_array(node, "power", gpio_pwr, 3);
+			power_active_low = gpio_pwr[2] & 0x01;
+			gpio = gpio_pwr[1];
+		} else if (len == 8) {
+			of_property_read_u32_array(node, "power", gpio_pwr, 2);
+			power_active_low = 0;
+			gpio = gpio_pwr[1];
+		} else {
+			dev_err(dev, "dwc3 controller clock init failure.\n");
+			return -EINVAL;
+		}
+		if ((OCTEON_IS_MODEL(OCTEON_CN73XX) ||
+		    OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		    && gpio <= 31) {
+			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
+			gpio_bit.s.tx_oe = 1;
+			gpio_bit.cn73xx.output_sel = (index == 0 ? 0x14 : 0x15);
+			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
+		} else if (gpio <= 15) {
+			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
+			gpio_bit.s.tx_oe = 1;
+			gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
+			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
+		} else {
+			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_XBIT_CFGX(gpio));
+			gpio_bit.s.tx_oe = 1;
+			gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
+			cvmx_write_csr(CVMX_GPIO_XBIT_CFGX(gpio), gpio_bit.u64);
+		}
+
+		/* Enable XHCI power control and set if active high or low. */
+		uctl_host_cfg.u64 = cvmx_read_csr(base + UCTL_HOST_CFG);
+		uctl_host_cfg.s.ppc_en = 1;
+		uctl_host_cfg.s.ppc_active_high_en = !power_active_low;
+		cvmx_write_csr(base + UCTL_HOST_CFG, uctl_host_cfg.u64);
+	} else {
+		/* Disable XHCI power control and set if active high. */
+		uctl_host_cfg.u64 = cvmx_read_csr(base + UCTL_HOST_CFG);
+		uctl_host_cfg.s.ppc_en = 0;
+		uctl_host_cfg.s.ppc_active_high_en = 0;
+		cvmx_write_csr(base + UCTL_HOST_CFG, uctl_host_cfg.u64);
+		dev_warn(dev, "dwc3 controller clock init failure.\n");
+	}
+	return 0;
+}
+
+static int dwc3_octeon_clocks_start(struct device *dev, u64 base)
+{
+	union cvm_usbdrd_uctl_ctl uctl_ctl;
+	int ref_clk_sel = 2;
+	u64 div;
+	u32 clock_rate;
+	int mpll_mul;
+	int i;
+	u64 h_clk_rate;
+	u64 uctl_ctl_reg = base;
+
+	if (dev->of_node) {
+		const char *ss_clock_type;
+		const char *hs_clock_type;
+
+		i = of_property_read_u32(dev->of_node,
+					 "refclk-frequency", &clock_rate);
+		if (i) {
+			pr_err("No UCTL \"refclk-frequency\"\n");
+			return -EINVAL;
+		}
+		i = of_property_read_string(dev->of_node,
+					    "refclk-type-ss", &ss_clock_type);
+		if (i) {
+			pr_err("No UCTL \"refclk-type-ss\"\n");
+			return -EINVAL;
+		}
+		i = of_property_read_string(dev->of_node,
+					    "refclk-type-hs", &hs_clock_type);
+		if (i) {
+			pr_err("No UCTL \"refclk-type-hs\"\n");
+			return -EINVAL;
+		}
+		if (strcmp("dlmc_ref_clk0", ss_clock_type) == 0) {
+			if (strcmp(hs_clock_type, "dlmc_ref_clk0") == 0)
+				ref_clk_sel = 0;
+			else if (strcmp(hs_clock_type, "pll_ref_clk") == 0)
+				ref_clk_sel = 2;
+			else
+				pr_err("Invalid HS clock type %s, using  pll_ref_clk instead\n",
+				       hs_clock_type);
+		} else if (strcmp(ss_clock_type, "dlmc_ref_clk1") == 0) {
+			if (strcmp(hs_clock_type, "dlmc_ref_clk1") == 0)
+				ref_clk_sel = 1;
+			else if (strcmp(hs_clock_type, "pll_ref_clk") == 0)
+				ref_clk_sel = 3;
+			else {
+				pr_err("Invalid HS clock type %s, using  pll_ref_clk instead\n",
+				       hs_clock_type);
+				ref_clk_sel = 3;
+			}
+		} else
+			pr_err("Invalid SS clock type %s, using  dlmc_ref_clk0 instead\n",
+			       ss_clock_type);
+
+		if ((ref_clk_sel == 0 || ref_clk_sel == 1) &&
+				  (clock_rate != 100000000))
+			pr_err("Invalid UCTL clock rate of %u, using 100000000 instead\n",
+			       clock_rate);
+
+	} else {
+		pr_err("No USB UCTL device node\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Step 1: Wait for all voltages to be stable...that surely
+	 *         happened before starting the kernel. SKIP
+	 */
+
+	/* Step 2: Select GPIO for overcurrent indication, if desired. SKIP */
+
+	/* Step 3: Assert all resets. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.uphy_rst = 1;
+	uctl_ctl.s.uahc_rst = 1;
+	uctl_ctl.s.uctl_rst = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 4a: Reset the clock dividers. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.h_clkdiv_rst = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 4b: Select controller clock frequency. */
+	for (div = 0; div < OCTEON_H_CLKDIV_SEL; div++) {
+		h_clk_rate = octeon_get_io_clock_rate() / clk_div[div];
+		if (h_clk_rate <= OCTEON_MAX_H_CLK_RATE &&
+				 h_clk_rate >= OCTEON_MIN_H_CLK_RATE)
+			break;
+	}
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.h_clkdiv_sel = div;
+	uctl_ctl.s.h_clk_en = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	if ((div != uctl_ctl.s.h_clkdiv_sel) || (!uctl_ctl.s.h_clk_en)) {
+		dev_err(dev, "dwc3 controller clock init failure.\n");
+			return -EINVAL;
+	}
+
+	/* Step 4c: Deassert the controller clock divider reset. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.h_clkdiv_rst = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 5a: Reference clock configuration. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.ref_clk_sel = ref_clk_sel;
+	uctl_ctl.s.ref_clk_fsel = 0x07;
+	uctl_ctl.s.ref_clk_div2 = 0;
+	switch (clock_rate) {
+	default:
+		dev_err(dev, "Invalid ref_clk %u, using 100000000 instead\n",
+			clock_rate);
+	case 100000000:
+		mpll_mul = 0x19;
+		if (ref_clk_sel < 2)
+			uctl_ctl.s.ref_clk_fsel = 0x27;
+		break;
+	case 50000000:
+		mpll_mul = 0x32;
+		break;
+	case 125000000:
+		mpll_mul = 0x28;
+		break;
+	}
+	uctl_ctl.s.mpll_multiplier = mpll_mul;
+
+	/* Step 5b: Configure and enable spread-spectrum for SuperSpeed. */
+	uctl_ctl.s.ssc_en = 1;
+
+	/* Step 5c: Enable SuperSpeed. */
+	uctl_ctl.s.ref_ssp_en = 1;
+
+	/* Step 5d: Cofngiure PHYs. SKIP */
+
+	/* Step 6a & 6b: Power up PHYs. */
+	uctl_ctl.s.hs_power_en = 1;
+	uctl_ctl.s.ss_power_en = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 7: Wait 10 controller-clock cycles to take effect. */
+	udelay(10);
+
+	/* Step 8a: Deassert UCTL reset signal. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.uctl_rst = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 8b: Wait 10 controller-clock cycles. */
+	udelay(10);
+
+	/* Steo 8c: Setup power-power control. */
+	if (dwc3_octeon_config_power(dev, base)) {
+		dev_err(dev, "Error configuring power.\n");
+		return -EINVAL;
+	}
+
+	/* Step 8d: Deassert UAHC reset signal. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.uahc_rst = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 8e: Wait 10 controller-clock cycles. */
+	udelay(10);
+
+	/* Step 9: Enable conditional coprocessor clock of UCTL. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.csclk_en = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/*Step 10: Set for host mode only. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.drd_mode = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	return 0;
+}
+
+static void __init dwc3_octeon_set_endian_mode(u64 base)
+{
+#define UCTL_SHIM_CFG	0xe8
+	union cvm_usbdrd_uctl_shim_cfg shim_cfg;
+
+	shim_cfg.u64 = cvmx_read_csr(base + UCTL_SHIM_CFG);
+#ifdef __BIG_ENDIAN
+	shim_cfg.s.dma_endian_mode = 1;
+	shim_cfg.s.csr_endian_mode = 1;
+#else
+	shim_cfg.s.dma_endian_mode = 0;
+	shim_cfg.s.csr_endian_mode = 0;
+#endif
+	cvmx_write_csr(base + UCTL_SHIM_CFG, shim_cfg.u64);
+}
+
+#define CVMX_USBDRDX_UCTL_CTL(index)				\
+		(CVMX_ADD_IO_SEG(0x0001180068000000ull) +	\
+		((index & 1) * 0x1000000ull))
+static void __init dwc3_octeon_phy_reset(u64 base)
+{
+	union cvm_usbdrd_uctl_ctl uctl_ctl;
+	int index = (base >> 24) & 1;
+
+	uctl_ctl.u64 = cvmx_read_csr(CVMX_USBDRDX_UCTL_CTL(index));
+	uctl_ctl.s.uphy_rst = 0;
+	cvmx_write_csr(CVMX_USBDRDX_UCTL_CTL(index), uctl_ctl.u64);
+}
+
+static int __init dwc3_octeon_device_init(void)
+{
+	const char compat_node_name[] = "cavium,octeon-7130-usb-uctl";
+	struct platform_device *pdev;
+	struct device_node *node;
+	struct resource *res;
+	void __iomem *base;
+
+	/*
+	 * There should only be three universal controllers, "uctl"
+	 * in the device tree. Two USB and a SATA, which we ignore.
+	 */
+	node = NULL;
+	do {
+		node = of_find_node_by_name(node, "uctl");
+		if (!node)
+			return -ENODEV;
+
+		if (of_device_is_compatible(node, compat_node_name)) {
+			pdev = of_find_device_by_node(node);
+			if (!pdev)
+				return -ENODEV;
+
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+			if (res == NULL) {
+				dev_err(&pdev->dev, "No memory resources\n");
+				return -ENXIO;
+			}
+
+			/*
+			 * The code below maps in the registers necessary for
+			 * setting up the clocks and reseting PHYs. We must
+			 * release the resources so the dwc3 subsystem doesn't
+			 * know the difference.
+			 */
+			base = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(base))
+				return PTR_ERR(base);
+
+			mutex_lock(&dwc3_octeon_clocks_mutex);
+			dwc3_octeon_clocks_start(&pdev->dev, (u64)base);
+			dwc3_octeon_set_endian_mode((u64)base);
+			dwc3_octeon_phy_reset((u64)base);
+			dev_info(&pdev->dev, "clocks initialized.\n");
+			mutex_unlock(&dwc3_octeon_clocks_mutex);
+			devm_iounmap(&pdev->dev, base);
+			devm_release_mem_region(&pdev->dev, res->start,
+						resource_size(res));
+		}
+	} while (node != NULL);
+
+	return 0;
+}
+device_initcall(dwc3_octeon_device_init);
+
+MODULE_AUTHOR("David Daney <david.daney@cavium.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("USB driver for OCTEON III SoC");
diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
index 4719fcf..8123b82 100644
--- a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
@@ -46,7 +46,8 @@
 	uint64_t u64;
 	struct cvmx_gpio_bit_cfgx_s {
 #ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
+		uint64_t reserved_21_63:42;
+		uint64_t output_sel:5;
 		uint64_t synce_sel:2;
 		uint64_t clk_gen:1;
 		uint64_t clk_sel:2;
@@ -66,7 +67,8 @@
 		uint64_t clk_sel:2;
 		uint64_t clk_gen:1;
 		uint64_t synce_sel:2;
-		uint64_t reserved_17_63:47;
+		uint64_t output_sel:5;
+		uint64_t reserved_21_63:42;
 #endif
 	} s;
 	struct cvmx_gpio_bit_cfgx_cn30xx {
@@ -126,6 +128,8 @@
 	struct cvmx_gpio_bit_cfgx_s cn66xx;
 	struct cvmx_gpio_bit_cfgx_s cn68xx;
 	struct cvmx_gpio_bit_cfgx_s cn68xxp1;
+	struct cvmx_gpio_bit_cfgx_s cn70xx;
+	struct cvmx_gpio_bit_cfgx_s cn73xx;
 	struct cvmx_gpio_bit_cfgx_s cnf71xx;
 };

-- 
1.9.1
