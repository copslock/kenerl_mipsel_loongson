Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 03:35:50 +0200 (CEST)
Received: from mail-co1nam04on0717.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe4d::717]:46107
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXBfqp-kuz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 03:35:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyZW08iRLc9BAs8mADL6bz3Jp7buAGdYC4yNiToQepA=;
 b=G98I1MzXLTojK5z9acY/yybjiZD35UbL4fXpkyGjlIwvhdfwA19ms1pTO7DsKkSeLavWEfEShbBw/OWR8Vypy8/1RYJvqKvaEqqzmy9LuIAYuEA1T0KHo526TjXFl+Pwsbef+EXfi6fzQzhjfg7kUSCMFT3jkbOFzz2TKTgJi84=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 01:35:31 +0000
Date:   Mon, 23 Jul 2018 18:35:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V3 01/10] MIPS: Loongson: Add Loongson-3A R3.1 basic
 support
Message-ID: <20180724013528.uza77dfrqpuzkjsw@pburton-laptop>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
 <1524885694-18132-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524885694-18132-2-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0042.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::28) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da9c2ec-5c00-4ee9-9df3-08d5f105bec7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:8x5B9jmy9y39p/j5M2S9b/B9z0LIj1TcsWcKL12dVDzGbCw0h4Z88rgAeCRCIARBuHxWQ0fBRz2wRzERWaK48wHmMd+QIv+nYKp21dcfd7pGuhS7X9ZiVVwb/HnWIs6bAA3YLh6cAiEdS9VKjV1HV63Z1HdvSomi9CEAtUAsuZGpn4MJkxK8uPtc6aKFPjCsuDGWfnpDLbL0124a25FepA3kuFqIeDWkYoxcoBeyS6Q5Mn49AnyYJ+67Wxz8aB/7;25:iHzsnT0xV2a3yR3b+33fB6w3u8vTZHvASRWyZMgr/yJUZB+KflBEPp7JTzgoIgFRbdNsseDPVeSWnXOFuZYqITyLaRJrnwVOis01WJA85o4mo8H23mcVssAUeJMfiWrLfzfVj4G0MZ8a1KnE1JyewDwzcS7c0zDyJLvJ9vOJknah2DcKoRiBBRxSMtwdG+wcOfTQRi1nfzTKqihygqYpPjn2SUeFyykkVsBqKHLMT9+pEUkiR28Nr+dNxHESjm07WPyAE7SLDKN3nlAlLGI665zhZMXqd1DI6+1EPmneVZFi7hn6wnhpojYZlXqVzbgFfgoBhYlHzBfqYKwAsckIew==;31:We/upAQNJ6mHRou7KKGJqbORvDyvahm6SsOcPQEHEqAFIySsU3WnbGY9+HdLfJ/+cdFYNiy/WLuUF1IYra9UCqFTiELFsqhpLvRQnL/SBeMif8O0NKddTGP2ZqKXXmM30LNwRks2v6kXUlfnYF1JbL7mNi/qZAWREcr1QmR9HVTmvQqznbeBS0EhfzBA6SJyc0AJArjJio0+RNRJX2rIsOaAI64tY6ldxcvzYuGqNAQ=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:Y+Pg0LqJuj8S/kF8C0qpeCHmsKd1J7SAGu4mzGsp4N9YMb1yB5E4fhR5abcpDIchd/dtd5UEtthBkErG3v2J4jNJ5XZzyMCzcAHf1Q71sj4xwWxHus7lpXhzeYZBNdECNiYQbaYYaQnVP0EEm6Gx+2nmbYr2+dsx+a06QFfYsiTy/vB9R576AuYbAqVorPCtYXlzjaBK5y7iqSkhnX74HXeGmRizHqhFqJ7OVEECQcLn7YaoIwC1sHWBk9t2XSLt;4:hXcliO3I3nCcesAo/Z4e1PB1cUFzRduNbvKqmy6tLqcCSJ6w3o5zZJG3acBJpATgy+N8JYY2AK+APWHncyDGuXhj34I/W5jAWOGKp5qHYN55qGx8UnNNQM1w3KeS8uZYG731JV5uZPBfvOWnPqvniq1BIO4ng+c0GE4kQP9eyJquseUgz3HalhwenOZdlhxk0QK6R9qw+w71D68fX/P99CrhM6gWkPVRE0z66YO0xMc5pJmedNzrMgLeLQzRtSHsiN3QIwCzutMuZCc5TaZcFQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934E2EFF55AA0FC4DF4C1D1C1550@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(50466002)(386003)(105586002)(2906002)(8936002)(186003)(16526019)(76506005)(5660300001)(106356001)(476003)(305945005)(6666003)(52116002)(68736007)(4326008)(446003)(6916009)(11346002)(7736002)(33896004)(8676002)(26005)(9686003)(42882007)(956004)(478600001)(25786009)(316002)(66066001)(33716001)(58126008)(229853002)(53936002)(54906003)(6246003)(1076002)(3846002)(97736004)(44832011)(16586007)(23726003)(47776003)(6116002)(6486002)(81166006)(76176011)(81156014)(39060400002)(486006)(6496006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:cn+xEQ7NH5WW7cpRuLWXdsGjMr3R2bDCZJDjo03Uf?=
 =?us-ascii?Q?SfeJe6IRY2KxMtDxpNunDtNuVdM/XCFRB5mthU0WNx7GKRCj3LN2HL6UArrs?=
 =?us-ascii?Q?QlskUPbAy2islZhF1PREF2lfBcolK5JaB4J/rusMCC2dhzTaw04B4V7KVKGl?=
 =?us-ascii?Q?DhBbqPM3dBcCt/p4SUYcKXZKoqoAT6zbzlKhHwNiubWU5/zs9cfrRRNZWTvq?=
 =?us-ascii?Q?ffa5pmtlzwThdEKpmjxLfDP7dSPaqISTDcfTY6PmjLrMScSDWsYEVtLS/eUE?=
 =?us-ascii?Q?kWW52KRghJxrrwdeJtY7vAiUVCwtRgvRUY81YUHrT+EHpA8Re+sUYTIBAZIY?=
 =?us-ascii?Q?2pnFiqWNSGGFdViZ2WwIuPBWw71Z2MQ2ufKQaVgMec5sukhlQ6TgwoRJ+aG1?=
 =?us-ascii?Q?GUofcl87j+HOwnI0MHvzGwxC9c3OTqfbW1/oW9I34ZyJMgjQl2NA1pawDLmB?=
 =?us-ascii?Q?uIY838uq9MOd0OfR4UHPI0kGe+uCBnIHMwEE4G4FsfyVG2Zjzc4WzqkBEhlH?=
 =?us-ascii?Q?ItT27NiilnW3eSYypWDPng73PNc2Eqvf2N9Jdi/mj0gmQefo/gyeHPHmafUg?=
 =?us-ascii?Q?iuBKDPhVhNbipQy1AuzZ8lnguwtrcrMwXvhI1kJZqBYN+oqIIJ9qX2HidKcM?=
 =?us-ascii?Q?jWoXIByK4cqWtFVr6FtVBC53jTHEBDs/9wfcrBqMeZ6+8Sng7GFFbRB/QMMS?=
 =?us-ascii?Q?LU2p0wY7yRIaHzZNSv2dkd3zS2xla/PTkwLeFf8CP0Xi7AVVEUlsTs1jB9+w?=
 =?us-ascii?Q?F2Phhc7TAbhpY3MpsY6w2ZueSH8hPV0MnbyVj0N7wiMOUFB57g4L4YkhGswz?=
 =?us-ascii?Q?c8GWMMG+r+oQ2ZglOzg+48fLHq4VBSYsAne+KDaXpZpD2hqXaxEtE0PA4TP4?=
 =?us-ascii?Q?YZ7IN1izsdBbMm5qoLd3Fj+HohRJLCTZ48FFiqsNCU60bByHXK0RX/TYOJI2?=
 =?us-ascii?Q?+NnH7Q9hmL2WTZKIF51Ie6t1yMPKzG4uAt8v4jXhFduKbKu/v7EkSUTbj2LF?=
 =?us-ascii?Q?5hxaGReLpB2ob/8lcAlavOo4qhNbI8dfT7ZZP/A7Ch55GeVnCYcbztocsfoi?=
 =?us-ascii?Q?QJ7siYwb7UqtApX8gXRbk4ldbtvUzS8zK8XRPz/jFCz6jmH7BhQzy5XpNf0C?=
 =?us-ascii?Q?jbbltVmhQBA9/L18uu7cEfs7m/qoouKXfjTBCnk/nU3/BG/Fqs0bt0DUezWp?=
 =?us-ascii?Q?lOfwqENpPZ9RjBE2LMD/oocjl2BKy5kDWasGjN1uWubgmEy2rasyTVtLU3Mo?=
 =?us-ascii?Q?afMVcJaiz1l6irIor4hn0xKwGYKUQFdclxacaiGbTZGpKHFKSnHPP3XyCfOw?=
 =?us-ascii?Q?LxpjcOmK0vsxa6wmwJyvrG1AIS4MNT2PUUwUoF6H3ky?=
X-Microsoft-Antispam-Message-Info: G4vwXkL2/PQUVKDGYRnqwh7dgzil1KSGKDduga8p4rY5woFhirwI3oe+mlVTjoZHvkL49YH/V0nTUN69FkhIc7ool3Jv2B5bRgLd6aF3oLq+ei93xrJlqu9NPQ4kSSY8DwGUQJ7B2udKlg9VZ19eX2BXxsD331/kYGgq2Cnf+wj759c4RijhAxrUMrf8NOfEOLaNfEsgT/v/mOAXZLM4zQjqK5kR43jXckNJUJo8ttcQreQzMxcr6imnpetYKjVAWnrbTZWjWn/XX+a8KQMI2KSV/WvXfxL266nqXeO/S+bFFb1Zw0iP4U1fNzU43N5AF1fk86OPtVS64RDqj9KsZnKV1FNAcxGV7w5pB3c9kyo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:QPMhHR/v3BGyRUMLHEW9SAYOg6yetuzymQxKDlM/cFvvsr0u7sAWuU1ne6FK3qieJdDSlmCekZnsX3gqQ6AbP29wcfHVeVNIQZWdlQmdAqQjG0IbTGIkAz6CDhUky1+8KQ8L0IRGxTQchRxNgV1LNWrtC9hMNdwVumgYuc96SJ4uAiu+ktZrL3rdkzCOPkwLmPODNcS6R4YQpBJGglRy5vjMCTyLfvQT7n13DDsGrlH06b7SmY7SGqNW3spQoPyfmc8YLy0By3oyti8egsOzp3fD/N+pT4lnul8j3AniXNbdROh/SwSXQSz32yLLaXb0la408UEm+dmT8NWJoKhANL8sA9LoSjTc9hlzZ+mCS8iZ6YjkDQhe3ZqzKukshw+qvJGPLA8fVF/XGBrVPppf9ZXiRytQMXGOZMH2zuZynkwnRWYY51OZPjGo4ik0MIAnoleWPcJEGt8rbMd+3hAyag==;5:2nrzWOsfFF/lpVkjKAcFu7K8tnVcisxY5R9ThFgaLftxNs49B0kbZGKS+eNSgsfhZC1Dqz5wgZDtia1OQP3J96p0WYAE7N3Dmvhhjrp2Y/8wILYZvOjaoIyzSIoaNQmaodbNl/Nr41m+qv8elAdyhcqACG/Cpvef6Y7kgDOqCxY=;7:D28UtATt/9z7/YrzzBTvnJVyeJovV06khzhbR2TLMDlBAmkJ0HELVgqdvoYKqgj8qAmJr/nU9vaXaKzqXreB0TgQ9Xda8OvFjKj9roAOH4G9RZsgadfGAVS7YSS3K1oy/gg7hb6MiKfuHRQGFi3mtQbqpvqSLZTny7gGlCG3LB5PO1WdGQmTguNo8sz4tWq3+qTSK5W0k0Va6HeOfbjIGH5YSYXFf5u22k3REbwklOQHEEEFgvIfUtS15mWEco6u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 01:35:31.9270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da9c2ec-5c00-4ee9-9df3-08d5f105bec7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65068
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

On Sat, Apr 28, 2018 at 11:21:25AM +0800, Huacai Chen wrote:
> Loongson-3A R3.1 is the bugfix revision of Loongson-3A R3.
> 
> All Loongson-3 CPU family:
> 
> Code-name         Brand-name       PRId
> Loongson-3A R1    Loongson-3A1000  0x6305
> Loongson-3A R2    Loongson-3A2000  0x6308
> Loongson-3A R3    Loongson-3A3000  0x6309
> Loongson-3A R3.1  Loongson-3A3000  0x630d
> Loongson-3B R1    Loongson-3B1000  0x6306
> Loongson-3B R2    Loongson-3B1500  0x6307
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/cpu.h           | 51 ++++++++++++++++++-----------------
>  arch/mips/kernel/cpu-probe.c          |  3 ++-
>  arch/mips/loongson64/common/env.c     |  3 ++-
>  arch/mips/loongson64/loongson-3/smp.c |  3 ++-
>  drivers/platform/mips/cpu_hwmon.c     |  3 ++-
>  5 files changed, 34 insertions(+), 29 deletions(-)

Applied to mips-next for 4.19.

Thanks,
    Paul
