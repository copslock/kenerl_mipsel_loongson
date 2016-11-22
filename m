Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 20:44:04 +0100 (CET)
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:62592
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993120AbcKVTn5p4Qxv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 20:43:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uUPlI8vT/o9vHgVOErVKKdAGhoSiIRVC0fZWYM3t0Jc=;
 b=a+tx8m0JE4b3Etprt8zMvM6ikcbnTZWNQtjgrPqAPXS+c+/2A6OZuGQMSvhoAcCiJrxjeKf2Pjod/zQpCzp9oEflxUw2iht7XGuNKNptOzhOjy7C/FqScBGKN2ObHjo1HwOFMtoRQMx3oqPam2y+2i6XSlbXlrYrGN/mgZkIqHU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 19:43:49 +0000
Subject: [PATCH 0/5] Enable KASLR for OCTEON platforms.
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <088264c9-75b8-37ff-6514-0f536b1f8e55@cavium.com>
Date:   Tue, 22 Nov 2016 13:43:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR1601CA0018.namprd16.prod.outlook.com (10.172.93.28) To
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147)
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;2:Bxvq4FrqrMzm5Ag7NyenVGpuqUd5YmfJWnx36LuV/1z/ZJyAefMbztGlFAqRup5rWlzSLt0d9FSX7YSLI73a6FqMLNzHZ58uviX1NsTta4H6AT+qoBWLWKmzuwMVsquDfvxm4c6Vn1OJVUMoDRCRGm3qNCuLlVLA12phViacewQ=;3:GE0TO5Fy+yat+GnzyBVOBcbjExNDPQSwYc2dXVKWldyGCt+IPM9ID7XtrVsX2XXzgcd9vgNWF3s04rtaz8mXV6tNUWvDB3Ku/h4M8G4IM6pYp98BSuFRi74qF5S+4huPzjUNe+tRonjrwUrAqyfzj0GfcyUDrGWe4pHAgKHW588=
X-MS-Office365-Filtering-Correlation-Id: 9a26d1f7-163e-47a6-e6c1-08d4130fe1c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;25:xk2HCZUgGgbSdpgj6fsMlZSuJzZ8DQAVnOX1SpRfLdtilYIJpgW8H6hbP14I2r+ZFYfC9DHRPIc1zW06ZFznqbclzrHx/pQpxIFH9Y2jDoG5CVn7Dl7c2NPi/E6HD5lRsnqPbGhsrDQ9Lwyy9qnL4ygeJuZ8H0QtXmKOIzxXx11yjnISpxlPA6I3zInPmqh/ed4TF0BP7Z26DaWgBVnzC9Kvzsvs623oyBS6oWQy32URNFsuiiM6nLOoe6zcVC1oi31BG+ewDqSuEXyMBa1f1rcLGISInYwEcnrbkaNRxxkwtGU4LT0WhMpdKMSUZjpmELqrzR4viU4WxMLMgk1Sm3TFcc9IjVN9xJE6WJGinZKOmENyOd3SYhxYq4WlHVNa8UizD2z+vw4t50Y9J0wbIPrqNr2ofRl6bQDYCb6kCASD8MJPyvxhSuwyQhcWacudYqFt9vR2z4vCK7tESGzf42f1tqEof8Zvi1w/o00ElOIwNE2dlnXZCc6jDb6161RfAwHf9aScgdONZqYKBZ1w8zlEO80I7I3cyh0pAXMRFWSGD/Vf85werupLK5r+e7ujAEhBWRnc5v825HOn2LIkrUoyABRxItXBCBtc6BDXA4bojz/9If29W3y0+pT4drk06B4ux62N6GoLK44w9rwhFKgVJJtN7x1HaWBhuSI6Qrd1Ns7eLXLvU2ejBbyDIiM3KIOBffZZSfuhR+Xw7StcwkTUFSQmz4n8pGKtb+5MB8mT+t+ekPCJVOZHQbcOmMhgiRDgJgs9qYkXjxYf7nl7IQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;31:Fvk7FXycEdBW/xWFzovgB+8lZH9qJ2fu/7cYkCN78tIOG0FAHwXYcjRvRJliF191qSevJ2dvK8wzwEjR8vXVLAaNjPgcideBPMtZw7LTBIsd77Sn2ngEaAiS91QIaHTvdIjm6JJELe6GOkhcBvHhXAn2KgNsHzk7SiU+Bvf5psjr3ljYL6lt6c/pUv6XY8a7F4VOiM4mbulm3OP6v7GNaiNkLlBdnYeJsxmL68D6D4pcnNOxqu+1cEXugtwZXQ18/ctVHoxDz7eqimX1NbC6xBmVppc/Ocp9WN6lmv+Y1gk=;20:Z3YrbbgVKhqm07UObxV+79RoQeerPSNkdDOU8ay5wmXBGHr6rS24zvdJl8WzLlam17NI8d6sHFzEd7/fl8jAYKjZuJwSNpuYWTyCzQPfhJaUQ2gpww/rY/Z3OWODBnjQsWJM7EvLQyzoo0cGNoYTNOrL87eFbn9aq7yf6x3lG1eNCEmyHr85zOiILtKJ6D392AOxxRhOYxsOn3JcWSAjr4UPmlVOIoeiPBiGi7SI1JCzQKKkA3ym498e0tPBkD9otd4WJox4wNPfXlpizrqC8C94cRgHDWvPdfdV220Z1HrjbW102mv01Iy1b5PzGXUfp42sGF3/P6xdNTnBjE4IjsCHtvbvX+H8h4ZybLRf7wZfO5+5CcPleaPInnXSl98LpkWezEYfiCLgIKIjmwo/HDJRwNVsfa8UKHMvDEKtK7lDlkIfO1rT0Kod29+AsJjYynMpShtYy63xpx7XYZ548MRZ7kuMYejvEjgQ8h8GcTvcaV0r0bfW73cH2JgeQySE
X-Microsoft-Antispam-PRVS: <CY4PR07MB32059CFA7FE741C160D89A1280B40@CY4PR07MB3205.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040307)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(6061324)(6072148)(6042181);SRVR:CY4PR07MB3205;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;4:vkFdGUHq6JaDIZG9UVSymH2qVgaUlj08/1ABehm4a5gaAunkqk+SiU9BEK2yiRIvOSEx3AB5A8uJneTWTqHcbkb5nSFIx7rRY+pAHT5Fg3Zts+u6eowPterH8slNIXgrzg32tqCQYhkLUeA2ilvk2THnBs41fs6EP890wxyss7OPFrcr2lxm42ulN+F6omhURMAbekoixGAs9ATFiraTtLyJ8IwemUI5/XsP0+AopYYi/PwWluns5tJHxqJDnFQEaJgefK8wFQX2KdAiDqVAUqH81/pVgyIxJ86aeB7KJgKszUy1L9w8zw3jFO6YFwkJyWhp/hKuviVl5/HDiwRAIkkV7/94tOQkMcvzROvLdllBRMaM3c4pxnCKSGhKyvqMQ6dSSthFRByMZoXgNNjLQZdUFt05/9bSdNU9T1NOWZkq93mTG3oTk9Tnyw+hMG9roYCjQ8OT0o3J9ykFd7XhIWPD/VxLgEKxdPAx7mHo0Phj3XdMAH92UiSlkz6YlAETwD1kaohBuvABb9XvfXa+6Q==
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(189002)(105586002)(77096005)(50466002)(2906002)(3846002)(101416001)(68736007)(2351001)(42186005)(106356001)(4326007)(31686004)(6116002)(33646002)(81166006)(64126003)(54356999)(31696002)(50986999)(110136003)(81156014)(305945005)(86362001)(7846002)(7736002)(92566002)(5660300001)(450100001)(189998001)(65826007)(38730400001)(47776003)(8676002)(97736004)(4001350100001)(6666003)(65806001)(66066001)(83506001)(65956001)(6916009)(230700001)(36756003)(23676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3205;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA1OzIzOkxHYmtWVGs4WDRSS0wrMCtMc3hzaHlqNSsw?=
 =?utf-8?B?MDJmRSt2NjBkV3RQYUlhRHJlNCtreGcrQ1QvWmNnNzFVR2pHMjFxL3JpVWRm?=
 =?utf-8?B?Skg4QStnQUE1aFpTUXF5SkxnRkFIK0NxM2tjUVlyTmpzM2JYSktxeDc3dC9U?=
 =?utf-8?B?aEdqVG44MXgxMG5Qbjcrb0hBSEJQczZ4a3RQNHlicGM2c0FOZGpSWm5iRUxG?=
 =?utf-8?B?TjdTSWhYNjJIY1pYUnRMdWpsdE14YkZvZnNwV1hHVWlhbFZwWVhMSFcwYXc4?=
 =?utf-8?B?V2kyc3p0WkFpVlhZSEk0QlJLVEE4dElSRHJmN1JwYnJvVzlJZ0R2NnNQVDJ4?=
 =?utf-8?B?LzJjSDBIL09OaFpKa2E0aW9TR0pGMjZpdlZ1a1psWEVtRTZPQ0Q3UHhXL1F4?=
 =?utf-8?B?ZjZVOGxTNXlBd1AvTVVMRVVzU0l1ekgxSWFTR2FCQWdsUjZZaUtBWlo2cXJF?=
 =?utf-8?B?MEFDaE16blByWWVaeVlUWGh1OFkxY1RLMUhhcXlCT3ZCZ0tFemh1dzc0dDhk?=
 =?utf-8?B?R3g5ZGRSQ1BxZFZuY1dVeUttUlZsZjlrcUZXUWJ5eG8yR0RhbkhNdVBETWQ0?=
 =?utf-8?B?NWFoYlV1NnpvOVo5RHJWQXBxa1lBeXV1am5LQS90akxzS0hzL1pVRXlCQjZ5?=
 =?utf-8?B?L05qYTN2WEczUGRPako3ZnhpODRSVG1vRkw4bWM3NjlFK0J6NGNWdllLSjdU?=
 =?utf-8?B?UlpCTDFNdnA4cVAzQWovVXU5U2ZYbEhJMXVuRi9Qb2pKM0I4S0lHRDN4NUJu?=
 =?utf-8?B?ck1NZU1zQXk0Z2FCSlVOYTBBTDI1VHdNR3FZaGd4V1JtTmVXaE50bTkyL0I3?=
 =?utf-8?B?Y2E5dDN0RGVwWUF4c0M4bjl2VHduWEVybXRRcnI3ZldDdVpzVzJGMnJLZElM?=
 =?utf-8?B?ajdFeDdQNld1YVRZVnVjYktaMEJwbUtwdWVYK1JDNXRFeGJkczFyaHExRVl4?=
 =?utf-8?B?a3IyeFZkbktiR1hEVnFmQ0IxZDREenZNUUxNVVF5MkNFVHdtTnAwU2R6N25H?=
 =?utf-8?B?L0lhR1pXT2VuNW9tWXNCQ1FTcVNpTXlDT1VhYzFhK2tUeUFqRDBHK0JiSDhM?=
 =?utf-8?B?a2JKQUdQSkdrSFkwaTlRaVpoVzB0aXQxY3VEeDJFWnVLSFVrYW9rMFRHMGIy?=
 =?utf-8?B?UmNJM0dEeDBIM1kxTjNRV1RFQXR3Nm95N3pWdzFwcjNCOW9FT3RTbDZCZ2xv?=
 =?utf-8?B?N2kxMWl5VE1yOHRpNmt1VHMzNC9URWY0RERtZk1NeWs4QVVPcTZoZ09nWldS?=
 =?utf-8?B?Z2dGNG1vNThiUmV5Y0UxalE5VnByMmtrUWtMUTBWOEhhRU93ZVRJbm1nV2Zj?=
 =?utf-8?B?NFQwdmVndnBwcEtyTTA0SXlUVzROclF4L1Z2N1lHSlh6empoYlNRMDRMMHhX?=
 =?utf-8?B?Uzd1NW9vRUJ2a0JEaFZxeVZjQUVkWGkzNVRWNEQzTVFHMXp4UTVtZ0JlcVp0?=
 =?utf-8?B?a0doMnFjd2U1TnZETjQ2VWJIOXBCRGsxeTRhVzBCQnl5SmxIZmUyOWlpOTFp?=
 =?utf-8?B?R25UV2hOankwK0IybE45eTNkSGlTbldVcVNZb0Nwcjl6bEJyc3lETUJZM09p?=
 =?utf-8?B?MXFiNGlJbFp3RnZlZ3RSQWhldXk4T3pwUlVEcE03dHltZWMxRzF1RnNaZWdI?=
 =?utf-8?B?ZndMSEw3SzV2MHY5VXdvY29PZE94dlBTTHZna0F4MXZDNlV6TWluVWNnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;6:kxKGBqf/QGWS3yKVoKwZadV54EMUGZ7K9NDGTgQzX8C1ZWB3pXqfMwCzaQEZKJFAJkieV+WvbBk6LEi9b1IGaK2Mg61xvdDCHc5WpcQNj8FlsOZCqyjMQwbzNr6pywzrMhyPoMdv1OZK6VSCHok0fS8DNiRrZHOVzylP3D0VaHETCh7GysRKNODBnjhOS2lVNastYPijGdBs3pUh8tdgNfpTDiBuRo3xCGCpnUSHHaukw07fuNgSf/kdCF5t81lz/gUkpADk/BlnhjvPMxB6Mo86JoBXPILEzo2YmI1UcJ5QyQ4oGluURtEDKJSvJ9HePzn2qH6Wk6RrGhixDlIHvcAOVGk5dqKO87t/sAR2kl4=;5:PHyAwP9eqUS+Ce0OEb/XThRnc0pVQea01N3y2S3ShkdR5J/4L7Yh/aDTRCDxcaKWnWOVPDdiek8WdnNz2sKcJSbmwD/mbUgRbq3zzue8tjWHLs4xKQSOzJdldkG1zoX9ww/avNy3N7h1GoFzYo2UpA==;24:ESH2AbenBuwavwvnUJr3VZmP4sQt2dR5xkglQLmcs6+ji6eIj4McITR2/QVaRnpTrSbyBQwMh4HNOCJNKHLSP7ZV/K+ttAUDU96OYHJKYCo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;7:sNyaFj3oX/8XvkQ1GVeLnl/ZADAOwFVMuQZRBsE779/LqA033xRpKdvLZdV1tZQ9MvQPKggn5NuHL122G3M3Z1KKyu8KaXZzu7rq+0aLkhzkk1syrSkNAqvVXZZ71ZBvB6a4HGkcStvk0NMM5Nf9h/0F97w1tyLMLwsitODyoYvwthwOVD+8rvUP6qa30CmHCtx50uGzxJXVnRBcYrYnxaPDV/fdq40/ArMUQS//ijqq8B8RXOkIjhyIYis9JQl8EsYEIF8qL9jTbfKv4rMEqmoZOrJKPza4FSLg7Fi8lmO3EjT6tiqHKft52WBI6Lcd14fDPOdEtX44NKTBjqIJLBBu6vjLtHrKVPaWGRzbIwY=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 19:43:49.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3205
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55854
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

This patchset enables support of KASLR for OCTEON platforms.

Steven J. Hill (5):
  MIPS: FW: Make fw_init_cmdline() to be __weak.
  MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
  MIPS: OCTEON: Add fw_init_cmdline() for Cavium platforms.
  MIPS: OCTEON: Add plat_get_fdt() function for Cavium platforms.
  MIPS: OCTEON: Enable KASLR

 arch/mips/Kconfig               |  3 ++-
 arch/mips/Makefile              |  5 +++++
 arch/mips/cavium-octeon/setup.c | 23 +++++++++++++++++++++++
 arch/mips/include/asm/fw/fw.h   |  2 +-
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
1.9.1
