Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 23:02:15 +0100 (CET)
Received: from mail-eopbgr720107.outbound.protection.outlook.com ([40.107.72.107]:17691
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990509AbeKTWAfFpCI2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 23:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDpfCkzoIUG3/p0e3fK3bMP+fondJx15Vulq9J29FNs=;
 b=Yws3T7U+CGYdn4b+lEGowXP6SD1FEldCfa4xytr/piTWGuk/HiXAYjz94Z1bWNm9LET1GFQZdUQXBPRR4lUWU50Xm0H6KZ4hWnINTbVDv9Vfc4dJJWLzBlGmbRLOsMxvyHgpADR3OoIH8Kbrc5t8Ur+c7CY8AGmSMTqiytbd5rs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1294.namprd22.prod.outlook.com (10.174.162.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 20 Nov 2018 22:00:32 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 22:00:32 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hassan Naveed <hnaveed@wavecomp.com>,
        Hassan Naveed <hnaveed@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Enable Undefined Behavior Sanitizer UBSAN
Thread-Topic: [PATCH] MIPS: Enable Undefined Behavior Sanitizer UBSAN
Thread-Index: AQHUgGr1yl/0Nqaop0qwOw3uxHV49qVZOBEA
Date:   Tue, 20 Nov 2018 22:00:32 +0000
Message-ID: <MWHPR2201MB1277AFC56E3D87C3B685B566C1D90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181120004937.8211-1-hassan.naveed@mips.com>
In-Reply-To: <20181120004937.8211-1-hassan.naveed@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:102:2::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1294;6:mSv2eEBz0MIMKWpI8bd+TUeqrOzAMkeiui1zLu1emlNt902JdYGbfI+TGaK4KCf8DVP7S8negh3mCU/7ZGcnUwOWdDJcCJat9tZY9XzqnAxiQS82aDp6X8ppWvMI2s/amltrukAGpeguhsqvP2qEZk6+Z+2wpwgbqBxJO+cgAWSsCyt/KxlsbV8C4mcgqUQM1VM+pwLJ6cMkJBLlpooHl+vVxDMrxd+6rWY93ckHyY8deqibIgKx0wvMHE+jK/rMdk/oERUgS55eDEgeWr49ZnVwQk+eJZcyfWpc/mnvUYffwm3iYUOMe1hQKh9OJ1rNU0ltLWZzLRmcObyOVriW7PRqhWrvJYW3pI7co2v0lLB5UZT/F2iiFD5/FQNtf9V3wjMEHgXHVyl+CIW5GuYSAVFm6Zc1UVPIy8wgrj5dWOlJ3MzdsZcMRNsuzhhSuSUUGeCcMRGoTr7ff5csW1CIIg==;5:8Rc+zwFmedmh9MbvEYqF1qso20s0jARoQqjMDcbrUdND9pDUmAbMMi54GUnHAu7Yu89F33As/Ph7GRmCZhaAtf6KnPeYHmMzOG6330ZQOh8Tb0A5u4qLuk9Jp+RWb/zSIjYWUN8YxMhJEY49114HBKvTf+LJZ0SCz5v22BaMmaU=;7:9Eaov+grQt+F55cV4/B89zH+wEc3+FfxIVrzoPOj2Q72Ui3iL00LFvfmDj2L0s7+YwWVd6S/4Q6VnVIvnc4NLvcDBKP5UF2miPLXT+R3juFJxOquVlKt/1tiqD06TJrRESFALX0cSTF2xWeTCaPFsg==
x-ms-office365-filtering-correlation-id: 5c5c49a5-07d3-4ae7-bbd3-08d64f339751
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1294;
x-ms-traffictypediagnostic: MWHPR2201MB1294:
x-microsoft-antispam-prvs: <MWHPR2201MB12944A26D170DE5C05C91FBAC1D90@MWHPR2201MB1294.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1294;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1294;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(366004)(346002)(376002)(199004)(189003)(186003)(102836004)(11346002)(476003)(386003)(6506007)(26005)(44832011)(99286004)(25786009)(446003)(4326008)(8936002)(42882007)(66066001)(81156014)(55016002)(8676002)(256004)(105586002)(81166006)(106356001)(53936002)(6246003)(9686003)(14444005)(68736007)(6436002)(54906003)(5660300001)(7736002)(14454004)(97736004)(74316002)(316002)(478600001)(33656002)(3846002)(2900100001)(6116002)(7696005)(2906002)(52116002)(486006)(76176011)(305945005)(229853002)(71190400001)(110136005)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1294;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GQZexCwuvRb4kiD8JUze4/vDT4YfzNg1Os2hzmF/2HhE1WFWdk+To2FWWz+DvovD56JlnUS+M6hZRcuTb8eMxb8Gq6oFW1A7VpzpYnJ3RytY2Y0WDCl/eeawNd9krPIsSa1H+u4irTn4P7uWDj0OVl820eGsiosrISz4j9JVSycB6WOd8syHsGXCXM85yVMppxtaAkLAmYN/gl0XJDaomFhwGq24kmbkH3k51/x/KRnp0zyuyGXqxR/wZVciHoyNecJ99HH2+tDRqSrOJ3TCga7BUGbUXhWLPNV9as1+MQvUUUmfzdDMI4DEW3aQzUnzGukrBckzQXYRctfmX72zlVhDMppw9GX0R/rYNP2NGR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5c49a5-07d3-4ae7-bbd3-08d64f339751
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 22:00:32.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1294
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67409
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

Hassan Naveed Hassan Naveed wrote:
> From: Hassan Naveed <hnaveed@wavecomp.com>
> 
> Select ARCH_HAS_UBSAN_SANITIZE_ALL in order to allow the user to
> enable CONFIG_UBSAN_SANITIZE_ALL and instrument the entire kernel for
> ubsan checks.
> We exclude the VDSO from this because its build doesn't include the
> __ubsan_handle_*() functions that the kernel proper defines in from
> lib/ubsan.c, and the VDSO would have no sane way to report errors even
> if it had definitions of these functions.
> 
> Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
> Reviewed-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
