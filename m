Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02474C04EB8
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAB02081C
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 00:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HHgiznGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAB02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeLEACz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:02:55 -0500
Received: from mail-eopbgr770129.outbound.protection.outlook.com ([40.107.77.129]:20352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbeLEACz (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 4 Dec 2018 19:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKFA6dNujxrevl+u6k77BTvPDcxxu8Hex+4O7UMNON0=;
 b=HHgiznGcw/AlpG47sE7D8IvZ2NoQl6lNMH4imjmgWWvsJbuRxfb3ehujooBxmqV0VjY4iqm3LoQ1x25q6DAoL20qAP3fcpUPXVEz48bel0BaZs4ZV41URpwivPVXjawBcaRQsrSfint0PrMd0K1vmDSSc8wzjF0Rc4ebu15M538=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 00:02:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 00:02:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiong Wang <jiong.wang@netronome.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/7] mips: bpf: implement jitting of BPF_ALU |
 BPF_ARSH | BPF_X
Thread-Topic: [PATCH bpf-next 1/7] mips: bpf: implement jitting of BPF_ALU |
 BPF_ARSH | BPF_X
Thread-Index: AQHUjBO4tsF9IyZ8J0m98MrHRQIqGaVvQ5EA
Date:   Wed, 5 Dec 2018 00:02:51 +0000
Message-ID: <20181205000250.mc6aw6odykynadkg@pburton-laptop>
References: <1543956922-8620-1-git-send-email-jiong.wang@netronome.com>
 <1543956922-8620-2-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1543956922-8620-2-git-send-email-jiong.wang@netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0058.namprd22.prod.outlook.com
 (2603:10b6:300:12a::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:cdN/ceqgESpZ+C2C0A1K1tFaMn8RHVS6eBPS/I2RZbDOckgkv4pX5flfgKB3A3YuCIH2KopqlOKifpjvOp8xto68+Yi385hyKkzw5KB43vvHABq0CrBB8M0Bl3EUa5qD0m1Ovh02NBqzQ0QbQmvGc/clko1uKvZyGpZyjj40QNqmAn0tAJtUhtEtvWaK20qg9f5h/WnlkTa0AZA5beCH7Wa1BnQ0TXzwr7t1hoAoI69a0Bw7dJBDaB0CY7/Fr9ZpjTtGO+4TpiSvMYq+Q8Zpzc/GtNAuMYmRPwOLovVeM5LwGMQldJWNjONJbbNNYAokOpMhTDaDdEHqFb4yshXsoMgGNMMYdf/AAvBdiC2FOCNSVkf4BVsl0Ie8Ji5uZl/mJo7E2demzoBqbmIjMH77e+cXpMp64G2eNZPB1tlLleUxBsNtAEyu8/y6YH7ayfn95YvLfc8FeZyRt1vhCQfLsw==;5:mxDpqTkp8GlQNBfmm7PNB1EyLWZcXxAU3F4jmAfy/J6iBmWliTIbc60ITnFb4RqFWE6vs24TQCQdS5uHBgwtxfIswbt71QoWg+xqT+f883blPRwa9xov3cy1I4lDErGFn5I1g/E+QzPYr2SFNiulZF9JMuqd97kAs8J4FYU9tBI=;7:Y2oVOk6psW5QOudMMsI2MvGDRSQcJGwTfJXQiQo36SDpK2qg0q9Aq1/gmImWm/0coqZDBoFEM82Dt+IcjP3JYTIw9VwIcayN2o9MuwOA8bmBgWDWkcte3RxRxcHAKbv9Uui/zs35GahFU/4igMMXcQ==
x-ms-office365-filtering-correlation-id: d4177fba-3dc4-4ffb-d21e-08d65a44ff8b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB1119D718BA884119B5776096C1A80@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231455)(999002)(944501517)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(396003)(376002)(39840400004)(366004)(199004)(189003)(8936002)(316002)(68736007)(508600001)(58126008)(6916009)(6246003)(26005)(33896004)(99286004)(256004)(53936002)(2906002)(6486002)(25786009)(76176011)(33716001)(9686003)(14454004)(52116002)(229853002)(6436002)(6512007)(39060400002)(66066001)(102836004)(486006)(105586002)(42882007)(71190400001)(71200400001)(44832011)(446003)(476003)(6506007)(3846002)(386003)(5660300001)(97736004)(11346002)(106356001)(6116002)(1076002)(186003)(4326008)(54906003)(81166006)(305945005)(81156014)(8676002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OalX5bvsHOsCebdJaOU8Khb/K1/0Ov5CnheiLWuDa2+8SHw/PJMZfx+6d2868tb2EoJISiUuv/bSYEb4zP+3/t+BsUea/bdj1Z/UDYrxJFEEVaHfrO+4JknS7s7qFuPNvPFiMgDfzFnenOXt1hqMY3YEFmP9eR6X/sMbpaO401moUz8R9D4Uzx0wyeWlhdmAhuEFyjY/PE9tMh8dtVvcPuA/ph5A5OnWomVPjFI8TDYdXySmCTSohYdKgzh9DhnPCwpygU7A7pacTpJi2o7b74ApcgEa/bDoBCOdRSxhuxqervlkLB+WZb4yZfAy/YElkeA0TmYY9+8XiskiJo3HDAAupNcShKNoguz5HPrt+/s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D15226C779CCC478F321AB9092598A2@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4177fba-3dc4-4ffb-d21e-08d65a44ff8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 00:02:51.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Jiong,

On Tue, Dec 04, 2018 at 03:55:16PM -0500, Jiong Wang wrote:
> Jitting of BPF_K is supported already, but not BPF_X. This patch complete
> the support for the latter on both MIPS and microMIPS.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  arch/mips/include/asm/uasm.h      | 1 +
>  arch/mips/include/uapi/asm/inst.h | 1 +
>  arch/mips/mm/uasm-micromips.c     | 1 +
>  arch/mips/mm/uasm-mips.c          | 1 +
>  arch/mips/mm/uasm.c               | 9 +++++----
>  arch/mips/net/ebpf_jit.c          | 4 ++++
>  6 files changed, 13 insertions(+), 4 deletions(-)

I don't seem to have been copied on the rest of the series, but this
patch standalone looks good from a MIPS standpoint. If the series is
going through the net tree (and again, I can't see whether that seems
likely because I don't have the rest of the series) then:

    Acked-by: Paul Burton <paul.burton@mips.com>

If you want me to take this patch through the MIPS tree instead then let
me know.

Thanks,
    Paul
