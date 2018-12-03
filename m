Return-Path: <SRS0=6l1E=OM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C361C07E85
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61545206B7
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 21:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cnTtAq+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61545206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLCVqY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:46:24 -0500
Received: from mail-eopbgr800120.outbound.protection.outlook.com ([40.107.80.120]:37968
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeLCVqX (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 3 Dec 2018 16:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnUFssu/GwmiaGC/2HQP1rulwBzacLgcDFpRge1IqrU=;
 b=cnTtAq+aThjjxbZsvsmLyfRH5iZOiDNa2ehbdKYcw6O1etrkvidXMowElX+zCIp0GqHkRTMJk7xNNLscgHUOZBNtxL//lzA+KofllhXpH8O0XMMzVYLP2Xb1XgVM8Jqht7rzvGFf4MbncW7vaR71p71eLySU19DbG4BhJV7RuWU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1408.namprd22.prod.outlook.com (10.172.63.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 21:46:21 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 21:46:21 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Hardcode cpu_has_mips* where target ISA allows
Thread-Topic: [PATCH] MIPS: Hardcode cpu_has_mips* where target ISA allows
Thread-Index: AQHUhboLqFn8o3nj6kWJZ/YNi5uxY6Vtl8uA
Date:   Mon, 3 Dec 2018 21:46:20 +0000
Message-ID: <MWHPR2201MB12774CAB380D26C30587406EC1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181126185829.11551-1-paul.burton@mips.com>
In-Reply-To: <20181126185829.11551-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:104:1::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1408;6:xR+j5bjyF87beqgo8YQ2tN43X5jIsfo9ASxK90FuWyK1DhhNyPUTJoc3oJ6CFsbYhFHd2aJ/1WOm/cWqzjPkNy+stNeG3Xov8wo9oPqIiN4+JuF0BHNl3s+a7s9xFzYXPpIf9qlgvwx7EHNGFK7OWPRjA2sk0wy/Rmi8BP6dculnMit08tSloKf6udIpVFWef3/bYbz2S9qjkdHzzE2+HhcpeL0SDmsEgbxqgJ3YaGGE1Kc5sc1pVLVlTAj2PYkqpohOBaQrQBxDKv1FVA33c8AowzXWs/3kOAW/Z59D7KMNVQbW26E4/+3etA6SF8Mghs0b2Ku3BuSRZJxyD9+tNOXt81ga95M0HFB/a/6jSdCjSe+fF2/Pg0i+Q/KB+84kU29BGSds8LlDabd1S2zAn0GARbDD2P1GJ1gFgdQ/vYqQbihwPsjPr0lA+ezSHJQP9ZCEGK7M4TWZGU+R1dJ2dA==;5:llE9zipbeslmDrbnjudvexzhqof+5fcLYhietASwIDkI1RZdnbGpLfFrFqfakCEU88zJTtvkFUXO0/K2UF+ut7O4r3rC7P7hvTdopLzoOsj+XEh0mXoWoHUS9R55W3ne7lkjKsE/XBGjWv8ZRwadqe1NoZiX77VUbgaQc2vx41g=;7:FwY4xFav5ku+pEmpakgEQkso4TKlSpWZMorgapt4Dn63QyVOEYCHRz+bQNQIwgyntZimU75y1inEehvTMnLd3RqFAwmI1IggtOrx3zfSpanF3WiYAxGMzJA8JuIFZb0NgQ+SMj3XZ0k0MEp4CZJXPA==
x-ms-office365-filtering-correlation-id: 71959a2f-2a0e-4e98-9383-08d65968c329
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1408;
x-ms-traffictypediagnostic: MWHPR2201MB1408:
x-microsoft-antispam-prvs: <MWHPR2201MB14083FF587CACEDDAD92016CC1AE0@MWHPR2201MB1408.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1408;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1408;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(199004)(189003)(5660300001)(102836004)(386003)(4326008)(6436002)(97736004)(8936002)(8676002)(81156014)(106356001)(81166006)(229853002)(105586002)(33656002)(478600001)(68736007)(446003)(25786009)(316002)(14454004)(54906003)(6862004)(71190400001)(9686003)(74316002)(71200400001)(44832011)(52116002)(99286004)(7696005)(76176011)(305945005)(6116002)(3846002)(53936002)(476003)(55016002)(66066001)(26005)(11346002)(6246003)(7736002)(186003)(42882007)(486006)(256004)(6506007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1408;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BTxwnF82mMRBS1JSBiTqqu+eDu4ekql/TWt64okLWxqrt9RTenkpMcTmoLM06rF+udaEj2I0HXxiw5kPVhUfMNEFs4nog10hS9t2jPkqUhSQOn1NMqXO1/hqyXdhGdEQO3hiXPDNwvBSDur7VwudxK4E3VKlj9PSXyfot+Nw/bOT/o700uxaUAWHgC+kaWCK3uASRlxB6vHIV6hOCXe7sEJxics3HFsDB7x3o2VlpjG0762rsZkGlKRDTa4iVh/2udpasZMmsdbG9dMZZ/9YObiUR8Y8N42zPMeitCbaJvkGvc21TA1bhaI6CrGj7c9ORCtG9x6o24LSoPXwZCCB/CY8X2Np8HESuddLyJd5OWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71959a2f-2a0e-4e98-9383-08d65968c329
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 21:46:20.8899
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
> In the same vein as commit 93e01942a6eb ("MIPS: Hardcode cpu_has_* where
> known at compile time due to ISA"), we can use our knowledge of the ISA
> being targeted by the kernel build to make cpu_has_mips* macros
> compile-time constant in some cases. This allows the compiler greater
> opportunity to optimize out code which will never execute.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
