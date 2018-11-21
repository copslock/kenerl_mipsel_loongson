Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 19:21:40 +0100 (CET)
Received: from mail-eopbgr760093.outbound.protection.outlook.com ([40.107.76.93]:61168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993845AbeKUSVcfTiq0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 19:21:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY9qTtccGaomCuZpMKobaT4QKpXj/s2Bv3yqs81X9qQ=;
 b=mmi4U+ckWkvmkYi/NM21P1k6z+bhkPVF+wK0bcDGjDcoEX8IeD63w53mgeMVt3M1M26vzH8KC7vVne8p0cKhi+bJJlV+oW7Fyksfukvo8+tuwMjxT1FBr7g33Xu2773g8lrWTE2D3+nxQxh8KDRmZXip85REjHDrS3b45fiQNVc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 18:21:31 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 18:21:31 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: malta: Use img-ascii-lcd driver for LCD display
Thread-Topic: [PATCH] MIPS: malta: Use img-ascii-lcd driver for LCD display
Thread-Index: AQHUgS0jJtHjVT78vkq5jPtctlVABqVai7CA
Date:   Wed, 21 Nov 2018 18:21:30 +0000
Message-ID: <MWHPR2201MB12776EB2EEF77CCFB0AE99C9C1DA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181120235937.32049-1-paul.burton@mips.com>
In-Reply-To: <20181120235937.32049-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:302:1::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:L51V/RIek4+2mInrJ57SlO28gUu9AcqzK30qnjJlchizZFCzyrUu37cBVpxIOTqTNjZ3+xHHGUKzqTfukLqz2rQ0WNtGatBsjs7VfGlXF4godgnJ5a+Fue+Df05/xWjnVQGkrBf8CeP0fFNKeNoDv5eONEIWoAXAqXsmxIlglPg4/ZXm1jxrkOq0uzm1SRucxFf5SSgzKowKih5eyXJHcEZ8TxpbfEe2dLH272IZmCSpl+y4vvHSxH/nrhMuqn1PFXbYX0GF6e5VgLY3cK5Td4jdNl1mr7gxESfU2L1FF8EnTMnWKfGHOi+ROQwmcfSpTjPXcxpQNRmrBDCYpOTv3mWjnJPKt/pp6ijDF9vbphz092LV/cesr0nnVs+9mNxQTkVyesgyEeXvQ3maYh8MhvZgJoxyWQo72IpjEGya9Neu0ojJ9vpYmlnTTliTMX4wnt4Hws4vkh+W48+55qrQjA==;5:ehOaiiPoKOqVrSfljxkQ0MV21j83R4nIDdE4v0aJyg7y6ksZOKCAVViUl4R9ePyehvCzMrFwgKjS+7gFcb+W5TKKIf4al7jdm+IngCIHLRUX12TaS1TiSTSwNkI6xTIrkCT3Le8IFYqq5GQWVKUgv5WX9XhRKf4fCyHD7qpLajs=;7:4t/P+rbXDAwS+sgAqlk3niOi9hP0gPTUUxE2JuWN1XQznSooR6JbHgM13d1VrkMe3uN34CRJ3O57c5hDwEG6zbvujGsGy+Z0fsvCDa5Q35JhjSZ/JxtuRgTXi2JSgmXWPhySooOV3aM0m9dbGpQmyQ==
x-ms-office365-filtering-correlation-id: 3b67f9d6-8948-4bdc-5492-08d64fde28db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB1119365ACC9CE7241B0A93B4C1DA0@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(7696005)(52116002)(76176011)(3846002)(2900100001)(6116002)(25786009)(5660300001)(99286004)(6246003)(9686003)(2906002)(229853002)(53936002)(55016002)(478600001)(33656002)(71190400001)(71200400001)(105586002)(66066001)(386003)(6506007)(42882007)(106356001)(97736004)(476003)(7736002)(102836004)(486006)(4326008)(8936002)(6862004)(26005)(54906003)(44832011)(81166006)(81156014)(316002)(74316002)(8676002)(6436002)(305945005)(446003)(186003)(14454004)(68736007)(256004)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j3//e2cf+gM6yoSccGa5ahYziKu7RrRftx9cuiC3YABohXJOnUMfEkdfDP/pji1EW1t5SCPB4acXYoHHQDptl88Ban0CcGhwhdw58jmQb3HvNICnk2CT7jYEyng7ZS7t7a/P91EQ2EJcCdifDhL37PvX1t4a2agLKS4lPSov7gsj5ZtplNUg87jKyET7I+lW2pPyI6vh4Z45AtiRPpb/MT7dEznInPZOI23TzTJsQs14m3Iav6KVtu3rUuDBXMFeWViL1PzbZR35lMBgHWp7lqUIsSbl4tYyng5y9kI6Z0VsqJJ7mIyuspBBwGdUe3wp4wD1AixWyxDYylyq5BH1FRiwooURfYs9ZHBPPwQWToM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b67f9d6-8948-4bdc-5492-08d64fde28db
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 18:21:31.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67420
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
> Remove the Malta display platform code in favour of probing the
> img-ascii-lcd driver via device tree. This reduces the amount of
> platform code & the img-ascii-lcd driver offers us advantages in terms
> of code sharing with other boards & functionality such as changing the
> displayed message via sysfs. Defconfigs are untouched because the driver
> already defaults y on when CONFIG_MIPS_MALTA=y.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
