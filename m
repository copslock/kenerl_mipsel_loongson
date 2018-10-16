Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 18:38:17 +0200 (CEST)
Received: from mail-eopbgr680098.outbound.protection.outlook.com ([40.107.68.98]:22304
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992871AbeJPQiO1VsDN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 18:38:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC2yTso89ycuYsU9Kra1KPveTs7IlcrEHe+Dv1GxvVo=;
 b=Xfr9tvCaenxxCtqHFSCZHropRILVwPonXY6h4Rj4GiWG5ATgkcbLv3pAgqmUc2DFWHKsMjishrqNdNxgSfbQPlnwTdPYtWSXeoF0cUZbsOWqPHFEU0U4WVkJHb+mZ1Uu4yeGUw3SeRQZiWEc2dOmuDbGwQxEsiUWWcw4Xeu47+4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1216.namprd22.prod.outlook.com (10.174.161.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 16 Oct 2018 16:38:03 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 16:38:03 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Langer, Thomas" <thomas.langer@intel.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] MIPS: Cleanup DSP ASE detection
Thread-Topic: [PATCH] MIPS: Cleanup DSP ASE detection
Thread-Index: AQHUZLSNncF1I35ZS0mNMRNssfFMmqUg9iTwgAEdp4A=
Date:   Tue, 16 Oct 2018 16:38:03 +0000
Message-ID: <20181016163801.jktetwm2afdtdpj2@pburton-laptop>
References: <20181015182600.15423-1-paul.burton@mips.com>
 <0DAF21CFE1B20740AE23D6AF6E54843F1F0AE192@IRSMSX101.ger.corp.intel.com>
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1F0AE192@IRSMSX101.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:300:ae::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1216;6:RGa6jd+s7fv4+GzMxm22PVxMdHR1a3uoE26jO2fm1g4EFdiwinDHJgBJV3yOMhXJ54thpSK3E2N42i9y7PEsIefXre4tZifuMa6+lJ77wD1WYNF4agfN+5QGFyFDG9VYDVnf73CcxObY2RJvFLIwtj+k+ObgqivWAKD0vgVRmlGQzIabSEy3UWeS8ho8S1HlE+Dad0QMPFQ3dkiOQIn++0dgK8/FCFydcmVzzUCBU7GAR1He6TOragD1cl/yWL6OtL/8zQ3frc7LlIjF7C/ljWICWxE6qiMSJcfZ5T7ADwYP+ublxeJsRsZ2ZNVRJzbIezj4Y0HCNdTLHnkjykqLhefu5SONC1h9fblTj56qKNp7ckhhHu9t9rOfs2f9Z9DduF4pkang8ZqtDdA0Wr9gYi3Z1w8U8psb7gK994ZsQqc5cZW42taamXGVieZsKOds8ceKOEQngyoZ0Rw3IIPDyw==;5:xn+WdEjsWDf8TRZ/zpqK7yTcu4LhPsx57xapgpeDTNJSFxiYHvkiuwY1FjTYhlkJudjdu/9fNVeOSP7/WrEXKwvKljEdhsPkBm0fh4qbU8Dth2QzayvXW20dZ/f7479XnOr24fH4UPzp/QAun2udIGHdBElF3DDGAl0wsy9tBuU=;7:F1cyBjylvV9rmz6ynzbnNUaKtREmozcVNCtvNFW4pw54XYD5+FRZpUbsyBqLupk3EnLoi/TqmniR5xNIwyxebEcf3VD/+WGbA4q3M/nj8v1iVcyHPn5n4YOSjkrfeTf8w48kF4E5WTyr482Uh6aUsO26JIe8AWnEDGkS71YeyOw1uinZgVfQRoqjt2NlWSUiEoCoen5/zgpLzHlunw0rzK/mZ+iectrjLPSPXaBp1X3wNZWQkJTJEAnkpAHvwbGF
x-ms-office365-filtering-correlation-id: ecd06fbb-5c9b-4382-e6d1-08d63385bd77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(7094020)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1216;
x-ms-traffictypediagnostic: MWHPR2201MB1216:
x-microsoft-antispam-prvs: <MWHPR2201MB1216ECDB57D54BE5AE7FCF29C1FE0@MWHPR2201MB1216.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6042181)(201708071742011)(7699051);SRVR:MWHPR2201MB1216;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1216;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(189003)(199004)(44832011)(476003)(8936002)(486006)(217873002)(71190400001)(25786009)(256004)(71200400001)(66066001)(5660300001)(6916009)(508600001)(2906002)(14454004)(105586002)(54906003)(106356001)(81166006)(81156014)(6506007)(386003)(52116002)(33896004)(7736002)(102836004)(99286004)(446003)(11346002)(6246003)(305945005)(107886003)(4326008)(68736007)(58126008)(186003)(26005)(8676002)(42882007)(229853002)(9686003)(6512007)(6486002)(6436002)(2900100001)(97736004)(53936002)(76176011)(5250100002)(1076002)(3846002)(6116002)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1216;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O42QV+xs7gsJMYC1fiHR85AvAPm9HahlIkKPjbRh0fYceYT2+XF201VTZxSxmDOPQCsWeBAtkXol4HAPH2DfNpadWJfToyVuVRlzoQiMZXquFJQ/oWOiYog8nmFTpvFJzOo2iqQIVCHqw/6nNjrk8LtADglbQyNa1W4Unw/P9C3zp3EETzOrFAD/BJcEaPmw7AszbfePkO8g+qgGRGJ0QEr/rquDwGq262IDP4zgnAneqSnVPUbx7qmnoy/zJYv7crpa3wXz6c91y9ZwOPub/bdcvEbrW06WeCDJ3Qiku5jbp9PbvFSRLft0ZMF6euiQYqK/ICA1tSc1e2+wgqBA4o/xyPbcga7VeuKbOmK/QpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EFB26066FC54946B3B92C2FDFCDD753@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd06fbb-5c9b-4382-e6d1-08d63385bd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 16:38:03.3016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1216
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66874
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

Hi Thomas,

On Mon, Oct 15, 2018 at 11:40:04PM +0000, Langer, Thomas wrote:
> Hi Paul,
> 
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index c28b9bf617d5..a8f8ca8ccf89 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -231,6 +231,8 @@ toolchain-xpa				:= $(call cc-option-
> > yn,$(xpa-cflags-y) -mxpa)
> >  cflags-$(toolchain-xpa)			+= -DTOOLCHAIN_SUPPORTS_XPA
> >  toolchain-crc				:= $(call cc-option-yn,$(mips-cflags)
> > -Wa$(comma)-mcrc)
> >  cflags-$(toolchain-crc)			+= -DTOOLCHAIN_SUPPORTS_CRC
> > +toolchain-dsp				:= $(call cc-option-yn,$(mips-cflags)
> > -Wa$(comma)-mdsp)
> > +cflags-$(toolchain-crc)			+= -DTOOLCHAIN_SUPPORTS_DSP
> 
>                       ^^^
>                       dsp

Indeed... well spotted!

Thanks,
    Paul
