Return-Path: <SRS0=6l1E=OM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23587C04EB9
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 21:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C625F206B7
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 21:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cBQ7Vbe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C625F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLCVpO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:45:14 -0500
Received: from mail-eopbgr810118.outbound.protection.outlook.com ([40.107.81.118]:6469
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeLCVpO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 3 Dec 2018 16:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPrqmW0o43d2TKCWfl7IckQ+h5aRpz4iArfThKDrycQ=;
 b=cBQ7Vbe3hG2Yfpa4pvtl58fC4wM0DNDUJSZ4os3z4JkLQKO2N1g9kd7+S3OhMf6DakZ1GjyJKjxbXYXGUBVDJLD3WB9vRLBkIJUYxPCSTDxIRg7FmraM1a+6MR5EzMRIU6qv4XMQeM1gWB2pQ8ZZyT8chybghs2karL9roIq68M=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1408.namprd22.prod.outlook.com (10.172.63.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 21:45:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 21:45:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: MT: Remove norps command line parameter
Thread-Topic: [PATCH] MIPS: MT: Remove norps command line parameter
Thread-Index: AQHUhbh9xMtQWCky7UyKhL9qbkyd5KVtl3kA
Date:   Mon, 3 Dec 2018 21:45:09 +0000
Message-ID: <MWHPR2201MB1277ED7C2AE05D0F3EB44F37C1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181126184723.9324-1-paul.burton@mips.com>
In-Reply-To: <20181126184723.9324-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1408;6:0PMfvcBeeaZMySSdZSRHVEp5oMUKv1OR7MyKADI9U56bsWG3CWa2xZ3MpMNQcZCFCjdgTfXiPcOQePqExuuieH34DRH32yAMwGScFJ3VkmQNv08Dtd/E21hHBGtwH+d5OSFQPH3Edm2ppkfYnbp4JD9MCESYg6WVvOO5QmtwkSArBze3trvQuUxSBEoBQsQgk4dbT8Oa84cOTinVY6B+uavZJhLw5Tc3vC8+jUTbukLtgdIMdkVneG0H+N3TtMertYAEhIFjkDz1PiQcGpnzZttMn+hSB88skWZ9yHCd1S6mf9Fz0hj9wuRuDhui+Hvt1NGlxZeTzxkiBMAuTTLa3HYTIZqCBoB5GYCbI1sBEBsXIekd8xG9bMjCMl0/CZeyF6j44VarTrSeyPJIExfzTXX86HNm4Y7ZvuR5pZDPKJsp/xHCn7y7rcOwfqfk7S2xz8W/LjKRoC7U+DkdLY4Psw==;5:7anI53fyqn2gIrPvgf3U6E+aHjqj4IS5IFLzeyebnlNzjgtqWWJa95LNMzSj4nbMteNct7CgbaHR89/DhOuYk7kRMVATUKGS4Flm+Nq7wO/s3q29TsVUvfvmuyvmWQTP2Z+KqgJbVt8n613JCAYsUvKHEGFyodqKmoBncf+aLUY=;7:THvqrwBZxjCK8xrSIS53ReCIZ1OnPKkiMfGKFbzNDq73MqWht4NOwxuraope+vbvVcm7TkoogerXis+86dAPnPI3/4nUU0eMPRzkY4ltWDDGBDDobcAxVPjSNzUZ9GPDSfT60mUEi7E0EYybyHZBPw==
x-ms-office365-filtering-correlation-id: d8179978-5b83-4349-0d78-08d65968988e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1408;
x-ms-traffictypediagnostic: MWHPR2201MB1408:
x-microsoft-antispam-prvs: <MWHPR2201MB1408416F67272C7FA8A2697EC1AE0@MWHPR2201MB1408.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1408;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1408;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(346002)(136003)(396003)(376002)(199004)(189003)(305945005)(76176011)(71190400001)(9686003)(6862004)(99286004)(52116002)(7696005)(44832011)(74316002)(71200400001)(486006)(256004)(42882007)(2906002)(6506007)(476003)(55016002)(66066001)(3846002)(6116002)(53936002)(6246003)(7736002)(186003)(11346002)(26005)(229853002)(106356001)(81166006)(81156014)(105586002)(386003)(4326008)(5660300001)(102836004)(8676002)(6436002)(97736004)(8936002)(54906003)(316002)(14454004)(68736007)(33656002)(478600001)(446003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1408;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qYOGUkQ/H+0onTyGtaNrcBPtf63dQgmThsj32CRxrICxqzBKpwADj9dxs2Wuu9yoBDeI5QJ9KAh1w2EuH2YK9hfF72kyUwe4LGLWxRjYfxfxaaQ8LgQ9TXV8/SMvejBlUz0t7csamadaCP2j+AWUG8vlT8M/v5a/LGLH7cbmuP+O1Bpv2At8NqHbl78PyrCgBv871tFkYyIxdHYfjVI60rSl2UiiAijitnfd2ldIStlkSZuDY27Lekf9S2h0BHNrT647PAePzaAFyzKtxfxPmrxBNcb4kguDIga9wJMz7YIbKLgEb3AjFNuA9BAF8Cma4sgzPFl6VDICr+io+xV34bxZ66Z+lmhilt9p2Q6+A58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8179978-5b83-4349-0d78-08d65968988e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 21:45:09.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1408
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> The "norps" kernel command line parameter has apparently been deprecated
> ever since it was added to the kernel back in 2006 - all it does is
> print a message telling the user to use something else.
>=20
> Remove the long dead "norps" parameter.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
