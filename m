Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:54:56 +0200 (CEST)
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:64316
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994615AbeIEQywhWVSu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:54:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbDE+t2A57peVPqZBKGbU4fJFQ8bel3Y1Ger/ty8CVE=;
 b=PqBZau8Ryg3eVYpt6sw6Aldye4jE7aRAz01qa8In09VYPeJ16EosQMEqP7LfyKEId4BVPfUSVInPU9qo2z0v9KzCzcjPS5gMflicznHG2Q5vt7RQ6lBm656jIA8nczPxoluHVcVFh9kuBq6KHuOqYyc+1c/Q27yMw49OCP1VH50=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 5 Sep 2018 16:54:41 +0000
Date:   Wed, 5 Sep 2018 09:54:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V4 01/10] MIPS: Loongson-3: Enable Store Fill Buffer at
 runtime
Message-ID: <20180905165438.cqdr5cq36pbujtjc@pburton-laptop>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
 <1536139990-11665-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536139990-11665-2-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:301:4c::17) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a170962-6dcb-4df2-863f-08d6135045fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:S2IT7Z2tTnTmsdg6lEKvldsHtygQe/zuXBADXE57HMIwXxv8Isiu3Uchmk5fDvYVBpoNJKmJ9E9PhDVJ04jZM1r+/i9K6fK5q2pff9VXS0EsgvpULs4wx+D/BbccAD1Wdwr0QgqY8KiGMbPllRbLluJlbrAVBrZ7tNUmGco0osGWMvJphelz6KuQNA7E6qr4VqkFE3OJNnRaHookPmS0fW+ZcCZ5vsIcbTQq3z2vnqCeh42SP7AEOTHHk1SllUqG;25:u4GmJmJBOhqD4cELIO5YmwRmq5zGmMKRnEmCIAw6M5qdsQNmVzyON4oR0gOwLn0rQPPD4Xb8m0DXLeINCVbk/GgwImniPnycmmvvhQ0kX9Tluow7/8e8FG7jzcWBKlOGvkLvKVwAJRkHh348YMwQQ++ryAMjNNXWPbc45S3j0aKRxpTMEuU2bjsXLeQxfDvQD/RAp6gQcgnvddTD1j48LyNiiT/TE6H5+v74BIp8gINYmqrGygpqMugKynEBoZI9aw/vw77fp1Fa19fNZJ+LYI5Mwu4lKno0xJwJbup1sDrJPp3kEjm54kWeydfu1mXyKSDtkmPpIBbJHayI05tU+g==;31:OS8K2brwYV6y66/cE+WYMqYtwFw749vJVeVwJTJqu2IWrvCr3ULrBFLMWyw8XzbtvIIMYKklbJkMQjoneakKGAzB0/DDRvHZGp6DvoKjenQ2Oa3perLYuUeY2TcwMIwuyoTaQOMrg6waRu6+H3fic2mhb44ea+eAcBrRykMw7JWzZa/7SnHgD+hI4tk3PwIX9iVRBJxA/g31fT1KBn1fASZdYnN0dknBPxV9ODpZrzQ=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:jKWAs1tjOakKLVe/WgCTZd3Jt/L85vG10NdG/uyy4V+ej9elwBxQafE8TAG2ELlo/JyRLpT25W4OlcmG1PgN4oOLcK5rYAE86eFp2QpWvFC455GbsCSbvA5pFCJgB0XMH4WVNxEClvnSh4xMAMRrRJR/PmTC4QubgBYcF/MrCKts6gLmqB+ZLM7DG4u8o3985JvrXZH5nGSPTA+sWS9zPXzjglKKo+jUdUxiM9cJ7Mi9H8DQ1hNJfENwvqoNwSaw;4:k0RR5njrMZKnBTZ95/rlQax9HY7WA6LlPXg1vpZK1DyKyCvbFRyHl6bQSCwILmXMUG8Mg3/99Mr+yopkCa2gI7BvSds4fRvCWgdD/kNn+zqpzhZ/s8sYxeHWH+l9k5XGPOvg2s9mN0NR52xXtKL+y2oc27H/QpGRWNXBqI4jgnq7W3MtH5Sk4bWugwD/mHdk5gDNmmO5gdBPz0nIex7ngNBIGX82b2zd8CifBS7sswEiWwu4MR3cTVqe6ZjswmLlS+qWhqHFrkTMRsjmo1s0EQ==
X-Microsoft-Antispam-PRVS: <DM6PR08MB493821E5415CE7F460BC171DC1020@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(396003)(39840400004)(366004)(346002)(376002)(189003)(199004)(25786009)(6306002)(6116002)(966005)(478600001)(5660300001)(44832011)(23726003)(1076002)(305945005)(53936002)(3846002)(9686003)(106356001)(76506005)(6486002)(105586002)(7736002)(68736007)(42882007)(229853002)(186003)(8676002)(81166006)(81156014)(386003)(446003)(476003)(486006)(11346002)(956004)(16526019)(47776003)(8936002)(6496006)(52116002)(33896004)(97736004)(76176011)(26005)(50466002)(66066001)(316002)(6916009)(2906002)(58126008)(14444005)(54906003)(16586007)(39060400002)(4326008)(6246003)(33716001)(6666003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:pFxC5R7BPurXAxZdexFUZ46ux6auv9q+yG6lLlhQ1?=
 =?us-ascii?Q?gWM2hBbiwDc9dBvTkDz2WMa1BKZoySV3sAaJE2Q59gjxg8HPEOqecbA9hAo0?=
 =?us-ascii?Q?vhat3J8az2QCWu9SKPqv53wbVrOv1WNANAhXg/4mvManJViGB2YKQK2sUBuW?=
 =?us-ascii?Q?JEqwAAi7voD+Eln/jnCCi2DXXW4Qx0w2aukmMNZ2+RW6mKJVHp7aAJqEQn1M?=
 =?us-ascii?Q?O+emNJv3hdIERLVESazBNPjlzsW8zWZVDLf54uyYZF8DVjZ7BVXGeYnzqtOj?=
 =?us-ascii?Q?9xPVU8N0vdvaVeieCHzY2//U4K+G69of29/KSRFR4ao/enDhtlaGTA28WYRn?=
 =?us-ascii?Q?CZzsQKVkHhqQT4yg+JtnKJres7adOkMhBYOjkjwsaxMa7lG0uQ5AXdGGZx8Q?=
 =?us-ascii?Q?roshFJR5+/ZvHBGLEnKRHi2XyKdRdwdgwO4JOVTxSg7KX1f2eXsUAnfDosuJ?=
 =?us-ascii?Q?gEYKGMLuIqFujFOFzACrTJAjThyico7H4mi2b6dxDWa4TCso3lGNtjdi4utM?=
 =?us-ascii?Q?qavySe/JaQ/FznaMc1ZVgHdqMWPgYXvX8C/mho+lPtUyvpb5RnXlfNENtVsF?=
 =?us-ascii?Q?+MCYiUr4nEAyvmXQ++BYGGjjusP3Sk2V3uQkmZ4+tN8zE+s0LtMeRub+kug9?=
 =?us-ascii?Q?fmSZOpvt81GODGwVN6kK4Tn3TB23BvpaB+yNmAQ+ShSVzqj61Dh/WAeraAV2?=
 =?us-ascii?Q?OGccQG5huC7DmS5++b3hdrUlIDG4knNmKLsRsllGhuMxQ9haDHyo34d63w08?=
 =?us-ascii?Q?UCE3LFrJXRE/elx2c3Cg4RyfYI/a3ibOyF1jva06VTRMLsoqi45WjUiM4Dei?=
 =?us-ascii?Q?DkX3quqarlpeUPZtAswJZsMQ1BLMP1fIYKkUKwqZ05qAdX28m1am5BKHr7HI?=
 =?us-ascii?Q?AKW5enxvRrBkdhr8Mjet2aRNgbGPi/b045AU3ArlK9hn6LUSn6m/DDGGxZGD?=
 =?us-ascii?Q?KhZDx9tUiGGZKRHK6az/edWgyy/+hyKB238OJyW6SKfhBdsIKAZjJCjOdzGy?=
 =?us-ascii?Q?8sJ1Ud4SHlHLQFSoqJ1rX9lD/afeLfBYbWUu1UzTuXNfYmYYwtj7nYkfH6Y+?=
 =?us-ascii?Q?bqOLouDX88Zj/oi0CZjQg44NYj7Z9NVaxowBBCsciGFlkNFnvBitH9GhUn+i?=
 =?us-ascii?Q?oeinQKMkHvR/s9qkI5Jceom3nbsmZPD2SaFmW8uAiemsLV9u33yRoJk8YB9x?=
 =?us-ascii?Q?12Lb57zzsZtDajS0aq6jRZZ/N+0cjZOsW46X63SgwW/jyBYn75IVYvuySwHw?=
 =?us-ascii?Q?ifWrm5DMPIMEbImdQy/TKGSUT9yRwWGbszdvAkU6fnvbkxLTx7JeeA8UYatm?=
 =?us-ascii?Q?mYAy8ke2G4JZWDhwtDqmi8R5zlPEPOdcXzYuyL8kAW+LsxguSkOvqUx0eL+O?=
 =?us-ascii?Q?2Id0S2AC7HoC/jj3leY+ygjNG0jm/JRB0D2BR7p7Ythm4A0c2B43pzorghqX?=
 =?us-ascii?Q?Kaebyxp8Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: iE0vxotyE5pvMDFjm+scGo53anSGwYFRZaXlRgVZOMab8HOIvpmQcezweDIOxe98UDCiV4K3vjnHIE5+RDOHQbaLbV72kScKvJspaYtGTkzlpJYFeqG2k8mB5v7re9c9Rp7FP2+PrajYtdKszb9mTPr75dz3KP46Vj+CxGr+BKKY299rnJgqUmBxLmmqsF2SyaFwisjsNKIdfSq0jAugLV71+8jHluu/zIm5nzImElcvxkDoAm+gceSYWJxHzmo5yahSkm06Z4NpN1IN8AqGsuQehS8h2iqgffbhf+R5dLv+OniXAsBcgJI5cl9hIxrHHpzPT0/wclAFo4PADd060TfQdIz0w7NPd7qqtaMT+qE=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:eAtmVfZTgfjx4HKIFviql4LVLPeiM1DRsKmwW8glGJiO4NcJMqLNvctp2YMHfx03uxy7UrqPQ3eBXtjbcQeqaSG0ypRha25bTvc+16AuVZtEYAhzYigJ/PzBH0jr9LrA+qOmKnZi32UC79Wajxgmja2d/hRhxz/xxIknQLLMTQFfZkrZDEdd05T/VDTFwlJgVXfXwpczY8kHOenchFpecYAusvEUtF8Oe2EjupECLx45avKlM+yA5AAkmwmVOWE98O4jwHKoajFXyXl3vHWX40J36UcjzA7r7YpTY0l19pQ7yLzVMg6IRTAV2XMzp221W9RgyUyHWesCIWV/ewFbRRsuWD5p8kJZyi6VOJdfZ6NJ0JZ4biJ9ZQ8fYfCg65dtwkfZCZeR7cwiajkSLQ/8uQ+g4dAL0uH2gO+8aDtCfTrHl+tIlO6HL04F1iOxo5e2mCwMelZfQndZqwPJvI8qVg==;5:Y3eB6Lp8KTXbdfdDr47j7JELLdAT41JTMQxeXdL3P1i59eHzFM57K+JrkXwpkQX+ArCPiCvrdTlTIXo4lcEGSiIayVcW0Va/vcbxDgvhT9PgYNTx+7dNPd7lKeKRMnAlPN2yBWn89HZf31Vj45l52zqugAczT0ZwwjQ5XsLqQo4=;7:Qx/NWaaiIaIyXDQQOm/EM33Qq6gpPcscM7RSU8vAT1Lu05o04u3PTiq6so80XFGWNEJJ6EYG0XFmO15n2FJ0mngxgVfHXZBpAsx0jikMbf29H2NbGH2nRi5bkUApgw2v4LRCfHNt1ge1CIrZhjPFBoBPx1D73wTLryc8De9rZ6NG6TUAq6kCYotFde2A+/VkPEHhsSJD4JzRvNRpxtyS8+OlChmDHIJhIptJHnsj7wQPDeTakY57TqnariMPjpl9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:54:41.0572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a170962-6dcb-4df2-863f-08d6135045fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65990
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

On Wed, Sep 05, 2018 at 05:33:01PM +0800, Huacai Chen wrote:
> New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
> (Store Fill Buffer) which can improve the performance of memory access.
> Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
> the generic kernel has no benefit from SFB (even it is running on a new
> Loongson-3 machine). With this patch, we can enable SFB at runtime by
> detecting the CPU type (the expense is war_io_reorder_wmb() will always
> be a 'sync', which will hurt the performance of old Loongson-3).

This looks unchanged since v3, and I didn't see a response to my email
here:

    https://marc.info/?l=linux-mips&m=153248530725061&w=2

I still haven't seen any explanation for why you can't just do this as a
one-liner in C, the same way we enable tons of other CPU features during
cpu_probe().

I'm not saying I'll never accept the assembly version, but I want an
explanation for why it's necessary first. If that's not something you
can give, at least describe in the commit message what goes wrong when
you try to do it in C as justification for not doing it that way.

Thanks,
    Paul
