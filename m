Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:33 +0100 (CET)
Received: from mail-eopbgr770129.outbound.protection.outlook.com ([40.107.77.129]:28260
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993090AbeKMWWVLJR1u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvSz/iARkM9FZt4wwymYwVZewOJ8XMklN0vDbapOfLE=;
 b=Je8Ii/1c1fds/NSlEFy1iptSikJVS+O20FbFvLIyZHbtDFVnTjHfW00fbfP5zVjcafYvaGHGAKZZilur3GH9bU8SU+niLLZhP6x9WWCpvEs8/pWZCDe1W4UqjEBhSNglbwpBq/+y/KH3gs8EUb0zByDPVLogm2j+8wFaImfhsT4=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:20 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Simplify GCC_OFF_SMALL_ASM definition
Thread-Topic: [PATCH] MIPS: Simplify GCC_OFF_SMALL_ASM definition
Thread-Index: AQHUdu5q3GyLMhBWSUW7VMR+ZHZNpqVOUM8A
Date:   Tue, 13 Nov 2018 22:22:19 +0000
Message-ID: <CY4PR2201MB127217D506B0CB4D21A4B91CC1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181107230524.3370-1-paul.burton@mips.com>
In-Reply-To: <20181107230524.3370-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:301:15::25) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:sKS9DcA+SCVi2aWLA4ajASdEjZQi1Y5vBfZIWILXrXXNIc85VhY46QKsILLfKdeQfdS0rldl5x82S+I3ZQoDVltDK3tOInANwpGPX5qjSos3CD4Zpxsw4VpVoWGoWG3hTqw392v2EIwJsbbN+f2O/PJ3hgH1vDNHXEaA2+l3Q4ULT4mzZXbnbZP4/czKB4R+tpoIKpVN4nqdn3O08M8h/dYc9hnXcADv1aHu+tqaiZE85oADg+i2hXy//yYPK/0B1RN6BGo9SQuawdmwbidBwVQoA4IT0vGU163E/cNWT5zCt0Hwyy5naKZlnMChsJpcAaq+H0M/msdOdzfUi92SQ3hMTJb4W3Z6yWbM2FWvS2xrb7m6rsSLmeD9ASJXfHi+LVbC9NEQE56uQXMCKvHqp0QX2BOyyC09y9o6j504kst/pEY8SODKICQYtGdXsrlU4c67pX3Vwr4eBNPKtGBRow==;5:J0AbQoVHaxg3vamZzxheK/2Q8s9DNYfnr6Oikrs0vxqs2w4w3WesdHdgPhi8fIVo/Ar99Il8lxtHebTFWPVx/HnzEbEkH7tVfMZbXJott7qNL5USkTeHCd8SsrJtwcsCrstS6lsh2hMXV05ruFozeaiWI6zEATswRoS2X0SqdTQ=;7:gp4xTf0KlGML6+8+JdJC1EZjv0lPPFYVC1Zqr/w+vv5GQNSrrBTNDSpDiiGFsiB4T+pc91rPexadjXQp4Eyob3AvuZjt5UoxPG6GKgq6wO2xdXnEnVesWO2yval0M1tfDmSkTX9UJrQSrC0Kdk0yrA==
x-ms-office365-filtering-correlation-id: fcb7dc36-592f-4290-0fa7-08d649b679de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB13502AC525D95B63F25AB4C2C1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(14444005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Lf1uIbO4ij0K95kxkbi4Uyjo833/yTrLHNqYomhQnqut6irCMPZWBDzsHlK8qc9QkHq4+lpmpPva7Fgi0/eyGkTwDL2STojmclXHty8Fmet3R4GpM42rZQ7QTPmGMNuNiAsG8g7xPQPKaxqbcXccgRQK+gyVwfJegpYOtlpym+bkVMdjG77DheSBC08JeKNFLYztyFldnqY+f2ksp32G2OQl4ruxzoAdSo1qQ30fLGu/Pmzv5bxQF0YsBhowqgrTLiztZSeTvkWwjOM7kENMbSHDk6WNs56yQti+z0jMSm5twl8THFDY7pd0v39DDh/91lGMfj2gw6pyEcrOa12ZvM5vNI/TxCAyziBxnwRgD9Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb7dc36-592f-4290-0fa7-08d649b679de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:19.8536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67264
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

Hello,

Paul Burton wrote:
> The GCC_OFF_SMALL_ASM macro defines the constraint to use for
> instructions needing "small offsets", typically the LL or SC
> instructions. Historically these had 16 bit offsets, but microMIPS &
> MIPS32/MIPS64r6 onwards reduced the width of the offset field.
> 
> GCC 4.9 & higher supports a ZC constraint which matches the offset
> requirements of the LL & SC instructions. Where supported we can use
> the ZC constraint regardless of ISA, and it will handle the requirements
> of the ISA correctly. As such we require 3 cases:
> 
> - GCC 4.9 & higher can use ZC.
> 
> - GCC older than 4.9 must use the older R constraint, which does not
> take into account microMIPS or MIPSr6.
> 
> - microMIPS builds therefore require GCC 4.9 or higher. MIPSr6 support
> was only introduced in newer compilers anyway so it can be ignored
> here.
> 
> The current code complicates this a little by specifically having MIPSr6
> bypass the GCC version check, and using the R constraint for pre-MIPSr6
> builds even if the compiler supports ZC which would be equivalent.
> 
> Simplify this such that the code straightforwardly implements the 3
> cases outlined above.
> 
> For non-GCC compilers we presume that ZC is safe to use. In practice the
> only non-GCC compiler of interest is clang and it has supported the ZC
> constraint since version 3.7.0. It seems safe enough to presume that
> nobody will expect to built a working kernel using a clang version older
> than that, and if they do then they'll have bigger problems. As such we
> don't check the clang version number & just presume ZC is usable when
> the compiler is not GCC.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
