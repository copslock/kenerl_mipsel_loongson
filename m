Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 18:26:12 +0200 (CEST)
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:37548
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993972AbdEVQZ7sN2Cz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 May 2017 18:25:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O85jmr5V+SviZV48FnXmIjPp4MWlKtbbiE77HCT0l7s=;
 b=cuzmXtoNmtckjNcLX5DQyLjsoKJH+IODlDSibcgTqrVoTLueSoe1yr8hMjlLMsn27lMO2f8CPPIGLd7MBkMtfQ1OeszT9JnU1uNhjMW6qmCx12pNaiUpD9hjQ+baRiGveVeIoYPfriUIgqsul3xalDVkgc7TMdePnBKjKA8aK/M=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3492.namprd07.prod.outlook.com (10.161.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Mon, 22 May 2017 16:25:52 +0000
Subject: Re: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>
Cc:     Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>
 <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>
 <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org>
 <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
Date:   Mon, 22 May 2017 09:25:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0003.namprd07.prod.outlook.com (10.162.170.141) To
 BN6PR07MB3492.namprd07.prod.outlook.com (10.161.153.31)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR07MB3492:
X-MS-Office365-Filtering-Correlation-Id: 03c09494-90d0-450f-fd28-08d4a12f3779
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:BN6PR07MB3492;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;3:aG7lbDDFyKh7Q13v1RdMrNr4IrK3tREitxdNVsWGTMt5TTS4MNv5z4KV93038JT2nDlHT+X5ZoJFumMbUZ+0MRSAMpT11dcsnsjq1st6V25XlcwT1mObLHmQwVTOuW/nHOiqX7avp/O1OiI8rLOwOfb8chUwGwsYLqYsf5lJgkubvV/iARhYWdSeD1zCUo+OuqpEMQwhVSe95tHawnmN4DKbbWXtfkjHwndtdyMHQQdfK0t4KbjJLbC+yUNtoa074vrSqrblrNhPZqQ64xsOXnbNlAHxvJ+TkmWAAiqZ+NjN6CJuxjwck2oJL2dC+YjfI0cwrbkETF3Bcx0QXg3cbA==;25:7fsRmkMPopNAhoy1vIaT91biq1pYLy683UnM2kOQk1sBIE/F+X+tCv9oPwq6zj6n3eivAKNKET/xXFKoQM9RbjBi5wwDDbSTNVVV4mbL6QWi0Ncf8zci+O5OlRUOcVMEbS1DIRTkdxVRvM9mnDGESaibWmBmL4/J4zyZ7rNOfUVviUuqm2t3Tyf+a0z9ZmgaB+7JIC1r1HzqCJ9ZDzyvc6d6sInlIlpuzT7kPWaex7HQoEoCVAJEfwnH+/TICjf7mcDTS/YmtzJQH9+/NFK7Gu+xf9nX3kxR1qIjv2zFrLs4MMjSLaR4GNQ49cxqgBEDvakT1WMGhXlV97pgDx8aRj+0vyCP8Ay9m4YCyVHnDG8FtbVSMG93eGgJaUJEfgut4ihc0h7hwxFyrdFF185T/1oS3194UA7G02ZKStpRMNgfO63GeUOk6hBH9/sElcpyvHDRKOOwwaB67vKJegZ9oPX9/hj7OihAT9K+4THXW8U=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;31:+oXldNeRECk9Q1Zb+OZ1D73s+qtktIO8jlMb/gWVXIm7py7uPjcL5jyDH4LR/JFDv1GposNH5zRs7enE5cRN415fYVC+ug82q/CFxB1jHdMPIHOQaFsFpBmvR8edoNS1WojzJW0zcL3HcaNbCvc9O0hd/N95ELjtH9ffjIDAYawQ8l1lmboSoCzXupztOvTQPQ+QoYP8hyjfw1b1CuWdKimxYPv57PzUy7w9pOEMRBU=;20:hVuCD3Tm+j++JxpHvhoDugNhqqNDp+GSG+u5jWqT4MxkOKW/DGaqi5Dc/s4ImOOroEQFqrwSXkn5e0lYbTnogb2IcDsBCAscqnSKoCwvEnb13L7sW9wfKIh4gFHbz6eeZe6tj17tmm4lyxIZy8k/tmYHx2ZXneOnj9h74qPXs9X3v9zOvYkwSHLuKgBNFLfoSyEzIRvNTiTmmrqeJu+/DCAIVA5mzxvk4NaswWs0orBfBkHGDawQ/MB46t/lA8VZnU1Lw4YdiPWgtGvmxOBbVpfMk5R9/h+qHeSS0yN72bGZPlp8ZxuAURsh7aZTOq9fja8RLAvWR2hbyUE1mmuzk7enVKj7ESqRZhka2gnjfs/q2mr+JsHG5o1DLNiMJsVkfXGdhOkND0rA/ZdXdyovG2pmSlpkpcpAS/E86jW4xY/LJdJwp7IylbPtuyhaYUvY/miG9+yD+q1rT6yU/XfCgfX+xyW/EfMzQkc7sqvybm96DIcSTIAcnvzKg2hE8Gw4XQWM3pWDDB0weSA/cL06/hMfbHuOs01w432BOz1qzpYu0PeJuFZB2OO07k6gYkk5ufMFrSmn4Y4gacE3OLT+kMD0xc3bM9kqWplTSrl6QNo=
X-Microsoft-Antispam-PRVS: <BN6PR07MB34922176DFA4D8FAE3F1F0A597F80@BN6PR07MB3492.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(6041248)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123555025)(6072148);SRVR:BN6PR07MB3492;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3492;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;4:9ZN5qzg9nKM/Jh4Xn6GMsQCQ2ZdsbfRDO2QuTqEHINGU3iD8ochCzRst+QZKJ9PYmWSLbbtzrQ8gRzpWjMdaD/W8ftAfUozn38WUAKWX3gPaWGH8d4jsSwKO3L1C/vHtkZZreg9itcFz9feT2SYr5LhiLKY1FJSPwPVTFZ7n2gwCbPZNxWf7sutgvS9tgY8094Y7waGb2srYWhRwh4Y3pb0orpxgroQAgmyb2/rvmETbkXrxcYll9IGWu3SBscw9fv54cR4DXgGEjhUQWNH2M0hC/50lFyiKoFkMPcopt65nKZxct4ghXmUQXzFBDo3lWNGyKcOzdnObWfSqk3Vi30qVXPZiR8E+BhoZB29rkaN+vBS7FSEPcDVrs3RDxa5v7i8mnKRaZ9sqwehN6i942jl9PsnG8+va03CTlnyFsGYCScVc52CDt0XYE4FsSV9GKmkw/S4qeXNMQNI99KuirgEw8YTHmsE6b/5/xwYXqWQWw3DoxlA9zUWTWC4lNxazNl1ul58rRs1VKkYSvKF3cHIjSaZcRIStuFztX3UDmqAVI8+/L9/gN/En4fDTJLvN2gOpNK1eSoQw4+Ah52rFEs9lu/3IrE/tYf6BH+JjCsIGhHmt9rwNAJsD1Th8T/92BFbRkJbs00UdsLV3hLagvZCulQXUNxurSaJfrTPEEXcOK85/9m+kDFlos69JHTYksqDN8Z+cOBio8ejOnzATu3Xwk/C5dH7U4kWKAdJT1z7MMJe0y8xtBw0WFirT5m399urWngFfSsuZlp8L2ZbX+w==
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39410400002)(39400400002)(39450400003)(39840400002)(377454003)(24454002)(36756003)(33646002)(6116002)(6246003)(38730400002)(107886003)(230700001)(229853002)(4001350100001)(53936002)(478600001)(3846002)(83506001)(6512007)(189998001)(64126003)(6486002)(31696002)(54906002)(42882006)(2950100002)(54356999)(23676002)(50986999)(76176999)(6666003)(6506006)(72206003)(42186005)(5660300001)(65826007)(53546009)(31686004)(47776003)(25786009)(81166006)(7736002)(65806001)(65956001)(305945005)(93886004)(2906002)(66066001)(53416004)(8676002)(4326008)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3492;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkyOzIzOlFVV2FvQTBKYUJMaHhzSS9aN1lIaGxMd2Nw?=
 =?utf-8?B?Y2ZWUXFhSEJGWVFIbFRkRlF4RWtyYmcwVEQzdzVNVkJzRzVQcktJdHh4N1NJ?=
 =?utf-8?B?aVQ0VU1mTEdYMUlpV0VtWkxtUmJnR0lQT2lpcU5vN0NyUDByNEZiUUhZVHZG?=
 =?utf-8?B?WHZYNnVvZ0dqREhycEc1SitOZUFjcWpLcGN0K2pYbGFjbFFSUXI0UEoxOEVQ?=
 =?utf-8?B?VDVPTmxBRUtUUGNrcVFlNnhHQ3Y4TlJTSHdUSEF5d2dudUpWZG1HeStLYXNE?=
 =?utf-8?B?bGNQWUVMMTFwZS9YSzh3UHNmSWMra09KT3RTaTlya2Rpd3Z1Zis5eGlBd08v?=
 =?utf-8?B?dVByT2hrT0RnWkhDdFVGU1BadFZweVdReGtvbUlYZVlSSnJwY0tzN2M1MEIx?=
 =?utf-8?B?UzNFWm85SmtYNXp5Y3JaMEEvQ3NtWlU1SzFGa0dFbWQ3UERrYU5EL3RIMklW?=
 =?utf-8?B?bUs0VDdjcjFKMkw4QWtTZURXZ01NanVqWUlFT2RkblBHY2thMi85ZUxyMEVP?=
 =?utf-8?B?WjJNcmZOMUhqRHFFUXZtMjVmcC8ramd6eVNLRVlZZHdoQ0d5RmN3RHpGcEtC?=
 =?utf-8?B?VEsvN1YvNzNuZ01ST3JaNWk2Y3kzZTliZlc1dzBFODZXV3NxUmYyc1RXamx0?=
 =?utf-8?B?TGxpYUZ4aXY5YThOZmJzb3lyS3R2ODJWcWgvZ2JmRUt4aHlTcUJkd2djcm5o?=
 =?utf-8?B?WU53VnJuT3pGS05xL0dLZ3pNTWtBK3lVc091K1BFT29BTW5SZzkyV3c3QXR1?=
 =?utf-8?B?aVRqK0NIcU5ocXlINjlTbWppYXJ2Vkx5WDBKd3dOaWxnL0FSQ2dqcHhEdGVQ?=
 =?utf-8?B?RkJza0tEdnV2NDQ2Z2FSL0QzOWgvM1l2Slp6VHlDcktyakE1bFZsUzVHa0xr?=
 =?utf-8?B?V2U3NU5mQ0kwaXZPa1VNT3FUNkRRZ1VLczBTL082dytGMm5sMkQwZXZZd2ln?=
 =?utf-8?B?T1IvYUNyWEl4RHdwYzlZaW5neHM0aUVBaWFqY2pXYXRKakIxMzM3dExaczRB?=
 =?utf-8?B?VWhVbnFJV1RsUTJiTVBMZ1NJeWRmVlhoSDdOTG9wcEZiRlVsaklCOGtwRGxq?=
 =?utf-8?B?dUVxR3p6M1lCdlN0T0tKUVR6TCtIemExRUZHS3ZPK1RIZzl2TUNaQkh4RlJi?=
 =?utf-8?B?NE5rTUhxRmRldHVta2NPeWM0bGk1Q0RzK0tKRG1Rd2FpTnNERlNra1NDelFs?=
 =?utf-8?B?RkNtbXI3ZFZYZVRtaUR1OWxwcWt3TFFiYnFMbEN1blpySlgzN1JMemNSTmtS?=
 =?utf-8?B?WVFNa3dPTTVCVXJFQ3U1a3NNMkIyZjRHRVYvNVM4VHVodXdTQlFHSnNEWEV6?=
 =?utf-8?B?bnVxeDJCS05PdkdoN2RrT2t2elVxd0RlT21NVGkvb2gwRCtyWlNObWpHWE82?=
 =?utf-8?B?SkV2M2ZjSVhwdGtIWVM1ZkorcVhmVG1qMzhNeEs4THZWT0hsNWVhajVHL1E4?=
 =?utf-8?B?aXdVWnkyTVVWUEdwQ2V4Y2dDUmdFZUVkK2pNYXR2YWVVMk9FQlpnRUlyM0NO?=
 =?utf-8?B?UTdRUmlydVVPQWh5OGdJdVYxZHNiMVhXakc5VC92MEVYdVphOG5pZytZS0xj?=
 =?utf-8?B?MndsL05IZkpsU3lZS1E4WmpNOTBYREZROG1XM1phUzhvSUFpTGdQS2FKY3pn?=
 =?utf-8?B?YVlZNU02UHRoVVZheW1YWC9aVUZod1hlbk5QRFRHQmVsdUlMYU1paWpkeU5o?=
 =?utf-8?B?MDJ0YVhQOFJlY1pGOXBablNlOVVNRFlOSnFvK2VGaGpnVVk5MXRTOEMyY1hv?=
 =?utf-8?B?V0RPVUtRYVJqNEl4eTd0OEhhL2UwaXhMNVlML2RBMTg3ZGZ5TUNIVlhLVGdv?=
 =?utf-8?B?VmZEclptcVVhNkpob2xWa0Vkd2FyQjhuL2dVV1NRTzNPRDBUOUdkQVVhZEdS?=
 =?utf-8?Q?Es6eY/mbiwc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;6:fsx6Nc7j/CxvSlVc19pQm+owkGHIEUqUM8KenNEi46fqyIKJqxj0pMIzY2Ry4N0BLjLSO3vA8d3dMhEzdOllcJfO5Wv/m6Wu4Xx2bgj9gj3y/O1kjOJ8pmN6cQFZ9DhahFWM6QWVkWnwkz+VfKn34KpZbKmSWfgHdGv3Zlmm68qNLaXSdEujM6AxiSzX/MRqGitkvJTyMhkSwFEJs+k9T3A+S/ZF49PIr3FJ+F6Jqm3IqHRN23BYTuHjmHWKWsl+h0MH1/3uMaxb43+6/o0kHLHAoLTyINtlB6hn/FbKnkxDS+l6fb+XCSrPtfY0ITNRu14nn/sCjM6QkLadkBNHmtsGn9fjUzUyq+lrxGydIi4K3r86O2TeueAvaFXXZixMPDFXTOY8rVFYQTXnYFLaTFbZXEQjtFqyTUSZz9rRmUBvbsoY5KSoe7EPFufsy17PLdBfTtSnm6qfgak4eaDmtNLNvVdgAO53ei5widEwt6CwsYe2SXjLKZVtXBE4JG8vkmLubiQwuzNie+CVFmtAJA==;5:PudBRqL2o5ARQV0ck0nQaUuIcMSxW+EZ2onv6MDaD0+xzZMbWyj+tiuZH7NDHcU7EmSozdsAXKiPAu+34lAsR6YfeF5I01yTl8XSISjHfIhr2eFiw+WvbdNo5DdHJ12WpjzrP02nSe09ESLBdOBWyw==;24:7+zLNLohsv+CQowpUZsm8QbcXe7Tfo/bg/BtBphYlllhGvtA6T7JfGhC1jVTL4yaPha1oyRNaieOSr5aW0NXg3iNA+zW5cJqWtXxDUCsKQU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;7:bdvllhPwwSi1wKEQ2+AuEbSAoA0Ypj1/js/alonPZqQy45tLuPIup4+xuzwKzTNHcxe6nhxn6m8deaRq+JKl8TeTj10cEmY4rrcAKoQGjeIwBisdIkbhNvKziUDhLmvgr5C9WRDHDEVmaqHo+p83G2hpZvaIKVu1r8PwQ1L7yZARi6mQ9EZxgdgltk2Z6rmkon8syNr0ZK4v1Q068/fB36KzOfmSfT+uluzXBBzVMf7Py7xaYzlf1yiupZmb9OcS7A1bKS+Q8vUzrsFax5KIM5dTMiJxyGx8d+TpIyIQ97jp8x2vT8GAqfZyTdzeVgXahl5G0W1O5t5cUReSrq0yzw==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2017 16:25:52.3672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3492
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57938
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

On 05/20/2017 06:37 PM, Maciej W. Rozycki wrote:
> On Mon, 15 May 2017, Petar Jovanovic wrote:
> 
>> Define Cavium Octeon as a CPU that has support for mips32r1, mips32r2 and
>> mips64r1. This will affect show_cpuinfo() that will now correctly expose
>> mips32r1, mips32r2 and mips64r1 as supported ISAs.
> 
>   I suspect it will affect more than just `show_cpuinfo', e.g. some inline
> asm, and you could have included a justification as to why this patch is
> correct, such as by referring to how `set_isa' sets flags in `isa_level'.

That is correct, and exactly what I said in my reply to the patch when 
it was posted.  When the OCTEON code was merged, different code paths 
were taken in the kernel, and there was a deliberate decision to 
structure mach-cavium-octeon/cpu-feature-overrides.h the way we did it.

I also noted that the information exposed to userspace via /proc/cpuinfo 
should be represented in the kernel by a distinct mechanism from how the 
kernel makes internal decisions about CPU features.


> Anyway it LGTM, so:
> 
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
> 
>   Such problems pop up from time to time, so overall we probably want to
> have a consistency check with a BUG_ON or suchlike implemented somewhere,
> preferably once the console is running so that the kernel does not just
> silently hang without output, iterating over these macros and verifying
> against actual CPU info.
> 
>   HTH,
> 
>    Maciej
> 
