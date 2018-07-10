Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 20:03:40 +0200 (CEST)
Received: from mail-by2nam05on0728.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::728]:11008
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993997AbeGJSDdytXDt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Jul 2018 20:03:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lIvHL/M90jqY6F12P0yNPkMEURAEUCscRzIOHwYt4M=;
 b=axRtr8r4UVkp7GC6pao4vMjUVu7sFCkSMmu9fPUViY8B9UrAELNddYSWhiMtwbMPQo20ai1ycUazGKpV6leBHnhySCrA78WqM+QwswFgBgtT7U8bOwfh1z1Xk5+O4sqrZjyPVm1EVP4WPdJdfF9/Hbuv9Z0cvhtjHC7PO8QW9PE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 18:02:52 +0000
Date:   Tue, 10 Jul 2018 11:02:48 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Message-ID: <20180710180248.ns6x42ibi4mhqoex@pburton-laptop>
References: <20180615110854.19253-1-hch@lst.de>
 <20180615110854.19253-19-hch@lst.de>
 <20180619231925.mgbgc7lfvjqumr7a@pburton-laptop>
 <20180620072328.GA1675@lst.de>
 <20180710123518.GA1812@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710123518.GA1812@lst.de>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR10CA0043.namprd10.prod.outlook.com
 (2603:10b6:404:109::29) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb931dbc-587d-4a7f-e375-08d5e68f5aeb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:xJz83r00RrQfbDOTdH4GzxWh54mk2wXzeBFqfJNGeVbCkZGRIr0LZLK8WV7EYKAUQnSvti8u6lW1rJlbmEpiiBrWaWg1nCLv65qhjZxifDxQ0cdwj0mIqYJjAgVfEDvIyhfrMpWgqJbi8jh0zDTSGL6CLhkr9NdlriwaYKCax6O0/ThSKcoDv1tqNqxEsTzHgMBZOZcAauc1ZQ/lhyXtHvrddyocFmG+fdL6VknX2jktrzoIs5PBZW/JynjnICJc;25:zl0J4IohSsxwY8Ef/TV/jBNZNPY8mDg5cM6oGUZrirpAqdSnRdPlbHpVfhPIyn1QMBCfLEGVJNGp7NWV6exS5ibqFTbOHyVAnX8zT6B8bejlf2DrgRRn0pLQqPd/4Zu8HjCgEWfkDsU9NzA79Yw7KBSk7YBgc8/y4fmjwKjpRw85S1KxSibahCFi5LzrzGUjnFxPmTNy4ZxcuGmCyMBNFyJAaefBd3SKyubGn8o0tdW2zNWPawSLpxWo8bjpqlyPPHv4kr2f885/3APSnJhJMjXKWbJePBeb18Iy6SLqiRAkdV2w44DODHRfN8rY5m22loxhjVmPW5D78Mf8QQzb9Q==;31:3Yh5q+24CXIl4quHwQdytVjApEM4aOU7isY8QRYLJcdnNsVBDFwHru3jpzDtMa4nfk2RpjqK8an6ZoyjRj8lC+3AubwpvfnN0crX4XMSQ/NBVloj2RNTkrzm4tf+0Pjq/GMIXmBXMfiJp9MS9AkxHzdX0OqMJqfKDPDm8BSSH5Kt6K5OVL6g1aMGk8q1+Rra2o8HGoOTmlB2Lw+vxTTHgzYaSw0agobYBvcC8LU3SAc=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:9gVEtssYYuXuOt8OOQSYxGkCr2UONhx/3xVK3UDWfLw0YEAnjSXBM+rfqwA+t5W7MrhStjWUaxrFZW/gm2edOSFV/wm9rds7b6yOKppDsfsS6erbeBgyPT/P28KbEReA1L4Hs/JvkqvtfOWRX1xNdm1wx8y+H2GERetVKgJL59nTgySJJQViwBVrOm7lYeeVPVw9wGHON/rqAuANXT0rD+v5yz9IbmYeffsO7BnBXZ7DZt4tFC7hZzTlzfY130bt;4:t0/m0O/Kt9kNghrkZ/MO/wZaRk5Q06OUlCBP9NrLwCGjzuNMhcyFDmvpKWwEoVEuxgSVZZz0IndegYDlhmYU2IL6WUK4ebWfo6ATO7tGurkLZblmQNhcF3hLwItkIg8W+bbKxoISZGYnN72bsKeYeDaS1sQAcSHPjTavC4e3Kmg9QiDkbh6ecseTsKn4ElWzsIgJoOBgdhxqbv4Z7k8QfeegnWoxDcu4hmNAgHa1ythCe+bDsh7umVRS/p5lQlzGS6VkrCaEuQJRXXUyHskuiA==
X-Microsoft-Antispam-PRVS: <BN7PR08MB49309F628E207BE2081417F2C15B0@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39850400004)(376002)(366004)(136003)(396003)(189003)(199004)(476003)(81156014)(81166006)(956004)(7416002)(25786009)(305945005)(8676002)(4326008)(6916009)(478600001)(1076002)(2906002)(23726003)(8936002)(97736004)(6246003)(9686003)(5660300001)(7736002)(3846002)(6666003)(39060400002)(53936002)(14444005)(6116002)(42882007)(44832011)(486006)(76506005)(16586007)(6486002)(93886005)(11346002)(446003)(386003)(16526019)(50466002)(26005)(6496006)(186003)(68736007)(58126008)(229853002)(54906003)(575784001)(33716001)(106356001)(33896004)(316002)(47776003)(105586002)(66066001)(52116002)(76176011)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:OZ+FwfYpZUC/J8FaRMKOohq3EEDEkvrlxnLD9Pvg3?=
 =?us-ascii?Q?+whRolTUrWvjGMbrFYw9MLDLie0AUWoXEYrampjRzh4JThzNA8RD0pNrZFmb?=
 =?us-ascii?Q?8vqV8MZnRg9+DEvmGB54tjkFkqGLNGs0hoMyrg8fIHdl0c8dgrMRRON5V0UQ?=
 =?us-ascii?Q?90UnKaG60xMakTf5iFLNm//xLbzeF0IyrTXTeYO4ZrR68/ghu4xNsA1yvEbq?=
 =?us-ascii?Q?Y594nABjl/C7xpmgxDD6rdPuz0BV6wK/iRjowck8j//aP5YlMMHG/8FshuPA?=
 =?us-ascii?Q?Eq79CHXdKFgqW7VQ+d5aRO/Ke89AsgYqt4GTNlawJ6CvHKpWWYAtzyIC0Fr8?=
 =?us-ascii?Q?1EGMV7zBfDztpz7bpUwuJkSpE10ku6xM0fbilIRagIIPuBEiQWwH0eGsAWKD?=
 =?us-ascii?Q?6w869VlLJdS0mLyTxVrdcqy9aMtaqqVejx/fDRUwKbO/qQ130812w2PMtK1i?=
 =?us-ascii?Q?Lrwhq7OK2TNC8gi18wLWInlBuhdZswOvu8+aVePjDOix0JpGDUNU0uJawYZP?=
 =?us-ascii?Q?YJbkDyukw0tV79BFkF5260DzAumsQW9zoooeTjeYwuC4lGZ5reubQ5XYRojr?=
 =?us-ascii?Q?HNzfM+UKyGQ8VwcwvmaJTGwQ2x5enX1i4WGmGLQkZl0lErfr2INCeZqWq+VV?=
 =?us-ascii?Q?YNB+cDh1ngWQNh9nlNWf6uZFJqan4ROlD+kdBK/z2H71FcGvobJLusXqLOxP?=
 =?us-ascii?Q?4u+kqiltE16teY6SSC40S36vSvjb7psp9/tGvE0zk2juXLFYUmsGnGrV4cEf?=
 =?us-ascii?Q?0BMaPNoFIAeTS6rDQOvgSEzkhnGtdburgy6PavtRL0tgJxnz8NUOIAEagjUk?=
 =?us-ascii?Q?ct3dbtO6KhnLbgihUruv0v9xw8RL3fXNUy4P8WcoVa7kvSG1fjRjSVPYqopU?=
 =?us-ascii?Q?Dk7a2hZlu/oxpLMZRxtQUIA20b6mTnJsVAPk81NXHjM5Ny6TMXqC5VNRsUjB?=
 =?us-ascii?Q?0hln2PifTrBdA86R7tF33zmOTpN2FGiP9/YWFs8/AwCecFJ2b8TolAOgsmbL?=
 =?us-ascii?Q?32SZilIN8z/aIpyKxdsHWOTzaw+j10qlPFTRgH/Dmc3C/wEJ1gElmcDjLZEK?=
 =?us-ascii?Q?jBMFYjG2IuqTqM2n0+G+quLSqW9a2OLrjzXBBDbooatLXz/JnLUOpruJXnzN?=
 =?us-ascii?Q?S4+MYcSlNOYFZxYN4oaoDHS7NluKIfyXgP94z5fS/cUz8uyvAEFohWpod5t6?=
 =?us-ascii?Q?EZSmW3MYdJwFSG0oAnInYgXzdNBPBuV7uUc9KSPPO9o/qLj7J0R+4rrDrZtZ?=
 =?us-ascii?Q?hFyQLh9vSvVgg1tvHfB+tf/6xaEVJXTFay0fmXkKZRvOVoMRuolnkXVLkBjo?=
 =?us-ascii?Q?+UxUq/7Ny2sNaitU8oVyi/2psxXioUKBQygm3YvIGEk71b1bPRNQYVzQ/PyY?=
 =?us-ascii?Q?Ch4Phmr5RJ1E+yZhhzS9Jm5wdc/R2DV/JV3fDMOfZjOn3ujCSUW5F2EWFi/W?=
 =?us-ascii?Q?xpUTmoRBhjQ/gOIwS4DJXAZvzTU2Wk=3D?=
X-Microsoft-Antispam-Message-Info: AVvxuzeYto/bQRU2/Qymj7pRUpyZ7zolKQRp0efGa+3eWQYfrqD1gLMaMjp4GPwUlZAjCJruQLOeTNLPymZm/BAMzSiqHS6jv5FMZgFDmpG8Ja1bNIiWEkDUlK7DFjaOxmsqwO4jrC32hojg5dY4szMflMY/18aDbHAtvr6h0WzJ1aYY2vOzXpFk+C26VatreOVjSvHGBqDu2J/d0XP1Yxt2wh9EXnw8Tr4a0h4thfIUlVf67sBf/TBEDg+SqmgGddJY6bYKrWJ0h9vhjF5LMRStRc0g9zcJyGw++CcEXdeFuKDrf3uF8o7LA0pPoQNEKYu3rdyFhwhuyFI4xy44Kg==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:cLhB6gz6NF+vnGz+1E6uE+Ds2aLWnyp5tEpgNZAeMpV8mY9sUvUiM8J5RkzyFBwOhHS6TjebTNpMbowPRbF5ws2gjN90ih4tw8hJxAGz78a6Osd9NAWiDErI/WuXuTQLqGRztVlBbpKi5vPPYYDqBTQ4NFVXX1oAf06GeVyfN9xyAq1N2C4w8pX2ex2iFfmiD/02mVfewXLpQ1VGmElAWYJEyoSND+nhxnNxwQKuuW/rV26Q/acJ5g/n/dHUoj1uDiS/y/oQZWIrt8E1ziQ49fW8mre4NdX47WwFmvTUHlvXmoJhICC0hV9y1VicBN3eorn+LcdlX6FgQIU41NQSC1ImVc5/rsGHFx5dUFAJNQUdIESGgcP/FZPeCts8keqIiHzUT+SV7qtEG3dL+2rv27jy+C6r3wdScO2qQG+u5MPpeRwWlh3Zjnhn7LCK/87cWVlet8KubjBHlF7fSyZI3A==;5:lxJMs2/6zYkzgwoEQkK1bAgzg+1/FcvALwd0nLDvzrh20nSVTGEur4x8Hn6jiwGyk9n09H7EXRLdHV/ZXrHtDErJehJEMLD5G8urSHbq0lM5WtpuRs/UQ68chcCqqejH3lNDTYr4U6wnvcNAMniZ/5CU+9eWLT/oY5E4tA5B4HQ=;24:IZrRkWFOQxRu260+xl/jvrZr+OejJHIXMKHM0P8bJNV04hxgiA6sEh+4xtMynRls21UrsIRoXwySwFjFrtM78BvGrsDjx/rxdpjr+6nJ2WM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;7:ufhYKBta+sOn7Uw20RgXSaqBm2zgxYtCLkx67RaCkAyCMjMaLDgOLpNrFbH8fI8aUok7++kEDLjhrF2JPJfr2EOrlL2pmhQJ0Tv7jueWfYTJD7sqPMLvFrTR79kOLJYBgQ0t1HizHsrCMuUdxWGemNt3t4Y2IGPiZsSC/nTFwGjIcVv20RXB5p+LVpEp/zPi4cW/hpPJ3ZPcftZVCMOR+nYNG+eilO0MbWYCXKCqI+X9+jJR170vgRGNlyQ7Fgs8
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 18:02:52.0371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb931dbc-587d-4a7f-e375-08d5e68f5aeb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Christoph,

On Tue, Jul 10, 2018 at 02:35:18PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 20, 2018 at 09:23:28AM +0200, Christoph Hellwig wrote:
> > No, this is a mixup.  I hadn't noticed one case was 0x0fffffff and
> > the other 0x7fffffff.
> > 
> > Below is the minimal fixup that keeps things as much as it was before.
> 
> IS the rest of the series now ok with you?  Anything else I should
> update?

The rest looked good - I applied the series to mips-next & it's been
sitting in linux-next for a couple of weeks now. Apologies it looks like
I didn't reply to say so!

Thanks,
    Paul
