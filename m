Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 19:07:11 +0100 (CET)
Received: from mail-eopbgr710131.outbound.protection.outlook.com ([40.107.71.131]:16878
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992786AbeKESHGdrnAH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 19:07:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vamk++5Wq+YHE87L9LLDLsFIRjOJMsx666yYVhclXg=;
 b=WlqNOR7by4R8EV9jBUKWHqVNYQ5HzkyapIqR6HN8nrtlYQUilh3wVSYkPfUFqg99Kn2N957rngpw3p4wD0DJ8aRgGjj2JBR4JLWPWKnFXplUQbmq3wls7xAb4AEgbPNq1fOeEtqzlUaVIddQitdT5V4aYMLjTblXeyYwuZmODIk=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1504.namprd22.prod.outlook.com (10.174.170.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 18:07:03 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:07:03 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: fix out of bounds array access on CN68XX
Thread-Topic: [PATCH] MIPS: OCTEON: fix out of bounds array access on CN68XX
Thread-Index: AQHUbX3cns7kB0qKe0CjF3KIYTsAB6VBibUA
Date:   Mon, 5 Nov 2018 18:07:02 +0000
Message-ID: <20181105180700.2fwggvcy5mzlxscz@pburton-laptop>
References: <20181026224634.30560-1-aaro.koskinen@iki.fi>
In-Reply-To: <20181026224634.30560-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1504;6:Gw/5Nkx4LT9QIM7IJom7ZrG/F7Vd8b7/sxu0nkben4sgP0oefItvj5fS6ID3u7AwTiGrGjmP0gHyIhRoEFHbMSsp91vf6YJETL/eYY2VRbSVJXwumoEmaagGwAP8cVOGPrTw8AhJmXb/ByeGCMa8YGoiLBM/PnQZ0EhmDHCVD0mu7dxTg1UvHjmXjIqbr5PEXOoMThpYmKoa2HI8EkLNn3ZCP3M4kSeHP6+cBMK0xtmgSaDaincjWM5qKe9kBZ3ET3c3EaqJePIU5YZPL8RkJ717IhIipT95yw35RBT4RjjhQFFDQmqQMvDEN+9zaNSXycxGfn+jEK165a86TX2+T5t7U1/0H7yOKy0AtbAZ/Fg8Ymdd6zREh9HbrLJo9DTUr51Ee7GstlNDPsnBBfL/+M+jnAqoHeP0qrXRIY7w7Cka2jsHjQH35kk5qjwOaFHqq8OqBItnWYJ/bAR8QpUNJg==;5:bZ/4EXz/S+wWJ8UY3l+xKlBTdbI/+aelPPqWGVYRNtQ/pLQdGBlKHaTCHt5GtHgndrqxRcTIlqy2LzbXaMYeQO5V1/tuffqWqyC3eBQ1YnfBR9qV8Ea/fQYEjypyUePLzlOs2MOWFrZKWR9gZXDW+xAhKZB39WbyOGTNjQy2sGQ=;7:xcRTFrDoBMWVn2/1XMSPG4UEEvyiXs3MiILlKOq5kzCzF0GLU4+NYaz8OKqqgabNukhVE6jly3AVLg1aOVTHBO2ySJtLWjlvW0xKnIhLWEhh4aH7eycZ2ijl5+rCTb30OrcBm8WCqZ+6L9KwMZEaBw==
x-ms-office365-filtering-correlation-id: 574bb642-51d5-40f9-5aa1-08d643497c43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1504;
x-ms-traffictypediagnostic: MWHPR2201MB1504:
x-microsoft-antispam-prvs: <MWHPR2201MB15048F30A869914A48AF30AEC1CA0@MWHPR2201MB1504.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1504;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1504;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(376002)(39840400004)(366004)(396003)(199004)(189003)(6916009)(8676002)(1076002)(81156014)(6116002)(14454004)(97736004)(54906003)(3846002)(58126008)(106356001)(7736002)(305945005)(316002)(42882007)(105586002)(5660300001)(446003)(8936002)(11346002)(68736007)(44832011)(229853002)(508600001)(25786009)(26005)(6246003)(186003)(81166006)(6512007)(53936002)(71200400001)(71190400001)(52116002)(4326008)(76176011)(486006)(256004)(14444005)(66066001)(33896004)(33716001)(2900100001)(6506007)(386003)(9686003)(6486002)(476003)(2906002)(6436002)(102836004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1504;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DabvvCM3RrS8hcN+8eEW1Mzhh2Dq8CKXeJGG4m6AWuFHyDEkWIx+4Yte+JFv7E4YQs8gnZrQyhft5NewK9c3gGkAU7+V2oCa2BFPIDrL91Rwe84SJYqgiZb339uM2tk8WuRTuBp8x8vLJbuX1BYPT71+ET/eMu/alpEIZ6/62npJHoGKM/rCxOitFKJ4/SJlKLq3/lxOjxVTO5xNnTdFCApHASZuLCYD4DYhLlATIYiqRXmedL9vKXoo07b7bBOBJ80b2E1yhptC4Bl3wHOLfp2hbgXcHJ6JXF7lLFp4ZXWUMKnn8E68MzhfONCaSoEFqW0D75QQSr+1wFbnlJYNWDTPNHojUqHuhRePH5e5mAs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <635D4B5312EF7C46BC097AADE0A9CF4C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574bb642-51d5-40f9-5aa1-08d643497c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:07:02.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1504
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67086
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

Hi Aaro,

On Sat, Oct 27, 2018 at 01:46:34AM +0300, Aaro Koskinen wrote:
> The maximum number of interfaces is returned by
> cvmx_helper_get_number_of_interfaces(), and the value is used to access
> interface_port_count[]. When CN68XX support was added, we forgot
> to increase the array size. Fix that.
> 
> Fixes: 2c8c3f0201333 ("MIPS: Octeon: Support additional interfaces on CN68XX")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks - applied to mips-fixes.

Paul
