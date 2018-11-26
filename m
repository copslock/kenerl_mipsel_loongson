Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 19:18:12 +0100 (CET)
Received: from mail-eopbgr810133.outbound.protection.outlook.com ([40.107.81.133]:62556
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993032AbeKZSRWwGiCw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 19:17:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5IuTME9/jBbnm2n3ypOcmORycdC6gzkqUmp3w3TlP0=;
 b=Zo6hf6ktBlogohxlmfBtShdaNVcwPHO0rgYdv1JazFl2vQ7OGSmnFae/VHYKsnSttAi+x+gohVQSqF9xu6xywcv/KVhOqqetlOMkjqFyjUB5TeeLCJDncefC8uyJi9GiljZfptW9tQANPopocShUsNuKIyBjQSiMpnVdL1KKPsg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1373.namprd22.prod.outlook.com (10.172.60.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 18:17:20 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 18:17:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH 2/7] MIPS: Remove unused PIC macros
Thread-Topic: [PATCH 2/7] MIPS: Remove unused PIC macros
Thread-Index: AQHUZLWLq8uo3tAHiE2f79JEYFipP6VcOCWAgAZm9wA=
Date:   Mon, 26 Nov 2018 18:17:20 +0000
Message-ID: <20181126181718.ub4djz3x2dyffy7m@pburton-laptop>
References: <20181015183304.16782-1-paul.burton@mips.com>
 <20181015183304.16782-3-paul.burton@mips.com>
 <alpine.LFD.2.21.1811221608260.22145@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811221608260.22145@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:102:1::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1373;6:N41Zj4++a6mQnXU5eZEkLw/Gww/3uf/qybX7lF4sGLLbPLvcEMIgvpJZhXPXv68y02Qd323T6J7tGMujnKHmxJlR3mZR35VQyWhzuG9wXsZE7ESDPnKdmR1rRfhGcHJrXiP2H2S695d37z/VFMwV92UjWAutAITBXPFK9BNpqub0IPdPRK+xiGywM5AhngOQRgt6WEvFGXewzGJqD1mNVmSx+VKR6cWTtmaW6yOSyQ8AexiVcDIHLXizc3oa3dRQeonLcvPQAVlwRxHo8r9VDqs1GYDnomcwXMIEpK5B/VyHmfiCSEk1OUW34k/DDlpMpQJym1JR7DwC8Mk9ZKRQNQTtXrrJHsp/s/94zWcLjwl060zRhcH4cZY+yv2H8kKJfCjRK6sC2YP+IhCxrGu0SdWq/Jc6Z/QYfEd686Y3uj6KfTDK/TX0+VbbrUr6FTRqjYemlwBRhD6kQEStRJIScQ==;5:gQwmFNsJnYRKsS2GMB/d57XR0yDGgp6Ct8+mBvvqUBOO6niRPglHuxvIMjkZ2TZ7Rcfk9PAfs69SJastKMiTlZYiVH7z0Pj94rggDpHhHJiKeWvU7hC2vYVzoFrHhYUeKjctejrb7P7Qhbvolde7KMvRM3ELAqBj5y+drAxJXwc=;7:HmAaoozeHSUeMcetmWNDVYSRTL1NUTebhn01JDpWEiT0EZ0h3Yg6ZA/QiImO/zUCpFYOZti/RPMpHJ2khph/4WuZKAiifHq9PDFL+PWQRzMm4ZD6pTMCAQ+DjRDlFUvwtJxH//OyKLiH4FqEumLljg==
x-ms-office365-filtering-correlation-id: d0ce55f5-673f-4273-bdb3-08d653cb676f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1373;
x-ms-traffictypediagnostic: MWHPR2201MB1373:
x-microsoft-antispam-prvs: <MWHPR2201MB13737C54CE66CCAAEBBB731CC1D70@MWHPR2201MB1373.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1373;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1373;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(366004)(39840400004)(396003)(376002)(189003)(199004)(69234005)(51914003)(3846002)(8936002)(4326008)(316002)(6246003)(53936002)(1076002)(107886003)(97736004)(6512007)(81166006)(81156014)(8676002)(9686003)(6116002)(14454004)(186003)(33716001)(450100002)(105586002)(106356001)(2906002)(33896004)(386003)(52116002)(26005)(6506007)(102836004)(76176011)(305945005)(68736007)(99286004)(6916009)(42882007)(5660300001)(7736002)(11346002)(446003)(6486002)(44832011)(54906003)(25786009)(486006)(66066001)(229853002)(256004)(476003)(58126008)(6436002)(71190400001)(71200400001)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1373;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MacvdLHW6+OXCuoqKFH+6MHBeIjevU6+420RQNoDSR6TMHpaguFzEyGQkvAgQWtJax+UmWt8nLLaKBrhP3/813Wwh5n7aCRZZbMyItXdBUzFkF0meFViqCQQewV+jnGW7LUctF/6BcQJPzsGXUGi29pR0DE4jbQy7eKFwdodLnux0GDXBs5SbDW62/SN2t+AAOk6jhrhdysybeskOaoBACKsYBRoAuGYFsYCKr1vKeAylQM3UeZet7jVPq3okd++uu0U/6/EetVWncIAaU6iIMLJpOPBN503pGKhBvwefGq01I9xJ44e7xNRnnO8Sn7QxddBFnGD8yK+v+iwiXGenr7nEQM7pFH6lhNZIZdNqoM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D31756AC9A648343826FF9599A5A3A1D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ce55f5-673f-4273-bdb3-08d653cb676f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 18:17:20.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1373
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67512
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

Hi Maciej,

On Thu, Nov 22, 2018 at 04:31:13PM +0000, Maciej W. Rozycki wrote:
> On Mon, 15 Oct 2018, Paul Burton wrote:
> > asm/asm.h contains CPRESTORE, CPADD & CPLOAD macros that are intended
> > for use with position independent code, but are not used anywhere in the
> > kernel - along with a comment to that effect. Remove the dead code.
> 
>  FYI, this was I believe for consistency with the <sys/asm.h> glibc header 
> and in the days since lost in the mist to time may have actually been used 
> by the userland too.
> 
>  Overall the contents of this header used to be somewhat standardised in a 
> platform-independent way, e.g. the IDT MIPS software manual says[1]:
> 
> "Many toolchains supply a header file <asm.h>, which provides C-style 
> macros to generate the appropriate directives, as required [...]"
> 
> and then goes on to use <idtc/asm.h> across the many snippets of code 
> included throughout.
> 
> References:
> 
> [1] "IDT MIPS Microprocessor Family Software Reference Manual", Integrated 
>     Device Technology, Inc., Version 2.0, October 1996, Chapter 9 
>     "Assembler Language Programming", p. 9-17
> 
> [Yes, it did have a chapter on the MIPS assembly language, including the 
> syntax, which some people confuse with the syntax architecture manuals use 
> for the instruction set.]
> 
>   Maciej

Thanks for the background - I figured these macros probably came from
some standard header used in multiple projects at some point in the
past, and that maybe it used to be useful keeping these macros to keep
our header in sync with some external copy of it.

In today's reality though the macros are dead code, we never do
synchronize the header with anything external, and I doubt anyone
looking to work on the kernel will start by reading the IDT MIPS
Microprocessor Family Software Reference Manual. If, bizarrely, someone
did that & got stuck because these macros aren't defined then I suspect
it would be among the least of their problems.

Thanks,
    Paul
