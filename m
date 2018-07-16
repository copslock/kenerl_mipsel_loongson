Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 17:31:57 +0200 (CEST)
Received: from mail-sn1nam01on0135.outbound.protection.outlook.com ([104.47.32.135]:46720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993003AbeGPPbqECcFv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jul 2018 17:31:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smXjcRfRb23pkzJuN6G5XMAgnnknj8N0wwp+U4cLPbI=;
 b=D6lkaJnjOaA/eGq5DIOHRLADb8DpIfkXZODMFseBj1n/TnX3kQm+mlnOWzaf95s9Xv67k8NSqY6F80vr0+jVLKCoigAPg9Cn8eu+DVqZ5wnk7RsXS8oTtrehorr/oMXAsU9unJXR5eorly+tSh40dnAnEBkdgG9Qnb3EQJ9ZAKM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (2601:647:4100:4687:84d1:277a:c6e5:ae34) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 15:31:35 +0000
Date:   Mon, 16 Jul 2018 08:31:30 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] mips: unify prom_putchar() declarations
Message-ID: <20180716153130.yvya5lwipglzwn6w@pburton-laptop>
References: <20180713155156.2747-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713155156.2747-1-alexander.sverdlin@nokia.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
X-ClientProxiedBy: BYAPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::38) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667d0f74-5617-4cae-21c3-08d5eb313761
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:ZHWhxFX8qBCMASllU1VOv1qVCYSDm8hHcYaV4KEM5GAmiz7c0pNJ3NLWOXrMjG2wZDNrkZVmr7Hn8eAFXkWRBt5GaRfBEUd8QMRntLdhsTtgnoum0Z0KX0JuoGWe//UoaocsEW2PkzZbyEy+SuydETpXeWYucALeMAiOWroNCXZr5GEtLeGT08lIJ90kOGTIoi7FKJxyxFIsFv/AHg63E/71+7iGfI50SySKk1kJlZ5LcxVODiZxLbcdKb5VH99uUojpE8wfZZh7jixFx53BSjOWqNCgHf2D9Q37Perbdwk=;25:jBbijoUi3gv8fUb9sgu69rlmplT+VdbeiopuIt6A6GkaYOXFFemF5jw5RYMzj3yYdGjPB3zoeYbH5Pd+MW9wWqonb8ID1GVWlL/0OtBR3ElCrnzJT7tDA5g7QGgAQmFlnEpQi4bdaibR4IsJAUltiIGZ96Lgq+QS/cGX79BA9gNgdo1Y9Twuv/fhKCQeg+wH/TmrR4QUS2wAGWlLukRApOXbKZD2wCHzraJ2d1zwWIsiesRE5z0oP7v3wf/A4oVNgHvyYgwgLFE1edSKlkCAz6DqdmxBTeQt1dDaSWq910pkzvzTrMbFN5MX++G2YM/K92ZCMvcSS8zA/PTEJBvM7A==;31:jSHbJklYBus/BarMzhPqqcpK0uB7WKSnDQvvPTKBHKWhFrCRxwF2yO9WStUWCoC8UTWBedASBU3xrXPjcReO/FksjrQ7kR1+mfkhGwOm8XbN6G1wsI7mu0LXU2gmHTXsTB9utH0BWvMQzzhtqGtE1Tmu27J/eDHeL8DjzJ/xp8HsNKv9vJLCoPdscXoOJKkrb4/YBgA5truPpvTpXIM7/is1Y+gcfo3vVraMxXdTIgU=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:Iefa+9GDJhRTJqvj18P1iheZbx/rKWnWc6i2ZSXyqqYtndfXR3tdwTI1K/x8HxbhBP6qfLhSvldXPOQbFuL+VE+Q9tr7zLsYQ33is4KpDE2X2V4ThgeBWES2Ix6hbR0LfXGnRXZQ/7F2q6NqaAJU9khSwkWFRG6MzHUlyzQKfCjcIN9bow0Otl2RGXukuWz7VTjrGoqWYujWcEqSp9iieDmgxFC3QEdKltK2ZmNyX9f0kW6MMHIh7EYR5DSdYTMp;4:TzTCt+Zstv0QfXXehQ9o3AE40z7YRGZDyaTq6PZlrtLVFXmXIZHhuhx4XL6rAx7Ekh3kfAghr12Izml6Cg/1w4yyj4dBSC9d3iCIvaV8wWVVuuw/tVcsU0/Qq+BrbIAIvoH6pakvH8hMXZTe8YAsz4gyPb6wu6Ut1BQ0TQ/b0XwNAV9hkBQA0FBlZR9YnLNJqNOdMclYonAbkszd1lnMdjFFuJ3qobZxlFvH/xytIjIvCMhywRHPey7fC/P8uJOUFHjm5uZ4qWwqmuozvuWnhyff+EjXUYJ5nxuZLjx9mNe/etuU1pY55tQH2wTab9ynF4tIUb68Etn/xVUdEsrg74REK2L7jy+xpo4wTdBj6ZA=
X-Microsoft-Antispam-PRVS: <BN7PR08MB493065EB3F7AF3BE86DFDFE2C15D0@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(366004)(136003)(39840400004)(346002)(376002)(199004)(189003)(478600001)(6486002)(229853002)(9686003)(50466002)(25786009)(53936002)(11346002)(6916009)(4326008)(6246003)(6666003)(33716001)(2906002)(68736007)(106356001)(105586002)(76506005)(39060400002)(476003)(6116002)(6496006)(52396003)(97736004)(47776003)(486006)(386003)(23726003)(58126008)(16586007)(52116002)(316002)(446003)(16526019)(1076002)(186003)(7736002)(33896004)(8936002)(44832011)(46003)(42882007)(8676002)(76176011)(305945005)(81166006)(5660300001)(54906003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:as7TxUOlUYuE8WJxZiag9nqM69nPb6qOGvtZzPOMn?=
 =?us-ascii?Q?rtayGDThXLQiTu5O3J8hCeP/m8/Mj1j1CZvpJiST6SUOFnzDnusr6+2dEvDc?=
 =?us-ascii?Q?X+TZn39IHEFpesoAKcSXaBK9fcUftdmNkq3WYgGSMCOqjpdiye3jibKEgF6w?=
 =?us-ascii?Q?OneaPfQsKcnVvYwVK0Lj1eXF8BOtyGwEOlwcx1+XBNHEmdPSgh+Yx6x9mkyF?=
 =?us-ascii?Q?w3bevennsyhnZIz+SYVnfDvs9zFyjUh93Lh6j012vEa7nfxoIaBTqGI4nAdk?=
 =?us-ascii?Q?T66oI1HokdqQLOW53zY7KGRZUuA0peSQcDhrN7LSm+P+QbJ7Ua1aaDNyxhDk?=
 =?us-ascii?Q?93JTGjaPlqPa2kgZSqFfaV6ujzGDIdyxn4jexS3WJvM7MM7epyMKl+GF2eLS?=
 =?us-ascii?Q?Zlaaki8EG/OJdin08rzfu6IP6cOu9OiExc8p5dZ/Kh/iptphXpl6E+2cA/Gv?=
 =?us-ascii?Q?5NmJMv7AJCyWz0Lp4bDwdBDdU+NAd7bcXgCWn6q+3B8Yr8My9Hoou7hijAo2?=
 =?us-ascii?Q?636O5QInbLrHFNWiLPjQ65stWowzApDCwOhn0h/W3H2XxCLVGIK8c2SCPZVw?=
 =?us-ascii?Q?oHYJUJbTLmIGXnVwiuPoj3fLU5qR2tCYWXbo0E/qAcEP5Q9aPckdUDbluT7Y?=
 =?us-ascii?Q?CmXe5P+6FiB1kvbFwnZdfyh5ZSJJL5GLmAI3kdmB3/Tf+G6VQyKwqhq68CCt?=
 =?us-ascii?Q?MOgAtBcI+/8BxZv7TzQnoE4K27esxGiIN4st7k7fLd7IqWZEEYEOqcX6fp7N?=
 =?us-ascii?Q?XjaEx1BKKjkdCi7HssKq4u1qg6J1F9me3e1qndHWL2FT/dqMTlSbGk2RYxZr?=
 =?us-ascii?Q?8W5do7w+9yYEtpDVAfrL6PvwMlUGLKCYJyME7e891qdTmh75y8Bui8MwZj8L?=
 =?us-ascii?Q?AdOdshu4YI30oy6dB6peMP8Tye5y9vDsHM+1MPpDTbOKIiXuZx/YNwsdoYJR?=
 =?us-ascii?Q?E/Im8VPqwpZK4AJlvL2LEpy8mFrEVQsc8RKABPt3STUfi6+A1Awp9QGPdFeO?=
 =?us-ascii?Q?n3jUmN5UJtxWYDk46kPMFy19PWE5UbSs+yC8sj011LaQtrNvU9xcdxSHwgnP?=
 =?us-ascii?Q?mMZylVomLht4sQVMhbQo+NF51XQJIy6jxY8ee5YuNAD4l5wrIZAwanjrZQL+?=
 =?us-ascii?Q?W4YfTfBAh8Xj03jHZJkYQp9W/M/6jT2uTBOg70XJpEjUhSTimG3eexOW2NKT?=
 =?us-ascii?Q?fCDW7UnzdiVfl4FkI07FolOqY+azVX+AJs9qgE3YGoadryUk0PuRxz1ZjEfz?=
 =?us-ascii?Q?ADehehZZsRYg66tIPvv/w3Tr8Lvfv56nUV53pbfjRo04Sz3XoVBNDPsSVYwD?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: Fj2oLF1jPi9PRAMJsKDqnBgSkQC2QECAQAAI+eL6HdrX3DqyaaNIRRKSJ9E+KiZQNUWkxLeVE5AzpWOlYszzNmU1sB0LqVz2+3FkyTvPbggZygrPXVugRrDEmI44KSBTCCdiImIo3x646vyEYOcV7RtUyPN4exZa5r6WZMsGFaNw92F6XzePvyBh9m7pKBr7EDNaNVIUeg06s6lzUfDS4ikP5hlJWEavERpT9OUYKM0C0WQxQmOP+/qgKvEEcgtCXZqpMaDBjUALiz0MFjIxgyxn8KZHpCDGReodPfP2ZdeOBwDHB2/X1TT72CQInonIewbrrLuZR9FLj00nHM1giqALTdnvSCZf8bR383cR8SE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:ocKhp45OpW4B7/9vbPyoHIIotyfRam9GI8nvaf+2Y8HiBsCKb3RB+oVI2fYGk5HTWevVd6nskPYo9MLfJ0oUArkVldrUEn1zO5hHxDkrvuzCwJAbS6ByBJ4YvEaK1trqyv3XaiJQcBR/mNSAJQTT1wh/FCE9c76oK5qnoL8nUA9A/L0NUxY+x729JXR/LPHv6l9MHN6TVXKIRwYWlHZyuDZ8BKAqtE/DeKdLbTMa8gqtO+Glwq5kY2bOfk8PePi8tB68kC5Er5emXeT4Yi3Y4FHXt6Rxsxbh9ZzS8j+ap0BXoC0oTucD65hI5HemNHoBruWSdtPU+BAc/6IFJ07iGQcHHxti2tRPjJO3YFu8RGNAGzMrYYj6vIMevhOiAJccDuhkrF1nhS7ZwR1DxBSUqtrzfSlyLFF4+4qcsUPvDG5PWYiG6P7QbM76rCA1QleRBeD3NjE0lxlHNkc8NEzQeg==;5:qv745jcawu/E+KUpHytX6c+MRFqiWET+bmgWKufuiLDoCAN2i6ooMaG0zy2GEg0bSDRLNxbRlKBKALUji9WVyA+mets0ezMb1bX/hRsppeIz446uhVq1BkwylYrYSnFDW+Ag3HCZ2H0eMGAG1DxpBZaiBLJLY9VcNtY6TDOotso=;24:DuKejT8hhNb5Nt/VlBzSbm+wcNcSBdTv6vFn9JLm2P1w00EdVbS0P0FkRAc6U8uOUwbiZkELSZlThNUCsKqmlb6FfSO+V5il7Y0BA5QzzUI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;7:8IWvM4A9JaVLzoK2Tz/jpYTduXVvytyeI1WWHBV8htOntZeFBP6uzKLpmOjPVF3EEWLgMctKDEx1Nl+3rq9rB/3JEJMdriCqBag71p8D1a5S90u+cWbtS9cESc+yxNmiBhXMPssR5Fon3ckr2Pm7zthb2Mah7dfZvMpWv3IkIjk9Y4B0M5/r4tjC1zHYtl01wuP7Phm/QLUpMbRrsz+WNgm1kPMgQEDBy1UaUJFRmSvfWhhSRTBa4E9+3BXRTLUH
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 15:31:35.5955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d0f74-5617-4cae-21c3-08d5eb313761
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64862
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

Hi Alexander,

On Fri, Jul 13, 2018 at 05:51:56PM +0200, Alexander Sverdlin wrote:
> prom_putchar() is used centrally in early printk infrastructure therefore
> at least MIPS should agree on the function return type.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/mips/ar7/prom.c                      | 3 +--
>  arch/mips/boot/compressed/uart-prom.c     | 3 +--
>  arch/mips/cavium-octeon/setup.c           | 3 +--
>  arch/mips/fw/arc/arc_con.c                | 1 +
>  arch/mips/include/asm/setup.h             | 1 +
>  arch/mips/include/asm/sgialib.h           | 1 -
>  arch/mips/include/asm/txx9/generic.h      | 1 -
>  arch/mips/kernel/early_printk.c           | 2 --
>  arch/mips/paravirt/serial.c               | 4 +---
>  arch/mips/pic32/pic32mzda/early_console.c | 4 +---
>  10 files changed, 7 insertions(+), 16 deletions(-)

I was wondering about whether asm/setup.h is the best place for the
declaration of prom_putchar(), and whether asm/prom.h or asm/bootinfo.h
(which declares a couple of other common prom_* functions) might be
better suited, but ultimately I think asm/setup.h is fine given that it
keeps the early printk declarations together. We could probably use some
cleanup of our various headers with not-very-well-defined purpose at
some point though...

Anyway I've applied this to mips-next for 4.19, but with the addition of
including asm/setup.h in all files which use or define prom_putchar()
(and including linux/types.h to make sure we have the definition of bool
which asm/setup.h uses).

Thanks,
    Paul
