Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF3C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EA420879
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 19:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Zf8zk5Cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfAJT44 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:56:56 -0500
Received: from mail-eopbgr740132.outbound.protection.outlook.com ([40.107.74.132]:10520
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728498AbfAJT4z (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 10 Jan 2019 14:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nwqZThe2EEHXMohureQNu8gGR1dYAYYsrkQ6LnIzqM=;
 b=Zf8zk5CgXojfq+z+88hdEdypLMN+Dja0nF1btZrwt3zB7zpFbLQkTMQZ5+PwiEABIhxt0wWcEZUT9P8GUE8FDgUL6mbLJBm3/MiMe2zyFjTKzmTKnXC7M8CdRtu+RmcAjzNtud63n5oK/KRb6S/l5PeQn9a1zXOzgzoxjKc7hWI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1454.namprd22.prod.outlook.com (10.174.170.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 19:56:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 19:56:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Oleksij Rempel <linux@rempel-privat.de>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Crispin <john@phrozen.org>,
        "antonynpavlov@gmail.com" <antonynpavlov@gmail.com>
Subject: Re: MIPS: ath79: regressions after dma-mapping changes
Thread-Topic: MIPS: ath79: regressions after dma-mapping changes
Thread-Index: AQHUpRUxbLw1CyC8K0SKb231sq/YSaWo8xUA
Date:   Thu, 10 Jan 2019 19:56:51 +0000
Message-ID: <20190110195650.ped5tqsgkedrnn3d@pburton-laptop>
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
In-Reply-To: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1454;6:ZJp6V0QQ79SHUWlhc0Sm+3vyoKIM/2JqQ/gw3r6zS2JEDAvvknyDUIAIyDTNn20MGgq6xgj5uy/tWAudcEDVxNvOD5eBwPSrR7VCsKpIPqpWXTups2hzwnUa4+8fe77mt8Z/9LY9P6kidSuL2AprI3yMoZtIDKLdCz7Olo+n9B/BfVefzZ1V7FNe6D8/9/Uh9T/nDGWBM28a6B/QHpQ6GRcAFIcFco7/76/av6Wip/YFnTx/kqHDEJbaTzSY80Rxi1ja8UQ8RlN2T2Nqrozuh3rkGVXcMvn516y4I7ZMcioNZ1w30NHvZYfm9BoT9vgL5j2qG/aAu2EMm0/WEFQjqMuMEGXvfzwzQwVQNmHL+mtBR+rL1oqtYqTlO11FIhhnjTEVHryhhmsXclFQEypJ4TMlzEImUJpIPSNvtbrZAtYe9dE9xF6TU5PL6m1Qz5+P5AXSyyT18X7WbF74PjsYVQ==;5:CPfp2ZanSL5Tct/OzQKeRQ7DRruJjdc7m9PCCDNxaKDkxWIXuPVTTX8flfvTPX6kFcBxhiFzcZB5ol0oGVm87yOVWRalGy93Jpq9fpr4k7w4UG5aCvJSmnxt4S2Db55vrUDhSIAxuwdKI7gYcc9Oq84vNUyvYDQJDrNxrs8SrBRZGMdbp1qhkLWg6odDP5UGyqYFpbmPMh6tZDAy1O5NKA==;7:3vTNMArIUDq3DuT/sr2/qAUrMfbBorb/p0qKgeR229nbYttxyXRLRcQFPXHENKZ93P+Y6ivBUIKxepF3UwxCFYFtjoeS8la80/uB7/CvOuEA5vzY4xiFw7DscDPE1azX4hQQ5b33NBzjv9y3kZRvGg==
x-ms-office365-filtering-correlation-id: ded70fdb-1848-4cb2-75a3-08d67735c35a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1454;
x-ms-traffictypediagnostic: MWHPR2201MB1454:
x-microsoft-antispam-prvs: <MWHPR2201MB145484AEB6B2C092954CFD87C1840@MWHPR2201MB1454.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39850400004)(136003)(396003)(376002)(366004)(189003)(53754006)(199004)(476003)(8936002)(8676002)(25786009)(478600001)(305945005)(71200400001)(71190400001)(1076003)(68736007)(7736002)(3846002)(6116002)(39060400002)(2906002)(256004)(6246003)(81166006)(14454004)(81156014)(33716001)(4326008)(66066001)(99286004)(102836004)(52116002)(53936002)(486006)(33896004)(76176011)(446003)(5660300001)(316002)(6506007)(9686003)(6512007)(11346002)(42882007)(97736004)(6916009)(229853002)(106356001)(44832011)(58126008)(105586002)(26005)(6486002)(386003)(186003)(6436002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1454;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: biReqCBqwTJj9xkoEcNvgsJB5UUry0OO1/nhRSmepeI2YraoTvA8WZIkUnTid8xgDibNyVSCOFlgA8XtS7i/CTEBdoxXvNJ3Ye+YIM/ZmvmvnI3j/jbmK1hoU3AMNFTPBx2j4vJXzN2L/oKQBuZrjQFqTBcAISS8g0YXsOrZG1jKYWA6e2tQARsvIyjwFI0BTM2PIa3eKV3J3K6gIsBSk6NXH8wRxtxSH1T1ca0fDSmSP3aIMl2s51Q9Xy8kLNmwtHPxLt6VkNlAtSNh2zdqkcU38n6yAlH+JsajeN05R/0KVB2cqE+z0x0YNN4zibl+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBB7B3094C82284FB2A4439AAD981D11@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded70fdb-1848-4cb2-75a3-08d67735c35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:56:51.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1454
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Oleksij,

On Sat, Jan 05, 2019 at 05:39:06PM +0100, Oleksij Rempel wrote:
> Hi all,
>=20
> I'm working on Atheros ar9331 related patches for upstream. Suddenly
> this architecture is not working with latest mips_4.21 tag. Bisecting is
> pointing to dma-mapping-4.20 merge.
>=20
> The symptoms are following:
> - networking is broken, getting tx timouts from atheros network driver.
> - depending on configuration boot will stall even before UART is enabled
> - after reverting some of dma-mapping patches, network seems to work but
> init will trigger segfault. It is running from nfs-root.

Could you please try with v5.0-rc1 & let us know how that goes?

The mips_4.21 tag was based upon v4.20-rc1 which had a bug in
dma_alloc_coherent. That was fixed for v4.20-rc2 by commit d01501f85249
("MIPS: Fix `dma_alloc_coherent' returning a non-coherent allocation").

In general if you're planning to use the mips-next branch or a tag from
it then I'd suggest always merging it with the latest -rc or the release
of the appropriate kernel version, and possibly also the mips-fixes
branch. Or just use linux-next instead of mips-next.

> First patch where regressions started is this:
> commit dc3c05504d38849f77149cb962caeaedd1efa127
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Aug 24 10:28:18 2018 +0200
>=20
>     dma-mapping: remove dma_deconfigure
>=20
>     This goes through a lot of hooks just to call arch_teardown_dma_ops.
>     Replace it with a direct call instead.
>=20
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Having said that, I'm not sure the dma_alloc_coherent issue we had would
have led to this patch being pinpointed by a bisect, so let's see.

Thanks,
    Paul
