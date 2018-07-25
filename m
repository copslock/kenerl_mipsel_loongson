Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 04:21:31 +0200 (CEST)
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:12352
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990393AbeGYCV1qV6Xu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 04:21:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIA7cmjDzszTHRbQgkdY2p6aGvwONosWIlxbu+pY3Fg=;
 b=a/5sSfHAJZGziRl/iLpQnT8banTY4JTI0WwQEe0tZhZ2vI3YkLoQ5edAI15lhm1WO++5xmyv6Y7/aSbAiW5ZafJqXr6FTy3SQP6D6vkMbMmsmfHApFtFiD9EojkHf8ErA+R/hrD/FpSStoKYlAGWxkPjuF/W71XyOa3Jx6QnFOE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Wed, 25 Jul 2018 02:21:17 +0000
Date:   Tue, 24 Jul 2018 19:21:15 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH V3 03/10] MIPS: Loongson-3: Enable Store Fill Buffer
 atruntime
Message-ID: <20180725022115.kdvtddbrvysmgfqw@pburton-laptop>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
 <1524885694-18132-4-git-send-email-chenhc@lemote.com>
 <20180618210507.akcvvigzj7qis3re@pburton-laptop>
 <tencent_3C127D3D5620B83833D77E8A@qq.com>
 <20180724012116.bxtzn7g6qmri43bd@pburton-laptop>
 <CAAhV-H5eUPOGxDMLZGThMjidCRjAc2e8e8LS1JGWgJwW71uk0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5eUPOGxDMLZGThMjidCRjAc2e8e8LS1JGWgJwW71uk0g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::46) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f6503b-318f-4b18-e699-08d5f1d54dc9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:WlxXgOZg/uu4DWQh89phOflz1b38ty9uIRHIb+gIO1Iftt0FUylWFGsKlqMmsxvGDFGGE8F14Lz7CUd3EqZdt45zXh14qz4VQLytvCmg9xZtJrib+BwrDSjH6OZC0Iv89MSKPN/O7x+oKbk5qWXttoXVvw1mLB3veZWRsTroiar45VhAQRdxK8qlHmZDCuBsXWhjzqr1b9b4FWH4QnzPYtcOI/0u8D15CttJe5RBcNySLmoXWtaaQK3rMTi8txOK;25:ZW6ekOsjVBKyKMXhzNOHHxdgao/ZjSVHAaGJZH86f9GsOH0ZtcMZNmu9kgKo8sBO2PxiKU9NiPFEEhqKKtLBiDys1XpL0gUBJl8PhEm4aOGXI6riCKzPiHqLslGdQD6oOm6zxNCV2hvU64NxGRhz2siPUHNBdOnC2JVv0ypQWy6kCCN+5W8jOBr1Hq52HwlVTd2YwHkpWibhY8y/DKjulHb7wgGsw79N+wncO+JraxMG56Lap6boTkpHTSw/1klqkw3jlKAi5iDKEF47J3qwcD2pOOUM+ahpadPUgfogYCaToYgFx7mgsKIYndq1cXfS35W+pDGT/R+Qd6DDd9hbog==;31:Z15zfoNkunko6z/QqcqHZAY81+y1aXgfWHiYhlfBBXlOaWZgMPDHAL92uB67GLQs/8/CQHStMWavcJwOksEiJFj9jBuNWmrWxjSIpWlq9+/H8rIn6bQN4oZlH6mNiwC+BIMVnq6BesMMo+2wDWn0SnE0Kr1TGwiB3Gwpj28JS1jkX9RwthGhxl5U6tBSHfIKZebCl5ky3Rrg6Rl62jzcsY5+ZSF/h/mXhXrx1wsh+JM=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:8Mj/eUoQ9X0i/c8R9kOORYheJ7UWZ7uKoalMTf/+mfM3+kJWhfLFeSuVHXxL7iKofy9m/SEifgRVjYqLxgqqmd6kZXocxWJLPtsEiV6GZDRpP7QdHRBnwpss8RSrnP4xL8zPftpHaZ+LxeS64EwBroHSZJB7SgQugQ0Oy9tLKJzMqVM41LfGndvysrBNNmXNbHfMCscq0dK8q7XB0BIuRXU1IG89q7fkJqR6jTBLoqSLOt6smAzts5TO64EUk90A;4:EFjlkb6sWMnPbudYolH4lMK8ORY20dDBv5xAbCry60sYIB9SNL3mUoPjEmuoBNRUjLpOYqteBQ1A6hv1kih/n8uFvI+VLL95h3elavlYFu/FarHguCHQc856FG7wdAWIJhbQdemXRm5FedmNHT2N7pYhQFzHthqsIsqOzaOwG9NFQxif/mKD1Whm/RdtXilaxxh9BEms0bxFJ5FPIQnY5fRaBcDGoOWK1mQiokMX9+zrtclOdY28azCH57gvA6unPOF04Uafjn6YGn4na27plg==
X-Microsoft-Antispam-PRVS: <DM6PR08MB493883CEB36C408359F78B23C1540@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(39840400004)(396003)(346002)(376002)(136003)(199004)(189003)(8676002)(305945005)(6246003)(106356001)(76506005)(8936002)(97736004)(7736002)(81156014)(68736007)(6486002)(229853002)(478600001)(39060400002)(25786009)(81166006)(9686003)(53936002)(186003)(4326008)(16526019)(316002)(16586007)(26005)(54906003)(6916009)(386003)(76176011)(33896004)(58126008)(47776003)(11346002)(446003)(50466002)(42882007)(33716001)(956004)(44832011)(14444005)(93886005)(486006)(476003)(23726003)(3716004)(105586002)(1076002)(52116002)(3846002)(6496006)(6116002)(2906002)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:MsMWg7TKYZB8zX9jXaedvNRBH7B36sE0Unisxhjsw?=
 =?us-ascii?Q?pb6zNEUUL7+4lHe2auldy7otY8F0qgIZXWYuEvMWMFE7LeJFTHGBK79kB79P?=
 =?us-ascii?Q?A9f3gESK4NHLTaA2k0YEYDJB+6ThuooNzBV+YnuwN5P095cCsWqV+oxcbGKh?=
 =?us-ascii?Q?6WM4b1lTRm/ltofw98OqPxN/UQpLUocqr31KZLgkz3SG358egHenUCgqcED9?=
 =?us-ascii?Q?BYePO5rYBYrdpxgwXBS7mSSkzSsnkocOi1KY2EOJQnyUhEBnNsh+niAHfMpi?=
 =?us-ascii?Q?1LqBJnkG153QnfAQDDRJBy0qPmfOldKcAye1qbFfJjS2618T7HEXxs0AHpTa?=
 =?us-ascii?Q?ui6qjzT68PceYa/WPwNcEzI3W3BKnq6N98EZvFnv2NYf9NImSByHDj1BOUhG?=
 =?us-ascii?Q?x3RA9d90fxOJl/fcOggYkTE5UJj2b8hy6GXaPL7sgWItsjE5GIUIRWLkWytQ?=
 =?us-ascii?Q?A0wwY4BlEHXytAEDqjAC0wtZ1+vRKGWprpJXJof/xRw9vJxFspnDtuYkvxT5?=
 =?us-ascii?Q?8mlrwJECG3z8lAmpCQqBJPQCjV0NgZC7AKuAvDKXd733H7wgM7mZ3Amfp3kF?=
 =?us-ascii?Q?ueeesTQ4Hw4fZgLGoqwdh56ZQettk393tj8kc1N3Nd9qEU5raqBMKVMUlakI?=
 =?us-ascii?Q?l6UiUAxFfunGDp4HYSC93ukHb6Bh7PJbY/8tCqdxpICv1X+Tl9WXjg+jOSHp?=
 =?us-ascii?Q?aIuSs9N4ZOfVS43tsEgk0ePtZ3f1/+/gTnQ3DjECFjiQKAtIiUcmv0mBPTYB?=
 =?us-ascii?Q?Dvv7kgdBeMOl+7iOae+O7eaacfHqsGwmtVkVyfKSW9P2xZBWwOhByns9wTmp?=
 =?us-ascii?Q?8gNcdybnw0gE0U5thDWssbRNV+EEZaTgElDUNvGpv3kfBIEGuvkh8FZohKfW?=
 =?us-ascii?Q?J27GuT+cfXEfG7/2R/rABglz397CP0U+nST3EWMW9TgoiS1vootDMNfTP7b7?=
 =?us-ascii?Q?ovBLfwzBBuB01ZHbLZJoWw6bKmbeqkH3e+Pd7Yxv+997gRaQ4fwFJB4mb2XQ?=
 =?us-ascii?Q?RT7wpVgQoE8xnTHb8JOOU6Q41XQfXh1rIdgVDcc7ljp4okp8VVb5DYoX47Fv?=
 =?us-ascii?Q?yK2Yos8+U/UOXDdscBQBiu7olm3q/0PIdGebJSUOvumYfNbW7e7iQORA62uH?=
 =?us-ascii?Q?9I26id+Quv9NjAQFURvB+MefBvGbxx1IR5Ab+TpWq2BmVRYwxb/AWKuepCOs?=
 =?us-ascii?Q?9vAJMB4xm1c5eafv/zXjMkqCMZ0FRwtFbnEBNkrDzjb2N2kZrIBqHVK5Kxf+?=
 =?us-ascii?Q?lfhPU8xPCVjzNgowFiAf/WBNB1pcfPyqILDRKeuHQ1emWzOBoJn/hzf1nKcA?=
 =?us-ascii?Q?CACPZn90/4p52Vw9Hgkw70+uYvJwf6dJ29/EcTCyhygdB79EQFWdFt9o3mbZ?=
 =?us-ascii?Q?1Yw35jq0xRi+P774vwuLhhZBvQ=3D?=
X-Microsoft-Antispam-Message-Info: fEruNx01J0DPAQBCKzGlIQZS/1ZH5Y1IcxOnfBc0+JMyhZuEmZoYQ5SzCpXG/LEnWsUsFAXq85RRWcwEauR85JPaTPbY4EdrnbpJTJ5PzLDjKoxmiHqqwAYUpkyfRG24xYVHdBVjSRG5i9YvPDMamhgAm8tKbtpH+AomEmEiKI6QBsb8eXuNMhlX1Kxc9LppSlsUZ1oHXutDe6yjkPfFSbG8AEPh0DImD1elf9sknfeEZheDKac6LL4gtzWSEjtF+aL+0ZcLgQkBRGUFVssLRREXOiMyG/SUCoWGH02Hkq/FmPYx6IdEaaOOAavfNUSkf2XUFefKJcmvLdMRXCTW1MW3qq7ukZVcHoOs8sGcD4I=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:B4kbLYQIMCVHSsKJ2G6ue++mxrWH2cGkt+i+z4IusGNVQmk3gw1Ofk6DoA/AyeV648z9ZIJ3o0676gbyvl18JNDg4Mzk6rf/4heW/uzHmQFa1Ezasdlgxs/XNDswg88T5/r+kC4KWf90JKFX9sIghwGT6+sHLpeg61nwU+FrTVi0e57G5VRUsxa8LdbQCwHfolF3bZX4+HxgX94ISWL58x1ADHB3n68OWFwK/yLtVRvLQXH3nArICvcRILblVtU38NSONrSKpiraJq2LPrRiCm6CxoD+OGxVDxZmrsNV4uOF7h/0WBhyPFWKRf5nLL81KcWDpMElNMwH6aoNfkeDhMyf5stbD8VBgIDmdzzPZFQgToMIQylnoXvv4puvT2StZegku9luBVD/Zymk5CyGo8B15U8UQRbJjUtg8E+O7coU8HCfU2O4YwJjTglbDksKz6qeMm3dweK606E8N2QbwA==;5:7hbiJiOscmF4PUZNBXHqoceb438dfLkMCZCCkdL8wWpvAyirZNnZHpuUZbiv2TbbYfvRSZljd6KUUpYmNcqM7/+nTdecxadMACBCgKFJmc5NXU80qAWkX32noXUQr35zpqwOppAMpUGQ2Dq1Zmv8MnYkyX4qwSwZpyhdETyNGV8=;7:KsuXtg9OV6aJRgNCPtzeexEkIqJq+PHILikfzNLmMHGQb2fNtY5S4WrkYQjYkNRKJyOqwMIPdQH/VAKAVtePTJ4PwwzzS9ejqLt6aQnX8q2B77gN0wWsbGQ2xEH5YP1OalImSlYkMw3XiMzkHrGumVoB43uMM0mqFcaEro3ohHgMoA3kPrH6LnONpbRKVXy8kH1v5YSN9DYyeLFhNfWJKx0F/tzX9Be2aM5XdThYzQcBi6Z1fKOOM4+Kb4s24yvK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 02:21:17.6792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f6503b-318f-4b18-e699-08d5f1d54dc9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65129
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

Hi Huacai,

On Wed, Jul 25, 2018 at 10:08:33AM +0800, Huacai Chen wrote:
> >> > I think it'd be neater if we did this from C in cpu_probe_loongson()
> >> > though. If we add __BUILD_SET_C0(config6) to asm/mipsregs.h and define a
> >> > macro naming the SFB enable bit then both boot CPU & secondary cases
> >> > could be handled by a single line in cpu_probe_loongson(). Something
> >> > like this:
> >> >
> >> >     set_c0_config6(LOONGSON_CONFIG6_SFB_ENABLE);
> >> >
> >> > Unless there's a technical reason this doesn't work I'd prefer it to the
> >> > assembly version (and maybe we could move the LPA & ELPA configuration
> >> > into cpu-probe.c too then remove asm/mach-loongson64/kernel-entry-init.h
> >> > entirely).
> >>
> >> We should enable SFB/ELPA as early as possible, because it is
> >> dangerous if one core is SFB-enabled why another core isn't. ELPA is
> >> similar.
> >
> > Why is it dangerous, and in what circumstances?
> >
> > Based on commit messages & our other discussions about the SFB my
> > understanding is that it sits within a core, between the CPU pipeline &
> > the core's L1 data cache. Why would another core care about it being
> > enabled or disabled? How could the other core even tell?
>
> In practice, SFB cannot be enabled/disabled dynamically. But I don't
> know why because I'm not the CPU designer.

That's not what I'm suggesting though - I'm just suggesting that we move
enabling it from assembly to C.

If you're already enabling it with assembly then it obviously can be
enabled at runtime, I'm just suggesting we move the code that's doing
that somewhere that it can be smaller & more readable.

Thanks,
    Paul
