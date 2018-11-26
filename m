Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 19:24:17 +0100 (CET)
Received: from mail-eopbgr780111.outbound.protection.outlook.com ([40.107.78.111]:52303
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993828AbeKZSWriVZfw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 19:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VrLJL1fUNLob4gjx0JGBhPj/sWQFKgzuwcXY0sUzWI=;
 b=WjtQQx75Kj12rT+UTDB4myq97XBbZK26iIOoFLr2clDK3UefitVhXldxSRq2OarGLP5EJ/yX/cCi1H0gVnVyolJPmF1OOqcBVOuK17hlpJtKCfjsREzGEi6SQRmr4534sGvsQ+lRx49wyG/TbJTg9sQQT3vXkrDyYQAokp+2xKg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1344.namprd22.prod.outlook.com (10.174.162.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 18:22:45 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 18:22:45 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Enable dead code elimination
Thread-Topic: [PATCH] MIPS: Enable dead code elimination
Thread-Index: AQHUgeUSZdktL+pHu0CuQIGgjSaL2qViZkIA
Date:   Mon, 26 Nov 2018 18:22:45 +0000
Message-ID: <MWHPR2201MB12771CB00C8821F0FC62B94EC1D70@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181121215623.31911-1-paul.burton@mips.com>
In-Reply-To: <20181121215623.31911-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0046.namprd07.prod.outlook.com (2603:10b6:100::14)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1344;6:twpd+Z7YxzpTXg+8o1Cm2KSUu5MRyhz2dloP3rmn3RGrQUXeDrD9IKvDCoJi3V3cn6ojVcJZK6gikc6PE0sUQL/IKGcOH93oPfCZY299F4NCZ/FCwXaiMiP3ht/faP77I0g+zMaxwhoLx3kPybLgHrjSukqgYST1jxzubvg6Zyu92Egk9F1tAJrmdPiM9Tw7v23rPELqO5PHew2o5KV7HyLub4dceC7x9nWFpBPcsGRZ9QQXKFZsZe3nDLOlnvy4AZj1xfaT7gqQzCfuMePd/370/Fo+zXhmP2PCxKV2JRcCQW9JsB3OO6/NLYJZ0ihqzVYbW9CFOGEKoXEIEUUIYZTHRqsPWlNhD5Y0M5IGRYzL9nrWy/WeP9n500YDt4ZAWJeZfYYzXYr4yWdweh7XdSmpO9lMgWhrpnDeLLPqCkH7MoBkROKi8DrvZ9ICkWzc0a90JimfpYJ5Iw8FAIJEQw==;5:RTNasPgd16/EF50YCEWxv4z4dRvEnQREWdHLFrTsjhUm1gX0GdsXPY5kU9nr7zLFlXsF084Xij8maU6BNitZrEwmukY5Cp/5vvjUthIi0X6AsFZc+TFZu5PdoUxosHPGRNI75497qJ0yx1vmgYdQ6xZgvxC/HxVLsXfsVkCGwMU=;7:W6h9qPB54TSEWjKaPWypnUep2Zc7UR2Es5KWaM2iALgisBlmM7gLo05KmN721cmF2DeIXUNuO0NoIaADobCp/n5yLq3En5wplyckxDecCYsTdmzAZ6aN/KZuYJujBwcNa6in708hDcJSUmWeXul3OA==
x-ms-office365-filtering-correlation-id: 09693b6f-0b37-4e78-5be5-08d653cc2981
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1344;
x-ms-traffictypediagnostic: MWHPR2201MB1344:
x-microsoft-antispam-prvs: <MWHPR2201MB1344DAEEF92DBDD6D69F695CC1D70@MWHPR2201MB1344.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1344;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1344;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39840400004)(189003)(199004)(8936002)(6436002)(66066001)(71200400001)(25786009)(68736007)(71190400001)(81166006)(8676002)(81156014)(229853002)(256004)(14444005)(478600001)(446003)(44832011)(55016002)(6506007)(33656002)(316002)(386003)(11346002)(6862004)(42882007)(97736004)(105586002)(186003)(6116002)(3846002)(5660300001)(102836004)(476003)(486006)(74316002)(106356001)(54906003)(7736002)(305945005)(6246003)(76176011)(26005)(2906002)(99286004)(9686003)(4326008)(7696005)(52116002)(14454004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1344;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0suCbDa7zLp0yebjfrNHkCncZZU6oxNBzt4dc4N0UPP6zn8+Tbs00phbLf8RdR4ThFyG7TnrkwmYSU/lO4l22Kp5qp1Zj2TI0v8B7cFcbKO9NQ+1HGeUnQ5FlzzTxy30cf8LPRnAs7TyenRDR49bwQGMQjmgCggZaik3bHNwYdhsc4B/YrTwcV3TeqnPGMAxtEoA8Ob2d8VTafm6LslR4NUoXI2nV3yIQ0pd/DlsBqvZ8q2ojk6Fem73QJKu0pCx1X/aThSPycAxQEjxFhzLoMZTjv7+VXdQ3ZlGW5NjAShunCn/rBSwxXi1v1rTPlVsAHFk0nMuDkYODzzUuHANbc14PTKXSNKOcTss6N/5p1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09693b6f-0b37-4e78-5be5-08d653cc2981
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 18:22:45.6937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1344
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67515
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
> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for MIPS, allowing the
> user to enable dead code elimination. In order for this to work, ensure
> that we keep the data bus exception table & the machine list by
> annotating them with KEEP.
> 
> This shrinks both 32r2el_defconfig & 64r6el_defconfig builds by ~6%, as
> shown by numbers from scripts/bloat-o-meter:
> 
> | 32r2el_defconfig | 64r6el_defconfig
> --------|------------------|------------------
> No DCE | 8919864          | 8286307
> DCE | 8338988 (-6.51%) | 7741808 (-6.57%)
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: linux-mips@linux-mips.org

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
