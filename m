Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 00:58:58 +0200 (CEST)
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:26400
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbeIRW6zfR-N9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 00:58:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhbxYDOaptTmp9cRQNz9h4xtT/DRVyTzA2WJ2Ec0uhc=;
 b=pzu8mwD8P+baF9X90t/eNbODJG9sC056xGwLzr9pF7fMic+IByLhIQX9cbgj/lhvOIHODxIJ17kCvQyoizl0XMPML93hQtPxzxYrwLVEJydlYannnhliuO3ayPf5huUTSWhkmME54iImptXotWvUyWEHCMd6G5gJnUdz91KcMyI=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4551.namprd08.prod.outlook.com (52.135.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Tue, 18 Sep 2018 22:58:44 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 22:58:44 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH 1/2] MIPS/PCI: Call pcie_bus_configure_settings() to set
 MPS/MRRS
Thread-Topic: [PATCH 1/2] MIPS/PCI: Call pcie_bus_configure_settings() to set
 MPS/MRRS
Thread-Index: AQHUTLlcOPX2626J80C554399F2YUqT2rNaA
Date:   Tue, 18 Sep 2018 22:58:43 +0000
Message-ID: <20180918225841.7ucrmpof7yuoxah7@pburton-laptop>
References: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR1101CA0018.namprd11.prod.outlook.com
 (2603:10b6:910:15::28) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4551;6:7Vz/f8jRdIH80kpym/IyfdOKHz5+w1Xg4Z5gDMzq7WTd9h0jEPBf7k/ckxxmdpOpS2VBxIcnNU/3dAsv5CXQB4o6GfyIx845WeDUPJw4x0WzAPssJBjVu8MII+oj7uBTFQmX8UqtbrlO4DKKtiqj2MJGjQRTiE1dk1D3AGpxCVLH8dLnCwQtfDuGQ+elSi2fhb8vLQIfu/rRWZEdKFHtprxJFVUwrYoHvpAMlg7fXGgEjSo/7X8kFfYtTR4t1uJecgaN3FgUvXXRwRln4F8nUhSLu7btL2ri3KtkNkcREvilew290FbY9QSRKLMsmKYCilmm7ypXDP32N5YXpgjmZfJyEt07TgyTBhD0PCGyWdbdvROMMcgaZcL7+F0YI6lwRmFgWlUzAdGFywGeyk1iQwtJJp4tbT9jhPrg2rNPqvWZfD+mJX+2j3xaBmP2TzAYUXbYABpl7Rlh6Z7Lm71csg==;5:3juud8mb8cBK9o6CSko/jc2xmW4eU+Dmk6x3cIUvvkOuS2mXolRBmT97kJg9FlplcAHOuMkh41FIv8QwzWznQOwP7diCuNDWA8jNnv9GLHES9a3UivJctpK5npv4wHxyC6/5K6Y0iOt8BFOCjem7pxFNaFdP8P8WMfJAPx1IwTU=;7:y3HGcTirvWFpDPvBxVt2Yd8Pr9wKvNuvTtlEkFKQbgUZNbURos3vQUzF2nA6OSL89KPvfF3dFP6hYc485Ac18OSIqyCZ7mvgGYzJESC062KlVgBkkHznxJW6xwPLJtVSqE/xWCo/wb8rRWPbWEELoY0bIcEWZByPJKJHoAdqV8ADWFmNdKvPYmez23KQXHyNvrhoNaO3ip72FsPAqAItE6T6oJ29tu7ycPm16JjFyVkr6Wvrkel54MPNz9pKd6L5
x-ms-office365-filtering-correlation-id: 3b0156e5-4824-4141-71ef-08d61dba4811
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4551;
x-ms-traffictypediagnostic: BYAPR08MB4551:
x-microsoft-antispam-prvs: <BYAPR08MB45514B4E037D9057A89F02E3C11D0@BYAPR08MB4551.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:BYAPR08MB4551;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4551;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(39850400004)(396003)(346002)(366004)(199004)(189003)(256004)(33896004)(11346002)(99286004)(42882007)(53936002)(6246003)(446003)(186003)(6486002)(229853002)(25786009)(76176011)(6436002)(44832011)(52116002)(26005)(66066001)(2900100001)(5250100002)(54906003)(486006)(58126008)(102836004)(4326008)(476003)(97736004)(386003)(6506007)(9686003)(6512007)(316002)(39060400002)(106356001)(2906002)(81156014)(81166006)(8936002)(7736002)(105586002)(33716001)(305945005)(6916009)(14454004)(8676002)(68736007)(1076002)(5660300001)(478600001)(6116002)(3846002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4551;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nZQO6UjDpTJJsLAEA7VkqxUuerIkKwx8eAIKS9+AE0QQXSHLeXRdtbkbKQWmdc4BeN48+/y7EkeDJGsdOvPWXd8qBdFOG8Cux6EnF8xasyGewrVywkaChpddMuL7l3vWQbgptoAz9Jqz7HJmc8ClmiEmU4S+nn7SrjCXIvgbWMXG5EPomUJXLamMlb7zDVhcZjecV/UHNU+bth2PcCqCuoDuH6fhLDjpvO4yUNj/GAE97qADY7PX1NwAAFqCB++YNMT9kPwCnDTBrF1EaT9qHHwLAD0yxS/uHNdfisxDqyDU/6uRuumXvN+Md6/QsvmvDaCNIeYELDLZtLStw9m+6HK6LWPKsR9acH1sZIvkbPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD825DD2A2ABF441B158EEF749511455@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0156e5-4824-4141-71ef-08d61dba4811
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 22:58:44.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4551
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66400
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

On Sat, Sep 15, 2018 at 02:01:12PM +0800, Huacai Chen wrote:
> Call pcie_bus_configure_settings() on MIPS, like for other platforms.
> The function pcie_bus_configure_settings() makes sure the MPS (Max
> Payload Size) across the bus is uniform and provides the ability to
> tune the MRSS (Max Read Request Size) and MPS (Max Payload Size) to
> higher performance values. Some devices will not operate properly if
> these aren't set correctly because the firmware doesn't always do it.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/pci/pci-legacy.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks - applied to mips-next for 4.20.

Paul
