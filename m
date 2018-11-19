Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 22:20:08 +0100 (CET)
Received: from mail-eopbgr770128.outbound.protection.outlook.com ([40.107.77.128]:22496
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992716AbeKSVRv2FeVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 22:17:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KevPPbak4+wL6spoFilkyulI4PewqKXZTxd5IfsEBE=;
 b=k3AWjbEMvspGVxy9ZGqQtBphX0KGA9nG7l+q0a8lRLRLmOgquS5RMVZN8lKMZD90U5DaCsoCzl4x+ilk2DMkt3CrdHQMRs3YRmIilcBOypwzU4iLTGA6ctuLms9IxILLGpg8wfZhzGXJJM6RVzEm0gylfhAkNFh0nrsrWXFKL68=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1565.namprd22.prod.outlook.com (10.172.63.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 21:17:49 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 21:17:49 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Sean Young <sean@mess.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Remove superfluous check for __linux__
Thread-Topic: [PATCH] MIPS: Remove superfluous check for __linux__
Thread-Index: AQHUfcbKsm9fWZ3QzkCWmZA3XXsKNKVXnxYA
Date:   Mon, 19 Nov 2018 21:17:48 +0000
Message-ID: <MWHPR2201MB1277E62483AFF08E7EFFAF92C1D80@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181116160939.22085-1-sean@mess.org>
In-Reply-To: <20181116160939.22085-1-sean@mess.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:300:12b::13) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1565;6:VVZpX40E+t5/u0d3PKdG3xv6RXYFmlkpQLO3UeB8IOgqjzqMlIKiinOvvFxvnzYV8ftJOXZZKxqqXMH1EWuQCojcpX6q3fSzi0J2OCKKLdtOGluECNBc3phXS3RpZg7+wuT6acb24x65ISTsq7eJwgjETKUWHnF+JlispHLGc2lMdOziXvlfuuD3rqgFYmmmLVP9Iqp8+0fhdlYbmh5W3mIeo6kjr10EvOA7+Q/HlGF1FGGDQoQyCPV1sbNnb+geYqWdynfzS+kJM4pjZbWUSNNWN8ez5eFZ2q7l7y+hVJBGsQds5cDEorlOWb4vq1TL7WNJpWApzV0GQFqGjxKEhWVR9p2S8J3tdi+pu0KVtemWe9G05KwGMlS3jDiKJFn8ir+uEog5phVutf2BoU+PAs+R/QSNQjC1L6ZzR+PlV4irEgv/dOd43OM4/kHDxNxO0mtF2PpnrECTz4h824NeJA==;5:mN9C51BWbcYd+P0JkSGfBo4IwJMCDElr7+RAn7DrzU7KlQe446K/brX79/GJiMshe7qPa0gnVQpgac692nyirszskTNMLDxC6Sp9Y/FSGLFiO6k7wd75Mec/dsmnIWamh9yMvvdHi9Z1N20p25iym9bAsmKAV+R9P8b45+QivXU=;7:89+yHkJ656QmQF+DBEzfXIP2bHMZ+eZCd70aBnQNxkWya3qrbypoG9ipIzn8++QKcEBhkgNs8xpobUmI8gEWavqKCUMqQxkIXBPd5wnYTN3+5sTqqrtrjpDTEZdQ/Y4n5/3JjdLEntpztILKdwLPAg==
x-ms-office365-filtering-correlation-id: 41a8a77a-4cef-4418-d968-08d64e647519
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1565;
x-ms-traffictypediagnostic: MWHPR2201MB1565:
x-microsoft-antispam-prvs: <MWHPR2201MB1565C55830E1D1E2DDA391D4C1D80@MWHPR2201MB1565.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1565;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1565;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(396003)(366004)(376002)(136003)(199004)(189003)(4326008)(25786009)(6506007)(386003)(97736004)(102836004)(5660300001)(68736007)(81156014)(6246003)(71200400001)(256004)(42882007)(2900100001)(9686003)(6306002)(26005)(55016002)(186003)(71190400001)(8676002)(8936002)(76176011)(99286004)(81166006)(14454004)(53936002)(52116002)(7696005)(966005)(508600001)(486006)(476003)(105586002)(2906002)(106356001)(11346002)(44832011)(54906003)(316002)(229853002)(33656002)(6116002)(3846002)(6436002)(305945005)(7736002)(66066001)(6916009)(446003)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1565;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t2fqrB+iXP4LejW75mH4tFyX3Y2A4V8CXchM3pR/xedTBDuyjY9Qc5j6ufkIRYPNIgJzSPsgRVJxXOV3TeJFSCZc8vhU0ARjQ6HNy6bCGr0uJzSSR7oylXDdPTmOAo91X0ZiLcPbJUT1FsxgNWnEpj6pOU2LoMBcX/oljnLF/iQYDMalbcsAWpNYO/um7ucLJQlJOMG1EPZT67BmvlU0e6mLCHxiSRl+IAkpFiOBDiXtlaSih+hFmeUaPpRRH/B8ibqoNn/hVDeYS8k+jEulRcZnbRfTTtAyXOk6f2P0vVaiyOiia2zWiXWYeM/KAQuiOURkC1mr2/oPzpNpHRAhhTIdzEsacTc1N+Mxy0YUuYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a8a77a-4cef-4418-d968-08d64e647519
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 21:17:48.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1565
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67385
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

Sean Young wrote:
> When building BPF code using "clang -target bpf -c", clang does not
> define __linux__.
> 
> To build BPF IR decoders the include linux/lirc.h is needed which
> includes linux/types.h. Currently this workaround is needed:
> 
> https://git.linuxtv.org/v4l-utils.git/commit/?id=dd3ff81f58c4e1e6f33765dc61ad33c48ae6bb07
> 
> This check might otherwise be useful to stop users from using a non-linux
> compiler, but if you're doing that you are going to have a lot more
> trouble anyway.
> 
> Signed-off-by: Sean Young <sean@mess.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
