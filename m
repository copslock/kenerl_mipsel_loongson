Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2018 19:10:48 +0200 (CEST)
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:43901
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992267AbeI1RKlzQX5Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2018 19:10:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NOSLITz4k1txKVAxWnEmKzn1TYe2XdKgUCF8FidtS4=;
 b=YFmkrIb5tv2HxtIttE37c5IdPQ2wy969bNpg3Pz9kZsaIWnGlsw/AUY2De+Ma9t3aLAMIM0UeuhDPl9fzwtIhAyn1YFwPSg/vP+wJxaHHi6w1qTrHxBRXRfKWBx+L4ahW219P/FYh/viZigVD79cvhlvpLEa6SWAv8q84Qvuo+Q=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1344.namprd22.prod.outlook.com (10.174.162.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Fri, 28 Sep 2018 17:10:31 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627%9]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 17:10:30 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
CC:     Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [mips-next PATCH] MIPS: kdump: Mark cpu back online before
 rebooting
Thread-Topic: [mips-next PATCH] MIPS: kdump: Mark cpu back online before
 rebooting
Thread-Index: AQHUVdH9j/uWdUY7e0u9VIL9wrCY1qUF8KoA
Date:   Fri, 28 Sep 2018 17:10:30 +0000
Message-ID: <20180928171028.a4ww7vyrzf4fvyqd@pburton-laptop>
References: <20180926194847.8734-1-dzhu@wavecomp.com>
In-Reply-To: <20180926194847.8734-1-dzhu@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0095.namprd22.prod.outlook.com
 (2603:10b6:301:5e::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1344;6:FZQ/caAPZpXP/9zepJPUYDJlxEzKtVxlDCKagmrDuS0+YHLwYaMwr49SowZm4oBHDkh0of4Jkx9GEbho/S79xbS7lpDmTGFjk5KWqmmyEVfFne+1giOSojSFxe3e6EfssXonG7vr6ipnLHIGV9Vg+MoVEYMvs9iYjNZgyh/gxKbzPHwaNNlH9T0bAxWlRfFEObLpXLgeXhfVU3enUxOz6c5QOMrAjPa0z7McnZE5qU9K6V5UEL41QreoBn8cjOM3//MoOaGgeNBjljaaCf0uR5dp5J69jKn/JLnEGuID7YcphKQZBVQyFU4bKbijUm2v4mUe9ZsmcQAQg1NPefz1lEmv0QIlz/+CXEYonVyUHgfM1Tx6y5Oy7wk/BlZu611a6+pmglfRUdYtXpu7Csfdd/lFFacEBBocLJMnrp4uwx77jy1Qpfxis2qSDVNAjrt47pQ4oL8XhUa3fC4neTPUUw==;5:/9EMPbZL+64J1rltu17CfF63JYZN2wYMrANAr5Vu/G7o0DLuvjynqd05wvH9flxFpnM6vfR0Ntiw/5etgPJ8W9mxy9HhcrPycd9BTpyVZfvNWj9gqljSN8ikgooLuG37Xfm8qntdN03+hjj+kyJGFivnJ3FexMkIeJBhagTIKYw=;7:6h65en2VherwBmp4sk2+cWHNk2aIcWJ6FtkSqJS7NRBvh6ULJzQgfX1c7iSphIgt0IR5fwcJZCK/NM8O/LhSu+nA409uNRvzQXqUvcq+CDOiAlmBEMqWC79CQfVhPuEhbkLu5TJCrly6OJkrGn//sDGb7p1a7yp3OmRCuJI3tNPW1/9PdrYtW9QWeVmQ/5aqL8gnRZfcywNGv+NINt4P9KGpU+X37ZiP/eso9fy67XIeB8/UoML+1zTuxrgWALGB
x-ms-office365-filtering-correlation-id: 4c2b2e0a-430a-4c02-b552-08d625654ab5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1344;
x-ms-traffictypediagnostic: MWHPR2201MB1344:
x-microsoft-antispam-prvs: <MWHPR2201MB134423EDF466202BB78E649AC1EC0@MWHPR2201MB1344.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1344;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1344;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39830400003)(136003)(346002)(366004)(376002)(189003)(199004)(256004)(478600001)(26005)(476003)(6512007)(9686003)(446003)(8936002)(106356001)(81166006)(2900100001)(2906002)(8676002)(6436002)(6862004)(305945005)(42882007)(33716001)(81156014)(14454004)(102836004)(6486002)(44832011)(1076002)(11346002)(34290500001)(71200400001)(71190400001)(7736002)(54906003)(316002)(486006)(58126008)(229853002)(52116002)(53936002)(66066001)(5660300001)(68736007)(4326008)(3846002)(6116002)(5250100002)(76176011)(105586002)(33896004)(25786009)(97736004)(6506007)(99286004)(386003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1344;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +neruXfgMp7UK6nBQWVp5IAFKlyJU9scuJpdpqa4Fa3Kn5m3shFFc9bks1OqZrYKYV273phlnwdtqA/+lW2MfUlpNX7xzenf+ukeK5hB1w7fhHm3ntPSoDx8CYm6P77gR5Q+x37zxXNXIwEWVtjWAaekXkK5Bklpn1F0Yhn9FgupckjHngkEeDA+M7DCDRuXauixcnztJ3aamm3W3yVsZcROR723QHoVcTOT5N9apODc6I6dpedwIj3CSxjBuLq2V8FLiAQXYQGvotUL9tl4TwDcOIn2Py5jQg8YF4LGKnTToWAwWST/Hjb8dqyVAameC+gyEw3Vu96R2BcuUaZGrw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE9E2EEEA6F86940AC7D820051C7A5C3@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2b2e0a-430a-4c02-b552-08d625654ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 17:10:30.7911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1344
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66607
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

Hi Dengcheng,

On Wed, Sep 26, 2018 at 12:49:10PM -0700, Dengcheng Zhu wrote:
> The crash utility initializes cpu state by reading the system kernel
> memory, which is copied into vmcore.
> 
> It is also natural to preserve the online state for CPUs at crash.
> 
> Failing to do so could make the analysis tool present info for only 1 CPU
> by default, and unable to find panic task.
> 
> Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
> ---
>  arch/mips/kernel/machine_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Thanks - applied to mips-next for 4.20.

Paul
