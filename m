Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 19:56:54 +0100 (CET)
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:62384
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990591AbdK0S4qMF63S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Nov 2017 19:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PUAbB8gXE5D5NUyh7gKGf8r89KA2Q81It7cPlwsmJNc=;
 b=JHQecrB1K34DyU1Mf5RRZKdafrPS5Rz5gTdBQ3WzRDQ3ux3+cJcOxQiaeGEqP3ChLTw+EnIr0yQFRhaqn9K5dlO7CZrBUkBOUGpVQuk9wFTx/wmw2CTFwdwy04rEv6OEHselL/Iue54Olr5a6MAVVddCfaUxSGQBxGfzIhWWprU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Mon, 27 Nov 2017 18:56:36 +0000
Subject: Re: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait()
 everywhere.
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <2f2def3f-e047-1a46-1cd7-ebf4744dc2c3@caviumnetworks.com>
Date:   Mon, 27 Nov 2017 10:56:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0bbc323-6693-4199-57e6-08d535c895ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;3:oiihurOttYo/zzSB1RP5HLD3j5eBYrjaVNovUNsPfehZbiL+lWaTVMNYmY8CWdLZhGc25KSHkiuMjJ1UQCBvMG+Lb3bhuPXXn6HqaOBZyt3tzjdDooKLQ1wb/STAlHVD+war60owfB9oFdnCu7DaqCIuUQOP09z8ScmScYcfNTp83qy89iGDzWOIYggxOZ2wHQNXKePDE7n6zj7VBAcCk5JB5zplMzNlelCc4HdH57zE3Gk9vTHHMOjy6BsaY0/T;25:vfX5aEeycc+r3raihQKurbd45WzY+sGRSlrxohaPBWBaQWE+04F/WUbZcJ0obOE5b77tk66kKJGOnIJcVdoBqdFWoIVFsvgySE3zN/8Viz3JqlJM4JAH2w/7PliGDU/WpDN9TtkdM1GG6/9cWECQYPSQC3GvldhWX1l97PMe+ngQIPkF+pqHfEWMrySu5uxth3HXxc/f5lQCxDCCIoURokzTCGuU/jxVgtHyz6Fh6ajS3wo/y5pQaGizxZFBC80/fwASM4YcA/u2yA33UkaaTGPNzxxrZpVRik+0XT6BhPnPVi58/yNNT5GcLResSizu1X7MVnwMVwSzEMUvT2Q2GA==;31:yLv9h7FI5npRkNyfGNOiyY5MJKM6mLp58f/DFqOEaippxPw8+pEJmH3wOyFmJ+4ThZAtb1ImmQfhq9dc1jXNwydUX3zjgeUySIG9jBk2mB2mBHmD0THZPP2Gxk40/0GIsOUULD2kzgJM1Lf/ochGw1TOT+E4U6HvK2aCrJ5fzIhV1gLj68DXRUXJlMU57lhanbuzSgAri6XpvkP8akLamUFI/56I/9s6T2cnInElO+0=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3497:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;20:G+Mozh10XBfk4tl49ForOCOcqooMzfRyB15PsOfOgMwxpEKkStn92EGNGqErjG1Ef8E/Z9LGtULb2vz01nZaNJUteE1vjCbftjIepYKxkxANU8C7Pr+OuvRBR4/egJ+b93oflGBGw5WNy+yQNAGc+NAv0C9+7dM3o8u4uVM12KDSkXyxzdtWFTr/JSXQ03lDI42NqIyxCBCC0TV5u5O/bbg8mA4evj2LEYb1vlODt1hc80J2ZF8E70r9zK2Z7A2JFlIZhN19DU/KVBB1CT9CWy0qIoES6ekeR9/apjmV3Vqt6ep2JN6yOUfgsBzkaDvb0roADyaxswVIry22feC/ncqrNXONKCnN6EBw1u4GhLLaleRwXq/8s5OhbpkWgOeG8b4ZqlRARcVPcSr/RWxZi6eSDJt1GDsb9puC4SqUF9bkz72jj60xu9sUgzYA8ZyCt/FjsQEY0j8Qlw1OzOmPESdo8s+sHMqgxon+87xwiNT0pLmvOQkzkaqFISivMvmdYswjVaOEHt8iolcLxXXcpU0PG0H9CRxxpzmxurXpxxpuH2/++Lu1gt5JEj1v/zDFh6kDuTg5Fe1acX6cde3sGuJur7ksEO5ZNZRNG+UTaMQ=;4:m/HB7N/i8eljMUEQH/5jtNNdxU7DfmE4tgCjcmUErFkF52E1NnzQgO2xirzBSh2eNfCNCt8h+CDAYGdv33ldKNGJLQXHFA1DOIxTmfgeANfdL5rG5OWtBUIATNv9euHtF3iyFmG/l06siwYgrG90kTyCAG5IeKe9jCK8Olq+zAfed3bmfKnXixcs8OoWh2RthSkKINlE/ubhQSKwbzGxJsQpRiAdZMgGl5k4lWlA3/KzIPksZVY97RRvqAuRdbCws9pvy4S5+WLs1JToe0RCaA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB349784CD1F5C2467EADEC96597250@DM5PR07MB3497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(3002001)(10201501046)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148)(201708071742011);SRVR:DM5PR07MB3497;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3497;
X-Forefront-PRVS: 0504F29D72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(346002)(376002)(24454002)(199003)(189002)(106356001)(36756003)(4326008)(67846002)(6512007)(53546010)(6666003)(83506002)(31696002)(6116002)(42882006)(2950100002)(58126008)(33646002)(450100002)(72206003)(229853002)(6246003)(478600001)(8936002)(3846002)(6506006)(5660300001)(47776003)(2486003)(31686004)(105586002)(2906002)(50466002)(66066001)(52116002)(16526018)(25786009)(7736002)(65956001)(52146003)(23676004)(81166006)(65806001)(81156014)(230700001)(8676002)(6486002)(97736004)(305945005)(53936002)(189998001)(64126003)(50986999)(68736007)(69596002)(101416001)(65826007)(316002)(53416004)(76176999)(54356999);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3497;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk3OzIzOmRiYnBYOXR0M1JvTUdyOVAwZzlNN2VHaDZU?=
 =?utf-8?B?QWhPSUVtQmhvUXJXdTYrTDAvZ3FYaHp5WlB1KzA1M3F4bDVpdmhRcERvYXdE?=
 =?utf-8?B?NU9xdVFocVIvemU5ZkxTaGt2TUduN3ViaW00M3daMTJKUG1wRWFUS1BEbXlu?=
 =?utf-8?B?cFQ3dkZYUCtUYTBPeVVTL29EZjAvSitIUDNxSGNGTWd6YnJzU0FNeFkyd2d2?=
 =?utf-8?B?U3dleFpCOW1PSlhsdlEvWVA5dVE4K1hkSmFya0xOaGRieDF4UForTUNRN1FB?=
 =?utf-8?B?NXQwZE5vTXRoK2p3RjF6UmMxRDNzSWVnWlhvQ0hQbDFrQ1ZrY0lYVGlFcFc1?=
 =?utf-8?B?RjNaOTBWK1BDUnpvaXpialNFUkprcnFVZTQzRldBSktOMTFmRjl5SzZsczl5?=
 =?utf-8?B?enVBaDUwRnJJdnRsOXBwRnAvRVBrU3ArL0pqZGdlOWpuRkFWc1F2cWluVlNG?=
 =?utf-8?B?cW55UlQ3bit2bmEzTGFCOWZTdE1RUTlWRGlHaGRpdVZSYzc5MkFuWDQzcjZP?=
 =?utf-8?B?MXVISzBiaEM4T1dlU20rYWE2K1pXYnVZR1M5WmVZQjRBSXJQdEFqYjZxdzNq?=
 =?utf-8?B?dGVFdHpwQVBwQ0QxRFF1ZmhGS2w1UmJMR0ZWMWx3aVU3UnFJRHdvVTlRYytn?=
 =?utf-8?B?b0owaUJSUEtqYlBZZWJMRFhsQW9uMzBCNWRPQTc2ZlBTSzE5M1ZYWmlDYTY1?=
 =?utf-8?B?S0dURFVRRCtYNzVBNzFLcmVnc1B4YXU2Y2FDa0VRcjI3cnQ4amNBRHdWNDlw?=
 =?utf-8?B?emVVS2d1aXlMQ3drZ1hjOXBtM3lpUkUwV09pb3BuMkhSb3RQTTdQY0J6R0d2?=
 =?utf-8?B?a29ZOWVSMWdNWnQ1emF0SHVXN1QzU2FlRlhzdG1RdXZSRWMyZnh3QjhMTnh6?=
 =?utf-8?B?bDd3VG53a3Rva0RzU3hJWndkcEpoY0tsYnFtaTZwV1JHQ2R3eCtvb2JCNldY?=
 =?utf-8?B?eUlyNnNUWGNXK0ZYd0Q4R2tlT3Ftc2xKR3Y5YW10cVg1TjhCY0sxTzFqV0Zk?=
 =?utf-8?B?ZU9YZUQ0bHcxWUZxdzl6a096U1ZtTDEwVGtsNlBDekljV0c5M2lNZzlPNnkw?=
 =?utf-8?B?SkVFS2FuUDhyQmZjVHZhd2RXMGlpdHpyQlVmbzJ3eGJQeWJ0ZUgyQWJsdHh6?=
 =?utf-8?B?RlFzNFJnWnYxTFBnZ1E5emN4cEtoOWdFakhVMWdWNE5JdnpxNFF3VlJwWS90?=
 =?utf-8?B?RnhQNE4rUlRRK0RtRlRyZy9CMHZqZTJWMFUzbUVQYkttZk8wOFdKbTlJV3dU?=
 =?utf-8?B?eUVOTUNZNmVndVVIZ0NmcDRXOUtrTmR3Sk1XajFlbE45TXJyS2tMMzduWmtI?=
 =?utf-8?B?b3FiVXZmdnEzM3dhVkVsM3VKdVZRai85TmxxZHJrQjB5amFoaVBOZXRlUjRw?=
 =?utf-8?B?dk1WR05YQm5CRnZGdUhLdnhocmp1VDlsVzFTZ1NuMWFSNmZxZkdjNlV0TVdB?=
 =?utf-8?B?QXRvMTNSd2FNRlAvTG5RWkZnQ2JKSEJQU1VZYWFtM3VXYXlYVGE3MVRuNkpY?=
 =?utf-8?B?a3J5VXFML3VKbWJRNFVMZzBPV0tRcWNPR0VJL0cyWTdzeWpuWXJyVnNmNzZE?=
 =?utf-8?B?NG51ckhhNWdtUndadVRhN1djN1JJc21QeGExaldFZkRvdVJ2Ly92SGVPTlZy?=
 =?utf-8?B?NFVTd2YxcDFla2dVc1M2VHhnVlhCRXVaWFgzSGtoYThEQ2xMdVF6dyt5cHRL?=
 =?utf-8?B?RlQrUHFaaGZqc2VhRXRCQjc1RCtWVWRmVDg5bGQ4SndJZnVIODk5czQ3R29M?=
 =?utf-8?B?aWxQSExKc3lvQWJkeFludmlEMEVHWnBBRjNYS2lUM0N1Y2JvNFZ4bERDL21N?=
 =?utf-8?B?ZGxlTmI1ZEZEdWFvLzlpZXVKeHVQcFZxTmhBNFVhdk83eVgxdTFJdEs5KzZC?=
 =?utf-8?B?R2M0c0dvMHRtRTZnamMzQzV3RXNXVk5URGlRWmlkckxLUHQxVlpFOTZLVG9Z?=
 =?utf-8?B?TklZR0hzR0hQUkFGNllJeGdtNEgzT05TdlZiWk1JL2swbS9FYWlCUEtRcXdO?=
 =?utf-8?Q?IjK0fX?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;6:d0Np0EbvbE6o8R5rZDCTjC+OIvx2RP3FJMl9uxzbd9oN6bPCcVS/UEU3dug0ypD3vGtqUHhq/655nfuI7j68r04784AT9TvlQIVC8+CroxLJ7LsSOKRDMmtM2+xDmzlhlzVvMTJ9HEku3FKPpGnuky/qib1vSUcMNk6oTiEYvA6WX7rXKb7abkPOsNmU/ISUVp2GdV1OHFt83LHE1xklty3g2vDoUDEu5M4hqmghlxta5Pi8KrZ0IKIU5U5TvkgoxsQUvwV4d2h60VWaC+ZOSR6ws5UzKz7wEQ7L/+LiBJ1KLlo4qamqdK2vs+jSQbASmA8qRIT5UxOurLci5aj64DknT7B39Fq0wtJ1XHChyrQ=;5:giYrxATFcaMcIKvZHZhT8TGYzEP635VbFczh3/IGBjUanehgjySAPVTzERKyPUq8SWiTjjDYK/ZiawNu3nXqzBAszL3bwUD0TV3gdkMpxo4PsxpukJjwDLk5mmAGKXstu4Z/79Fi1vdHLINnn8FTw1jnzv9Xg4wj79wGqgOWim4=;24:/pSrM48vT1MO8TGNHZ3vV+uU5YOY56HWE7r3n46/5Bg7o2BUtpAetJH5cs5Nu6sRa0Xoc5zLRZtHzyQ52D6t7usU2uHgF3//xXORlNFo+dY=;7:2SLCTx4xKd5mg9T2RR7otDmlcwhFnViwltA8+eLNlaJPv2Pg4u364DpATv8VXm/dn9+yEC6taGJukeM5t2yemwqD59P2Af0tO36YTl8pFpkDiOM+UYbWa3GB9ivleMNqZf9aVUnH8zKzy2SL5m3TV/A1ywcrwpZRk7rLwdlSMrGy4P8hJQmcE2VeOkGp3irE8i5d6bhqWEp3iI5ZdwXdrf84Fimsb3gAWlm+mS88YBQuNiJoIT/kfG74wHd0zd3d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2017 18:56:36.2415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bbc323-6693-4199-57e6-08d535c895ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3497
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61103
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

On 11/13/2017 08:30 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper.c |  2 +-
>   arch/mips/cavium-octeon/executive/cvmx-spi.c    | 10 +++++-----
>   arch/mips/include/asm/octeon/cvmx-fpa.h         |  4 +++-
>   arch/mips/include/asm/octeon/cvmx.h             | 15 ++-------------
>   arch/mips/pci/pcie-octeon.c                     | 12 ++++++------
>   5 files changed, 17 insertions(+), 26 deletions(-)
> 

WTF:

drivers/staging/octeon-usb/octeon-hcd.c: In function 'cvmx_fifo_setup':
drivers/staging/octeon-usb/octeon-hcd.c:636:2: error: implicit 
declaration of function 'cvmx_wait' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

Why was this patch submitted and merged without running git-grep on 
cvmx_wait?

Steven, send a patch to fix the breakage.

David.
