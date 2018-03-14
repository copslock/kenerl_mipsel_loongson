Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:46:14 +0100 (CET)
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:33312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992363AbeCNWqI2n7NJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:46:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1uKSJLHp7AsYXSpeIRUVZ8rpbuHYLf9vOube5VSZJ+Y=;
 b=FRmDn/TPRIe5HRw3785wComCHAgauDxIQ7sFCjGd2wm8rPHQcoaN10TDqTtwO4Gp1N2iANdkAA+Aff5MHqNHVH6h0sqqN8kk/newZf53KvnPwVXo076wdmO8tH9tAEMHYRDQPvui6bw/6sf8NquQr60UgYgYPhR15v1LJbCnCqM=
Received: from [10.0.0.40] (50.83.62.27) by
 CY4PR07MB3605.namprd07.prod.outlook.com (2603:10b6:910:76::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.567.14; Wed, 14
 Mar 2018 22:45:57 +0000
Subject: Re: [PATCH v5 0/7] Add Octeon Hotplug CPU Support.
To:     linux-mips@linux-mips.org
References: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <8426dc72-89a2-2ef8-141e-dd986d47b537@cavium.com>
Date:   Wed, 14 Mar 2018 17:45:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:3:93::14) To CY4PR07MB3605.namprd07.prod.outlook.com
 (2603:10b6:910:76::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9992b205-195c-469b-c6d0-08d589fd5ac1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB3605;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;3:Wj1b0Z1dUUfmgoVAPCcfRczeR56HEEue23LyoIlb69/AE4sna3ZcQHfrInEQd4WAdp+3QRkh0HGGjUKktrjNNp+VJyZRi3MDgdQzt1h8oEvQQa5BODgnXBCYyrOSxy332NilLJxYKlBKRZxIgt6KXLRXcGtzpUfBNt8hgmQH/n1NPpYhmvK1ZxV2jzY0ruR5UsykB8+PlK7FY75Tc0pFWWaUHWOEhiNNiKRQ2n8twRcfSIVgFgfS7lj5T6Z/A/K9;25:9HA6nOh5dH4AlKLn6arQb0wI8lf8TT5ELUtYrJPs5X/y0N+Xy7d4+U4GvRywdnJqLlVGtcTNTa7+QolgphTQZTZnOIF9Li81KKGY4lo7x+lG6sXcWnEc9Uj9D0JPCIXRN+H/OWFd0kHU7LKSPOKL+dhQ1YCGQPQJ7pAuLbWSHuNleLJ0ZI65Q9ZAwtzUR9tr0kyEMzpJ5hWJz6klXqgLtALwPWYnB1X87OyBl2Auyr9x0drWwTMoiH4bNzz+RjNdfDqDfHjYGhtO5dGkCIh+ESXHP5u+R9pSAdGNLjlE/L1GGeMddqpRaHDH91Wd33cNM5h+DTzdZ5stiyGxR3yLsA==;31:DkltF6ivAcxezUP/B8cPLmzkpjYj+c/8ft99H+eBZvxHZ6/JuwZmpvS9eyZrvzFxRZdDE6OCfIHIlGNVs5NSG1m0i7ZWiy6pDQsStQTuem0Gg9hE1SFrPUJqDoHusCo35VdQ8FASVsUG+Hj1OMihUFIHV1inBoFDQkcGEcLh4UKfT1/rgxJvpuoe8l8eudehfQcXJ1HlkGE9Nykq+n5fav3pseArUCNRDYKYyze4X8c=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3605:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;20:k9VYF26qGs4qc1UFH98RDsBXur8lfXDo+9Lx2Z4Oi9ljxfrS+3TrWns7Jw8XlfaKSYX8weeNLn5KKISaVrOmBHicC+f6smTzMO37B8aUBjhrMoyAZju9BBXRsfXZ0iS4ooNhXZcY1aTIW/vQeyZhevKzkmMlV59wtDvTm93cFdDXJD1NbfY3UuqfG1/Zd5rm5ISHWh3ppcA8+c13+fo/0IHUA70V8m6aLyKOIQ3LHC6B5J3/nQtiNinJFaje9R23bm2I/6+rI+rmlaXRSw0O6NgXzjgRlojRwKNHru0dED8wjD5ODp2wKwozxgVcnOF4bKa8HrcGn21fqliImofxhKHJhy8gNflMhg6eIQarsuzRFFzGup1U8Rk1IyZ6WPTVmIJFrN2Kmq5dcIphDZkGny3Klj8i3g/QbYsIH4o2gn7GTEb0muo8aqc1dnEqHX+mPNr5FdbY5jL1/Cy/n7m72+omlLNz/eVhnLnFnlI57eptEp0+tbuyE42KUcVd5JQI;4:TZPRaZVD7nB41V/VSSHp05Jhiqz0hq564zysxzgh1npc3bcpytDZyeksRXt/OkuLM1KlnNQdBcRAAYdaKNuyT+YyaujygXnTbb4vs7XBaB/cJtR63xepEh/87O7CRbsmuUjK9Sizlpce3GnwEfFqlJB5YQlZCeNIlBxO/i1t9qujoObuCWO9Jv1SLTxcoNo4+gy6y9GHCdul1hVKKg6dUeHj5Th0yHqfFGOtnj27lHFAwPXX/A7M4kXadpPOpAtBwTWwey/lxd0vSE21oKnraw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3605343020C9FFE516C2024C80D10@CY4PR07MB3605.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR07MB3605;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3605;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(39380400002)(396003)(346002)(376002)(199004)(189003)(36756003)(64126003)(16576012)(6486002)(58126008)(50466002)(47776003)(53936002)(65806001)(6246003)(2906002)(97736004)(65956001)(26005)(2351001)(106356001)(478600001)(31696002)(65826007)(229853002)(186003)(6666003)(86362001)(31686004)(66066001)(386003)(81156014)(25786009)(68736007)(52116002)(2486003)(76176011)(558084003)(105586002)(52146003)(6116002)(53546011)(23676004)(230700001)(8676002)(2950100002)(77096007)(81166006)(2361001)(16526019)(316002)(6916009)(7736002)(72206003)(3846002)(8936002)(5660300001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3605;H:[10.0.0.40];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNjA1OzIzOnliQUkyeXhnZ1BFMmluOEpsSDlIRklEVi9s?=
 =?utf-8?B?aGxndWhUR3pyNkZEQ0VXeG1ybEpXWWRGVVRPQUp5WVJnaE1ucDh4dXhlaWZq?=
 =?utf-8?B?RSticXl2bGFBaGgyQUUyVFVIK2tCSmRjUFRsaENVY2xOcEFXN1FVOFNDSWlJ?=
 =?utf-8?B?OSs0VHZwR3I5Vy81WHk4UXF5Tng5NmFucXBsUmhTMnhQSDR1RGFDR3BpTmlP?=
 =?utf-8?B?SzBoaDB3VkdVR2oyYjZmWnZEWU9tSXdYVFN0ZFNKUmt4TEQ5VWtEMlNnRWdy?=
 =?utf-8?B?SjYrQUo3L2p5OHNBZVlpN2FnSnNLRGpiSGtCYkRqdWlSSUZUMWFMRUhHZ2lC?=
 =?utf-8?B?a3hWZzV1N05LS1JpMS9YbjM4MHg3OHJyNC9XSGFZK0E3L01Vck42WExURzB2?=
 =?utf-8?B?TTBSams5KzNLUVFmNFhrcXdSdTg0cG5uOC9LL0YvNlJWNzBmUkpXMWgxU1Ix?=
 =?utf-8?B?bjIwNkhLaElIek5ZdjcrUExSWkdBbFpySFlNMVVTUnZlYnFNMXU5RkZQYjFq?=
 =?utf-8?B?am4rRHJiRGZvck1YalNyUERkU1kxdENmbEl5aEttUWdERmlKTzFSK0x1NXNz?=
 =?utf-8?B?MGxPakFNWmxEV2M0UjZuZnIveVM5MmxpUkI5eUpZT3R5eHVldFFlU1cxT2du?=
 =?utf-8?B?Mys0bi9mbkhxb053N2FxdEFRcXlFeVh4djJWT245UzVpbTVOc3dpWElyaURq?=
 =?utf-8?B?eUVnYkpiOEcvdmlTM3NxM285M3YyanhXSkhiSCtzRUNTdnRsU2hMWTRuWFFq?=
 =?utf-8?B?b2ozSThZOTRGZmRaZTVwTFBxeCtROFYrTkZUL0N0Q1NKUGZUc1VqT3BKb3Uw?=
 =?utf-8?B?WlplOTYzMmRWL3hXY3g4ekd5eUtBRGVVVDhIQVp2UXFVU3FzdnR6WFV3ZW5n?=
 =?utf-8?B?WFRjUzVDeThXOW9LSU8xZzhab0p1eWdDbXVQYkgyTFVZMmF0VG5DUSsxRjU3?=
 =?utf-8?B?VGRlQ0hwVWNjc2NNQytDaHhiY0hGTHVHMXU4MitoS2U4SVhjVkpsVVlRZzVK?=
 =?utf-8?B?WUgzYlZDU21BZmUyZUNLMGFrNitNV0pnRFcyK3U1eG5odkZFcmtHRUJpMjV4?=
 =?utf-8?B?WkJ6WjErc1FmN2V3ZlZTTmNxNXE1Z2JTSXdvOEl5R3pDdVhicnBTRlEwM1Ja?=
 =?utf-8?B?TkFGb2hGTFdGTFMvazNCeEZ1T3A2R1g5cW5rREVtTHlPOWdXTWNtMkpzNVc2?=
 =?utf-8?B?SnNhVFN1K3JCUzlaNzJkUHh5VHl3WWV6T2k1VUZkdFpoMzdOa3daSVBjOXNS?=
 =?utf-8?B?dkV5SWRZZVp5UGJBZjM0WW1NeW1pejgzRmpuSWFYMm13cDU1SDliaXhHbTc1?=
 =?utf-8?B?ejh3SUpXd05mdmRaYTY5Zy84T2Y4Ujd6MUJVK0JYSCtzQ0V2clMrdUVPckdF?=
 =?utf-8?B?QkIzeEY2ZjU1bHhONkJHeWlGM0Z5Z1kvOFppclRVZ0FCQ05neG1yamo2dXJv?=
 =?utf-8?B?TDRQRXI2QWxkWENDTVlSSVlJYWVCN3dYbHBOZk0rVmdBWmsvazdXLzA5OGlu?=
 =?utf-8?B?TjVqRlh3TTlZeGtTN29PbXRuSGdKaGduaDNkZVRjMUZ1c3pNZVlUaEp5NWdX?=
 =?utf-8?B?UDJPTGsrS20vbEUyemNidjhYNzhaUnMxdjF6L1pPQ09VSjFMV05scVM4YlVk?=
 =?utf-8?B?VEVDdkxoTVQ2OXhSeG82ZVFkem5rQjFqc1VHN0pwY0xKZFJEcmtOUVBOOEg5?=
 =?utf-8?B?RWs0VVJKYVJydkcrdTgrSXdKMFNxZzBDSkhRbCs1aWtITmk1cGhMd2NDVDFs?=
 =?utf-8?B?U3hHdnNZNFZUeHJZTm40SzJWVlJXT1hRdkc4TkVsK2t6d01DVDlSYkU4bmlU?=
 =?utf-8?B?bXJYcmVFcWoyTzArYS83UkhKdGxwSDFMWVBLeTRrUGxIQ2gxd282azNlcTNy?=
 =?utf-8?Q?xtTZv2spL8gZUBfCtSCtA620RtdGUF+i?=
X-Microsoft-Antispam-Message-Info: WdSq7LA2yCwY6+qpCmVZZDCGucUHRmLBELJBJGwD3HzAhvDKh+F9s19jVFJ9yuEDwSOKB+lyuVNyJ4psTKBRDHxB1sZ48n/x5+8GnOZaJhE0T3crvLGTwT2rZLQCG3GcFwDw7ZcRNAVDjgPr/6LEk9bC/927Vzsta55kHnilGXfMbJKzSahGsdZENFySCQ16
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;6:XDXg0jEcThxc3bZOsZtSEeYkk+uLhPVjcrh78fxZ4Gu1Pvda43qyrzziIy5q3NvuvSM2wZnNR1dwUNEBECl2Cn9me2nHiUr7McWi+Slqjv8mrztw9QkQ1fuZJv211TH82J9yMuRpaUZuf+xZHyIQBTD4PZ6OV7lfhBaMKSQgOiyH6Xkqfz29n+iAr3wks8SGl+aYRURmIrHlGgBBXZKdl7sl00NRBcJ5yAvsxV8wuxQPoibjpkz4JIPaALp2/EacQ5k9BQti7iQRNWGp/Jxyilqt0EORnCuWx/VhiYFe2u0QZG4TD2S00SOaPlxKfOrbP5FDcaTzf934K6hoZkPCEEHoawcaO93SEF3WZqBvUbM=;5:k3VmnUPPLQIjSkV3PdQCJ4I++BxOoPOzE13KSphYkvl1M8+sYbGq6zTmwRfhN8GKCerKoXsVPPzy+0XAGlhj4llXpnlDK+46hdej+GvMtrcwj6QqUdBCVP2pnSwE3dxPSRy6moVCCPycV6PjkQ/BL11FmJGBfGeJMdmiUYmPuJc=;24:yayp7hdCLURRWEiYzfJsBDUrRLKB4bJ/vCxIHD5c8l+LJIJ+vJv0HPcjiZ62AZNaH4RdKsgEvLHkwDPZd4OS8XLPiwPhydmeA9TNHebUcuY=;7:g1qxLQLtF4gT7ac6l+cqgbr/TBRrWavR629qBAH45h7i2FfLmBkEiDjDBGoVUMb9dWZJTDna6kvP5OL4jw5YATAvzTiRp//3wAl33Ho+C6K44cvJLtM3X8BLGTY6BAsbJFs7ZSUmLyP2BhDarcTM3skzya6/u/OPBdEaEuMOMQuyQiopyoZUDWIPm48ecj3bCZ1Vxk7jq5tDjmLVgouzADe7A0PN974fJmYyBFCBMGP2B/+bhwJE4L5xRFFcbTbD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:45:57.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9992b205-195c-469b-c6d0-08d589fd5ac1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3605
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62987
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

On 03/14/2018 05:24 PM, Steven J. Hill wrote:
> 
> Changes in v4:
> - Rebased against v4.16-rc5 kernel.
> - Smaller patchset due to some previous patches going upstream.
> 
Yeah, should have been v5, oh well.
