Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 07:57:16 +0200 (CEST)
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:58480
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990511AbcIBF5JlySU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 07:57:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OO0RP1sBH525KDEmdWV0cy4MYxorTW8G6pHWmTBCvMQ=;
 b=FNvvAqBMTUpH618HtiNrJjSfBs31TRkl/LPRL3GJgp4sbPkb8PwE68BJjsypBwv1jqAowVAKpiyiZKo2m7Y58GS4XDvMJgdyIerrB+i/2n47MzcLplo7XVLDpdCu0VoT51Gs+/Kq1XQy4DVf/WmeboSBRhiNPPmeRrAK6ClSmoc=
Received: from BN6PR02CA0058.namprd02.prod.outlook.com (10.175.94.148) by
 BY2PR0201MB1495.namprd02.prod.outlook.com (10.163.153.156) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.599.9; Fri, 2 Sep 2016 05:57:02 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR02CA0058.outlook.office365.com
 (2603:10b6:404:f9::20) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.587.13 via Frontend
 Transport; Fri, 2 Sep 2016 05:57:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 05:56:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56791 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfhTI-0001Tq-L2; Thu, 01 Sep 2016 22:57:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfhTG-000618-MV; Thu, 01 Sep 2016 22:56:58 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u825uoCi016478;
        Thu, 1 Sep 2016 22:56:50 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfhT8-00060Q-FF; Thu, 01 Sep 2016 22:56:50 -0700
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <33b0c20d-a939-0e26-4443-dc41ba06f250@xilinx.com>
Date:   Fri, 2 Sep 2016 07:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22548.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(189002)(199003)(24454002)(23746002)(2906002)(36756003)(5660300001)(63266004)(33646002)(4326007)(5001770100001)(106466001)(65806001)(92566002)(47776003)(65826007)(65956001)(189998001)(4001350100001)(36386004)(626004)(50986999)(76176999)(54356999)(2950100001)(356003)(81156014)(81166006)(305945005)(230700001)(87936001)(2201001)(7846002)(31696002)(77096005)(83506001)(8676002)(31686004)(50466002)(586003)(64126003)(9786002)(8936002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1495;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT055;1:2ZpcsVZtOW3tfP088awr8Q66xpHwt3b5G5wYgQdRKIZ+7TcLwsqLimo6UG4qHdY7RCWIlUDsjYuYz1ktGTAcJYaHWvAzNHoV19YbASVFnyf0t09Jn7kj4Pf4+uwrE0kjKkPCtKym1q6GqHOKlxQOWP7LVxpz3KiK00ddorYmCZDFKADO+DIPxOUhxSaOIIiwb6+j9yeKidIKhWElA1K/eIoCzdkHA3b94Nz5/5CvRpZPp6L6gROOCOHw1BfmsJvWzYjECVuVxJnpMt5edeBDDMm4vCAi7++r85R0Ah/rWQN9V1C3awYM5j4+maMk6QgSqFQbh23gqK8r6y3x5/ddvdzDmgLU27+DsIwnzRTcoj6S1uMcRy5rL/jLXRPArswf2Ti+FiR7/uee7CmM8inlKbXhDWiI16Djhlf6u3D572xB1DtHnqj5VFFyUlFi9sFdAy/QG/p72vBlpDCCU6jcOiaMPD7LATGPMNgyspsmFEO9UN7wxwx/N08aJVK55UzmFdKqOUiCEvRdlQ/8GIZY+xxAT55oc99ELbJKFXF6y+X6AHwNCXEuSHnkhSTsqSkU9W6GoA/sd+l66NL3V48i5g==
X-MS-Office365-Filtering-Correlation-Id: ed98e35b-4dbb-42cd-285c-08d3d2f5f466
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;2:8eUQWtDrClwj5BzNvcrSAbC+I8E+2CC+f0iHU3hST7Rma/DPvDNIspUNLEL//TXSaBOxpuf+DHDKalQhruky+sOSx26Bjx6i0Bw8aeL+Ak0JgeiYZ6/F2Rf6vqmkiF2bRkNnnzzCoh411LyR4MtI5yMEgXLJF07iucDip8nK7M7mOzOj/H7PLB+M2MAmQ3mv;3:6N6eJj8RN9RuSIgDu7Ec6jBU3fqUzUzm0XKX7cxAKxzxz2j1yZTfRhz17hnrqw50qqEhl1e/5Qxr5pr9Zip1RaATYqk2aV2HZNKxzFN4ORmavNRw5WrusV7kqBhEp+Rl3S7ztt7Uoic+3gPVZ5JNFmgBxC4ZkLI8LuCjTQTaNV0f8lEnk4jZfXhRSQzHWxU9yas38jyI2GUG9u3QGEMqQhkPpbecUvmlnsAXtWpgTon2yzn2c4CH3qr+tCODjPMsybOLG1g+Ndr2WXM8TMEYSQ==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BY2PR0201MB1495;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;25:NFH6lu1O++T662EwrWzRwTK8Df3kn0mlip7DLXwewofXyAIsZUTJjgcSlx70VCqyaSNWmbxatBv4JfP3Vo8q3B1V7uVoDxjvPaUcyugk3eNis9H+iUOnwheh+jLtuVn6oykMY+X4M1Z7uE2TwlNYzHCO9Loy3CCopmCn83fUqES/nfW4YMgoTPOSKAMmyMM3Yrocyi+r5zB7LuE0cXWdJwqBakDRIoIMcXM7c8SzTtHDNdH01dYNbGG/OZnGtbTxZ+mTJMFrqPE4/z8Tc5gxzD2HEWiDFwajrdO3uD10oaRZ91tNz4oG5Y0HofyKxV+jiUpXMcTEICH/lLeRrctX7+W2tv0URgi8mY2IFf8q0PBVYDP2DfNBpdWVmkjMi3MkIvCTela4ch4O0JNkdCkZ0bEJYYPnykzg1aaYEGzLwFsMj9agd+HstYLbORGUjVaqoFuXGm/q/wSsld5wevQg/SQ1KZVBpOUn9qpN8qt567X7DodRW2jq4Mn4tkZMJSwtdhx5T7M/qTipsvBeC07C1THXO4zS61RFeq2f6dlvMpMksESrwo2gEMuJP+kOsPFkfMdYWD9qKxQzXelwhWckkHxI0N9uL5f51NHgMQ4LrgdWYj0t7YiSrTW15R6HGjp83a4WKsJSMPIs5CKz+1+T6U41WjU8J1c7j85B6DWxQXKpwo7oXDhLvdHHZsNVwi8UX+lcy4sKQJuwB4FL2FH9Fy5VJAE7RZLzooXbzHtZVFPaC2CUAxnnP33ngZwkgKkdv6PrkjSfkzf1EiO7e8IktA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;31:+PUJf3F3YC2zZKHfMd6ttjbyzVZQ4lQ6/0VutFVUk8il+j0C3NfqPFkKnoqYYigSj1RlQVCwF/WCbd8bgkDrpHV5dOFLSv/bmfiibTs5BPtNMeC81dPc5gmOjhifEyN8GPpmw+TLs0BjJgpCOvvQC4xkLYzFjrEd0W2KSbtnMe+nbusTLfbz7+q5Tl8yfdb2RzuAAutLFjILdwLz0DVt3mz1QyqnHxst6l+SKq0tKZ4=;20:SFwCI8B64w1GZpJEE7yA7X4WfwDZk14+r8g+cjAQqrjC9KilA2Z8a4xoIPL/HY62jeGR0MYzkGPjmp2ivSa4gFZRIZpb80nPJsCHPgYyIRRFmq7D6wWLZXSoma8NoidMMP8h03N1fuzVhu9rsd2uNH6RTIPcyw5XnJZCX+7rjYhkuPIh+TxnGY3IgnN5NCm6X1tUAaH2lFSTCScr3bGtj6WXjGJzPyD/sM9+GIipdQDyz85eN6NKnTMXW+K50/nObR3q0a1UOJlcS5s31xZhbN1lYWZyPvBZUFzqjpvZreHeLUpWGPP+oAW3MZPRsfjCalputjjlgYtAUxN6UwxL8o0PbMdTOWJGnDJmvX6YASRUeSGuKS2sf+xKZyfXgpMSO07zwKgJj3eoOFGNZlhsJ9BdISCEBUF8A3PGJ3CAvOP2j5HDAyNkv+aZjMQrisC1jg5B/v8c47ypE+6kxraH9/Zm/9rC3d7AsBfRl5XeDJktQIEJAtpFeD4uznUvtEeZ
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1495DCD1183D202193842D26C6E50@BY2PR0201MB1495.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(13015025)(13017025)(13024025)(13023025)(13018025)(3002001)(10201501046)(6055026);SRVR:BY2PR0201MB1495;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1495;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;4:rVKque5GXEecKTR55M9MDrbUxRnf7ApSlSJC6wrAveuf68sFhqus0xZzt66wTc59XOeB9ySPYulA/oSltpyI5Y1YrKNBrhshHnwj2nhoWwhST/MOH12KlLG8aZUlQqyxFlkKcsS5gZq8RvwMY337wg5E9abtfirprh1O4HlumR6y8KhlU3SGQzT1F6NkRzd9HeSnfkn3NRtUKs4s+8JpJi5EpH9NCli9JwG9uTNN70mie9cUU/ldo83GIA6z1q7OChtb15Y5kKAxLTrKGxUjlqeZj6u48t3AcWfBIJ6mYS1BeEAp1YMY+CD2H5b08YebnrJTdcybH2lIIDIfvjilj5zdfTjBBt981jeys+VtxnXzUj2g0AZm9eYA7al6JYqLCN8SRY05X5gJqXyr8vxOxk+vpHz/GzRikzEbwf3OHKmRyAWFBzAvN5ZEnH79Y1SRs5G+/z7nRpH0q6/PM+ncoNBMMb29trS5znLW6C8pNW7l1xnedlTZZWmmixGs4ERY
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR0201MB1495;23:AQtJbGtb7vvETRLbfJnHatom3vCzz811oDO?=
 =?Windows-1252?Q?8F0gI+hxbX9SPVGQ/JHayZU+Nmg4x0KKlgDsSHswArv2qndU0IPuNbYv?=
 =?Windows-1252?Q?SOF8EFoeflkORMT3RGQHA3LybuKU4L10Jqq9o1vaVd4OAe59aj1LYRRR?=
 =?Windows-1252?Q?9+j6TVN4JNv7WwsZ1q4f1xswfJFVCsHLQMgjSryMcR/7rYZYOBEYGWiU?=
 =?Windows-1252?Q?A1Qj6DcD/ujZsCKoPR4GomsBVFAJ30F/heJSvjNXh9up7mJ6CAh4k67J?=
 =?Windows-1252?Q?ijI5Xu8YKAS/SbNOyNFrw96NB5RM9IJxpGuQJWqpcTMmJ2vMSig3O/m4?=
 =?Windows-1252?Q?jg6rx2lYY018c2UXDvgHy3LwF7cU8A5m3DWGJDIvBygxrTIKIJQopT7C?=
 =?Windows-1252?Q?i1/AxcvwS9lPuk8GkLvYP2SXF1ompzPkYmbFX+5VoFMrUu0cK3XOhoZF?=
 =?Windows-1252?Q?Vwx6Q2t3hntDnn3x6hNl2lPfbvA/eGgtPrlGUNR2lGBSUp7tShboXQ0w?=
 =?Windows-1252?Q?yzvhyTxnyQilsbrgOD1j5KzbqPeN3cVPId2JPs7orpfGFzVvTpyH0O3J?=
 =?Windows-1252?Q?Cz9RzXIBv7jD1DIiadbt8Q06Wi+6jUpUKMvG6Rvp03NBBSXXG8BoKOhe?=
 =?Windows-1252?Q?9BASYIBx1aiHRqVQr8dn0ifGqUn9xMKIYeSeZGrC1Ntg+0v/m2Zllma0?=
 =?Windows-1252?Q?YHp2XBIKjvYZj8FJYEWFVjGhV1VswCFbg1dCeJY2E4m28BbuWe49iuhu?=
 =?Windows-1252?Q?uFP1MtR02ZmBLchqyi6AiOfhGRj9C4BjEvFu9K9fd8iY2tc6B3AUsoQ+?=
 =?Windows-1252?Q?Yxwhn7oxxJkB6P1ggHDnhH+AMDlWpy3E8UC0AMOkYoOo/DrlCDnP1TSH?=
 =?Windows-1252?Q?xcEa8C2LHl+AFX4HluZVGgwJyWjK+VqzyV46byjfKqV16XjyjggfHyn/?=
 =?Windows-1252?Q?n5XhJtKhl573wcFO9Nu2+XUW0ODGmRLDng8Ujd/qyWGIAVscXt4/c/P+?=
 =?Windows-1252?Q?6bWcnhKXXytqil6IhsYbCQirWAfsgkT9vUkPuCCm37/1sxGrmitvmyEh?=
 =?Windows-1252?Q?Pnhsggjaz77d55z4anZ+R/s73sOv4KlVWqbNOxxva/CY1LrXBHpH3nmQ?=
 =?Windows-1252?Q?uIsPN8Hx7arPb4Lg6rbFi9TZMbL4ubLsnWcnuqnalnoQmlUKv+WZ5im6?=
 =?Windows-1252?Q?dvY54Ru1DPJPLoNAlEHoIoVth4/QtmMhv+619Crc7ts+KD1fzBSoAeNb?=
 =?Windows-1252?Q?QHz+1SdIY0aquV9LkDIvTHCEkMR8nE/BQhcK095g=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;6:fpJJEbbxepDzavQx5kmBLyvZS/+jmwX0RHHi/Ig9LhfD45VyVOC7T5Pugm0V3vn/OJhQ+OBaoyNXK02oIj9VlEpuv0lL4rsgSN2XpjX8bXW/SWzb9QXOJ8TX51u6o7f1hHCI7pZyvOT+TCHJKaqQ7z+fjN6WkDo2/I8lREi8yAymz6YEZk23oI/QIcKRr8S1+Vc3neTLlFx1+VzBEja/fILLOiy2+dczrqab84oQCoSbtxmnSB2z7G5yxTH4TP1XAVdr82iGFhIJ36qBH7HFcyOGfwGuUs7huwbcbjkKtTJKP58nDtLVhsOvhK4xoZwtBLS75N7284+xmLdPMT1EFA==;5:X/gKpwgNSfd71yalBDaQ7R1xzNLJ9Rs6+vSt8V9JZRNUZ0xSsnU0+qIJ9DEVhcvnkMH+LNrYgd4POavTRomxPQczh9ADQKcIRRnp9/uOa3YzWuXR2rQTLYzI1WI08rCZGBg7oXjkJ2qJNpnF5GyVcw==;24:CI3dGuDMkJIhA0xu72DbNbaltugfh/EfhwnOw1i/jKLRrJ1RdLgxpwjehQ9+PE1fFjw5Dp1kQ+uTViQWnAKlcutO1tRu7jNlpfSkEGxtuVQ=;7:U2KjbSli89Vr/b+YwV1rXr6HsUQrr4i17jNFqoid1YaNfJQR1cDBvsX2ByM7hbkYs80PqTWKK6O5EJV1gxawHEPT40Flatcs0fhNGLP4RyWadcQIEHi+3nMBImhaNoZDviIcgAw0sSFYbbGmO20tEbnf4XCpvQgXd3FC2mfnheL2nkK2x54nhaAVAuZKGj5yf6wqG/PBgGgpDNAtgOzeza6D4sGOojyjKxOpm6TWmJgWusAVNQ9oA1vwhAbZjqOd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 05:56:59.3215
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1495
Return-Path: <michals@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
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

On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
> based xilfpga platform.
> 
> Move the interrupt controller code out of arch/microblaze so that
> it can be used by everyone

if this is just move that you should setup your git right that it won't
be remove on one side and add on other side.

It should look like this when git mv is used and git setup is right.

diff --git a/Makefile b/Makefile2
similarity index 100%
rename from Makefile
rename to Makefile2

Thanks,
Michal
