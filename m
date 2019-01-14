Return-Path: <SRS0=henU=PW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA2C43387
	for <linux-mips@archiver.kernel.org>; Mon, 14 Jan 2019 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2755120651
	for <linux-mips@archiver.kernel.org>; Mon, 14 Jan 2019 18:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mhjEz9ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfANSfl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:35:41 -0500
Received: from mail-eopbgr800111.outbound.protection.outlook.com ([40.107.80.111]:52939
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfANSfk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 14 Jan 2019 13:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC/omty69x+V1qptwuPrPZf55FtILUq5YPqvC3Ov4+E=;
 b=mhjEz9ny439mlIq16IeTQuCM3CytVNdnLx902XWuIdwQmbUY4q6l/AZ/VZ6iYeSX5Vsu5uIpqq4PBKPftLf3faO0bBNxOc8CR4snbGYl7wqVs/GscMpAqTCrAgTbuIiHvjFmD+npHDZTyngrGxZpd6h9YiR8T0YivvBhIRQ3eg8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1021.namprd22.prod.outlook.com (10.174.167.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 18:35:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 18:35:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: fix kexec support
Thread-Topic: [PATCH] MIPS: OCTEON: fix kexec support
Thread-Index: AQHUqq5OiLvhuucSTkqk0aSXNRGNo6WvGoOA
Date:   Mon, 14 Jan 2019 18:35:36 +0000
Message-ID: <MWHPR2201MB1277BC8DF06CBCD467D86A3AC1800@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190112193728.6205-1-aurelien@aurel32.net>
In-Reply-To: <20190112193728.6205-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1021;6:cJNmAuk0v83/aHyxa20Rs/HXN1A8Iqz2BIC7OEbYgS+YBEKDPvo4RuW7DbwyVxoLCsUaDCvxY7ybqmSwkX2vWMTZomT91pt938wLq7rJAuwe5bL4bnyIwlJrfEgztEB7DRoGkOeWTq/a05A8p8BA0HSlbAYMSGVWKvPUVAvNUH1IeQt+kISjyx7a/qvmcqN1iI6/tQ53Gn0g+GGwR0Mb7Kw7XY9Pj63kgSPJf4kKIKixcFfTYd4vYwPeYgnbZX1OLtxIB5ZunkK/fxrR6EI1J8OGgg01QV7mRZaKtcaf0ATl4QLYFVLvK4brQZ2d5a9lQmABQKIRRXWQi+HuaJmTwJ+EyMM4hwUVOcojHGZpFaaM7e7FOJ+lIsPjk/m6dGAMPDrh2xRNkPvLxQvkR+zoGm9IHK9xeI6UvRqjIq7r3sKv03sAV/4TXf2YTgJRA4bxD+Yj4Phu8oUVrANYX82CnA==;5:t04M/a0PRgGGuPksHMwwkMQqlreD4BAT9X9qCddgu162a34i1pnIzpP2dnEJCbktC7u5zD1WbCmLMU+yM0ddkMbGIufo4wRbEsi45kRDI97fnyapr0m39StYcrhi8T0TFmsgYxkVaGw9oyDmOtX3rcM1k4M8YyAVI87lyvdSfhgNXALNi6jtFbNvcxqad2kvksB6z431vZyrFf2AsICqHw==;7:UfvnxCWPFcCfSw1nrV0UCDIRagMwO8iFTx9YZ66Y3Hx8krPHe4nb19L0+28CwCwnEiU8pK+pc3G5Pfr9c9ZvhJR2PZWySicEbqqUuMk+o1UZ7yiQUnnxIbmlGdrIC+ePhK+6P4CkxjK8cIKFXRMrrw==
x-ms-office365-filtering-correlation-id: 2743529c-8d6d-470a-c83e-08d67a4f133f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1021;
x-ms-traffictypediagnostic: MWHPR2201MB1021:
x-microsoft-antispam-prvs: <MWHPR2201MB10214197B0FCF304FB13604CC1800@MWHPR2201MB1021.namprd22.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(54906003)(99286004)(256004)(14454004)(316002)(106356001)(55016002)(478600001)(6436002)(2906002)(68736007)(71200400001)(71190400001)(74316002)(5660300001)(105586002)(6916009)(4744005)(229853002)(33656002)(386003)(6506007)(6346003)(446003)(76176011)(9686003)(52116002)(42882007)(44832011)(186003)(53936002)(7696005)(102836004)(6116002)(97736004)(25786009)(4326008)(8936002)(305945005)(8676002)(81156014)(486006)(7736002)(81166006)(476003)(11346002)(6246003)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1021;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aQ3UO+ZAI45m1SYU/YMzviUo2CB8QgCQ9Yy7T71x+K/kjItvj5rfWOYq1vknuMYa6Qz1dhx+dr8/Hr14qhYELgQ6l/RLOnFsPC8y5BN6bpMahFoWe+wjKNhATo3gL0kDzlEHWAY2RkKEBM4ILq4dNgZF7G3nFhdYz35HL/wK8YcmxMZYkdH4HWm1ONemD5/rIkaFpJ8a1g+HYAWs3Kh3/lA2E7TfbFtTeTwRC3KdVXTxCAzE5U5AUvsmgH3FgeAS2l5pDdzReUUa2PG8h8MRxhBltnnoN6CQCfaTgxiKabhW6LKPfrha0sEHI83BW++qvktokmDXGZxCyYk5FYiuLjtIPT2idTL9seVFOznw5xMXnHiT42afgMxD48imP2HOz0vr/Yyw/sOHRoTNYsfqxJyQYiI6v41Aeo7S8McFwaQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2743529c-8d6d-470a-c83e-08d67a4f133f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 18:35:36.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1021
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Aurelien Jarno wrote:
> Commit 62cac480f33f ("MIPS: kexec: Make a framework for both jumping and
> halting on nonboot CPUs") broke the build of the OCTEON platform as
> the relocated_kexec_smp_wait() is now static and not longer exported in
> kexec.h.
>=20
> Replace it by kexec_reboot() like it has been done in other places.
>=20
> Fixes: 62cac480f33f ("MIPS: kexec: Make a framework for both jumping and =
halting on nonboot CPUs")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
