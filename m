Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:33:31 +0200 (CEST)
Received: from mail-cys01nam02on0057.outbound.protection.outlook.com ([104.47.37.57]:2401
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994781AbdGSTdY3OcFf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jul 2017 21:33:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0gbzO52NYH34ly4pZk1fsVHQCWYjYGmB+sxELkrTtPA=;
 b=UXpiYxuq09PhhAZRjMuVDuCn81rZG9fXVIB9G7k+iEWvOkfVgQ8ipbb5ckA3bSDoNfoVZbuh1aerLijKfAY/x1/7qtu20gnB6zPO0Y3qrGFbf9+NjEcDbekn76hGdILcaKQ/i9/wotrpQW2NJayGQkfenOgKH9KwbjIH7mVKOTo=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (173.18.42.219) by
 DM2PR0701MB1231.namprd07.prod.outlook.com (2a01:111:e400:5031::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1282.10; Wed, 19
 Jul 2017 19:33:17 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Octeon: cavium_octeon_defconfig: Enable more drivers
Date:   Wed, 19 Jul 2017 14:30:22 -0500
Message-Id: <1500492622-15226-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0074.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::42) To DM2PR0701MB1231.namprd07.prod.outlook.com
 (2a01:111:e400:5031::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e78844-2962-45e2-1c3b-08d4cedd0176
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR0701MB1231;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;3:NCEtrV2SUzQPX6Uzsrs6YlQj+dSTkouYz7zYltugSgvIFrMrmMF+cQAY2GlTwo0u6jDm6BUIWRQnKmAnZGcdiIiVXH+uMRWqgXWq3YK54tYOnftEN/IwQOXRDcz8ztL5yQjjOggZBu+tU8bULOdVJlU3AALBDV/J+Ylmuvp1vToZ6aQYuF549mk2ntQFGb9bvw4jBWxamaZs1NfTV0RaYqx4hF7hvxj2WgVptkAiaoeWjX4LoSz/f0pb6oodDbr9Cml08oPmarztVtFfL2r4Lcjpf2Nnol2j3uC1TQAxlr84e18z6ZoYH98IZRCRnxYWhAqJEYeDcWLYACQivhozx8vGNYupVynJdJvAny9GQnt70k5XACFXnLr1PeSQRjlQfNq2kjZObXOXqXmYzWXA8R6KDNR12qqpicEKZLLIX2jJ8CDnLN/a4fHtR5B5lREDcjN68jF1Fe2/F1ap6URj1V1tRIOvrLjw0LWPGaaAwq/d3+tL9FMC4yhj2mxkBs2iIDnyVEK0SGTH7gtKW11VUnqrBZN6Rqi6isDrxHUD0U9c8639TeWztsIg2v32cn464zcqooNKBDgNL06YatM1i0OCwMLbieWW+zta8f6cXjTiE2cMubojiHx5lBTvw4lHvZDXqQvR/CTYT64wsYmb5FwqBj1mD11GRE4Ix4CNGBZ2RCcm02UcUQLdhjT22wqI1f802iwi5QxNV9PdcXufH3TNOaRELA5zrUuRjQ3xcJQ=
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1231:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;25:SO/lWUAfvREY3VUrLIR73o8WNbyqf6PAryV9dPeLmE+2d7ya9xBlWl0EukZDbgyG10i23rx2EOSlaCj2qFl5z3Sg4cjGl4GBuaD/2Agt6pUpvcdzUs5GMfCOjP+5Uniybk/aL2WjOLl28JsZgozJA6uqYhyrfcCyvOvnXuGdx9ekJR9tdUTqluKAit2Cl7lOTaJjbnqBt/uM4MeBPmGjRWoNWhGmqZlG9rfbLxmTnxLQWgbhjEN8d86EDAm+WteQD8FoFXnUyk0eCKDYYv1lNewIdfsYjNSVlYOaW0ISy35NnOk/DDF4BLtNA9sOG/+7CxX5NHzLhvJ7XibhWEB3WhYso4wMbQxlOeNG16Wla7fV0YTLdCtv6JaKsa2W+mHBK2hdoHPna9wR6pOeJyK9kbwzrawSFO6C3FFbFuwGTZ7GDU3YETmoOcxC4RcXjP4xX+PFP4raLnGF35czCjjyX4VFw3aDeB+AmwHzY+lWPqcXezt/WbuQKLwOnYlXMZIXsQKcTSROil64tmzZR51BuhTswYfR66jG+uPfriDrQwvVSKOsPlGtVINxGfDj9jwYOSIIhwxkDOYVafFm/hNinYAdcDbfzgTfVT4lECmLjDdLpYzgfC62qMLSBEHDRvKU07qpsrSSeDTMqjpaHcR20myl3JvMPCKpbE/u7HgQwTYUgD3yrD3V4MppS2EoPfvyF4ScoZIoGzXH+gE0+sSH9jphDrAoVyBswTXie3U98iWG1a2xEm2p/Q4fv1N55PaXQGV9h0TjUBS/IPCRFf4xWASeXchmrZ02gqX8Olatp0GzY9QHi9ND5GvfeYkSMxv7CKfmmzmh/6aFxpRK8V4iqRZc2gnPrXB62p2LBirKsKPmSM5lHCfDJqlwdoSN0Dmyy1HSiZRlh48WQTOxUS/ZQ8/Lm9Ar3kjIJ0V0DYbGlE8=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;31:aNR/Fz9cdsFZKCWg5Ph/HYiLfAs20hcGIhyWCaftfrtWtEv67+IyA2u/8mVdn8nT1Zs8EEo+2Uxo5X/PSgEOCp9S1QnQ+YWk6DYmuN3XdPdo3TwazXBOtpHJeeLyWvLVH3rIqv+uFNnVv4vWejhaQRtx68JX8VngkNgDlWHPKIOC/q+OgzEdCt4EvarhjtdRqNFR2RLz/DTuMdOzx60IaO4yQTaEVF9qz/R5gBS1GPDHNpRXOY7rnx0ymYcxsF3dRoE69kAmlaNTlqTFegXpEQluiKWNqvASznSU6oCx08IXhk6hHx/iJxHd9hvaVe6oiF6298h2vtIPkcOE59OQFC8hKIgvCnyoLh748N5L+HSwfVd1KQDwe+ORwb1wKM2XrnTY3vKPW4N7QTctMCvf6qd5roXsRUqYUmmd6utAnTHgG29r7I4xZHZRYUSXXmUyJt6cq0t0r3McuIMwgPaa3qYoQaFFjCfDiXwtTsOHngWtDA/+TIbc1I4NeIVEAr/5PpY+bvd2SXoSfK2AlHyu/JK/O65VW8P0MBYSKVleltC6ZjVWduIfUcmUP/W+K99Vrn2yXg4DJ1WK5nH+79WHzaWfXBRuAuzc3K+POPyLfflPclDvzvBKBdcA+ti6fvkcKdaj33itAzzjezX4SGkqXqmOJ+m9PIdJvAvusKkNZNcmPyHPpbWzt35TG643IhJo8nt1J+9Oxj+jHHDUv1YlkQ==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;20:dV/3JZRWIrq/k2i7uWsWT+AEXKlWZR71Y+PVd/7pdOOtAYikC9SKGBjmZ2YFa5vWJOWSryqYo1V8hrhtP5PTPazqPDwJGJ08F4ZNxHeGP9r98jkGs7QT/FeUq+JHKewnQ4v4qTHjStuUg+eTMC8gHaRoWEaVa4JKU+bZrRTayKWJrZtlY9l2SSC52cXIQbWenpogCEy6unZpJ22Z5FCMbNhvDkphcgrZ5aDpgIel8F4L7o35E4Ie9+B1S7Kh4GtOhu9Z5lKJJQDZNo4V6u7FXL+KdQpwIK71hSxMYAIUNP2JkdGDoZPsSn2Whn8sFdl0RFWqVWHmu/SbW8HoFmQvuxBGOOcZb+EJAeDBTP/jWM2yldwOta2d0kWFCtkAc712KbaPneB08KE1qwa1bqoiCo5Yh8tb6pXVLyWNXW8tL4o2NLbesYJmOjqVtDS1x9kRcTXyS6xF1t5VWvAoZiex9vcrbYQOjMopvX0JxS+LT3HnIz1l3ndnAJg3+QS4bjeW
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM2PR0701MB1231A4EAF0A5EBA4F7E0A12180A60@DM2PR0701MB1231.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR0701MB1231;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR0701MB1231;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1231;4:d8vgxo934E0IhoYQBRE+qiBZbLgkPqVK5/2mcwvz?=
 =?us-ascii?Q?4sQ6gOAPk5EJY2JwHitOUA22ZG9LqnTArJWIQ4McMhLMQkJCdb+siubkjlwm?=
 =?us-ascii?Q?9OGpPHag8KxiwuGYAV2tkjgSvbUkZ3Y3ZHwTb4hMO7wjhruAMdZh7QRYAKIB?=
 =?us-ascii?Q?TlAw8KAc1oZFy2I8fSCKj1WUMuX2FRxS9o2UBU4o3dnN4eDQk4U1+Ek7F1FL?=
 =?us-ascii?Q?vCRKgyML/7ygZqupC+/2NV0DgBW5s+v7JdQdwXJB7CVz7pAV3o53KlMyvvaI?=
 =?us-ascii?Q?a4MjACbdzG5oFF6FYA3aTj6Fgb8oC67rVHkK3urPiER7LPHIJg0vgpiCikTv?=
 =?us-ascii?Q?GgjhCRMj3imGfjM14glwgPp16DRIIfSDHlvygZHIg7z2STkSRLL6jl3S5LHg?=
 =?us-ascii?Q?gM6wnjaQpnARQWcM3K8zPl0A3H7CiIEwrNjXPCllANYbYXOJpHvAQ0jzVPTa?=
 =?us-ascii?Q?AEgjUNgE72qjyJLprX/5tV15fnTtEdM5YatCUBxZDgdqAl8ATjEJzvEApSxl?=
 =?us-ascii?Q?lWZuuGJOYlC5/2tAVcZTVjWQJWZJFhlF0jGBonWY5Lr7HHLQQ7WjNTcfq/Gj?=
 =?us-ascii?Q?ZBuc30iypcYXVE6uTKYzchAtCiy8MHCmXRj2xvwkSKahdgyugEv36/pwnl+0?=
 =?us-ascii?Q?fkxRvEqXysX61NdYLOOuPre9f0nAW5HRzFfYLL/U8Lr4GUv2MgY2DDgBA9kd?=
 =?us-ascii?Q?c1FtuyNBb4P8EtJM+wwO8RF2B+9mqwiCk31viQQzra9qfNTCw1Jn5kmxVvm+?=
 =?us-ascii?Q?0jgbI/Q981NRSpMSxzvVFY0skZXK8Lii3dWGEdGRZo1grRGFBupa6LWHx7rW?=
 =?us-ascii?Q?Z3oYPS/UY4bG71K1S/TYI3EVfhwEc+FOzNSdPnXzYfmDel8lYeWmEyJ3LR4j?=
 =?us-ascii?Q?ibYFHs5O8B+jw8T8es0noPae5w+/EXBVnZYnFxPMluVprU712j2Mn7ndXKuB?=
 =?us-ascii?Q?i/0YdKOVVCbyMZgpFE7WBm9AlIbcYEoJ69B60Ksi4Ms3igN1DZgdZKqASgfv?=
 =?us-ascii?Q?Zjgo1dBr0y4ZBIfUwXGFbFZ87PhrOFYR9RV9STmI6+6b6KhZRgPu0o+AcPGI?=
 =?us-ascii?Q?d/RBP+o5WtIqYqTM1hRvC7onfCbK8AzHK4SclIoE0zamt3SN/kz+x26YT9Qa?=
 =?us-ascii?Q?ncj5Qe4FcmaOQqrV5Sh7/05XzRqKTLrr?=
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(39840400002)(39450400003)(39860400002)(39400400002)(39410400002)(39850400002)(50226002)(50466002)(42186005)(25786009)(8676002)(6506006)(450100002)(4326008)(50986999)(53416004)(3846002)(6116002)(7350300001)(189998001)(6666003)(2361001)(81166006)(6916009)(2351001)(6512007)(48376002)(5003940100001)(6486002)(38730400002)(110136004)(305945005)(72206003)(478600001)(33646002)(7736002)(36756003)(86362001)(53936002)(47776003)(66066001)(5660300001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1231;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1231;23:u0zJAbz3wYAk6cODbpkOKf6LM77ojmabDd8cfag?=
 =?us-ascii?Q?6Bw21vsUw6Ucf5Rko05rBLeGLWIdEYYH16T2Ga7EQjykysxTSyNYrdX/mjr4?=
 =?us-ascii?Q?kJJbfOnW2St9NQy9aH5jlxT+foO27Qguq+FKKWLjd2jNx9XuVltssj4Z8mFL?=
 =?us-ascii?Q?YQ5qQbLOZVEBj1GwZJT3ZH4tNdnGUO3NAPrxILgWgmLacsHCtlr7hgT44bZK?=
 =?us-ascii?Q?qG+n4e4tU+uUQXza1Ji0Mkp5fSRinMlEffHgyKFT2AEd1iszEJbCjNbIranS?=
 =?us-ascii?Q?owHvsvXhAsR+dBhawDhxlQg91zqud58yNwEphBvpSaGxNkeya2/jwAOExsQP?=
 =?us-ascii?Q?N9Av+cUQL/dg97/nvLMpXzcg9jZhrFCBNzp822kR/r1UkAm4x/lq6+ll0Vjz?=
 =?us-ascii?Q?svl3xqMkcPiessWWWFRdURVsUbFtwRmM1qdU8zNjnSJfWI9yUP/HaBUW7L3a?=
 =?us-ascii?Q?HB7tYIPXZ99bc6Wsa0AJhLjjBWN2GyPCh1LhFaD4viE4etHGskSYoqmiM9t9?=
 =?us-ascii?Q?iDNr/xS9F9JSMVSW6Pg8rk+8G34ykmIGpZguUqh5RFZ3QDvZXboB1v0+z5ON?=
 =?us-ascii?Q?0GhyoU9x1mbWSSvVkiqQvjrCGXCagRSiUZnH9AY0ErW4Sw+0ls332m12tb1H?=
 =?us-ascii?Q?H3BioNQ3Vl87jmGNMbgqkobjlyatSgyWKbQIJXaJOX5xQPucubh9MnDGpvTj?=
 =?us-ascii?Q?UpRcEK/RHx1clnEvJ/T1gEQgqWfZbkIO35OWVQVjhtV+5CZxWzjjdOQ4lPe4?=
 =?us-ascii?Q?FGNNlEm9QEVPg5N27EQJFs1DzB6gUzzGCmilRvVsfw0sqtqiYMpMstTfuusU?=
 =?us-ascii?Q?vKazAiO2FgROAe3U6yLnMQBWVqkUH2bpknJtBg4RSr55inPbXabRzxmLUOQj?=
 =?us-ascii?Q?QHzLRnq9pSXhwDPJ7lWBk9zM5FSq4pC7HvOXi8XB7QhnNa9eajzcle6PKM6E?=
 =?us-ascii?Q?bW+hHRTBbXTW0Fow+2bBLiRkleuuEAXWJ+kW2KUmVuQ1XCHTbYvaBgAAOyhs?=
 =?us-ascii?Q?l3sbCTnWkp0iMCHs5TL0zkEqQ+9y/mbCvqkDMVVHD1bkPOXrfxh1uMUFEAZf?=
 =?us-ascii?Q?AkxZryDm9KGGDHTP2B0YirTFMwDayg2VxmrZFv+c25dkkwJyqHpOs+Afe9lk?=
 =?us-ascii?Q?BZI8+C/SlBtesCjbPaFbt6HR1DG0DISEJ+ZpcBQ0oWcL9Ej035BSPvw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1231;6:344BnNBbBN5rYhcxzuYJhJ7m1Zq6c4qiL1wygd2/?=
 =?us-ascii?Q?sTGwJTIA3DN1fYLZeS31O5f2KikcJcErVARdDSdVpID/c1gIWkstvtkOuXwc?=
 =?us-ascii?Q?nzXjOQ3jAZPEjSUKk+qB7i3KRnBcX0s3zfgqw4edx1RajcdxEYTi6S4APGpl?=
 =?us-ascii?Q?ErIV0S0Tjl/s1z+9ykfxmLokbXH3iwZxUfqZTlcAv5G9kT/eMrKUWJUrM9ZC?=
 =?us-ascii?Q?azOo3Mtv5Z4BDoedP9BGE1EwoXjXCsljz3cNQqi/6dZrAZdiHlc62QFweN6H?=
 =?us-ascii?Q?fjpaQG9unDblxRkvqBLJv3yr4Cvd3nWoUuDdlE8WpPyQZtyuFCzsalhAg+D5?=
 =?us-ascii?Q?OIUL7oH8DyCZ5MHRgZfZzpIdlVZW1EEREPaf6haPXGA2hy5XQSp82YrYOoje?=
 =?us-ascii?Q?C51fYjH77TeZLDIehOgoD34TcWR/MpeB2aJ7tcdonnwSWvKw7UDfpTvuGZoW?=
 =?us-ascii?Q?uF6AzZFxiEhlinRZEVFo5nWs7GuH4FDFvpByw/3Yfe8/4wrAHp03fKaxWCoH?=
 =?us-ascii?Q?Se/Cci70AKlsVae+1lsBMgNc0SBBszK/uXhTXOdSQj5Tf/eVWgVCRz95Skdt?=
 =?us-ascii?Q?TYrRVxMN1fO6s3XhpzFrmOXloXRJ/RP2oinomnV6paFKAdfU/F11VtvQGD7V?=
 =?us-ascii?Q?j3D9BjSHXl2LQfc9IofT3ZkEKl0Fn6lRzniG7dcpe1/nyPjsxa8K/TM0Tn0G?=
 =?us-ascii?Q?2PPZeli7qGamUYWyC0WRdT4bfMfdYFugHdCtwyGJS87W4NSyVbRrvvgKUb2m?=
 =?us-ascii?Q?4Q9L8gWCT9jLOZ4yv1JztFb/VIss18WWo5EeZe7yIofMXxNdUJGAJjO5Btij?=
 =?us-ascii?Q?ZMK7/NBQmHg1U3Hs9/P0lMakd0wjsE/J6k/5m3vKO8rMJJV1rOt+xK3oWbe5?=
 =?us-ascii?Q?h/LCv3bsaKVO0OhepxOo5pZQwpJKgsszBqQXYLIZUXMAZRclpEhEt3iWMsWK?=
 =?us-ascii?Q?Yk5CXDOFsBYSIImxBHW0xKQHvdwgtga8gl2vdvP44MIgeFbyzaz0TX9heAWb?=
 =?us-ascii?Q?04Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;5:bVndjQeWxc1dg2Jg8QmMRGxRYxMboSX0xD7X//sv9CC30CCgBcQOsopyVG0RlkKr2WWsAkX/Ixkfi5aNEaZcvOuxEfcMyQnGDtD2nx0Y/WGPdJfdpxpbIHjdTffan51GHQElYTDKcI7nE6yWKbCd2Omqeppn+IaxUCVM8EvKkbd5MBz6NVLcuJ5Dx62LI5dbzmMO9Rxjo566Lu8DjQ7jIypTtmk+y6fFblXAHA1Ev5twUJMuukNb1ndwm7fYOaI3/hqA/S9g+uoD/SSujY87yItHXCNcTz10CrlX1JWuydbJfRUg/qiNP1AvM8iA5gLR22vwAr2XmM6MX/aSue+2v309x0EkSDTXmNYLSJnHTbQlbGmyDxnOEbSkpB9JXXzWLIeiLLLFj4J8WCwmyiz61oWLGfBn2XyzWirk0V7e6WaQ/zPf+Pdw/QJ0CDTK9oWvOwkJ6v/ylYdTK4wD653n5ay/lUrGCevF3bKV6OH/4nCSNBbI5ymL0XLOQBvNu05G;24:zrMs6ZlwEp1NQrDGJHmUF7SG27lIGFIomHB/TRScEus088jXzdB68yHffXOWD8B+zrL4tou1DiyXOOf4zfEyUwTb7vxNKQeGIrUxUO6Czm4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;7:eeuoj/zG+GU0Qr88Xn9Jhx3JRHmwBRdfXZdFsXCls/+Z7ZjF81M0eFWfA/qUkM3bcg/TWIHL47X9V7dnKozc5gouzwjb1QhZWHk4AMT8VtQo3hdzAfAg2Ivl47inX9yIaTICSmw/Uuz7H5XBboIf8qG5m6xZwXQ61LBF87y3Xj0aBYzR5euoqN0RVsGWfVMsDh94XhffNi1lPVsDJTMEUG+HFnsYoe6DWfRNO4ijxLcPmmUFSPxZELjHliQlKp0Tm++cqZwQpxAcIe7/+64jOBI6q2itYr6ihB82ZGuvj+Id24lKQ7usgk2X36SFmbU/RqaJFqg1l+bFbSBXo5JiXLn1vqp8epPqpve3Y3+BsEzRu8ivNxLBoVAfIDqJQwer2mRD2QMUnV2Quri1B/60pXttng1U0LBA9w+h1hWnn/ESknV8mXkLf0rf9rFn21UIwTcD2Ehg4hDjkMtpeLMmeixNNxdjNoTM0RDD6wfn1ZWw+xkSl4pykOhepV+sNtqnLPdkuQAY3dDPPDuqwPUOe9rGpwZKTmKvvaJrirocH9Gfs52pi5oNAtzAwcoHJyj/FHD5KPm8hlsGgYulA2qyOPe/NktN5ATRW7j2pZBlCWQ+Lq06GYFX1uXejvUJERt98jj1Ba97icdoTh2oBZxjnRfzyxvxkhKrsbCfcpKlHR+ADBOV79+nLtCu5M+eRwLk8eAXYQHm+ja5C+JBT9ujbUR9FhqW66HTO1t182V1dama9ceLs31OpvemwMrXmDez6ake5/igbMwXEiLdMNdVHOVaJlBVvGXxpW9NMZtwF9k=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2017 19:33:17.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1231
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Compile USB driver statically, enable EDAC driver, and remove
deprecated options.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/configs/cavium_octeon_defconfig | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index e5b18f1..490b12a 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -60,11 +60,8 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-CONFIG_AHCI_OCTEON=y
 CONFIG_PATA_OCTEON_CF=y
-CONFIG_SATA_SIL=y
 CONFIG_NETDEVICES=y
-CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_VENDOR_ADAPTEC is not set
 # CONFIG_NET_VENDOR_ALTEON is not set
@@ -121,22 +118,30 @@ CONFIG_SPI=y
 CONFIG_SPI_OCTEON=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-CONFIG_USB=m
-CONFIG_USB_EHCI_HCD=m
-CONFIG_USB_EHCI_HCD_PLATFORM=m
-CONFIG_USB_OHCI_HCD=m
-CONFIG_USB_OHCI_HCD_PLATFORM=m
+CONFIG_USB=y
+# CONFIG_USB_PCI is not set
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_DWC3=y
 CONFIG_MMC=y
 # CONFIG_PWRSEQ_EMMC is not set
 # CONFIG_PWRSEQ_SIMPLE is not set
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_CAVIUM_OCTEON=y
+CONFIG_EDAC=y
+CONFIG_EDAC_OCTEON_PC=y
+CONFIG_EDAC_OCTEON_L2C=y
+CONFIG_EDAC_OCTEON_LMC=y
+CONFIG_EDAC_OCTEON_PCI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
-CONFIG_OCTEON_USB=m
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_RAS=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.1.4
