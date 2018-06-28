Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 22:26:15 +0200 (CEST)
Received: from mail-eopbgr730050.outbound.protection.outlook.com ([40.107.73.50]:64906
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993885AbeF1U0HWNO6x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 22:26:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ+idEg72pQmQ72QFwC4wrVMAjUZO+iZh1340vZEfgo=;
 b=hJRv+NKgNbM/jYn8b8/0GNNOdeDXRHlusDNxykcMqKTVUkpn+BEq3B4TLFhJZCO9aTzqSSFDioe+vdpCCysFRtuHqgc5HbELrqtO8YVObS+NywuldcRtQE6+hB24aqvQVshcDNaGUtf0JNT66tWaC2BlHhi34RpeMt9Zanq5/Ks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.40] (50.82.185.132) by
 SN1PR07MB3965.namprd07.prod.outlook.com (2603:10b6:802:26::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Thu, 28 Jun 2018 20:25:47 +0000
Subject: Re: [PATCH] MIPS: Fix restartable sequences.
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
References: <1530215856-8795-1-git-send-email-steven.hill@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <9cddfaac-d9d8-80c1-4521-b70d09990454@cavium.com>
Date:   Thu, 28 Jun 2018 15:25:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530215856-8795-1-git-send-email-steven.hill@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: DM5PR2201CA0084.namprd22.prod.outlook.com
 (2603:10b6:4:5f::37) To SN1PR07MB3965.namprd07.prod.outlook.com
 (2603:10b6:802:26::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d23839d-53a8-4ba8-de8a-08d5dd355b01
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3965;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3965;3:7034YWbZA/dTjR+gyYPgvAzhpcp9pnzGtKg2lArn1Ub/4/tvdtonyuPQuKDK0REtgNgycaA1k3QDD11yKyxjK4ryi8mwAa055aPsOwyxTesJEQCYp9gXmRBFMM+pVsQxRWu2ocyXmrpw9QkiTYhm68tFzLiNU9Uyp2GDlDnMZsVj0aJlJ3CWkr2H9JmayclEhUTdb4GCj7Wi3Rz2Z9nDBgyDI/HPd/04/MTJw9pMa9YnD74JaDhIXsCP1DW/4RRP;25:pCvSrXMk3o6C/k2KBm1USVnpiaDiZV3mlTpfPgEFwLu9/viLUs2+kL1Lartc0+VZMGDR/XTb4889+Gkutp5gVkgyHBOtMFeq93fxndfFTocTv/Gj5NXOoSvmBQ6xi+W427jgYBQP9vsVEXtZWrQZn3JnhwnHdrHy6ett8yOK+SYV7kvfmVZY++j/4XhTAmyLG0VxUg08rNrs62ZEZvH2n0yHAlloyEBOFEILEq/qo5ghl4/j3yEu45BMY1gfZlt/2zgWm4k7UDZAEhYnGAL6AJUqMv2+d3ZFFX9lV4VaW1HVEu3AXeYK8ZuFOD/CWzRSPJEuhRqcUJsoWvlQBVoE5Q==;31:lczPUIFQOW0KVDa41vZNGLx/yFe22hl6ON6A2HeLPR7XymxVNHmeOWT+QH0ZTYfln8Lg9GFrpUDUEMlNz7RPdL6Ap+V5YfZn0+zKyzZb7AgRC8H8upm3zNTcPNBLR1fXaHFAEQHssoD4bKRnxhk5JFebnLS+y2DP62LiDFtYg4/aCCRvdMpVzImgagjL5U7xgUaDuy5AgzY09HxS9vmWGGV2ljKdUV1EoTR5mU3rg3I=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3965:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3965;20:HgoM2ieD6Z87TDn3mCDDPuFyWg0BvVSdQ2m2jRb4BBXmllaYawi5DHGJfLZS9pljnEWF52XtKeQ7/1pHsg+U88tKt4x3CHXoLujap2ZjX8QA1NWwSVJjnP7fYP/5dp52s8evSLkUdfPf7UT6YASzPXpsiiF3tPY4DQiOYFib9T1O+uyWQRCrpgQ0OrrgBggoXpyO9XbqTYiexp1oj8tbWssw4pCXk+hfKadGIqvZ+1H0SP8i57NgVSufO/ZyLy3zAPVXUn11RC+hCoDhSIPEbseW3pe2ExpbcEtQ4EniwwjI+7zLb/1wlM4dL7g/eQpMCTlVta0bsSQkBsfcmhYCvATAfE9xFApGjkFtb4YqV0iPAB3aG89CzpN4qnhv2m4zuWEWSPM6DJvnuj5moHZrUmgg7ya8Rkfqe+tCTmlCk78V+1KOrfbbIW0CrnHJJ0whawNnAqlV/Du4OxfKH2HpfUGzuUEvJaVFTRAEcxaamvVJOKfwWawjaN7pjdoxsndr;4:SmZIR28IJdsvANiD7jnP4gHbcdcoiLwiTkfBGhsQJ+G4RXLK01gtZe0PRqgIdoODSYTBXZ8cnG5HSAH/OStA21gLQVOT+SWVWDnCYNGIPfaL71jzc42dL9OiuO7Q8o0AXgCGCJidakyKcOv76E0lxdgqs1n86qjE4BEDSBAoatWdhT3L/ujG2QHsmYa2vHG9Jvz8tcmwBLP6b2wlSIBOPDGxBtDi3vbu0m06QCrfsdRIHjNepIcbCdoko4IO+4uejdyMveFFDDiklfRiFzEmbw==
X-Microsoft-Antispam-PRVS: <SN1PR07MB39656D45F4C0BBA54C5733F1804F0@SN1PR07MB3965.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3965;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3965;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(376002)(396003)(366004)(346002)(39850400004)(189003)(199004)(65956001)(66066001)(65806001)(8936002)(6486002)(956004)(446003)(11346002)(47776003)(476003)(2616005)(81166006)(86362001)(81156014)(229853002)(72206003)(53936002)(6666003)(36756003)(97736004)(31696002)(478600001)(2486003)(52146003)(316002)(4326008)(105586002)(76176011)(52116002)(305945005)(25786009)(23676004)(106356001)(7736002)(230700001)(8676002)(16576012)(65826007)(486006)(5660300001)(68736007)(58126008)(6246003)(2906002)(107886003)(77096007)(26005)(386003)(6116002)(53546011)(3846002)(64126003)(6916009)(50466002)(31686004)(2351001)(2361001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3965;H:[10.0.0.40];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIzOTY1OzIzOnFTYnY0b3pIMUdDUlo5WkNNWENFTGZmVHpR?=
 =?utf-8?B?VzFvYVd5VHVLZmVCVmhXc2ZUbFBpNjBkWUhGLzVvRzBSVHZJUS8wYmFvTTFw?=
 =?utf-8?B?MkR5Y0VzZDdpa1p5N3lPSEJ3WTFBamw0Y0Q4WWg3ZXNadzNpRy8zNHNUZTBy?=
 =?utf-8?B?R0Z4Y1BYU0dNNGVRdGJCV0VxTEpzdDdOb3lrd1o1YVhTbVV0SEd6dlRIVXFW?=
 =?utf-8?B?N2Q3czJERVluc0JGcUw1TTloTDAwUGpvYzdmNGR1OXRyUEhRWjhFZTdtaFVt?=
 =?utf-8?B?QXpSbUZZdCt6OUJzYjJWMThseXFvOVFqYW9BcVllZ2ozTVR6eUlLdEVKcWEr?=
 =?utf-8?B?Vm5EQTZzU1JqeFJrNEZTT0JINlB4enJaV3ZYa3V1YitHRkdxSk9xWGxyMHZM?=
 =?utf-8?B?RURNbWFkMVhFYzdCakkwMzRJM05kME8xVmJjaDlzeGw5RXphY0l1WlFoVGxZ?=
 =?utf-8?B?V1ZqbmtYSXE1T29MOXhxRmRGMUdWajNUSUJiTnZnY3ZXd1UrSnBkSURWZDdX?=
 =?utf-8?B?cmJLbTJKY3NxV3Z2VTJzdEVuTm92S2JrRjZ2ditqbkcybkhBaDdBQ1IvSllz?=
 =?utf-8?B?eHlDQzQvSlJiNHZ5bUh1aWhEVFRYOEwzNmJqWjBOOVNzOFVkR3J5TTg3RGlP?=
 =?utf-8?B?Mk9TeXFFckJjWFNYY05aZXJOUDdmY2Y0NEVIc2JOaCtBY0tHYjZiQW9uZ3ZV?=
 =?utf-8?B?TW9paXUwUXRURXRaL0JZdkIydVBrQVA5Z25IZ3JKNkk3cWEwaEp3N2pvelhE?=
 =?utf-8?B?TTQxaFNIVjlRRjFLRWVwakVSU2ozUkVVdEFLVDdBaVIxYTE3TXV2cERYcmwy?=
 =?utf-8?B?blp3NjE5UHN3Qk9jbnNtdUdEeExvS2liWUpudjdJK09GbGlRV0kyOHBSYVRH?=
 =?utf-8?B?V0pDVDBIWnEyb2xQNzR3S2V4TnNWSjM4Q2c0MWU0bWY2NEc5SmRYNnBrbGsw?=
 =?utf-8?B?czRaMmZLVkZGbk9EcWxNUkttVWthQUV4Ly93MDVPYlc5NFFSUUxOTnZYY1E0?=
 =?utf-8?B?ZENQckxVRFg4bnBQU25MNU9JaFNienpKMWRHc1BWKzE2aGxOQW1UTm1RUHpl?=
 =?utf-8?B?cTUzUHlkRG9JSU1hTW9yb2FmcVk1d2ZieWFVSzlBMEE1WmhUQTRIT1RPanZx?=
 =?utf-8?B?UHBzMGpsWlhjMzFCRFBrRDZ0N1hyaWJ6NWtrZDI2a3VDcEdINlozWW5rc2Na?=
 =?utf-8?B?L2FKY2UzT0VqdkZlMnIwaWpGZGxEcHR6UHZLbFZqS01NYkZDaVdsOC9pMDRv?=
 =?utf-8?B?RE1LeUxnWVpQbE9heHh3aVN4ZHZ4VkQzL1Y2VmJJSXd5MGFKWk9GR0lndkNP?=
 =?utf-8?B?THhwRVBUbUkyVm41b3pvWTE2TitUNk1ub3VXYUNHNTd4S0NhMmZNc05PQmFl?=
 =?utf-8?B?WjZtQnpGa1JNWDhlQ2dVMEduSUg3VHdxcE1oZEc3N1czQ1lvYVdLN2RkMjcx?=
 =?utf-8?B?a0VoZ296Q2hDekRjVlFSVVZZV2xWMmh1N0hEQktINzJuRkxJdUxYdXJNNDlO?=
 =?utf-8?B?SkNFTGxxSmZ4UFZYbmFneHg5M2kyT29SbWswcStsQjQ4cDJQdlN2Q2lsRitE?=
 =?utf-8?B?QXVsVGhqVU1ocnlvSlNSUml6UnE0NjlpQXM0TzQ4WGN4NGpDaG1aY2tvVHRQ?=
 =?utf-8?B?bi8vbjNSdUpqTHI3b1VSUndnUkxvWlBiTS85WWxzcWJwRDMzUHpzS2xETXRv?=
 =?utf-8?B?eUQwWWM2cXhDOTdiUjVrdkxYeTRSaFMvL0dGUzlLVytlUWNBblh3VHRvcjJn?=
 =?utf-8?B?K3BuYXZoWW01NkV6bUNDbUU3Q1ByTHhEdmpFc3RsVDBnVG8vc0Z2TEtvOVpP?=
 =?utf-8?B?UkNoUDJ4VzlkN0U5ZmtDdUR0MktoMk1jRVV1MUh3Q05NYmVsUk8xanVCTzdy?=
 =?utf-8?B?MlRQaHBZRGVTNU5BVzlJclJ4Q2IxV2dmcGpBem1hTFF6SUlLYWhDdmJScFhy?=
 =?utf-8?B?WFU1R3NnTFlCRzczM0xnTm92MzI3Um9PTi94dFJLZkR2eFBna3Z1c2QwUnVj?=
 =?utf-8?Q?4Ck7B9?=
X-Microsoft-Antispam-Message-Info: ty68Ct/g0G3GFZrRaTXUBN+Zf1rwrqbZLAEq3tgx3sn2FFS/F38B00tCdixxWV7QZ5mamZGtFBCyioCCJRlPpqG5d+xbHgqoDnazJRcnKDNPIk5x86cE9ej/1r/Q6nT5J9SWhh4t7YWEtP73aYsd0/lfZl1JaYpDy13CcEjqPr5kmLoGwp1Fpu61vMk4gOtm50Gp7qn5F9pIZP4CVI709O3EbOLtMS4N/g+RRQMKzCB6iE1QneWhhMSgEG67dX40URB1txruoEnEwN9b+yczZevlJl7lkm7sD2MtD5Qnj+1LIv3QIpk0Su/TiFQzeZIPA0prESGU76yDXxpp4Ug9/QhT2huSOeEobXROTwp583U=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3965;6:eL+PRlOeBBrpBIcfOzR6kls75AMNxaTKGmnZudiHkl5DWOMVmWECintrV48gbMqeIeMWM3/pikmJP2/uFY5pzAK1hB2zkPrp6xqxJ4TLinL3LHec0/Y91ogUqpNqyXbMC7rJZo8mkQRjO+iZFOcqkw1eI+GVmVwiG6oir6xXhxEFdChOEtBXJtot/bM5RrzBKHZrwM0nEjqPDX/T9tJMqFDYs1436MIihQrhDAPrptxHbwItmT3QScfoYvEX57OrA4/eOfzfyD6K0+Fpnfq2ewGZxiI+5XePwoWOUGdCvHbbV7oo6aiB1CmeRr1IIAOGg24sbukw+vYFCu6P8SZGX1szRgz/Ipwdqdtgov6wfTDxYqP7IzDUtj8DPdut3ecqnJyCvHhosWsonqT4sqCDjx+0n9MJzZRsfUSDexsPGQD8VLN3FMNXejlue1DR8EZSG7EjerjqQiIqZQuI6a3e6Q==;5:8k/qw4bySs6CVVU2m6iK1kZEkIUm/7PUxhS5duWS+zUNcLAkqmwPqtg0hSlm43WfkAJRQVTdKZO5oiGpfDPfOMxK9XLKidWNS7mika2pSjB4eL2D9IJBbIWMz2X0d6A/cfosvXWJKChUaxDT802FWa25EUaThCuLZHr5k61CjIA=;24:/6Rvb7k7QemhxedscPutYFjoRbv27Y73NZNjkS+lJohnxBGRmH1l18l9YU8TTSE7Gs9rLc3KKWU53hMhyXQ0RMmJXdp/YS/3bN4BEPLk7eM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3965;7:adV1aODHmQ6DqQSlZUA5CdYKIQP5Clj6jW9EOLAd2yxmyprjDBhulxGFq1mts6fyTbxR7vMevVcozIQW6xnepStW8WeDwyHLEAKINCnFUW6xG+6LJ+/mcOeC4q6grs3OfFWYiCN59bMm3E2sTs8OmLWk3+tY6isO8sGr1TgwxxP9YjVyHCWnv5xkNLXvejwr7kp1uq3d1b79/nA0C8PIt+8M1MYy91OD9JRgsRDNd6L/knNWDouJeYJkBYePA79B
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 20:25:47.4208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d23839d-53a8-4ba8-de8a-08d5dd355b01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3965
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64495
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

On 06/28/2018 02:57 PM, Steven J. Hill wrote:
> 
> The API changed in commit 784e0300fe9fe4aa81bd7df9d59e138f56bb605b,
> "rseq: Avoid infinite recursion when delivering SIGSEGV" which broke
> building the MIPS kernel. Tested boot on cn78xx platform.
> 
Aaaand I am 4 days behind. Thanks for fixing the bug, Paul!
