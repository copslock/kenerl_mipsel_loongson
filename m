Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2018 22:19:31 +0200 (CEST)
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:44400
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992289AbeJQUTYrt789 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2018 22:19:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwxcbndn4buNMtmS+EckB1LwKye7GQdsf5j/dKSM3DQ=;
 b=MStf86KVGCgR28tXi1VJI+7ggSVkmefu6NlNKPsOZGtPv6q+LVxbsLHgRq2jvrgsDBvK8Rfbllhw2musAG1aalydHOaFO9QZMAcpFQ56HrGLsYN5NMq4TG3TlL8QR7VoMeyTH0N7ii9XveDB2QlV4tVxIq/iBe6HH2biQhYimyY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1311.namprd22.prod.outlook.com (10.174.162.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 17 Oct 2018 20:19:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Wed, 17 Oct 2018
 20:19:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if of_property_read_u32
 fails
Thread-Topic: [PATCH] cacheinfo: Keep the old value if of_property_read_u32
 fails
Thread-Index: AQHUZbCNDbhqXsf44kaMyJ5DqQd9ZKUj4fOA
Date:   Wed, 17 Oct 2018 20:19:12 +0000
Message-ID: <20181017201910.27kdwnml6kq7qff5@pburton-laptop>
References: <1539736193-27332-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1539736193-27332-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0058.namprd22.prod.outlook.com
 (2603:10b6:301:16::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1311;6:7KNcufBtOZuNGC+o0h39VwzvqR0lkKQmGsmVnTQXO6f52BPWyRyiJufLnkvu0BdqVrf+4laJci1FpraS+Y5OeH/4r0NlX7C1raSHwdW8RjgEXv1RSTPUh1UowFqmvf4uqdub0aQm58EPRZBDNFagnntRJ1yjyBm+g5bqW0qnxweovzAqVtDI3zmsPPkCGXw5n6nhQA+5z7xbRY0VnlGN3XUj2lrzWERDGPRFjJ2c0bgnognwqhodLE1CSiZccr5SFNuMf5eqJ0FdIY/WXWQ1880W3zLpeEhfK9pokGmx5rAB6NEUc0VAE9EA+fiLO7K4/ejfw6TtV+YHcBgpVf5ABy8DIHQpCf0YU2awiaCZwVd3gnMugH+vBd+K8Mep86FZa1JVrQshHJ5YoXn+5ipw7YAi7zF1jqd7aQbwNU5UUkQ8/Ez91wWl16wcJ7VXUNN9Yq4JjkKpmXpmPPVuqxZO3g==;5:hSEhNvygYVzsAj/Tk2oDIUmVZWymglNhk118Mh6OFlR4eZ0ZY1xEsRfQoUarswiMg4X0tS0XAJNcryZtKxQZie61YSKXsIVyComvn0lVtgYyvUtbegTEY5/tf/p7UKL+4Y22NECQ3RjbDGlXR58wVc+Xiv3nc5hLCMbZq1IufI4=;7:Iy1xhFlRV/4UHGQnraVgjm3gjmy7kE2S50mOzq/AQOskLhwdmb79I4Weasg97xjf5Rrz7yZoyEW2xbJM1OD3osWX58UCzGqy6zV4fUb6gu0mW09s6LctZHBRmcK3iCEu55LQtvvGGNoonx5RIMFSjg5dPKi8wB0E9n27v1OIY8vCjAWobWI+U7BK6GR6aEk79G++RqRs7InckXsfgMpBmmUJvkwqjmZjeeiGggA+OWx3HYHOOuHHNpKE7ksbkhHz
x-ms-office365-filtering-correlation-id: cad7fc13-d2cf-4d8a-cbe0-08d6346dcd53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1311;
x-ms-traffictypediagnostic: MWHPR2201MB1311:
x-microsoft-antispam-prvs: <MWHPR2201MB13112935195289CFF7998B13C1FF0@MWHPR2201MB1311.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1311;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1311;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(136003)(39850400004)(346002)(366004)(199004)(189003)(4326008)(42882007)(99286004)(26005)(54906003)(58126008)(105586002)(102836004)(476003)(6506007)(386003)(44832011)(33716001)(486006)(6486002)(186003)(68736007)(446003)(52116002)(106356001)(71190400001)(11346002)(229853002)(33896004)(2900100001)(71200400001)(39060400002)(76176011)(15760500003)(2906002)(8936002)(53936002)(6246003)(6436002)(508600001)(6512007)(8676002)(81166006)(81156014)(14454004)(97736004)(9686003)(5660300001)(5250100002)(66066001)(6916009)(305945005)(7736002)(1076002)(316002)(6116002)(3846002)(25786009)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1311;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vZnJiwTfpIWhpdKxY6XnC3h0Fj5ladXN12vsATa6TzRpwtp2kcd2+dS1YseLhmCuXkE7QOHhi1paqJPStm3rgL1p4c34lPLC187E/4muW6gQh9SHLfBmhL4a+k0y96mSRuiBu7d9FdE7l43KgPdU1e4oY7zoXW6cUebqJGuV7rjne74enPk5cRIrDniJhT6I4+ia1nBveedgtpCJ+fYLybYGdQEJe7yKE2Ce7liBzscp1q6A2xcPgM36uXziacP+kFtbRxyLRJIEac7umGXSSSC3fuRh0+RDc4UFynkMtYTh6ATmZIKLP9/qlu1p6g/NTLAqJctwq+X91JWOXu9DUYE7CEoUrNbGOAcT1FTV8u8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C05A9CCA1695749A4650A5858ED7FD9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad7fc13-d2cf-4d8a-cbe0-08d6346dcd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 20:19:12.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1311
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66886
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

Hi Huacai,

On Wed, Oct 17, 2018 at 08:29:53AM +0800, Huacai Chen wrote:
> Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> property_read_u32 instead of get_property,read_number") makes cache
> size and number_of_sets be 0 if DT doesn't provide there values. I
> think this is unreasonable so make them keep the old values, which is
> the same as old kernels.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  drivers/base/cacheinfo.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Since this isn't a MIPS-related patch you'll need to send it to the
maintainers & reviewers for the file you modified. They would be:

  $ ./scripts/get_maintainer.pl -f drivers/base/cacheinfo.c 
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    (supporter:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
  "Rafael J. Wysocki" <rafael@kernel.org>
    (reviewer:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
  linux-kernel@vger.kernel.org (open list)

Thanks,
    Paul
