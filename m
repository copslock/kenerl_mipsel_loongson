Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:29 +0100 (CET)
Received: from mail-eopbgr770129.outbound.protection.outlook.com ([40.107.77.129]:28260
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993032AbeKMWWUrQ0lu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ki6fhHaJxDzcoNx+Bvai7uCZT6pKTJrxI4DM5IN+d4=;
 b=Rvj1PYOAxQlev6uk0H/jvWGMm5mXLUKB9wlr79IEyK5FLAjBbqRMintoFt0i5jvDjNs3beF04DWtFt4dvM0sOBhNV71lzeOXWyAmKZxckfhVfrgp2WlUxrL2i0YLYOEkMQJyEylusl1fUPx44hDW942uFSTstR6f8SDj0hfp2KE=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:18 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Remove GCC_IMM_ASM & GCC_REG_ACCUM macros
Thread-Topic: [PATCH] MIPS: Remove GCC_IMM_ASM & GCC_REG_ACCUM macros
Thread-Index: AQHUdu5THmlJicKOe0em0G//s/og1KVOUM6A
Date:   Tue, 13 Nov 2018 22:22:18 +0000
Message-ID: <CY4PR2201MB1272BFF6F9737CF238ABFBEDC1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181107230454.3232-1-paul.burton@mips.com>
In-Reply-To: <20181107230454.3232-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:gKxmyqcjHpErUKJWD/glf6VNgO8zI5trTcwHpubFfSWmHN8DXXyCplTSglVRNfh1NBh6adpT1RrZGnDkPjbGKTuDitpFqXnq5MxkFEFpN0SIB7S3T2DiPx9VALQJvlL2NKYbo3K2AKINEdmYFsXc+tjXxhrylPqVIcuKIG1/NBSruD9oy9p3QiAZBZt23GOI6REz4XPTGaMoIBx3uKxNw3EZ5SvR2s8CabS60yxDBhJCYY4SXaALtwLalLozTV+Y/EU31wiDKqYjZv21zWt4B6JBBBpxFwyM6c62AD91Nwtk0WsITFyZIgdUEpPj3iDc824BZSzzLjIqVDVEUTwQa2TlOA79A466YUiUQQ2xlL8ZyXH6dqH5wShNQEHRkkfN6nqVx2Seo0PPWbY7bIa35tC1Y9dU7wRBzDt1AtToKjx0LOuPwmoyaoH5ObnDro/IEnm1xVmm12Rz60SzvjVZBQ==;5:NulRlFctZNdRYSNAzmHdQqdaYgw9iOSnaMhIIhXmQM4heaLB9nXc38yEZ9ZYflXC49YlzW4u6Unq4Nc1UDb6u61vHIXAr6eMzAEZGrq0MGsx1ACT4nQnohrolffSb6vge7aL5UkCXg+PaejJJw+FulmJEX8H43wECz9RO1UCWQk=;7:IjKyHj/Jykmy5gL+Ml6Z/mA4B3NjGVQpbdnnmceiku8TQqxPDQbRjAQEy489a5AvwnTN50nc700VnFHIPHQNtXIlqgqDCCx6sfuaiW60tAKDZcHXHYltzcU47vJIovUSEo5+TcZ7oRVm6dI9ZQjK0Q==
x-ms-office365-filtering-correlation-id: 571c05e0-a6d4-43f7-c3f4-08d649b67902
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB1350014F2FC7F9CE27C007DDC1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EwxcLSJTJbThnMJ6fRJ3d7RTWHWbAYYLGQ0tjhfOgPrS+V4H3dCyqOyN/6bxVhi2LU4yWSEk2lK6iz538blEMccNBw4Hh7SoOYfcoAnWxcQgQ/oZqWJj3w6JYIBARY+ZBmjdZLhSL9p1LSxSa7tRsugfyr1htcqOjQdfYr5svaiGFNlkNvQ7aBBmLI+kvJqirBHjZY5XCM30+C55V6o5f++YhfXSfDBGOLxu1lJUwhCIIlL9P+3ff0UQxDHZcxadfdn63aGcC8hgnfvkr8zmnlVO+k5qDt+Mw/JmNi2ztsUuAW+hwgOwb3pK16SU2tnR1QxP5yFi0c3iaOVuLq8hL1vW8gw4ZoZF7pVjV54DJ4w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571c05e0-a6d4-43f7-c3f4-08d649b67902
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:18.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67263
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
> asm/compiler.h defined GCC_IMM_ASM & GCC_REG_ACCUM macros, both of which
> are defined differently for GCC pre-3.4 or GCC 3.4 & higher. We only
> support building with GCC 4.6 & higher since commit cafa0010cd51 ("Raise
> the minimum required gcc version to 4.6"), which makes the pre-3.4
> definition dead code.
> 
> Rather than leave the macro definitions around, inline the GCC 3.4 &
> higher definitions into the single file that uses them & remove the
> macros entirely.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
