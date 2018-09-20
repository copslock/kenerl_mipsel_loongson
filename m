Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 22:36:48 +0200 (CEST)
Received: from mail-bl2nam02on0098.outbound.protection.outlook.com ([104.47.38.98]:63904
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992747AbeITUgjAWEa0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 22:36:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xxoKuBQAAwvRCQqycdu9Xp/MpCb2eKs+QEbuxMvTqk=;
 b=CWe9M9Qqv/ynXzxi530BPBqhw2NzkK2bYX9d4uVJIFTwnwoXPUR3oIw7NZkGFDqWvTBK7fLg2Wa20d2VSY5pqAPGxfZww+FCuTwl4SEoMU3zTdQ0YUgPsA0bO1PR+mZwPMSIvhjwUJSt9gBBiYEd3XuS1NTUphgnC++dF8Q8uEg=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4632.namprd08.prod.outlook.com (52.135.234.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 20:36:26 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 20:36:26 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
Thread-Topic: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
Thread-Index: AQHUUOs2L/z/C4c4KUy7syB7x8Is2aT5oVsA
Date:   Thu, 20 Sep 2018 20:36:25 +0000
Message-ID: <20180920203624.s4ivwqlco2icac73@pburton-laptop>
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
 <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
 <87worgia60.fsf@concordia.ellerman.id.au>
 <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
 <d31bd0cb-b9da-6f1b-4f93-da71644668d6@c-s.fr>
In-Reply-To: <d31bd0cb-b9da-6f1b-4f93-da71644668d6@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4632;6:9a94XT0l5QeB+6d3VL+VbvscZrmPcMSzGtrWQWBPRPEJQ5aZ6R7FSeJD4SxO4Jb6xgAF3FNYse72GpN6TOFwhZ9OmdV1u149H6XxsbDmlqygmHSj9WeEJhO4BcIOAvxg7HR4BGrf2E8f/ObF/oJlha5P0/BQ23zeKaSelFMMZ7SnFnnIqKgof/cCSYNGz1CiN/q6etf6wEdydEnXulsFOnRhFq7ZGVpsnDbU7CHnFbFL58/zWytUiQ4pHdCgQzNuOJvpV1BGFVMJ8i0+0EdM1V1/s1eBICTvb6rz1JGKe3yCcoLbBWr6ydTSx8P0KQv7J9FtMjhWVPT5+3SnBiG2+RXySgCkxY4pNnJg2271ihiGwUqXNGLGzEa7coV3oLBdqgWoGx4fnAIxaeSq6kdl3UQCrktm+9O7s4A4hrD3OTSSafwLgUDf8HS2pPVn2bThPAN89bsyKQ3iUkEL/x2IIw==;5:H4v7bRwmaxvyurdbK/jXfyiQt9adG3nE9nz2liAut8E3EH3L9z6VBVsxMKmPyRJF7Q5bH39aFTZfzuLZ+8E65JIhJ3ssyETZE1xft89TwAgKULQn2CmUUG5d2wO50Qa+vcDrZlf8VGOxm1O28VysRrAu+MB/j7GrLfVhCO4Xp/8=;7:NmKaHcfjvuF4B2PrB2SliJfwwtyN+XB4iIDN37ZJ0GixmoeFuV2ZGNxOpQ/L+oZuOg2j6hFinh1Z7GaGzuTRlog6ZqFOOc3WnHMsTkUvhXOQEE0PcjYQawZLqe7VvoxAzRazknnWdeDaKUgU7xXkGK5Z+OUOkuJQxqvbKW2iXQzmWGfMq1x8LAyQEgdDUpL8srqpmvQRsCnFOJ1BxMVsgmzYwqHjCxi0bPm8OwsCZ/OSDDuwJdFjeJj/1qly0nlz
x-ms-office365-filtering-correlation-id: 14ec4e97-f979-43bf-9b55-08d61f38bc0b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4632;
x-ms-traffictypediagnostic: BYAPR08MB4632:
x-microsoft-antispam-prvs: <BYAPR08MB4632E62D13DE84A19982DB75C1130@BYAPR08MB4632.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR08MB4632;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4632;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(376002)(346002)(396003)(39840400004)(189003)(199004)(2900100001)(105586002)(99286004)(4326008)(76176011)(58126008)(316002)(8936002)(106356001)(54906003)(81166006)(44832011)(11346002)(93886005)(81156014)(71190400001)(71200400001)(5660300001)(52116002)(6246003)(68736007)(478600001)(575784001)(53936002)(476003)(66066001)(102836004)(26005)(5250100002)(6916009)(6436002)(97736004)(229853002)(486006)(14444005)(6486002)(8676002)(14454004)(42882007)(7416002)(25786009)(9686003)(33716001)(446003)(305945005)(256004)(3846002)(6116002)(1076002)(33896004)(7736002)(6506007)(2906002)(53546011)(386003)(6512007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4632;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iSl/AU/7oHlsNDCBYwHFidSIldXo6K/mkVgX+m/eV+2Im468Ngo/2q7I4u2AB5xJ3oh2dVrHU0AgFLa7ugYEfsPgNYG+B9+MLikV7X2lGDCfFhdy6FrORb5uVykNK2WJsIAKTfpGf/oPZBqgreSiRp3p5wgtY3dmyDlC3Ne/2H5XZ8Dqzniv4ByhL8hvzd+xR+ivLajyJ/9LyhOe3sVJT4+lXqulqBCSWwUs75cRaXboDrsAZIPRvJ627feYwpjkySGzk5bTlIC1aHZ6O+eju3WRuB48/YD9SoStku6nzCcieZQQFbw4pCXumYaKw2b8eDF36irUrAIRiSQm10bRLFklTTAr23j8xagSWeh3fTY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E4E6FD9EAED89740B59642A301137BC9@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ec4e97-f979-43bf-9b55-08d61f38bc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:36:25.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4632
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66465
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

Hi Christophe,

On Thu, Sep 20, 2018 at 01:23:55AM +0000, Christophe Leroy wrote:
> On 09/20/2018 01:19 PM, Christophe LEROY wrote:
> > Le 20/09/2018 à 15:13, Michael Ellerman a écrit :
> > > Joe Perches <joe@perches.com> writes:
> > > > On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
> > > > > On the below patch, checkpatch reports
> > > > > 
> > > > > WARNING: struct kgdb_arch should normally be const
> > > > > #127: FILE: arch/powerpc/kernel/kgdb.c:480:
> > > > > +struct kgdb_arch arch_kgdb_ops;
> > > > > 
> > > > > But when I add 'const', I get compilation failure
> > > > 
> > > > So don't add const.
> > > > 
> > > > checkpatch is stupid.  You are not.
> > > > 
> > > > _Always_ take checkpatch bleats with very
> > > > large grains of salt.
> > > > 
> > > > Perhaps send a patch to remove kgbd_arch
> > > > from scripts/const_structs.checkpatch as
> > > > it seems not ever to be const.
> > > 
> > > I think it could/should be const though, it just requires updating all
> > > arches.
> > > 
> > 
> > Yes I was thinking about doing it, but first thing is to change the way
> > MIPS initialises it:
> > 
> > struct kgdb_arch arch_kgdb_ops;
> > 
> > int kgdb_arch_init(void)
> > {
> >      union mips_instruction insn = {
> >          .r_format = {
> >              .opcode = spec_op,
> >              .func    = break_op,
> >          }
> >      };
> >      memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> > 
> > 
> > Can this be done staticaly ?

Something like this ought to do the trick:

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index eb6c0d582626..31eff1bec577 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 	return -1;
 }
 
-struct kgdb_arch arch_kgdb_ops;
+struct kgdb_arch arch_kgdb_ops = {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
+#else
+	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
+#endif
+};
 
 int kgdb_arch_init(void)
 {
-	union mips_instruction insn = {
-		.r_format = {
-			.opcode = spec_op,
-			.func	= break_op,
-		}
-	};
-	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
-
 	register_die_notifier(&kgdb_notifier);
 
 	return 0;

Thanks,
    Paul
