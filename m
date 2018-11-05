Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 19:31:17 +0100 (CET)
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:44123
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992783AbeKESbMhY8qO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 19:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McwQeVyQdQJ13KB82eJQMTDA14e3eBPq4vNYac1/GsM=;
 b=j3OhRSjoWSNCACnYUHN7BZ2BlUxF0dl5f+LlLWQOdU//ahWMfoLnAkqK/ST3JcVTqJlpxnoPNDDFVOFCcBgH49lW0PToG3SP9SkAtVDzggV/cHMJXBtN7n4t1HDMhvR002gQ6DwaIPfQxkeWEBh0YYT3d1aJ6nggjcuDboCEOxg=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1310.namprd22.prod.outlook.com (10.174.162.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 5 Nov 2018 18:31:10 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:31:10 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hassan Naveed <hnaveed@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hassan Naveed <hnaveed@wavecomp.com>
Subject: Re: [PATCH] MIPS: Enable IOREMAP_PROT config option for MIPS cpus
Thread-Topic: [PATCH] MIPS: Enable IOREMAP_PROT config option for MIPS cpus
Thread-Index: AQHUb+/jHRWLZ5VMbEKBZ3jWpNeByKVBi5AA
Date:   Mon, 5 Nov 2018 18:31:09 +0000
Message-ID: <20181105183108.3kzk2oxl4fpypgmw@pburton-laptop>
References: <20181030012741.31391-1-hassan.naveed@mips.com>
In-Reply-To: <20181030012741.31391-1-hassan.naveed@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1001CA0036.namprd10.prod.outlook.com
 (2603:10b6:301:2a::49) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1310;6:XfaeikQj15cx/PrEj6LzFJr6Qr1FJD584j6HOocFS4CiHrdcFzTJNfmqjdcijvhwXxb5yLIkoASuc2rANY+5cGTSMCABYMPh4+11ry+kTLpiFrOY9eIsjJnUmXy1mmILJKVT5SgfmZ9eZ7S3qsL3Fgp60SRWidtUeMIqteihrRoeX8jD/lz1uRpgnqAt9NaFSUiETGUV11dMfqLo0xEfg5CujUhI1H1FEmOGy2Sm161G7lItDwTp2eqykUtIES/ALUWpFxShSONNlZYlo0YG4cEHdUAEOJHNZ8f9+adeYJYE19P2nU5++eJasOKykCaE0oCavzkxhxlDiEu1BbRYXqEa4apYX1NQiXNyBSNqP7oZYWeXyjI3Y2KHBCZRcXIdZNxZzWVTU1KyywOVAHV74JfHigj5ktNAuLWTN33BWcsywYnps2/u5NNLa/SqE6E6XZUmEbnvWHNA4Uno39l9qg==;5:XBSTCdaViGZxpPseYvJn61Fl9Wc3vyDT4AypbxvTSBr2lILGD58jMFJYsc6CfUELA6FGpxQXytZi/idb1j2piP8VeSz0vHKfgKAe6AvKxf4Imd1ZRpiQ0o6GJayYCkF21oMKZoPY8kuRrOznIFIeaJkyKeS7rsRY31MgMlKc81o=;7:8aqzAq3S7F30oeWuLUN8KcJC3SlyKdKZnyF0kUWa8lBkLszHF1ia8kN2Exv1d6UxZ16EPOLle5Wh0xE0JOeySrigrQaHDiiRomNskvCe8TJD9NcRvB9HeyjPARgWmoDBhTd+IItDWFVX4s+F764oZQ==
x-ms-office365-filtering-correlation-id: 4b0d4dad-b2fb-49df-5767-08d6434cdaf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1310;
x-ms-traffictypediagnostic: MWHPR2201MB1310:
x-microsoft-antispam-prvs: <MWHPR2201MB1310224D53123593960E3262C1CA0@MWHPR2201MB1310.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1310;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1310;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(376002)(39840400004)(136003)(189003)(199004)(4326008)(6116002)(3846002)(1076002)(26005)(2900100001)(102836004)(52116002)(478600001)(14444005)(71190400001)(71200400001)(186003)(486006)(2906002)(256004)(99286004)(14454004)(33896004)(54906003)(386003)(6506007)(44832011)(58126008)(316002)(76176011)(6486002)(11346002)(446003)(33716001)(6246003)(6436002)(107886003)(229853002)(476003)(42882007)(66066001)(5660300001)(6862004)(25786009)(68736007)(8936002)(7736002)(81166006)(81156014)(97736004)(8676002)(9686003)(53936002)(6512007)(106356001)(105586002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1310;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H//syLyaFEKf/FE6gV1fG1Zb+Bqsd5wHECvEK8jgeGXIIMnO31wqP8vLtTa6LT+4GMNHUPpwQsKZRhtNucXqixSXJJrd3KcifcYix9+7pPXpKvJN+znrTDByr6Br7cAqb+qv6tvY9XUngbf2AIuRE9mb+pamLwKKgxJO+sCwKNd6LTQO6op1WZ9BGXQTakb6G9uPAKHPRXbUCJqnnvQ/eaclTQiLmKy93xd8YG6dnq7oAZB11D+nuFLbRUFLm9+iTXdA2755erBonvStV2giAnhiCrhOCbMRoqCJFQSoZurpNaSsnVzP+Q3hSfzMZse7YVZBuxltTZkDVsvpCi3oT/isiaEgR5NfHzhLWRsOmwk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F13175BF5AD81E4E8D7A38BE7B05DF90@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0d4dad-b2fb-49df-5767-08d6434cdaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:31:09.9712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1310
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67089
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

Hi Hassan,

On Mon, Oct 29, 2018 at 06:27:41PM -0700, Hassan Naveed wrote:
> From: Hassan Naveed <hnaveed@wavecomp.com>
> 
> Allows the users of ptrace to access memory mapped by the ptraced process
> using the same cache coherency attributes as the original process.
> For example while using gdb with ioremap_prot() incorporated, both gdb and
> the process being traced will have same cache coherency attributes.
> 
> Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
> ---
>  .../features/vm/ioremap_prot/arch-support.txt        |  2 +-
>  arch/mips/Kconfig                                    |  1 +
>  arch/mips/include/asm/io.h                           | 12 ++++++++++++
>  arch/mips/include/asm/page.h                         |  1 +
>  4 files changed, 15 insertions(+), 1 deletion(-)

Thanks - applied to mips-next for v4.21.

Paul
