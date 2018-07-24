Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 03:36:45 +0200 (CEST)
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:36802
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993964AbeGXBgiPPQOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 03:36:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roOyHHXO7ttg3rvTdm2/GFgmEFMIm2d0F7jEq4MBxU4=;
 b=Gd+0VPS0kg36ISeZuGZM6/vbeP8OK/Rga6M6dFu9erpxTGZLxHt/BkyTJwQv+SQ31Kj9Zm35d/DwhnTHY9MwFaQiRKRN5nsO5c3NX5He3b/N8U7QtNs2z2A2OcMvlZcQW/gZvSYkoLa2dlVdG80/Z8asoPlqfEDpiS1SH1dREe4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 01:36:26 +0000
Date:   Mon, 23 Jul 2018 18:36:24 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V3 02/10] MIPS: Loongson64: Define and use some CP0
 registers
Message-ID: <20180724013624.sb7637ajsjh3a6jd@pburton-laptop>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
 <1524885694-18132-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524885694-18132-3-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:300:103::28) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452197f5-9541-427f-bb6c-08d5f105df9c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:pIyckp1B5cRFMI6aGkRNeJdN17WSiEyI6Vd3TZSMYbBpL9XePihA2v59/itdlF631A2x5GmpLZNza0TSzEyYM/60dmIhkIZz8tws3VE2fdzSNrmjmfbxBYwEu+Z1dpGkm5pnNtJBBFO/w6bpwXMxuVCvzQD3NoWjdyAbdormRHEm1aSGl6eS1H9vypCig7XB1rPbI84igkugQXph1x7yuG+xYZZ1y9kbpniVgmueyVCI+CproeMtKByhluwP/D4n;25:1A22ZHiC79Nk3PxQJnVltmyqorQLYnx+kimRWyq2NYlmPTIGV8YtsNs4FxLTkpjywnr7BD40xBv3tHx8RLK1yEj0n0S8lWialHySvTLWk/iSBo0l+y5nwkq2zCca+0HURPxSnAVgTqMML7+jiUfNxVIJSbiUCgpSDFa0vY8wCJjHOUfzOBmsRVjM4HrRyve4GdAEAdzwlx39x5a7fBdIDdwdzq56lUpLoEHpYAmQMjxm39IolstGalsKVMHV3LR9ZjvoRQTfnl31KXBYD5tCxD1XSFU7ZzOP5myy26ds7NwvZNlPn0I875vvoZCBqbsXrJOOiUb+7GvtbpRKaJNACQ==;31:0gO4+602d89D7P1MyYNcQDbdkRLzpUeobVYGbMWOcHbgSV6OrKBZeKpeWarL6vnqzU4zAv0uf70wsehVf+H+ewcRZrcL5s310K2TAHQco8Ns68SqF0JX0TQVzTMtFToHsUumimDJXZgWGRFcsbgAxAuYF5Z7mU4Ujfdk5dVct+gKchuDj2KMMkAYulakLKmhn05HQa8pkhbd2MNSzXw8WJDp6+MPilfH8pDwVsYdVJ0=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:fg0R/jnCC1w7IxocQ9LbCogESOD4zzu2F2cHwXX8wZaStgm3t+kMIUNbOCa38R39OmF56dYy8i9jsDDS9DmSjAwEN6456V6kqYSgkczGESYnCBkFGBPJapbfmzBArSNNKjOxyrqtsnWV6v4h12olwCPcWEtRX2KjVudKaXNVgYKExs4X4/jmwNmHgm6xRzoD6qdpl3UcYsu255cTKOQKYBh1c8yPeGQ9ooSOhIQTOBBMST3IEeCVHhIG4zmB7yO6;4:xdCtCgL4CNTQnMgHoq5U1LchHdKBZKufFvO2mu4GlD04dno8qniifrSiqgRYw25km5Knhxcfv/zsQk3uS3RWtZggxQ1dOfJgDbr+MFrPYUcBjSTUKcvGau70VmvGfrK6aoiOHkyv8dRjATiFrhPveT0NGrC+hlFxstwgBWKJjQ/jkc+FhaF0b6/FPS6G7mNIHldp+80u7GqTA/nGtTintTEu61C2aYtTlPO56heBh8Yi/tPF1QvEZwugS4BtHp/fO/e1ck8LZEBzsaNJaxdBPQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493592FCAA27DB8EF7D48116C1550@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(346002)(136003)(396003)(376002)(39840400004)(189003)(199004)(47776003)(8936002)(9686003)(3846002)(2906002)(1076002)(478600001)(8676002)(23726003)(39060400002)(6116002)(53936002)(81166006)(25786009)(4326008)(81156014)(97736004)(33716001)(6246003)(7736002)(76506005)(229853002)(6486002)(6496006)(50466002)(58126008)(386003)(305945005)(16526019)(16586007)(54906003)(42882007)(11346002)(446003)(76176011)(186003)(52116002)(316002)(105586002)(26005)(5660300001)(44832011)(476003)(6916009)(66066001)(956004)(33896004)(68736007)(106356001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:hxPNVuBDtI2iVdODuextHJ6r9PJPWVPUAv2Y+gveT?=
 =?us-ascii?Q?QAJN/eWsj1Jo6otK1cu2ACdS6kAsnW2WM1kHNGHvKhPFPLaBGzx+tbkcV2yL?=
 =?us-ascii?Q?WZI1BXB2d4iPl37A6f4viBD6hGkrywutM+kJMF5aix76Ha/phDuAnM9EU5HR?=
 =?us-ascii?Q?0cqV6Jw6i+K/+eBlaFCJwCdaBaot+OPij6oKcUAfXtC26Y4Mdm9bJMfUCDaM?=
 =?us-ascii?Q?kt0fjwYUxsgyE2GuIvbSJFRgCEydQqw9Ra/WwpZNXnTx1iDOC7w0rnm+klVn?=
 =?us-ascii?Q?gpJ/EMaaH+klydwzQTsLUoin6Amb/IP+tEsRZAPmG8m5z/+RFm8gIYX+I/fq?=
 =?us-ascii?Q?6241Jldd5GGKti+7u7NWVWYUcUGWmJGqPF47xb9xJA6S1g/foDMk/vN+9xpB?=
 =?us-ascii?Q?zzs4ApmaitizdN4VKkeZ0sNZTLutksJJlTLpkibBCWbVwGBpX/S0J4DqgtLA?=
 =?us-ascii?Q?2WHxpa4KnOL25a0HEJ4VVrnf56MmNkb9ebKwPAuxVW77veUyNA7O4WIhGiZK?=
 =?us-ascii?Q?H6EslamimZutUl4tobeLF+d9cvRyhr5SDpALhtXcPC8yvhNKoLHW1osfAhkZ?=
 =?us-ascii?Q?1z6sJpSfg8jfGdUh25wWzfNBQPuQl75Dj6w8gZr/EnokE6YJFvc8RWTWSjjM?=
 =?us-ascii?Q?nDO0/4ck/T1Pz2IMgOjfwmBMRBNBCdBt96hsAI2eZFQFK9n50OQ1UtddKUEu?=
 =?us-ascii?Q?9vk37SCxpu1zXqLTPjiIyGJyH/Jehc1kpf6I90vEDvB5dYfSKQJI925jyn4s?=
 =?us-ascii?Q?9CsEaeSoNGccwTTI8vY8fQH9p1Y1M9oPhefhB1CXZw9RJAUNvg14uZpH0xlO?=
 =?us-ascii?Q?c9FYQMyHtAQzW4yjwOLeVj/xtjZ3c1ZDWlibLTiqmK4S5U09ZAT0dKPeVNgy?=
 =?us-ascii?Q?keFfQs1ylnzErIA/CE5nQWgSH1/1Iq+FRXvHQxRRxn5MmWmOmsjnbXDah6BP?=
 =?us-ascii?Q?ZUH6rVrFYosnf/FK9vxyfpGqDSLgnz5IJ4GdeExpzaIPmXR0ATQzzBDNDdao?=
 =?us-ascii?Q?SfVaBxiUA+ac9OYzx8hGj9UrFMqnRms0pzc/fhZaq85NvLn/Og1VD0hBPqsi?=
 =?us-ascii?Q?ZgiuqbhgJl+HWlfV91/kY0i20Lp7/EIQaYllqBeZBv8qtoNFqPDF55HPBtbv?=
 =?us-ascii?Q?oe9rdVOPLUe/P1QqqOlARg7qYQ+HcBdZJQuEUCgGMRTEJ0E9IQCY5V8Z3TTm?=
 =?us-ascii?Q?UQZWHqPwUZKSkdIoVncjWADCC2WDEr1i7ET9hAfpUMCsM75tvbjQroLuqwnD?=
 =?us-ascii?Q?eFsuBsv4ImA9WuHOOCebgEkPwj0orlZkHJnjSgyBUmKdz9XhUh78OvwS6Ooz?=
 =?us-ascii?Q?QXm4cIjrb4ZMi34REMK0Zg=3D?=
X-Microsoft-Antispam-Message-Info: jozNR0XM2uldS4iPoMFlEQuV2nJDTHEPKW3GLzaRR0IXzYH+qcT6ZpRHDAJNPj64D314xIRoy4a3sx2GWoNqXnWqm7KvVuzBz14P6HMR3qWyFit8avE3N1M86ooioziE3ev/zbrMkRk7HYaAVM3X3ey3JBSva73jvWwRb4lgBZte33dBQYi18diCLWCiW5deUHOUBmYrw6MSoBrC2+t9wSi7uR6OapyBueOrKD9JFt1356yK9jlIYB4bBhEYnvB/cz6syerB51ZbYyMshXJ0z3KRcoasxpQkIBKjpgsp7gns7+d5okw6/pDx8tSrVA/GmLCbWjIUyfjpWjAPTr5DTTk/T5DCBtXZIS7fnK6QMsc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:eQTlatpzgYlnbCBTllcPcVVGetYplaBpva8s/SVH8rK+L77rF1v4QWzcL9ZdrG40mJsVztct9DiPKGMXvrVR7LrdBI6IULXzDx+1VR6SizQ72rE4VvM2/KNhw1hs7j2/o7x8tCwek3QIOaSCSnXPFgxOJPAAQJAwUTjXgic+xw8vx+OyM2MCGGibYZlcua1cyTrLeG0aW1O8bTQqoWyn+vGH1WQ7OKsW8KY9HsuU+cUuIxUTouUFoeufqnFws8S33jnopO1g++WfCjLIBcHzkunM9iQt8CwddPZfPlGsdhUZZQSBUcyJ1xvobIpuF+sUOvbdCZwppxP7nV7ZBJ0b7krMPpc5wzsbJiMK5Y8qUuAOz6lu5DhjeEVvgwMtblcWwfYIYquDmpimTJG/5AU/3BSDykTjJqKIFmBw3VUH8l9UAKH3AclpXtYVp1wESzWzQR65qZjrZt63s1+rl8udsA==;5:VFYqPgw762MiSaBkvQsnqcivhWZt6v6m6Y641GB2hbn2/BAdkgVAX7De0dibaZrdNSqH1ScQjBvFYhc915TNvX31EM7IAhRwiB2ObvP354D2gUGgGTZfP5Nd0yhhXyTYNmHb82ydc4Hr50tdb10RVCGgFxmbnOj79Ef793OoagI=;7:2KhP341Q8rMoZzYrPh3ROtJSc32zmFSQ4Gp46mYKdiBRTYbLCFKhhYruaKTsgD70hKXFj40CAuIAUTev7LLDEJ4ZpKUfkyEVaIS+eAE4h/29qyiUI51ypRd0gViOAclTpTmrOTrn40TmrWEGZR5k7KaxhmHtx3P9Dg1B1lHT4CiHarwMyWZzTgnaVaRqutNQxQUWOXgg+pDJ2lZvT78dcjef76J5uivGhJqAVQRpnHCQ0grIbrlrCdiN+ByJDVeW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 01:36:26.9795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452197f5-9541-427f-bb6c-08d5f105df9c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65069
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

On Sat, Apr 28, 2018 at 11:21:26AM +0800, Huacai Chen wrote:
> Defines CP0_CONFIG3, CP0_CONFIG6, CP0_PAGEGRAIN and use them in
> kernel-entry-init.h for Loongson64.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  .../asm/mach-loongson64/kernel-entry-init.h        | 24 +++++++++++-----------
>  arch/mips/include/asm/mipsregs.h                   |  2 ++
>  2 files changed, 14 insertions(+), 12 deletions(-)

Thanks - applied to mips-next for 4.19.

Paul
