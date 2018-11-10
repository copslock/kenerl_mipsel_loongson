Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 01:12:10 +0100 (CET)
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:52196
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992066AbeKJALbe0kC8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Nov 2018 01:11:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut4Fnv26HgOB4KHhjEx6qaC1fluaa8I6ZG5YA26jgvQ=;
 b=pMtJI01dQTqgvlv69f3AN6kdFi2wMOD36VfmBEp7KUFtUx6cMG6k4Xq1oupXdal3jVeOg+4+b+Z3+X18zu7SEQQHkzRc5z/0uaAZZtboUPAm9FGzvw2kBrzPqDfnX7YJgZFqMUdCpnOjbbG4qrpoDoarpij10dzXcjJ1ObgbmlQ=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1744.namprd22.prod.outlook.com (10.164.206.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Sat, 10 Nov 2018 00:11:28 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 00:11:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>
Subject: Re: [GIT PULL] MIPS fixes for v4.20-rc2
Thread-Topic: [GIT PULL] MIPS fixes for v4.20-rc2
Thread-Index: AQHUeF0lzsjGqcI/jkmahkpPrQm9fqVIBVIAgAAdyYA=
Date:   Sat, 10 Nov 2018 00:11:27 +0000
Message-ID: <20181110001125.3wbk7c42cpqq4bjj@pburton-laptop>
References: <20181109185053.p4hy6whjtdj3gq4o@pburton-laptop>
 <CAHk-=wgyGKdXbp6oU7ULc3QPYrVb61A_rRzDmhEXwNCFk14CRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgyGKdXbp6oU7ULc3QPYrVb61A_rRzDmhEXwNCFk14CRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:300:13d::24) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1744;6:MYVkwZPkGExZqVEcyyZpDQk+WLjyOXFz9XWD3VMuHtl44gxWFwqUO371uIGxFltwBIf+lZKm4TOxbRJCNNW2jcl+RGhKXd/bJfzUt0SbUwI9vU8ka03lzlSLK0z5aCi0h/eV7td4lF4xCeCG1TTeypymIdb3sdqcdS+4Vr/CMItz18ajilnJQATPnosDFdbvsZQosKf0RO7vK5lqs+MBEWJn3sEfxEYJpC2xEjsZi6T01ZQC8c3kkbrTJoIX0U4osKDXRTaZYw79gBF8eVwRsCunZ3KJxaFgTyQBOpdwOwrcMldaq49yX1yxY58adxNt/YuxdAdZtGRa6jmh4i4SPQsahq+Gfz4Q1Y4M5D7cRQxiV7RettnxjMhz1C/NMxhpQzqV0dDOQOG0sI1CECUVKB5eZ95xOQ8HBCAQ6BbuRmTLqMk7eQzUH+iz71HzRwp9/GRsaN2rarjiq1vHS6GMaw==;5:BJgaHP35LMOZ7fyjrU2WvBRgXVOgB4Pys/ttfmmuwZ3vzRXm0nU8CBB6J3YsiiUMgQY4sJxHxdD6Xplfnoe5SXMTLv56WQ/UIoFJe0IZJ4lsA3ydgwf44/sR55GsOAsiAQgECdIMxP4NIFqkXh/5cqUMb2INpB9r5SIF6iL0bG0=;7:DGDmf1uiiUjKTXXZ4ei6x7peUwg4iUFkL3NACVIDyPhhr0/dTdoE2mGSowa6+ENQxbUklrm/EteV19kQRu5S9V8yyvKeSmd4FGkzzai3qojN6HR/TRt3wsZ9iOAISU9NqvysXz3AAA1lzAkkXOmjUw==
x-ms-office365-filtering-correlation-id: d8954763-eb6e-4fe1-c49c-08d646a10e83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1744;
x-ms-traffictypediagnostic: MWHPR2201MB1744:
x-microsoft-antispam-prvs: <MWHPR2201MB174457A670B2FCEACAE60A00C1C70@MWHPR2201MB1744.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1744;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1744;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(97736004)(229853002)(33716001)(25786009)(102836004)(53546011)(26005)(6506007)(386003)(68736007)(6486002)(76176011)(33896004)(4326008)(186003)(486006)(9686003)(476003)(6512007)(105586002)(106356001)(508600001)(44832011)(6436002)(14454004)(6246003)(53936002)(2906002)(2900100001)(42882007)(6916009)(256004)(8676002)(81156014)(81166006)(8936002)(71200400001)(71190400001)(446003)(11346002)(99286004)(5660300001)(316002)(66066001)(54906003)(52116002)(58126008)(6116002)(3846002)(1076002)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1744;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7HSKodsa+4BWuQdCiGHHapMhoRkJn64fj+aHn575sB4t49Tm77sMTDs2xRo1YX14IDFGDlVOrC+ZDtPIztHC07avG18LIuEnL3qq7kIy0NXVZWDG3HeSxO0JOTuTt4e+LA16fjFnXRUHiZNY58scqtdtDnBKHrsfFR4yN0M+p14GOz5p1Qkl68ocIY+rH3Ma/z04Ozp8AzH0VqpfwlAK0GKn7U+U5CzYyM03Bw1UZ6pbKwioUNhxunZzIbXPChYBpb3BqnzE5sCaK+d4/vXY3VKF+B4nW31HvWNYJZACHYmzjAe+/Ir5jllkdjASFEgRVCozQUBRp7uV0gyUpfLUUxzUMPgNJkup4oevi4FG6EU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21D3E237F1AE37498BF2C3D0A35F763D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8954763-eb6e-4fe1-c49c-08d646a10e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 00:11:27.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1744
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67215
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

Hi Linus,

On Fri, Nov 09, 2018 at 04:24:48PM -0600, Linus Torvalds wrote:
> On Fri, Nov 9, 2018 at 12:51 PM Paul Burton <paul.burton@mips.com> wrote:
> >
> > Here are a couple of small MIPS fixes for 4.20 - please pull.
> 
> This is a "I pulled", but if you cc linux-kernel, you should now be
> getting those messages automatically when I push out.  I will be
> stopping my manual pull acks because of the automation. So if you care
> about it, start cc'ing linux-kernel too.
> 
> [ Maybe linux-mips is being archived by lore.kernel.org too and gets
> that automation too, but I don't think that's the case currently. I
> might be wrong ]

Thanks - I'm happy to copy linux-kernel in future so we don't need to
put that last part to the test :)

Paul
