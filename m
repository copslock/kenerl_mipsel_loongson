Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 20:57:12 +0200 (CEST)
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:62720
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993954AbdHNS5EcredQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Aug 2017 20:57:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qsvS9ZlOluPuoD6SFPo9elx5tw68BcmaLTnxQbaIbzM=;
 b=bO0tYsnVVlNgT4IobnMUI2k7jPQp53Oh0vJeLcL1sQohwEgwfCeYJ2lWW/py38Y7WJE/8WgwDG7PII0r7kz7AWDhkexRFRvAOJGrCjXz/MrHZWPdYKwPF1/CXhwZKWLO/7mtMa4xo2xhItM+n3CLpXUoymG4vGgfHrnweLM0Tbs=
Received: from [10.0.0.4] (173.18.42.219) by
 SN4PR0701MB3808.namprd07.prod.outlook.com (2603:10b6:803:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1341.21; Mon, 14
 Aug 2017 18:56:56 +0000
Subject: Re: [PATCH v2 1/8] MIPS: Introduce CPU_ISA_GE_* Kconfig entries
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
 <20170814181819.7376-2-paul.burton@imgtec.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <86ddc490-dabd-66b5-ebd7-aed6535d3966@cavium.com>
Date:   Mon, 14 Aug 2017 13:56:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170814181819.7376-2-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: MWHPR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:301:74::25) To SN4PR0701MB3808.namprd07.prod.outlook.com
 (2603:10b6:803:4e::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90521bf0-b2f1-44eb-4c39-08d4e3463c97
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN4PR0701MB3808;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3808;3:MkSoU21T8OBYwT3zj4tVOW91Uc18cciOT+GI+MQQPqsMFBGKXoDZaMV7wf+tNwLIAaR301zwJGzYZ6GGfFOb0B4xnBiyjLmkXm0rRICuFRWZIFWJQw68UG91iRCHIJxznYMof+/lFU5SRYpmAMicdxAoSegRt5JND4qS91951nw9hcF1rHJ36HOEOi0Kmp/VrkUFgUe724DnUTSfShlNBBNjeECJ/RsyF6CNvYhToqCD5hczGJ4EcXiWAGui1wIu;25:2kCV5d8nIAKdBz9zcXp4oSZ3nNO+i4kpLBn2M4r+bo2FCD4MlJKgcmL1mYnemHdyeRiMET6Yc6Vrm4l2X8JG8/XpJZZgrwcy+uYp69QxfuyJFfTrbjuu6Nk1em4LIOOBrAWkwUi3oV0DZL9RUvBWCdcsAA64k2JQsK3QJAhfds+3UARP138mJi7GvCMpn56QRsqzHD2ddwb9oSfR+IXmUkOqsJWbDOzr6bdpEME9dexOgcxMldECkx7N1BC9BcoSMdnwHVFV753XRUdCvQJay2nIj9mC1ZHpkl9lLRzQAoMsgWBTB23dDZyXOABZUEYUWAxkEeQ3RXJX4Vmtd1avRA==;31:kgbmEis2nbE8w3UUBiclKuxXUGZdy1J4OYZ2P7X+lmASBCRfVPH8q7jDirqccRweUYhfNJhVsj+OQ/yMemWk7GCrR205uixhrT9q3p47/J5j/guetxF2NaVERSmdbMPjecofPq/YGnUZTuh0520hngXkS2aYPIKm8Nx1JVDGqMQM+h4maSvhIQfD5KbgjDFlMr9JVbhX0HTw25jThg/13IUBoxIpqa/F2nhb32P3V2A=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3808:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3808;20:TLMg5TfIz3uGCO2+mbp+OWLt65MHHxGwYGxWFPrROnk3CpnzWgoLw2Qfgkkeux3pa5j6oJXh79pG5eqOuIQsI+mCXA/b3fj8nyHEI0DZ8gRyNBloSdXR5uGN45SVGuCtSm5DuM2c2PYaFylT5CwCD5fU/vpiC7AVLIQGOunDNUCDcI1O4EbfzEpDWopY/+ftDL3VclfY8ajtu4cx4mwTfBxQKqnNWNTMRdUk6d8iOTd3UVQQ7tdPppP1qhUxxS3GspvLZsHgTCDkDgs8ty1fnTSxEvCojUn3l9Erqq08dJ6RJmeIml7zzTbWgPTcRl6a7JLDCAZh6aArTr0ZwCAwKYCtOstIbRC/Hf6SO2AGkUzaAKO2E26Iin5RBEbZ6x8pu6/qw6jsLDI293cUKWOOIdV8A7AAfM87MALV3vM3Z2w4jV6tF/gZHxwE+XgVtDVhxlf3o6msnikty4oXViBvP0TSiUS6j6Zxjhculb10tCYCaybpY03KFO3nRmINJs/S;4:azm+f56KCER/j9hIfU8vyVc2zl/r65on+gH1lpjFF71ojytfL6CLq3dA4QP4/XX5AirCavbBDyvw6suO/rZEIDtjfzvItblWqmMeCJRo+8ZTC8EpY428KOe/663tc8PEjNuITxZ0MyJwRe0n5rurLQtuyqU4V4/UPvHyk9x6CAtjnIlTCG+Xb5ixMef/R8WCcNzb4QjMsdznv4inTuuqDWQi5WpC1/C2l2f8b5914CA02jtpBYBo9E1XyeY2wNCA
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38081E972024C905A54189A1808C0@SN4PR0701MB3808.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3808;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3808;
X-Forefront-PRVS: 039975700A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6049001)(6009001)(199003)(24454002)(377454003)(189002)(65826007)(47776003)(4326008)(53546010)(305945005)(7736002)(5660300001)(66066001)(6486002)(65806001)(65956001)(23676002)(77096006)(6666003)(2950100002)(101416001)(54356999)(76176999)(50986999)(2906002)(8676002)(72206003)(25786009)(230700001)(81166006)(106356001)(478600001)(31696002)(105586002)(81156014)(33646002)(86362001)(229853002)(36756003)(3846002)(7350300001)(110136004)(6246003)(50466002)(189998001)(42186005)(6116002)(4001350100001)(53936002)(68736007)(83506001)(31686004)(64126003)(54906002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3808;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjRQUjA3MDFNQjM4MDg7MjM6U3pZdkw0V3phWG5KOU5FeDgyK3JVaHVY?=
 =?utf-8?B?NzF3bHNNOTdDRmpnYlU2Zys5Q04zSDBCSkhJUnUrT1ZvQWZyNm9rcmhqZXJV?=
 =?utf-8?B?ZFFMcVAzUzdUK01YS0dEcU5hS25Wc2RMY1RiMWthcFVudmxUVVJSa2pLTzFU?=
 =?utf-8?B?aWg3bTNyUENGZjVNanpHL29iTTRJc2xwYXdoamxoYjZRaVAvWDBJOWN1SHcy?=
 =?utf-8?B?NzFJUm5SR0NiVDloS2VZdXZqL0lueFdFaUlLWjIwcDAvOUlOVDJmVzZGbFBL?=
 =?utf-8?B?eEJzQnJNSDY0YjBqaXBOUzdLSC9TaGZkQnc2cGVQSDFLb1Q5YlNWUVlXWm4r?=
 =?utf-8?B?aTVWTDdmOXNQaThxeFpXMVZmWFcraE9jK2w4VVdJQzB3V0luY1dnYXJPNUt2?=
 =?utf-8?B?K1Boak1VdjBsZlFRT0w4T3BpUzVWQmo5YjJMVXpGOVFDYVlRb2N6K2RNYkRD?=
 =?utf-8?B?N0xNY2xObjRLdEZreUkvMjNsd0g2TGZXcEQ4R3hxaG55c0szc2ZUMndCeDN5?=
 =?utf-8?B?dVpPODNHckJyTjdCd1ZNRkp0R0tTdzZGRlNTd1l5bjM2eXA1MHRWcHRYYm0y?=
 =?utf-8?B?OUZpbzFxWlJMTGJrZDEzUHVEOHBOd1pJdVVac200Nmp4dldFWmdZVWQ2NC9v?=
 =?utf-8?B?ZjVGRC9sQ3JYcG01MHZMa2h3NTZNNG16ZTJVT1VLaWY3bzFYYnEzMjRZV29P?=
 =?utf-8?B?VmQ2b1ArMGtFeVJIRzhmb3UzTWZqcmo1V2ExVDlpTWFobWwzUmovVEJRc1JQ?=
 =?utf-8?B?ZHF4LzFQNnozRUxiRUpJenQzbWVhR1hhM2dSR2c0TXdIaU95VlJ2bHdBU21H?=
 =?utf-8?B?R1dpV1VMUUJGaUhmZDk1SXVUY3JQVjR2NHZFZ3FHalJSRk9GNndVK3VPYlh4?=
 =?utf-8?B?UVhFeitPcDNmQW9PWXlMNDV5VHZaWTVnTi9KdHgyMjNwUXJjRG9XaVJVNFpJ?=
 =?utf-8?B?K2R0a3MveXNKYWVGcW5wWnRKQk5aQ3M2Nk1CRW5WbEJPOVJzb3EvUXV3RnN0?=
 =?utf-8?B?d2RLamdpTVBOMUxzRVIzL3BZbS9FdXorTW5FTDVvTGR1NHFHVEVnM2V0YXBN?=
 =?utf-8?B?dTZlR1RzQXU4cjlJWkxEZFJ0VzBxZHZ5SVV2UTdSOW5xUzhlWWV6V2R6MEt2?=
 =?utf-8?B?TGNzMjcxektyUUxTcS9qaWZyU0ZSQm5jUkZlbzNBTDcrS3c4cTQ1MjhrTkFV?=
 =?utf-8?B?RENvR0lHcExZK3VxMEpFcFp0OHRFQTlVWE1FSVhIWUcxbGcybWgyWmRUNVE2?=
 =?utf-8?B?Q2dUcGk5Zkg1TUFtTm5INmp2czluNm4yME1ybzhtcGhKSHdDS0M3MEdDVktz?=
 =?utf-8?B?ZksvQ1ZnRldwakwyeTdHS29VdUVLclkrSEtCTUp3U3FwMjB0b1N5cEN1SVBj?=
 =?utf-8?B?enY0V3JXR2VSWGN5WnBYZ1d4THRCWUZ6ODFldFRNMGlJZi9nbWgra2VCeFBP?=
 =?utf-8?B?N3VKY1hMSTRvZHhlODhDUjFlSmZCMVBMM2U2S2F1UUQ1SEVDMkxJMmlGcEF5?=
 =?utf-8?B?Y1NVN0RkdzJXNUkrSzlUcG5pbG9DWlA2eGExNzJCcnBFNnRFT3lJb3YvMDdz?=
 =?utf-8?B?KzdBSHBBd0hUVTBHRzNKc3NRd1ozdlFDVzhEQWo0SE9JeEh0L2xxcW1SNmFT?=
 =?utf-8?B?MitJaC81am9LN1JsY0ltUDVGdDNsMlQzNmFkNFB1TnNVbC96d3lDeXJ6dkVI?=
 =?utf-8?B?eXF5U0V6S2JKMEpLQm1nRWcveW8vUTlKaHlqQ2hsdi9OWG4zOTFicmNrSEsr?=
 =?utf-8?B?SUgwNFFtTnF1RFl5TjhrTGJwYjlUWE90WU5VZjN5djRiaXNScjJvT3d0SklC?=
 =?utf-8?B?KzVGZC9oMlhUNGRQOGtodHV4VzJ6akpaTEpUU3N0QndJZWg2MkpBejA0bDZy?=
 =?utf-8?Q?4+78M7YIHligvrdXx6J7QXPG/3QQORj1qw?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3808;6:4B2RtmzCnmiXg38V3AjXRcPSE9Vpk4eJmeBHDwFE+GG8Ygb3v9ViloSLGyZt9R7XPKDOQrj0WSUTfzfSlJjSRK7DbafJ1vqRt0IOFBjqXgdpvsDLKooEP/BKMI4WV0j0kJUfg8tqCzLUaFaxbTNRQnAJGiohFgfGu1nOrmA3GbxM14YA0UC7pLL9JIb+0G1LZgeO3KG098W5y9bPCYLyrC1IADzkfkX5Ftrvy76xNWE4tH1KW9MP4yGmSR8In1fWJKol9/60EhpbJ5Nz1MHTWQ7nWQdB6Os11m9Y4lLaf/tfnsdwPR+ekJ0/lXbN6K835wv/c/mBjjd3QEIYR5LeQg==;5:ovBMe0dwszrwFTZ3ye1FT6X+tnqVPrQkHbX1ZdJth5av56rTcZhc7CwTUQjhuXbwyKmLz8rzHUV4i17plu8MTTKTszSvlhAQpJ20G/korxrWCIYgg0FAmieEcXoXdWfu644Wtre/lgqmy+ySH1JOQg==;24:c3ftZf63jCFEURil25W487N8x4lUVohad2I/HCsCQBzIILpjGQOYl3ciz/h0npFU3E2/LUZODJQqqkh7vJAcCHAvQP5GMZ8LjThWvBZ6B4c=;7:3kFn1lswPjFcpMDYq2nVk8cd1YNkbHzwAfmX92Gss1PlgNJiUyASYtr310aTzsNAVflMAXbBdK3apmXvN4W//2dko4zykm/eNN+nD9TfmHDa7V5oZJLdSNuDia273KUT+DbMxrXX+JIWL39Wm9v6RofMJrVn6l59wpyZJm0qDXqkFkeIapAMpKILQiznDgyK/IPltx5cyeL1UvpuJwmPgsaJOUwefruP0uqTCxnRtjg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2017 18:56:56.1230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3808
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59579
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

On 08/14/2017 01:18 PM, Paul Burton wrote:

[...]
> 
> With the new Kconfig entries introduced by this patch this can be
> simplified to:
> 
>   default y if CPU_ISA_GE_R1
> 
The idea for the patch is solid. Can we not just use CPU_ISA_R1,
and so on? GE immediately makes me think "Graphics Engine" and
there are the GE7 ASICs from old SGI hardware. Maybe it's just
me and it doesn't confuse anyone else.
