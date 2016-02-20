Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2016 02:15:57 +0100 (CET)
Received: from mail-by2on0091.outbound.protection.outlook.com ([207.46.100.91]:61004
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013324AbcBTBP4A0ESy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Feb 2016 02:15:56 +0100
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14) with Microsoft SMTP
 Server (TLS) id 15.1.409.15; Sat, 20 Feb 2016 01:15:47 +0000
Message-ID: <56C7BE3F.7030906@caviumnetworks.com>
Date:   Fri, 19 Feb 2016 17:15:43 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     <david.daney@cavium.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: 4.5-rc4 kernel is failed to bootup on CN6880
References: <56C7BD89.2040800@windriver.com>
In-Reply-To: <56C7BD89.2040800@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BY2PR07CA046.namprd07.prod.outlook.com (10.141.251.21) To
 CY1PR07MB2136.namprd07.prod.outlook.com (25.164.112.14)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;2:Ii2MD3JeYZy4WiUwdqGN6LeBqj5W+xRvR+r8/YoAb9gBRHdvnE3b4CsWrmNmXcpONJeF04t1MCcd0884C8g2SAB+i85Ge9srfHL+/rPr3/x9OBV2UoPSB6s0vUHmMoPCXlslLVtAjMWloCiy03CnCg==;3:1S7UX9+skf8KWkfBKSVmFo07xGe/DDj+cyygvuKpUTtWiaHMlgnMcxHix8tIFHPAbvc279aHzKEMTbOnnKET1sY6/rEOXnGhA+soLFPSgmoFcUl5jJp/UqmGKg9T+1mD;25:IjtNJ+0iRezDTkbdDLmwV7WvuaH/LUa7spxfm0Q5uOx2cFGjDvo3sJRynbQuvXxng4Qn36bqeOVYITEgYOJPKFA8hVQsB4UmHGqJzscvNIZka6CMExawnsSXgecBfT6iceLB7x+G9cAjykPFKJwhfobctLFQOF3zLM8ma2Wh6d2VK7SQbN6Ci0BYuLRz47rinXuaRQxyM0Vi+tsDPXdUTLitRipS1j1hNdZp2sxR9wCoeTwh0yCdIpuPswyZFq93aUhnrUevF2fKf9kyJ3LJf2s1oJFwmP+/MZhCx7rVfwJDAiSe33AYN87pV4oz8mFF9sbFigfa9u4VNqV3X1Ovd7l8zXmB5l0U6E4nI/oYEuI=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-MS-Office365-Filtering-Correlation-Id: bd3b2818-d386-4b6f-bf23-08d339935d29
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;20:A9bQf7Aclf6U+ZDfxbij7rxuCRxrf0j9slVwzBsMxppMr09coYAaLOhGGHMEG0CFKD/91eb6zCDINmVgaPRrckQ1YBALvepmQT1T1d9A/p6tOQRbIVR3TXLgZOgS8MRRCl+//SjXtNnbuzLrIXiOKHwJn7afSyMJ473yPi1JXemWsKQJ/pnVKGsUP2mQJNsg9MfEV1nPVlRf3i3reM765WO2ecVa874zFsnHE5JMWYzTfu6o73WbcQML4zNBC+WEtfTz68j11e9Gm5IFLrEN+9ePDNHwJVQ1EHpcaCa0ZMghlQFEL192fzZxj3N3BTg7mRV6fY7DNOqYQslAla953qV18qwxituYI5Fp+GwsXZ84bDWO+im21E4Zp2mXlPSQeFZehb1nJpplPj+03NKQOWku0obTNMwvmwTkwx9il9MyH1nX8cqQZwHSI96EnWgSuG/8igYOmXPEc+rEeZNLa1FrKc/V63yfLaQza2hh3WN8oJ2+5bzcZAbZ7dxXCbjfDVc0rgSbbMsdwU1MH1LsVmT8Kw4hTNiBjNlosLFzqJtRun16ZS5ef/Uxmjw/SijqEFnvlw4/Zxo3yzoH+ALM2Mb27vEQ6sj/64R1WRDRoEs=
X-Microsoft-Antispam-PRVS: <CY1PR07MB21360608B69302FDCA27935A9AA10@CY1PR07MB2136.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CY1PR07MB2136;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;4:yHkJjkFPLbu4Y5vTWa+Bxu7iKHa9Wp6SBf1Xlw2CMaNfz4Uc9txk7TjI4it9LQcShgrVVCcWllyBNX66jdxm8y2lxOHCk+l/GXGEBbKFC7rxAgg6UwsQ6bOotZf5cBtMsnSy0Cd8VT9MnQkKoo+HYwcrad5W2JvuAWJtw/lhB/TCXqk/X8o8l4zrNAFN553bkqSiXJma3Bka3e+chWpoaY1EHTZL0Jef0BJnnpgidC77l8QTpLNAW0HyscXILHItgXbeMEYLBMS1NISImrihUO1NYVKXLa2Tnrq1ovAGec035CL2ndIAj8smeia9IN/QWuI1XUUlrdV48iC6v8q175zpawwzZVBY/Z3tpOkVwHA7qyrcpFc4H4qYWCtleq0Q
X-Forefront-PRVS: 0858FF8026
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(24454002)(479174004)(377454003)(164054003)(5001960100002)(92566002)(59896002)(47776003)(189998001)(36756003)(5004730100002)(50986999)(4326007)(65816999)(54356999)(230700001)(586003)(80316001)(76176999)(53416004)(110136002)(87976001)(2906002)(4001350100001)(65806001)(1096002)(2950100001)(33656002)(66066001)(19580395003)(65956001)(3846002)(40100003)(77096005)(5008740100001)(122386002)(23676002)(42186005)(50466002)(83506001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2136;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3TUIyMTM2OzIzOkcyWjZVc1plVWl2dXVUd0tSSFJDU3dqN3Vr?=
 =?utf-8?B?ZWlmTm1IeXBDRDhhVjFrRHh2amFmaUduWHQ5Z2pDSkcycTJMczRBOXovdytQ?=
 =?utf-8?B?dXpoYzUvZkk2a1NRUUN1WE5SL3JvNHRsZmpDZk1HUk1vQm11Mzl3SDROME1q?=
 =?utf-8?B?MlRTbmlLTlRnQTJBTFVwc2p2c2w4cWc0eTR2U2drSzBFL0taSU5JTkpQd1NO?=
 =?utf-8?B?bFhBaGhFS0RWSFoxcnBtWWxhTGlzU1BBUmtWcWZpUnNGUWY2bGlvOFdCaHdV?=
 =?utf-8?B?M05YWHdmeC9kTnpOYS9lejhXc0pYaEFjeUdYaU8veHdFMjVKN0pjUUo3RlpZ?=
 =?utf-8?B?alJjeTVjNTc0bFdYNG5ZZWJESEpBVEhNVjRxaDFNUEJHNExja05MRWUrcWI2?=
 =?utf-8?B?aWhJeHQrZVZkS21lVmJjbHAzV2ZmeTMwUU9Bd25mRksxMUZVeWFtdmd2Vm5x?=
 =?utf-8?B?ZnhKSURIYnNWaml2c2tTeDZVaUp1c3JaVHdWRmRLY2pldFAzSjBsOVFzNUhD?=
 =?utf-8?B?UGRjdlYyOTBtMXdVN0ZyN1FQQitXMW9CeVVwOU0waVlZSTIxWTR0UHUvYVFU?=
 =?utf-8?B?WjNoRnpRWkF2NXZpZlR1ZXVZZ1RSRkNDcXg0SElhTFFybFRBaUJhaFRTY3hy?=
 =?utf-8?B?U3k3cE5HNkxXWFFDR05aM1dLUTFiZHdRNC9SOVovL0U2UFkxcnRlWnh0eFg2?=
 =?utf-8?B?SXByd3pmZXJieHcyRlc5NkxST1lEYi85ZTIwWCtFQ1F1eDZ1NkRjeVJsa1JT?=
 =?utf-8?B?UnI5UmE2UHNWbTJIWmVEWWNqT0tzSnFiMnZOc1FlSkZiWEFSZ0poY1hhcFJ5?=
 =?utf-8?B?ZTdJRzROTG9KVHdvOEw2V3F6bTdRL2RnOVMraUtRY3l3cDRNNHl4RUdzZXVm?=
 =?utf-8?B?blExN0VDU0ZiQ2dqODEwMnJ1MzEvRklYMnR3TSttT0ZEbWZxcnhLTG9XenpG?=
 =?utf-8?B?bTFiYjdTSVJGUG9QenVYdE9TUS9JcEU1ZGh5ZlJqbnVRVnBIMWRNYnF6d1FB?=
 =?utf-8?B?eFY0NU1mNEt2QXJ4d2xZck0yOU9RV3MrZ29EUWVMTEVoM284bVNpTTg5NDl4?=
 =?utf-8?B?Q29TV3lEWTNOQ09UYXNFMVlDZnAweVF4bkpkWXdiQzExdEFWcW1EYThIS012?=
 =?utf-8?B?eGFjUCt5SU5DUWRwR3p1Qm1UcWdQdzJPRi9wMTFVSk0xcVgxZEUxTnNHUnpu?=
 =?utf-8?B?MThETDVYaUZRMFVadHNEcDlybGtDdnZmdG9yVHlNZWpSQ01TU0dhVW9iNFli?=
 =?utf-8?B?L1lRVjlhdjk0MEdCK3pxcEE5emJxU0dHMWVUTHA1eG9vUnpLaVZJSHp3bDdh?=
 =?utf-8?B?NHBuNHF3bWV4VXIvYUdlL0ZpdXNFMFBKelJWa2dBd3lMZXAveWF5Qm5WcmUy?=
 =?utf-8?B?ZXpVUWo2bDJaMy80c3loZGlLVXJyelBjek9CQXJWNXBBVCsrektNa3cwRmY4?=
 =?utf-8?B?MGFrdnNrT01OQytYc1Y0WkdhUzZrcFlsbEU2NXJaT0U1c2U1UElpVkVYVDR1?=
 =?utf-8?Q?wAaVsn6I2/CDtMT2Vt7+WY3tt+rofbyPSCX9BfzVDdZrTP?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;5:3lmArPL6chGxNP+Cbs/u8RAAjbaO9+Y6+zsfOuUAUVvIA+FvL1OAs4/o79pg9WZlp0zkXOmDTJRvoyQ/4zSGY3GhjnHnD1ucpXUfhwr/eTIihBQsihJ1o4m1KRFjs6y6Xc42ZeNCzF6GTIytgETcvA==;24:tqAGRVBRV1cqUl8To2SKuYfjKwd8i56gxTkQBcisk2PJHIpZfSt+Vn8Zeo/mZdi0kJ7ltR57Zz9421MmSV5Ogj4rIUgwoKrgdB7aUXA68LU=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2016 01:15:47.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2136
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 02/19/2016 05:12 PM, Yang Shi wrote:
> Hi David,
>
> I tried to boot 4.5-rc4 kernel on my CN6880 board, but it is failed at
> booting up secondary cores. The error is:

Have you had luck with any other kernel.org versions?

FWIW, I recently posed some patches that may help.  I haven't recently 
tested on cn68xx though, so I can't really say what it might be.


>
> CPU31 revision is: 000d9101 (Cavium Octeon II)
> SMP: Booting CPU32 (CoreId 32)...
> Secondary boot timeout
>
> I passed "numcores=32" in kernel commandline since there are 32 cores
> ion CN6880. And, the bootloader information is as below:
>
> U-Boot 2013.07 ( (U-BOOT build: 104, SDK version: 3.1.1-544),
> svnversion: u-boot:107133M, exec:)-svn107117 (Build time: Oct 31 2014 -
> 19:39:37)
>
> Skipping PCIe port 0 BIST, reset not done. (port not configured)
> Skipping PCIe port 1 BIST, reset not done. (port not configured)
> BIST check passed.
> EBB6800 board revision major:2, minor:0, serial #: 2011-2.0-00120
> OCTEON CN6880-AAP pass 1.1, Core clock: 1200 MHz, IO clock: 800 MHz, DDR
> clock: 667 MHz (1334 Mhz DDR)
> Base DRAM address used by u-boot: 0x20f000000, size: 0x1000000
> DRAM: 8 GiB
> Clearing DRAM...... done
> NAND:  4096 MiB
> Registered IDE device 0 from IDE bus:dev 0:0
> Flash: 8 MiB
> 0:PCIe: Port 0 is unknown, skipping.
> 0:PCIe: Port 1 is unknown, skipping.
> PCI console init succeeded, 1 consoles, 1024 bytes each
> Net:   octmgmt0, octeth0, octeth1, octeth2, octeth3
> Bus 0: OK
>    Device 0: Model: CF 1GB Firm: 20071116 Ser#: TSS20037110113081057
>              Type: Hard Disk
>              Capacity: 967.6 MB = 0.9 GB (1981728 x 512)
> USB0:   USB EHCI 1.00
> scanning bus 0 for devices... 1 USB Device(s) found
> Type the command 'usb start' to scan for USB storage devices.
>
>
> Any hint is appreciated.
>
> Thanks,
> Yang
>
