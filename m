Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 19:21:35 +0100 (CET)
Received: from mail-eopbgr760102.outbound.protection.outlook.com ([40.107.76.102]:63940
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993843AbeKUSVaunvA0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 19:21:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok5hctxTqq529bS7+opVkFUBJ7JMnIfNPNOoXQ/DRdM=;
 b=eSiOqh2+/w2oH2pV9Ps9OtxBZv4hJlonM3y4PYMfiuo/4lRuiKWvXU2yCP2MD6nfwApDiH4Xd/R/Od2qnekmVTSmnjH0fUEURcNzK3xZ6RSEExn3kOjCQmz+Vc/+9bSVZN376UyQl+dQBT0an2ttJhIU+hKbBRmxkhuelpaThyw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 18:21:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 18:21:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: ptrace: introduce NT_MIPS_MSA regset
Thread-Topic: [PATCH] MIPS: ptrace: introduce NT_MIPS_MSA regset
Thread-Index: AQHUgRFbxR/ChQn56EC3U5mxWwKQE6Vai+QA
Date:   Wed, 21 Nov 2018 18:21:27 +0000
Message-ID: <MWHPR2201MB1277D840F8AA64489C302390C1DA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181120204049.19153-1-paul.burton@mips.com>
In-Reply-To: <20181120204049.19153-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:OiCV92aejC+09n01BFApi27Pix3XGpQO848J+WxknV4i46zZ69qGWyG1rcXFwSoN5Hi7gNAzh+xIOsbWLUZm6eXL0Y8ZlbPPsmp/HxVLQa756rcvl3+6KWkuIx2o1dsoaQiJ0ba9hhZvXftqHm5+g4mOOTUOqcd0EdiaJn3Zi/F7HqBPxxqJXy0Ho6VPrnKaMGVAv8foVolEIhYJMtbZR9e1JqPwOCAC6H9DKKSgjpo2jJrjl7pMnURB+bYHdDoHCD6NX4crsqUIyOA41OE4dUWkMvW4TLb47cmy8pkNUfLq0BdX7NEyL27KIGVMuIcHn2RaqHDiY32R+3BTZkc2jt4FyxJVcAenY8cqyTnGrMep5BaJW3C1uqz2U4uLQRQ1Thjp94XhrphOn3JFbXuGCHf9H/0qg7BMVBV//5Qu1OzoeTqgXNzp1bjYCeGdNHap/eXNJE5xuWq7kTO8YIk2SQ==;5:T3qLe+j00pCvSJ9IlkVTnHzV4drFYJMTz3SBzUsvRbTceiuRavpxPoo8A35pcud7kSH1YWUvt3y72OS8D4Qmo68XjlzdLYRTh1HIAT6A+2cO+s20Ut6UgFqXL+h6VY8x724fN4LBSyLbavNsipvDIOB8Mc1H6MHHWyB2o+BPV2U=;7:vw+9StN0rI5EVXIlaeMGveKYETSGAs1tv3Zzh8bqQFFlt1tu6FRDdj7SkFE3gCGZxnGbLRZaamnNEENcweSLhou1r1/TyQhyH50e9lrAIDhJ7f8Op91i4P38Hkv7QeB65b2sKlDhNF/o/NceT1nLCg==
x-ms-office365-filtering-correlation-id: 7f19bc21-d8a2-4db3-0561-08d64fde26ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB111996479795A80820A3AA19C1DA0@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(7696005)(52116002)(76176011)(3846002)(2900100001)(6116002)(25786009)(5660300001)(99286004)(6246003)(9686003)(2906002)(229853002)(53936002)(55016002)(478600001)(33656002)(71190400001)(71200400001)(105586002)(66066001)(386003)(6506007)(42882007)(106356001)(97736004)(14444005)(476003)(7736002)(102836004)(486006)(4326008)(8936002)(6862004)(26005)(54906003)(44832011)(81166006)(81156014)(316002)(74316002)(8676002)(6436002)(305945005)(446003)(186003)(14454004)(68736007)(256004)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DKRir9EWHYwdCYHlJkQiOLIj/RZQ0RqW2ks8b4janwwZnAlLUz0bvQnEEaHREUY3hNXtqRsgCCPR0pHWu1B0r9YaOyUWF8bfML5oIIom8OwFsnAlK+EDZfBEbxM3oZcuYK9NfoXAhwyaxBpGmcaLQGLdNQAj01RP6eAZLxWzBDzVk+4FLmLJmni3isnIxFSp/OOqcAFtZkP1ubUzWG8C5i/ejuAW0mriPfnsTeMvx3c8v526qKcBoIYFcmcthmWeKlcWld1ZeaXssxYBz9NAJN11PO+RyGeH5IXx3lEMShe+RIha7qCxSAIIIKUQk3hT7+xz4/aI2yDKN+wjHHyvLsIC1bVciYgRdP6zyxKW40g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f19bc21-d8a2-4db3-0561-08d64fde26ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 18:21:27.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67419
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
> The current methods for obtaining FP context via ptrace only provide
> either 32 or 64 bits per data register. With MSA, where vector registers
> are aliased with scalar FP data registers, those registers are 128 bits
> wide. Thus a new mechanism is required for userland to access those
> registers via ptrace. This patch introduces an NT_MIPS_MSA regset which
> provides, in this order:
> 
> - The full 128 bits value of each vector register, in native
> endianness saved as though elements are doubles. That is, the format
> of each vector register is as would be obtained by saving it to
> memory using an st.d instruction.
> 
> - The 32 bit scalar FP implementation register (FIR).
> 
> - The 32 bit scalar FP control & status register (FCSR).
> 
> - The 32 bit MSA implementation register (MSAIR).
> 
> - The 32 bit MSA control & status register (MSACSR).
> 
> The provision of the FIR & FCSR registers in addition to the MSA
> equivalents allows scalar FP context to be retrieved as a subset of
> the context available via this regset. Along with the MSA equivalents
> they also nicely form the final 128 bit "register" of the regset.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
