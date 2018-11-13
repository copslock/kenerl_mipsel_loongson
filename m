Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:23:08 +0100 (CET)
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:6166
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993149AbeKMWW2xwiHu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IavmzCm5gwsVgzHW/OlDjDKvm5iKPl14ycoadVURSCo=;
 b=FO4in9J+nDhZVaCsOeRmWz08sdDigHp/f5OhhNkMyNTMNR7lmqide+CITRJCw+h3Lmg4GbKg7Zs+CWbpj3A8wb1hvaygZdTWxeBVH1/W9xinCxSfPeBW3cX8ygsgFxToxbz9TnGo9DZo7zbkSSlwYyUzx3gWznwHLBmDll9jcmA=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:26 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:26 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Boston: Disable EG20T prefetch
Thread-Topic: [PATCH] MIPS: Boston: Disable EG20T prefetch
Thread-Index: AQHUeIoDHv3bBIoYiEWwubIAC3hot6VOTaGA
Date:   Tue, 13 Nov 2018 22:22:26 +0000
Message-ID: <CY4PR2201MB1272FABB3DDAFDAF3E3800E8C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181110001155.12786-1-paul.burton@mips.com>
In-Reply-To: <20181110001155.12786-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0045.prod.exchangelabs.com (2603:10b6:300:101::31)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:45c8Iwm8iaptQEDItGqLBMxTUu9xDn9fSgudQhz+JTl9xrO9hHJg05EvtyeusCEFyP4U7OF1QZ96S+8EtnUDiKrRvezdWj8aYaOVp5GNX6obKRbU6FfdvXAM7IjopR8l92ZTI83Tb2nsCeGKDmUGK4/nJX0sPrBiYUbirm03JYM5gU99Z+Z8DujHAQKfGJt58HX4qR3pCHG6nGQAcoBcgGmLGl6PjONziMd7DuGXd4YJMdcnqVEDN9QlGSaVerv3DBid011kEsohhuFFviKsEpi6N4HZUXqsJeiIynrzfvL5zbyYr4mvILY3xcV5bLNQNcSXyuIiQJoKbZzYCHZRh81VxwSpOBgHDe8lqlFFxn94pXoeWuG0umyztjwyDdn6ZWCgc0tl0HcWAudVcjCPxPrSJz7BFUpJPEgHKfwKg6tdvA6Mptj6LsJd1YUwoO/EBO+JJ4snguDQmVg2jGCvVA==;5:RtydHiI2dYebphol5U+W54iE0rM8HOpNKFLHjfZBotqVXJTydaEgMNJSxLPhZ9MbDNJfTmPpub/3KIgY7pFewDqnCEoL6Dj2pEsd647E9s2Qya61ce+yLNoddA9nolX6htPt+jwbM17ulnRCIYjnCnQYWlaRtGXASYJRPD8Lh9c=;7:rZYbGXQGjir40BZ9frs5d5pRUUOY/MDNOLnDE8xN+vWmFsBu40XOf/oZStcJJkRiDg8SPEN2KMxcH17TWr3EUaPFMV5pol553L5nHtSh8uW2i9f/Gj0HqT6d4dMzqYmok4cX5G/RGAwvWC94BYnigA==
x-ms-office365-filtering-correlation-id: a8af4206-c711-48c5-cb2f-08d649b67dda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB1350CE77E84C6DCC5AE17E6FC1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(14444005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xE5o0cuQc8dVYRW6CYiPYwjWCtmHSuYmLSAlvthgEOoskpFdnnvgpM5naQCIhDTILrxaq/fHX8JN1FgrBP/8OkrDW5FJrVH6IrAEmAlomaO2QwT/+zLQAR6Kl99PWXBnS7GlJeMRd3pBI80YObU8gshwgsEmXA9khGasWRUk1OXQJDFUzLiq2BrDt0t+mUIqCvCi4mVgVFdSqJmNwfQG/1mawzrWY5URfSuqjyrpN5D6+3+DdUMKk9nCanUR8o4hcxi8qW+JZmzCxxyl/xfO/HJSEsO5N3+F/DLvnoeVBCT3FRlESXCEogMMg6te7vnRpyRlrRWuGXKlbF3donhCdvR6hqdhZzAC3LghHI02pc8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8af4206-c711-48c5-cb2f-08d649b67dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:26.5181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67269
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
> The Intel EG20T Platform Controller Hub used on the MIPS Boston
> development board supports prefetching memory to optimize DMA transfers.
> Unfortunately for unknown reasons this doesn't work well with some MIPS
> CPUs such as the P6600, particularly when using an I/O Coherence Unit
> (IOCU) to provide cache-coherent DMA. In these systems it is common for
> DMA data to be lost, resulting in broken access to EG20T devices such as
> the MMC or SATA controllers.
> 
> Support for a DT property to configure the prefetching was added a while
> back by commit 549ce8f134bd ("misc: pch_phub: Read prefetch value from
> device tree if passed") but we never added the DT snippet to make use of
> it. Add that now in order to disable the prefetching & fix DMA on the
> affected systems.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
