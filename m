Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 18:58:53 +0100 (CET)
Received: from mail-ve1eur01on0116.outbound.protection.outlook.com ([104.47.1.116]:30160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992896AbeAYR6pmJdLo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Jan 2018 18:58:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hCYQex8SOPUs2f6ZnHOhp7IpWOBCq3NScnba7QaKyDc=;
 b=aiVcob/38u4h8uofKq8f2XHv+nGltuCcg9Yh6tjNRk+YWZLz2uTPLE4itpJtus6syy/BWozckxv5kt43PI/r0SozDDYn0IZt1vcOGaAJMsXhlEr5+MpljvPMH+N0ab98nH1YMkgURN7VWCxQYoKnlOxRCf3ih7FpoMf20j8dioM=
Received: from AM3PR07CA0071.eurprd07.prod.outlook.com (2603:10a6:207:4::29)
 by HE1PR0701MB1977.eurprd07.prod.outlook.com (2603:10a6:3:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.444.5; Thu, 25
 Jan 2018 17:58:35 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by AM3PR07CA0071.outlook.office365.com
 (2603:10a6:207:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.464.6 via Frontend
 Transport; Thu, 25 Jan 2018 17:58:35 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.444.13 via Frontend Transport; Thu, 25 Jan 2018 17:58:34 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w0PHwAd5025459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jan 2018 19:58:10 +0200
Received: from [10.144.188.2] (CNU04747CL.nsn-intra.net [10.144.188.2] (may be forged))
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w0PHw88m025420;
        Thu, 25 Jan 2018 19:58:08 +0200
X-HPESVCS-Source-Ip: 10.144.188.2
Subject: Re: [PATCH 00/14] MIPS: memblock: Switch arch code to NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <ralf@linux-mips.org>, <miodrag.dinic@mips.com>,
        <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>, <matt.redfearn@mips.com>,
        <kumba@gentoo.org>, <marcin.nowakowski@mips.com>,
        <James.hogan@mips.com>, <Peter.Wotton@mips.com>,
        <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <f8626b9b-56b7-f1b0-6771-9cf573050bb4@nokia.com>
Date:   Thu, 25 Jan 2018 18:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(2980300002)(438002)(189003)(199004)(356003)(58126008)(2486003)(7416002)(54906003)(23676004)(6346003)(6246003)(5660300001)(97736004)(81156014)(106002)(966005)(39060400002)(4326008)(31696002)(106466001)(36756003)(81166006)(2906002)(64126003)(83506002)(478600001)(65826007)(336011)(8676002)(86362001)(26826003)(22756006)(77096007)(6916009)(6306002)(50466002)(31686004)(53546011)(65806001)(305945005)(8936002)(76176011)(68736007)(47776003)(230700001)(316002)(229853002)(186003)(2950100002)(65956001)(53936002)(26005)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB1977;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT021;1:DJDFpfgl0UTOusypR5w9vemINdkN5Qvl3debnVRUSSW0AmfLIvXkZ8cbrvS1dcbcb/m8ORnUU+tDjUtGCBQxQBynL1TRuQiXKbJI0VYZvMisOGmA4QVBQla3CUvRlmBI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 153971a4-405a-49cb-f8a3-08d5641d4135
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307);SRVR:HE1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;3:A3wpsXf0HCIFGgxFZXNouCHvKrGV376ir3tBiHqIGSh8415mH2O8+GP5XyKP6ajVZ7gQ09fA9/gZfrujR62tBSX1/wzzfn15MwQeztPApGGK4UvQUUuoXGCEbocLiBQNBm/i9vfEY9CwxPCb6Eh9YRHA7MhLBI82I8d6lqLxWUCwQ8Ob3O3sOy5jC+TuydMV6YicX+sT9G+u1xl2uzG1o9r+XQhBJklIdSFVdL5DE/E5rDxnpdSBVFny5JzzLeNe119+PMhrYA4r+7UGoJ8GPhZDVwlVRp5WZZ6JvQmzSv3FED7m7QCyJHOTnuTZ0ojMB0p5ynHnZS396P02vTkHZawSA6lUverxFLHSROouBfI=;25:hktpODe2R4GT+B6n9A3R0gAs1fCaMe2fGsPs29cg+b0MrY/NYN2rD2uztvCOuhnBZ8tsIM9elguDVa5HWmq4iqpAFfYqOqXl6EaPJDBQ3zDgWcJsQDPzFSnYt5Yc8RTurNwI3pMAWwahHkEVtYMlxhwn9XRvEianqOZ+3W7BCAdkjoj+45NQejUAJAz1/4x77/GEoElx/yy9wwSrEh826xycE12p+Sdq+6g76i1OpNvDATzaVH9u6SAIi/DJSCUE4QvXWagz3hplbtfEO6XRZczo+DX4grOxzCEncP2IRP8F4k/RdHzP+iUYsGzgmVl9FX8V3YYHHepytM2Bi1GFTA==
X-MS-TrafficTypeDiagnostic: HE1PR0701MB1977:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;31:AmQibu9xYO3eIr1V50ggc53LlQTzW3APV+GrJHi4QfjwmSZLy03Cex4IXX+Wg59shmQME6S5x07s2FGlwSQNGJQjQa8hG4ceA+lB30s/SQZv89TD9GwztCh2GVzYtAN69DYknhEzDkFDFbIprC6QFQfgF1BFhZCBhsruIpv51yCaS9thR2yjeBAILInbTVAZySlsiHYFAYjEM9o7E/DBffU9uuBOQFR/rHK0tvw/Wk0=;20:D8j4UbtP8Iym5qAmbj6dnv6g5atzqP4zULjRcVg1fzxMgo9oCuHUMiky4eZSE8pVf6i1LAWh6FiO+JpgB8EvVHjrIb74ACNCFfZvaeqBoWpLLgT7Rdy5gYThXsXcfGosFfwBsAhb8ytrDBLIRAuhk4EDaBE2Jnzx+5CObIYF4bJlRo9RN0q8M2fg3x4FvYMy1k+WwBQ9L8Z7xf8+WmoST8XcLTqk3uaWUj1KjmE4uukHSXeyalOjdFxCJ4KqdWuxCxgemDxgmw+6qJmLrhByU/mG+nEi43eqRkrkpr5G/YdDQEqGw/J1wvH8qEYJd0oKC4tgf9yP5xelsCizD0LU5YvhqPTlK9djbMg19om5SY4FF8Ns2K//F22F1oFVEW0KMxs8CfAJsgJ7ul4Z31L5V34KDN8VQxvsO1z0XiDDKb8ypZzLRgapfmJQGSlAQBzB8A4/O8ywgIDka/dvH5XzzZt/gTbpd2I131xfGW5ny5tfoXfGBsLFmmJnG3uwUuOFge0bkt8RLbSueGVofR0TCsLjabxRp+h2CtDeqcXciAhmFglLNIr6SqUe/UN6G2AmjhjDzbEOrR4xSbPzZnEkYKQ6yD2icdXVz+OAjfar2Zw=
X-Microsoft-Antispam-PRVS: <HE1PR0701MB197797FA3815366D226DEAB588E10@HE1PR0701MB1977.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(166708455590820)(82608151540597)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231057)(11241501184)(806099)(2400081)(944501161)(6055026)(6041288)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0701MB1977;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;4:mTaxc564b4+9JCivzDGrNI8UVlwU0eaqlrlav19kcsvSlDQFjexTbKFRRlcS4DpccyJ27scRjtyngZfdUp485CmX8o6I54h26hjGPjgrGBhbJ1r9FLxT8NjkhMnK8o5uYid/e9UVxlkkfP3eG9yUWEbs2ChlMuwc00D9kcKkCZuPP+YchSWyE7hlHgjO6uRkqiYhcXlGBm4cmJKTNh8upc5R2ZTxwktPaib7oRWAg5IaxkMZvu2MM9olLlvBgKXbqpHrOac2EZWiaIgKdM12/67sfx38JdoYOMrtlWufW1rqv3iFdMurAHpM1cbEgavjfCwSRuwoHsSS/pbdrJ97m75UMBBoDXf5j9YHrrk9eFZdzwKsRVA+4T4IdQ1nPDtY+A11Z4gxnjDfUdlbx1gmVW1UjKGMDTiXxRBhnTogfyk=
X-Forefront-PRVS: 0563F2E8B7
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3MDFNQjE5Nzc7MjM6aGQwZFQzaGxzTmRDbVBiQVRmT2djL1J2?=
 =?utf-8?B?NG5VRXNBcUtxL1lvNGhhZG9XdnMwMHhYMEhXcDhSWVcrdFhDU3p6blRpMkM4?=
 =?utf-8?B?V0czV01HSTNIZUxWcHFDM2hVVTJsNldvS2s1N3VtVTRrU2dONllvbi8xeUN1?=
 =?utf-8?B?TGxlQXJWZ3o2NmU0Rk1TbnBIVWdHc3hnTmFwQTh0aGtScDg1Umh5TXR0RE1I?=
 =?utf-8?B?VWVGc0x3Kzh0bzRacmw4MjFnQ1VUWEtPejJudURCV3lUZkFQbTREazFTWVpl?=
 =?utf-8?B?ODNTTUE5UEt3ZkRKdlRzK1BWcE80dWxDMUFpOU5ZNzkyQUlvcGo4NWFob1lr?=
 =?utf-8?B?VWRaV3NYRTlwVHZGQUdMU0piZm44SURrcDFHLzBGTFM3YTJUN2V2aDNpMDA2?=
 =?utf-8?B?TS9UM1VHZWpZdHZzWit3Q21NbmZ0MERPSFBKZlJSMmpHbTUydkRMRzg5bmJr?=
 =?utf-8?B?elpZQ0JmK3JZZGlPSDVDSGRNYmtuWURYL2gzTmhrR1FVVVBnOVJQcjlqZ0lC?=
 =?utf-8?B?QlE2UzlKYUViOE5JTXJNc1NRNldQT1hlVHVJc2Q1M2dpcjhkUGxZUTBPdUc4?=
 =?utf-8?B?bEJlTStacC90MmloYXRlWUo4cGV0OHQraHAzYzNYVm1iWUdxUTZkWE1kbXFX?=
 =?utf-8?B?MDhhN1ViVnorMEVOK2U5bjZHUElpSUVwYzBwUit4S05yTFc2VDUreU5adzd2?=
 =?utf-8?B?KzRsb3V6U25pNEkrNk40dWlYcTR1ZGhhN2FFM0tsczRjRm1GUldId1oyVzVZ?=
 =?utf-8?B?RE4yeHZodkNJcTZXalZuN3FTMHJzVWN1ZGZuc25CRER0Qkpid1pkUzhZNWor?=
 =?utf-8?B?YTlZSk5kVWNNM0FRVG1SSWZsODBnWUF0bDhJaC9iVDV1ci9UVm5tSVRwOTJN?=
 =?utf-8?B?NGh5M3c1MFRiMWY4U2lpRmRhNzVWWGtaaFh5YVVQQVRHTWE5YXpNOWJEcDVO?=
 =?utf-8?B?SjNyUHZjZXdSWDM2TmwwSnJteWZDLzFORS83eVRRNWFTamhreEdiS1QvK2N3?=
 =?utf-8?B?ekZHUzZPS2hNOUJFYzdHSDZhN1B3K3VxU2R5a0tKNjV2RTNVRHpzbXpDY2JV?=
 =?utf-8?B?VmdZYlZiYlo3YU9lYmZNNlV6QjJvMkYyalFuQ3QvYUZGczV2bVNhK0dnMUUr?=
 =?utf-8?B?UXdicnRLcC9XdkhZK3FZdURRRHhvYXRMWFRqUzh4ZGdBaWRPc1pyeG5DNHhU?=
 =?utf-8?B?NGNCZjk3ZGpheWxLaFZVb2tWSGhKNitUbEozaEllTTRwdlZBT3lJaEJBa29T?=
 =?utf-8?B?MXdQaVpJSkl2TlYvWldFcU50ckxzenRDZ1lDV1h0b2xIM0JGZWNURDFyRFlT?=
 =?utf-8?B?Q1NnaEs4N3Y0KzFFOUdlbjB2cVMrQ3RzeGt3Um1XM3piMCt1a25FeVNzUlds?=
 =?utf-8?B?UkZJWXFJNUdGanc0Z3JldXcwbjBWblIwNG5vOU1uZmgrUUdjdVlxczRNYm01?=
 =?utf-8?B?NndxRHhCSEh1VnBpM0xKWVhDMlNnbDIycEpNQ2NNcE5HTzVWdHdudDlsYTVG?=
 =?utf-8?B?T2lwS2FqWFNiQ0dkcCs2VG9Hd1lmMUN6Um5mVVBEd2ZGSHFxeTN5U3BLa3Av?=
 =?utf-8?B?OHFCaXgzdVBNRjViUW9hWmZWNktNR0YzSVZnN0VIS2Z5cFlIdEQ2TktnT3ZC?=
 =?utf-8?B?bWJlNWdaZTM0dG8wNFh4YlpmNnNOMCtwcG1QVSs1c01SZUZQaTQ4azUvL3l6?=
 =?utf-8?B?RzlEc3Raem1lclE1ai9JbFJSYnc0NnBidWhYcFpyNlZyb3grL2JtK1Z0M3Jn?=
 =?utf-8?B?MmJEeDhqSkd5RUVOdytaZXMySFhrM3VzYmV1NVhMbU03WGJYMHlUVnp1dWk1?=
 =?utf-8?Q?6LqLftCuSH0n3eK?=
X-Microsoft-Antispam-Message-Info: 47YFg2ca3XDdKaZh5QoQjaB7NLkCaut4AR+iNkGHgbIbwNlaak3HAE81dNjHvXKLuDXNQ+Y/GBSHt+24AaIBzV9FYpJzFY0/z5J1Nkt2n5AMEaDjscpUTgh/ThpJk7v1
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;6:eRLiLB5Ygoc1I0mXbEzizRX1Yhb4OryYi7LAJNlhR4iJStj86agDfYqNev7cnNSCRNqnDd/9UBl1vqwkzbOIsLiQ/EqeelF0vw74V7YrsJoH5r06yq1ODEr0S7atVylJ+36QfQc+R9S5YndYbtDdyOi5efM4r06dAqLNK47Mq7Z2SVIHmPVMu7jZr3CGm00tV46MjVy9UWSqQLF6TyFLdSPoCoOSuc/vbMjoCaCSuulMXAHgP8+T/ENRs6w5jr51Q8jge/DBTyt6bfyD/i+V4AyZpDnjwdMr+aUR5TH/fba0hq6LLcSNgAs9Uj7SZAzbbheITMPOIw8kjDPZkpgj3xBy/dOaGKgGicj16nBfS675mt6KlvocpGlNPMf3H4V25suK1vO4E0XPT6bDHIvvVA==;5:4MtjRmcCLL1iAXf9lYydpY3VV4xwQoYRfLLaJgs75Snm4R8o7WYNOUTK0sQip/ZUH8P6xSzjELCTINLVe8WeNMz73uJ3o0xOX7xF44eTiynHYEe7ETztQL/7QbXqwQ3SUn7FZ7/yj9JbPxga1IrKAuYbvpVJ6fhX7szTLIdlTgA=;24:7jGmReLxEEPTIK3YtWM9LZT8G7yFPQ2yRRAVzOvcUeCGPP5DbFlphoXl/CaSAFIi5jX0QjD6QnIUIdD18MH1s3eX8ER6lVMs0ikDSIuxv88=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;7:m8+ho+QQ/H3rvNU4qDQSCY9edftko7JRZUC2bAz8TBamw6xvE0zk1ElT/XB1ZazXNgpitUDD35w/yT3XMnMbVYVVeNp/Tk60YyW5w7aOftaEywW1uri9fMUd+dvi113jTRfn2YoJZa0M60mQ0fxeF7mOSl2NXZ78qsSFz8hxEOMRRNmqTcSx3gkDFLnglptosakEcV3ER1/gQLqLAC/iKbDwfjm1OFeTtvuWiqFqXGSlaz1uXB6VbMQk24RijhAo
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2018 17:58:34.8365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153971a4-405a-49cb-f8a3-08d5641d4135
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB1977
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62329
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

Hello Serge,

On 17/01/18 23:22, Serge Semin wrote:
> The patchset is applied on top of kernel 4.15-rc8 and can be found
> submitted at my repo:
> https://github.com/fancer/Linux-kernel-MIPS-memblock-project

I've tested the Linux from your repo on Octeon2 and it looks good to me.
I've only tested startup though. Therefore,

Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

I've noticed one positive effect I cannot explain -- with almost the same
physical memory map I observe almost 2 megabytes more available memory
after startup:

without patches:

root@(none):~ >free
              total        used        free      shared  buff/cache   available
Mem:         955040       16264      839948       80068       98828      810068
Swap:             0           0           0

memory map:

memory: 0000000001090dc0 @ 0000000009000000 (usable after init)
memory: 0000000005400000 @ 0000000002b00000 (usable)
memory: 0000000000c00000 @ 0000000008200000 (usable)
memory: 0000000004800000 @ 000000000a100000 (usable)
memory: 000000001fc00000 @ 0000000020000000 (usable)
memory: 0000000010000000 @ 0000000040000000 (usable)
memory: 000000000190a9d0 @ 0000000001100000 (usable)

----------------------------------------

with patches:

root@(none):~ >free
              total        used        free      shared  buff/cache   available
Mem:         955028       14292      841884       80068       98852      811996
Swap:             0           0           0

memory map:

memory: 0000000001090e00 @ 0000000009000000 (usable after init)
memory: 0000000005400000 @ 0000000002b00000 (usable)
memory: 0000000000c00000 @ 0000000008200000 (usable)
memory: 0000000004800000 @ 000000000a100000 (usable)
memory: 000000001fc00000 @ 0000000020000000 (usable)
memory: 0000000010000000 @ 0000000040000000 (usable)
memory: 000000000190c9d0 @ 0000000001100000 (usable)


> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Serge Semin (14):
>   MIPS: memblock: Add RESERVED_NOMAP memory flag
>   MIPS: memblock: Surely map BSS kernel memory section
>   MIPS: memblock: Reserve initrd memory in memblock
>   MIPS: memblock: Discard bootmem initialization
>   MIPS: memblock: Add reserved memory regions to memblock
>   MIPS: memblock: Reserve kdump/crash regions in memblock
>   MIPS: memblock: Mark present sparsemem sections
>   MIPS: memblock: Simplify DMA contiguous reservation
>   MIPS: memblock: Allow memblock regions resize
>   MIPS: memblock: Perform early low memory test
>   MIPS: memblock: Print out kernel virtual mem layout
>   MIPS: memblock: Discard bootmem from Loongson3 code
>   MIPS: memblock: Discard bootmem from SGI IP27 code
>   MIPS: memblock: Deactivate bootmem allocator

-- 
Best regards,
Alexander Sverdlin.
