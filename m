Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 23:12:15 +0100 (CET)
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:34367
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993663AbeKTWLSMQli2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 23:11:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGJHHXSY+NgD+UL6Q4holM+jw+C0LWO1NCCuoChi0Iw=;
 b=NzI1hITBbPnLeUYOXKI+8RkygY3odaGFgDS0cd1zhX6d0GGUo+Ymn94fRI/Z6+3ExtGZ6BsFZQfDdVs5wDGdrw/we0SMT138v96J25msY8olF5k1WKsZXhhKXLiGPq9Pklh3zdSqCF5M14SPAY7yGxRCjcmU04G77VhB9FfGHgs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1534.namprd22.prod.outlook.com (10.174.170.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 20 Nov 2018 22:11:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 22:11:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 2 . 6 . 36+" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 5/8] MIPS: Align kernel load address to 64KB
Thread-Topic: [PATCH V5 5/8] MIPS: Align kernel load address to 64KB
Thread-Index: AQHUgR30IVevJDwGf0qwXA2cGsw1Xg==
Date:   Tue, 20 Nov 2018 22:11:15 +0000
Message-ID: <MWHPR2201MB1277489B15D7A3C78862C184C1D90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1542268439-4146-6-git-send-email-chenhc@lemote.com>
In-Reply-To: <1542268439-4146-6-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0006.namprd17.prod.outlook.com
 (2603:10b6:301:14::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1534;6:2Ne/cZT0o5XsA3pyNBvnDvVZnr5ip21W64GSHw33HUPP9ycKUTTNADm3bVFlXUcJ+ff0z2B6lfn34inMCRc6iQQ1pN9LLineeLCDu2k0OMmjDzwFu8yryvx6iEBp/6qY14XOP2j5NN6bwWlBV4FW1xYytPF9xkw6q6M5R8eGEqE7Sg36PHyduRt0zj+xYT/dQKYhbqnf0dzHMHV8wyjR/T8sgbrFjcjWrucirmnYzjNIoyXonasEyaHiLgP+016qkKG+nSbNpm5qMxWhonnbqp0rVmwmJjofPTdQ0dlTQPGC8TO4qfc7WGNZj785kymZkYU0zqL8jLy/L65RN11cycwrep3TqJ1oa9njpdnLO42u9NV1jWLxOMWGcWjW0Ow4PbIGzzVBFVICJROkPQ3fWOymNg/2rzA5iu4EiVsbcswhJL4Tl57qHY1iV9nnoMghdNBImvef0T1tw7/Aq6r5uw==;5:oOm1uiMXaXwiOC25AfkgIjsY1Lz475qb+NSNO3P26qPWqF6pGicuO6vgJfRE7x16neBkSXwOx0aGlzm7CjyoQ+RbelYOeCFNtlQYt7mtCAk594J16Pf//rgdmh0vCxGOcizNXrICnnirZADH95LyNlf4+FllHJF/73ttx3HEpeg=;7:os2pjOk5FR1QT1Ra9r1M5vV0drPOMdtIhlsgG1ixrgKbZrkf3evgGdvKM2J/WC7FxqGMZrtLcju0TIQ+3/Q2Xc/JmBeO6Kuc0Ha+QmG70K4OZ1f3U/Pb59FekfiaWw2cDtByL4zefEYu3bQR8DObMA==
x-ms-office365-filtering-correlation-id: 75a19c82-b857-45bf-191a-08d64f3516e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1534;
x-ms-traffictypediagnostic: MWHPR2201MB1534:
x-microsoft-antispam-prvs: <MWHPR2201MB1534FB35186C7767FC66C68AC1D90@MWHPR2201MB1534.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1534;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1534;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(54906003)(44832011)(476003)(42882007)(6246003)(71200400001)(71190400001)(386003)(8676002)(6506007)(14454004)(7736002)(53936002)(8936002)(186003)(11346002)(486006)(9686003)(55016002)(316002)(81156014)(81166006)(6916009)(446003)(229853002)(256004)(105586002)(106356001)(2900100001)(68736007)(508600001)(3846002)(6116002)(6436002)(97736004)(5660300001)(33656002)(25786009)(66066001)(26005)(102836004)(305945005)(4326008)(39060400002)(76176011)(99286004)(7696005)(74316002)(52116002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1534;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NmSTEOKlO1AkWRnhO3IS3BBluttIYTkrjA//PM0SEmHOkhAF4XOdKILSTs+tWG+MQrLSCZWaJzF3Q9rw89t1KIj16SaxBO6rlb8/dqrivpKZXDjxoLU1Gfv1XM59xOeMlH72b+80EYhUMbTxr+KgT+dLFSdWOeqrWgB/ETjdf8XBw62UCXKSct7JxrBrvO5hmP9LbGUUrzt1eNNRyLoWuDSwn68LKFNZ5gujZvJBZzLY0VELB/0+mFEJ+uPsPMj8quYFiKG/vWsIdQ+4n4dFFPTkN4cEW1oKGC7w31w2G00iCJf7Ai21FloHgxYh6nJjOfFf0iEQTYsjORwGqQ+zlMa2s3b7isSFhw/poEpqlHw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a19c82-b857-45bf-191a-08d64f3516e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 22:11:15.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1534
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67412
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

Huacai Chen wrote:
> KEXEC needs the new kernel's load address to be aligned on a page
> boundary (see sanity_check_segment_list()), but on MIPS the default
> vmlinuz load address is only explicitly aligned to 16 bytes.
> 
> Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
> the alignment calculated by calc_vmlinuz_load_addr to 64KB.
> 
> Cc: <stable@vger.kernel.org>  # 2.6.36+
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
