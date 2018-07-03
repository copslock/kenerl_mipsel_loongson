Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 03:13:47 +0200 (CEST)
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:43845
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993552AbeGCBNjTzJky (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 03:13:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8t0AGycajR0DZZQA0QxrsX5cRddBVgxnggN8M8K8O4=;
 b=Xg6h3HGJZJNs2b7dAAetHhSbEueBOpgTdttRRNY+aiMnUVQ2ehA7Z2eZCZsDm/uVMK6Ucm5OprY0PyrFQB+ZOc8m6JIQFH1NsoycUaV6tSBhWgPirRqZucWYgC2YJEyj8UOB3QFoU9lidqQns3ohIzQYOouvJms4MVWdqTsHJ7Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.21; Tue, 3 Jul 2018 01:13:27 +0000
Date:   Mon, 2 Jul 2018 18:13:24 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org,
        Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: Re: [PATCH v6] MIPS: Octeon: Remove unused CIU types and macros.
Message-ID: <20180703011324.74oiu7dm43axjmoz@pburton-laptop>
References: <1530558054-5873-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530558054-5873-1-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0016.namprd20.prod.outlook.com
 (2603:10b6:4:16::26) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8997044-2d5b-4f48-1948-08d5e0822eb8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:BK0m5SdSDB9vpuI73FS5E/99B86xYi81W4IMpbZNeEuUM8dCMCeFaOPpyRTkSSnjBlj55OFpPxn3THdJ5iCcF9qlXZIjcUfZTMHGNwlt2uBH2csfZqCe74uoubsvJkknw+u/yLUtS8yvqmMgbF3pQN3Y8nck+0UisXtyuJqlvT9vXzCGSMvX4M8dJA4ASFFJYinx6hc0sdlfNF+If/b7tMxv6fuWzW/Ug/15jAyF/BXdoCaGpEL6l/FsgpoEqI/D;25:PEQSlUIIv+8psZJz4x6eGHPkC/mTpWnmQ+zu0BjDKPg92Pxsy+vmFi4Y5yiQj7mQfsJFWw1PYbnhgVRJcMJKA/Gfv1sfq8ZXe4Cr8IpxtrMskvrvPTB/iJn7YT7l+wdTCAlq2zhHte9qAQW6POspmLD9zonCn4Gbb5I2tlxOWbt+jnAbNNbt2zCvA7kacGrvn9uHYPW4QlQnxzBRaiEHtWhD6mJp3v1y+jWBosTj9O1qRwbkObPQ71G4o243s/aWauizevjoobUDQwwkTXhNbiBsKQlYLDKtfrC7Mk4jQXudFNgH0llZxW4WVHzOiDPa/ChJjV04wdU/FHrJU0IOng==;31:3PTiZ8n5zXfilV8o/gdhDqiw6SeXM7kjaKaWOVQUOnGq0bfqu9Gpc/kPmK2PJF7kTuye4KV8OwzUa82kJXCJ2jkfSqVkKchEnNAVEpWvtBNuzGp7FDo6D+2K3OULk/OXxnZDHbZejE1yijDWWTmKarfcS/Bg0gaIOmb4+C4xAKiVDI2/b0q5bc5kMq4ofyCd1HlodjJ9mcYHS/7+kh/8makcNKk1cMf+HBblng7Q/WE=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:sg3qbfC3ozUo0YTyRODItytXVOABrsFME4P+LWjUcpfDYuJYxtG2iL1NHMHMKxuLioV0VI4c2nxYV14hIYXxSi6KYZx9sE1yTWKdPoP3kle9CEFMMpIOjRlwSQf6DSZnzipNHjrVU9uklovSdCgR3z01JqiXP3a2hQUNIx0iZxYdIjy9OtTJhvOJ/MNaPLAvLddW2xcdPV+benqSbd7lcSERbgA63f6eSbxCbJlSDSC1WNp3LVy7QpEYx5zgX5dz;4:cCDaVL4vqk7DsLwfduYnJrT4PA4HsNwXOlH/eMZuVr7STLzz5FWlRfR2w1xWzbBaucymtGNlfXgOdnQIBsBhnlOMrth6VQDk/JLNfvvRV2eK4qaK5C3zjIVvqbhapHCZOZ/og0xuY1vzNZhDc0ySMncz6m9SV4cva9GcsnU3Vh8zByCa56qEJ2qpjy7kwXB2Aevk/r/oN3onRd6pdnapOph3IXCFbejeXULFi3E8GzxVG2vtOpinTgBbPs21eZ9dMN4n0m1YV8InjqdxSQO3ig==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4931647DCFDEF2AD51E67CD1C1420@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(396003)(376002)(366004)(39840400004)(346002)(189003)(199004)(478600001)(6666003)(6916009)(16586007)(58126008)(25786009)(316002)(76506005)(47776003)(23726003)(50466002)(105586002)(106356001)(66066001)(9686003)(6486002)(33896004)(229853002)(42882007)(4326008)(6496006)(53936002)(81166006)(2906002)(68736007)(26005)(76176011)(5660300001)(6246003)(33716001)(446003)(486006)(11346002)(44832011)(97736004)(956004)(476003)(6116002)(16526019)(305945005)(1076002)(7736002)(3846002)(386003)(8676002)(81156014)(575784001)(52116002)(186003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:BKJT72TQNlzxiE0TV7Op8ZEFW5+BwgUDz+FVSU1nz?=
 =?us-ascii?Q?ADme5qLDsXnlP1WPVa56Fm55N+6SAsHLqXTGypGIICFbkHHGWnVdO0Ra3OLu?=
 =?us-ascii?Q?+fe471sI3BiJkkgGdQgyG00hLpyEZBU6W/8MO3anqOa7AQn7yBEe9WPIuJFT?=
 =?us-ascii?Q?6zSFN7QlrJ7vrFgAxaCbCHVnW8YdCLf7uBF87mZYe5r8PO2mO8Qu0wUdUYyw?=
 =?us-ascii?Q?rgGniA710st6Ei/kAVbiQmD8BpR8WVOPu1vy8vsr6ZhYEH3f1Y8LOcyNTVWm?=
 =?us-ascii?Q?GNQz/9VT/l59UHUH8BQsA8D69tySaE3uWlf1n0XE6jlLJuShX7lActwfhRtL?=
 =?us-ascii?Q?uCUDIgA9o4GjWiXiNTYcpeQz0unakh+PzN9tN3HY+nWOeodlaybJ3zgtApWs?=
 =?us-ascii?Q?UsyT6IA0pwStY9v6fvIRTvkPGniknKTgY6U36A+2bX1doCWTrGnQ2pqXxGAN?=
 =?us-ascii?Q?kYo9Nl56CggcP53C2K9AnTC+KASEMlmwA0RNz3APzz+MiHKpaeEwvL3CeM82?=
 =?us-ascii?Q?Lt/gnugRBCZdpLjglqeSGMuQqc4qTWA02UoNXvA2xYWSL0n+T5nGupYf1ulF?=
 =?us-ascii?Q?3/bCI0ptIp4tmjOAW7s51YIBPYyDFHrBUm2V/gMjAbxLVeDtLkHSxGCLAE5z?=
 =?us-ascii?Q?y8AhhNGKwxfH02EYpV9fT5MsgcW2uBbsqVvSdTycvUPmamIp6BwGJeuo/+zp?=
 =?us-ascii?Q?+mxDaUvVZtyOOxCDumE7tFJeDRcPRzpqUyfxpmHYq5Y0YnS+k9Qg9zVOehsD?=
 =?us-ascii?Q?EQMimeMAPQmQQ8+/8UHcTjNXGzbqvG60TAFtxgh7iNjb3gd2ubGz+DPGWTg/?=
 =?us-ascii?Q?bhrOQGNQMgKx0QOL/yNVcny++52NLrxLj/ovf4Hi1vTJmK0zDiBR+Hlmx0RG?=
 =?us-ascii?Q?7dLG6v9amy/fkTC2gz4FgZBJN87QnA0h0Aq1vYI5o1qbPNpE6pu7WPeXU3QU?=
 =?us-ascii?Q?5EKdbNenXa2qPSVq5/31Y6wJCrOzxQYqIPpjtsN1gw5V2Sz7fnzfmSkvyvBO?=
 =?us-ascii?Q?OjmFrd+abqCk5Dm1KXMNUTN76smkeEsq5cBK5Uh1T/+3Q5rjpsqdV8RMjyu6?=
 =?us-ascii?Q?O4C767RKfnN7myEnUBgGTPxKLIZMrgHqOf1VRJhQeRAVdxoNYozmNBap37ta?=
 =?us-ascii?Q?qy+YOvLokyMrNdjp8XF3A1pZaC458IdgeJ8Jt8suSC4qx/4vSaYNwdBKdGuk?=
 =?us-ascii?Q?IrBYp3vvt0BOqkg13iJcGNoDJNEx6kheVC48c8AnYyppc0mnTHegkdU+Vw6t?=
 =?us-ascii?Q?LWjRK3fDBmFa8uMFVTQmOWLoKx2UvLKc0ffTzbNiVy7H1Z3cOEA1RghumYSz?=
 =?us-ascii?Q?iq+mF6Gooru5JopGouXQpk=3D?=
X-Microsoft-Antispam-Message-Info: WBPO4Kh+5zA3KfdamRRIl4CquXkLBkwRDdDZInBk9mbJRP1TKUFZt/AIzCuFftjDfKJChJtYPNDObNtaUgmbeqWHskZ5AB+0UPMUGMvnvFpDFKm+++Dlw5GLtfdbIZ82Uy+GBrJgPKQsCxc6FBcp3aED/9SNgwix8MeMsMogwHFpzETIpD20/XEnnDl4W7MvGeqEBm0TEJkUhDuAjc0a3t7s73yMdJizQE0xg8wFh/gKWhSotgAfl7JfpAUhB+ulBsYZvtO5KyroIck1T7p+ObxByHwChMmg//u3hFGMTvH9zX0p/64rBJclv8jzoY4WVI3mLVLsKTru7Q3C1nJ8QZK1CLhHy/x2Bn8LJ1R3LJ8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:gVAOpFISRwzgovsm6k2L58KmvDGV1Q85WTumamttKFuArgmzDgFS2zca43lHkOZWh4mup+2/BrbvGL/AIvMeSXD0BlPXOi8g2vc2RkgnUS75lFGgAUoGfCmDMe+8Oid4vGjZX764X4Y24Jey6o991766S5nZK1Rb+dRrqdwgTjlhK9nyXg2sJj35lZEPv/I3wc1wHJIsWvvJxHOe+SAaTOPR7rhoRjDfMl2kSxJrr6IWBkyIWWdeZeEiLY0W3hwr+Tk2jqm8+oM958jhD+L5TtTFJz+3MUSWLIUsvtcWVnXwYWDuJwTOOESMkVI9IF/lnRuRsy4GYJo00duW+pJvzfQ9PVTnAY3I7Zef3rdlE4qSQGQQYPhEBjg9/ilamn3zIThfLu6eYh91pRQy0lpTVZMUGS5RWELE72+3jAuveb3drP5kNAt3R0oM2SvYsvVy70TEW6J5wP8V9E9SMn6AwQ==;5:aHdpw4ZpY8CfFVgwR6wQ0xkUnxn1/FJ1Vfx4AXSqkjKp4AZfSawKbSZerTqOsCIThYhS4yXRHUhZWypFclTdd33fuS5/i718xoMy294FEcvl0mDNBXjfzjPqwpeDUMuG63Dz9iKF7HXUIcmWfmr/hg8oPnCSo5s5JGbdMY45wcY=;24:SdVNoLcTYb1l41biQpEOKCbplmt7p3NHZ6Z171QxDFz6ZqDtR8yM8ALV0gs8YNie1NjOJXWQhH2szPBR9FdP/3ro93Ah9SxLjnbIvA+N0/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;7:DzUhDhZD4KMNXxWA7sCOt6j5l1Na78G+hJ2sjd108nprlNYbw4okf/TWnSa5pq/cT6F/z6aza78OKRI0g0lUjV65/dbrfpyGmTEQAtQ6iiZSAFSYivPr/pEb+Ys3JxO0p0SVy7zo5PcarKYo5UvVIkw/X7gyttL6X+GIxGQa0W1UPd9t4c6wI2u7H/EwG2l9Gnmgui7Ft3suE7cnQRgiNe4QUJN95oB5XC/urMsLa6GFecl/SbaHJsZHvI8JR6oO
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 01:13:27.4793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8997044-2d5b-4f48-1948-08d5e0822eb8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64556
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

Hi Steven,

On Mon, Jul 02, 2018 at 02:00:54PM -0500, Steven J. Hill wrote:
> Remove all unused data types and macros. Define a new macro that
> neatens up the file. Convert the remaining structures to use
> __BITFIELD_FIELD. Use common QLM structure in PCIe code related
> to this clean-up.

Thanks - this is looking better, I've just a few comments/questions
below.

> -#define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
> -#define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
> -#define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)

Offsets here are masked to 4 bits, but after this patch they're only
masked to 16 bits - is that correct?

> -#define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
> -#define CVMX_CIU_INTX_EN0_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002200ull) + ((offset) & 63) * 16)
> -#define CVMX_CIU_INTX_EN0_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006200ull) + ((offset) & 63) * 16)
> -#define CVMX_CIU_INTX_EN1(offset) (CVMX_ADD_IO_SEG(0x0001070000000208ull) + ((offset) & 63) * 16)
> -#define CVMX_CIU_INTX_EN1_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002208ull) + ((offset) & 63) * 16)
> -#define CVMX_CIU_INTX_EN1_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006208ull) + ((offset) & 63) * 16)
> -#define CVMX_CIU_INTX_SUM0(offset) (CVMX_ADD_IO_SEG(0x0001070000000000ull) + ((offset) & 63) * 8)

Similarly these ones are all masked to 6 bits, but after your patch
they're only masked to 18 bits.

> +#define CVMX_CIU_SUM2_PPX_IP4(c)	CVMX_CIU_ADDR(0x8c00, c, 0x0ffff, 8)

And this one changes from being masked to 4 bits, to being masked to 16
bits.

> +static inline uint64_t CVMX_CIU_PP_POKEX(unsigned int coreid)
>  {
>  	switch (cvmx_get_octeon_family()) {
> -	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
>  	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
> +		return CVMX_CIU_ADDR(0x100100200, coreid, 0xffff, 8);
>  	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
>  	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
>  	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
> +		return (CVMX_CIU_ADDR(0x000030000, coreid, 0xffff, 8) -
> +			0x60000000000ull);

The brackets around the expression are redundant here.

> +static inline uint64_t CVMX_CIU_WDOGX(unsigned int coreid)
>  {
>  	switch (cvmx_get_octeon_family()) {
> -	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
> -	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
> -	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
> -	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
> -	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
> -	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
> -	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
>  	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
> +		return CVMX_CIU_ADDR(0x100100000, coreid, 0xffff, 8);
>  	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
>  	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
>  	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
> +		return (CVMX_CIU_ADDR(0x000020000, coreid, 0xffff, 8) -
> +			0x0000060000000000ull);

Same here - redundant brackets.

Apart from those the content looks OK to me now - my only other niggle
is that there's so much of it! 10k lines is a long patch. Perhaps you
could split this into a few separate patches? For example:

  1) Remove all the totally unused structs & macros. This would still be
     long but as it's all deletions review is fairly straightforward.

  2) Unify cvmx_ciu_qlm1 & cvmx_ciu_qlm0 into cvmx_ciu_qlm.

  3) Convert the remaining structs to use __BITFIELD_FIELD.

  4) Clean up the switch statements.

Thanks,
    Paul
