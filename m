Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:19 +0100 (CET)
Received: from mail-eopbgr770105.outbound.protection.outlook.com ([40.107.77.105]:14240
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993032AbeKMWWOTMQ0u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsFKv+oarEcNBKyd2e/K0HoZPvoljYZ1fYvA5UEPstA=;
 b=fmKBcTgOwxSq9mhHmuLoDUz3Z/Iafo27B0r769rn9wSBacmBg+EFy860eu3hRN0C85wVC8nDbMwFsLkh2Htj+rb/ndQh97tZ0LwN9rZ5OAHTe7kjGxcorm9eEQUSAYJ+FYSKFhsLB8wUwatRXK4P5qC5dQZFIgKDpZgL02igQ/0=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:13 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Use Kconfig to select CPU_NO_EFFICIENT_FFS
Thread-Topic: [PATCH 1/2] MIPS: Use Kconfig to select CPU_NO_EFFICIENT_FFS
Thread-Index: AQHUd70Nj7bmBkBSmUuHKRskL/vjkaVOTyqA
Date:   Tue, 13 Nov 2018 22:22:12 +0000
Message-ID: <CY4PR2201MB1272B73DDE21899898EB23BEC1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181108234409.21199-1-paul.burton@mips.com>
In-Reply-To: <20181108234409.21199-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:DpFdykfYRcJuQE2XMQpGJmA6qijJpBxSsOU6yATPflD22nQApDfASXkiCE7QGdSMTZHm760CqtJg6RbDtV009fBuahBjCRzqAynPvn+UT5SZQAFXsRQFrov1gEb4tBydlezR7axqpuikf3PvxkUuEc8Wu+mnOvElW03Q+FPGK3Ggfeu1OIf/ZHtzm4AHPFzJ5jaSgFDJaEYOIPLrt4au54gZUSW5cXRGjUvIcozxLAi+cC34BMdbhRDv31UZoWLAg1fWynbIVVjPSwRtHvY26fTI3vXMTKLD0fOHTE26IkVEYdQkv9jURi413tkGzgchvF9GiEv/d+EgaaoMErNLrxHwB9mXi37iqDsvv8O3jlmJLwa6A13o3ghPayLsfnvha989W0t5bIGUJSa4LtaJTarU6bPvCxSe8/0MI/ZZ9FwzLAkOaIqlTgjGJVzLlcOZRej2FOWQ4duiaeRMwB0ucQ==;5:1ehw31HhaiF/b0uIM+AcnnvN9eous/77uA9TF8jYxTDyC/fG0TLNyQPiz123hVoCv+we7vkd6VIwm2Ic0VuCShnFD+c0OBa7rvBCbqNG/th5IIQHuMKxkTju9eALl7ZZjxljboRgYvrEtRD4toV7hia16DQYyVBCBOjCoykOw+0=;7:tYDyDAZeUsNe1gbI5cHBMMPPzyOllPr/OpyhPhCUl6Q5lPwoytYkzW45UMePpuhiUiI3KLy5k2yKFGk/i0Fpn1UDjtntEe7B1vX+JpBCvkN+Pa9j0J82qLgPj0IVaJ/qmonVyH9YaGBHMg1Gdbq7oA==
x-ms-office365-filtering-correlation-id: 7092aa8a-09ca-4fcb-e398-08d649b675b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB1350E2D609570F1FF8FEC9C9C1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(39060400002)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(14444005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q8Q+/HgZKPhUsVKv4QXqtOFHgsifEPEuqblrWZDC9F7Hb6tEwXVJQk+SRziHYzyQVnVg0vumUsUBMTXFs0rNz0K0r+fViGxHkoFRPU9uzxPDw09gsU9fktNGMt/QdQfIz239h6gYfS0msIteW4FZDvMtmX2ibhyBw8RKQG1dWBdWcZug4qSwc5yg77IWTtmyBahQTPndrl5X08BKWQjaXlMCzPiv7+UFxjspLgqPjEQFQfeLa+IpbTPKxs6z2Vn5hwx7/0wGUCt59g/gG2RkHTxxYT8x7ZdvGIyqAqEetYKtlcv1BajDyx3OpNNpJI9rUDvTmdWXT5tiri7/2xmGdBibo7/q7NOzYNtQRwuNNYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7092aa8a-09ca-4fcb-e398-08d649b675b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:12.9670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67261
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
> Select CONFIG_CPU_NO_EFFICIENT_FFS via Kconfig when the kernel is
> configured for a pre-MIPS32r1 CPU, rather than defining its equivalent
> in asm/cpu-features.h based upon overrides of cpu_has_mips* macros.
> 
> The latter only works if a platform has an cpu-feature-overrides.h
> header which defines cpu_has_mips* macros, which are not generally
> needed. There are many cases where we know that the target ISA for a
> kernel build is MIPS32r1 or later & thus includes the CLZ instruction,
> without requiring any overrides from the platform. Using Kconfig allows
> us to take those into account, and more naturally make a decision about
> instruction support using information about the target ISA.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
