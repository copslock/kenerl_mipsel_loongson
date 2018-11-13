Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:59 +0100 (CET)
Received: from mail-eopbgr770104.outbound.protection.outlook.com ([40.107.77.104]:6416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993112AbeKMWWZlXUqu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH7+T+S+QxigM0uXycytDXpUfIP2xPQQloqmvFYwa7o=;
 b=dXZsy5InDVcYwCzDzHYCfd1jmtySD9u7GhnL8968ZqdPNoZDhPFjrR45qMfxVkeQqpJ+zmRgUzzLwlqKRkvnWjETpUm9mZ4SEWqjFaG1s+YM3L6xY2WCFlKIlph+VpSCHOW8etVhS8cTNUixx5pSbb3H/9/9yE1zbccNsfxWeWQ=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:24 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix do_ade() closing brace indentation
Thread-Topic: [PATCH] MIPS: Fix do_ade() closing brace indentation
Thread-Index: AQHUeGfnVDSHVO5LlkaIa1/QnwM0jqVOTeEA
Date:   Tue, 13 Nov 2018 22:22:24 +0000
Message-ID: <CY4PR2201MB12726DDD6A39A54907B11199C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181109200744.23399-1-paul.burton@mips.com>
In-Reply-To: <20181109200744.23399-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:ShiCND5BmnXsibDSC0wPjVPepieiET7cDc+1/uoA8e441v12FRL4qcdOzYVNs498AXKR3yrnOySS15SF710jk8E2k4GO3NzUNk8XaYOJCI42PbeGqTI2bOffX0dIO6Flgh3alctgs4b8c3v6Rg9iO6ruLmsOzo46FyIyv56d/9+xQQAXzvT7wEVHvfP6nFNxVwayVUseL09geOfOTxosB/4vufFfwj4YgOPxdQ/yktsnwEmr4CI7v3GZxI2mXLtFh1MrIq4dHQj0LL74I4WjLhd2EjibV1OGem9Keix3H8G/843bnZWc/TNUZs8mumRxQk0ElQzt3WdeJ4ioXDErBClRRgh/Ebmqwh/55RyoViVP6JMplJLgQ140FKufR8ICRWPjAb4ipptKSAitTNWk+SIyRNjlIzQEMhorvX3kvlSGhbEn84nni4RT8BJF+Mi8tjg1IqB4TMWXvy+oHoCKBw==;5:Ot0t6QlwUyKh4eUVqqqXYMRCjMejym8DNW8ukQDJFu80Z/88JeZGnKeGPiV9IY+sXWduDcBJNGMuqMJoRroqpgPXpRSU6GRnCJabVyUBaGHqhCqrAFpk/pEJ5CTM8nRkGfJtgmWNideuXwFldYSA+SZBhIoaXW/3LU1zEGZ78Ik=;7:08QxefJa5DDJMoirZosnAiGzcspqrz38EKzEKZQdAlX+cf126MKnzPmhnupzqNhDsRkOTL541Fd27VBPm6zXkwJ4qBpJNEWZ4pEkwta9WYagLjNE4X0Goaory1adb1B1KtqjDI4t59q1sP6pyjic/g==
x-ms-office365-filtering-correlation-id: 57c65a88-4259-4279-d94d-08d649b67c53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB135030EA90FDBCA7B56BCA0AC1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(558084003)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dKwmCIz4QWVvbYK8JOT4hqATrlrhT+VTrrioPDSwZpLwAMQcb1hTc2eE7jUb1oqeeSz8IfxccIVJtuYHy5imufo/lmfHFfm6rC5NgSVjzhF89X405Dzz763jbwUgVar4aiM2NmVF/yUZ93EUqHYLJI9vI2/wHWY2Hu6VXQECdZZwURdmUm+dTc9zVR2GmjqnywBsL2w7rsryEpQH0l8gVx4fHuAbNflWw3siBKF/n6Qia4GGsFu1ePWYWME1us/uc9/HfzRrwC8xvoTLSwx862qsle0eid9erYdFwGzUrSETNolZidwQAG7OHHLUExdjFFqWmXke9EHMVS4h/8OahAjuR7K6kMlvf8GKDmwHuV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c65a88-4259-4279-d94d-08d649b67c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:24.1111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67267
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
> A closing brace in do_ade() has misleading indentation; fix it.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
