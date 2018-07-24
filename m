Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 20:16:25 +0200 (CEST)
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:10304
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXSQV2TBJM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 20:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVPo4G77KF8PiwBOYYTZX3GTb3kl4w11VUyzRD8Angk=;
 b=LPvxHqgcE+9mHbmJhm7TBagAGbtx//7hxKR5w/kE6tMWwc6qZBFd/92fmVjKEcS203ekVGSjGevD80Y3LVv7cn9gve+NKFX2ZJ0Fp44cmJy/AO+QbxKkNzbsgqiPQlqTj6feqXL764UFx+umk/Y0Vzx8VU01zMpoS2TlSbqOhd8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 18:16:10 +0000
Date:   Tue, 24 Jul 2018 11:16:06 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] checks: Detect cascoda,ca8210 extclock-gpio
 false-positive
Message-ID: <20180724181606.jzho44vbpzjbux4d@pburton-laptop>
References: <20180724000647.okbjmghv4w66bl7u@pburton-laptop>
 <20180724180940.20249-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724180940.20249-1-paul.burton@mips.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0002.namprd20.prod.outlook.com
 (2603:10b6:301:15::12) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee0ac4e-4e7b-493b-c59d-08d5f19188af
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:fP9Pr+GIJJRpaXsPzBcou/SfQfY9A/mG32Vu+3uPoziXcYd+ppVDKSPOKBreofcxXB4a4rjG6yh/wom20e4RILBw6Ifh9Yg0fFi5xDAbt6+3rRzj4cTIqanXjsgRiegCYB7uq8qyPjVlUdHv01medB9Gn9Nc9Yf5HZERNfWdH4UxzdS4n+Br+hpk+VU0S+fGG3FtyQpGErzap8eiFeIR1rXJQ1A0Swhzn6miASKkiQUkwz5SqkJx8iYFQ++F76bF;25:7Ym0ScU1ypz8lPj3lZ9wOu8j5s26+oWpfN9EH3sY89CDKWfz8miNE2n7Q++kjY/PQLELb0Bmw4WB0IEgFACG6LdZ78TYxbN07fh7Q6erSMocBcZ3wKU0yQO564fCeiFUuEobeXSIweiOvb4ygpGBJTkAXZc8TvzuSUNokBJFk13bbvDSSsRQBGXFcRMJ7zJuuFCvfqFDOG8tW2TpjDDe2/CVKJzu7cFCKWltctvSAWuw5nxpmJDIPmxRCwIUtiU1kJVjkQjSOS9SUF/nc/1zSutpDXardh5ZodCdXuHigcPG1wcmkIvHOpXspUb6s3W4+CT4+O568RyHbHcwHJfe4A==;31:QukhxITz98V+POBoukoek0TQzdP1K8P4AZTWT6+TiIOB1EzchJnoTXB3ed4lOYNulzMU3ARSljJpdQTw2mp4XOG3qRuMubPIjjI+Gz5FhPsubd6ZDYwwnuYHJYxuFfEew/RCIJ2i0EdfpySzFbnKTmCDzU6vjKCrTzVBeV43dOI1zJgBkvSAeCsuOYvfYXMyF8+f2AxBqCciwpV/jAQxM2gR9fOusvyEq9tzLH0lOOg=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:Y62CQOyGV98tMlMT69NB3d8heKFSCDxa6k6zKSsJep7dAxAxvMP5f2DjWprhSyk1LHtPe01EQOpO1iA+ytIZATQVrWY+T4aZcKtmPKqaxWw7mxN1F47kIut2aKsL0pODk3qaawwy06FkVhJFJcl2diyVoTuhrNcy/S8LtTK8RhONMLuqiur0/klElxNf9zsMjH22FhkOGrzc3Z4OIEhHWAGKk49PNxc1Fc9OpdaoAFdd2ve+XyPloc/8sUyYTKBz;4:D1IXLLf0L6x2CDuf+L4xrn8GBlBXWgm4zoHeAX2P3oBOdw54k/N4i5348z7IohI2fn3w2VNJj8fh9mKrKA0Z254fvn3eMbwBurOYaYk5iTdlXrK/OewghQDz7akZ1VYXc/PuwQEcKjlXCQt8gaZRh5H0S220JtnWhHBrK8DlNyreJfTP+G3BYH3HEO9vXRRmTxe3zKiHHPB3jmQ0tIRlIX2dvWSgjyyKaJx0wa/AARL2w5MqkCsoO9kRyPYvfKWx59jknPDLB1xpURmpRVvqRA==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49341E1F161B5CDEE3782E6AC1550@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(396003)(366004)(136003)(39850400004)(376002)(189003)(53754006)(199004)(50466002)(386003)(2906002)(105586002)(305945005)(16526019)(186003)(76506005)(5660300001)(476003)(106356001)(8936002)(6666003)(446003)(68736007)(52116002)(7736002)(11346002)(4326008)(8676002)(26005)(9686003)(42882007)(33896004)(478600001)(956004)(25786009)(316002)(66066001)(33716001)(6246003)(54906003)(110136005)(53936002)(1076002)(229853002)(58126008)(44832011)(97736004)(6486002)(6496006)(81166006)(486006)(76176011)(3846002)(6116002)(47776003)(23726003)(16586007)(81156014)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:delagZ6+DeqeXfHy6ZiFdR2js8vOEfewYFql4XTnD?=
 =?us-ascii?Q?lFnNnVps6xrj/JTBMTCRbWtzfbng0RhFTf9C9KntHTHEfJzq1vlosSQLhn86?=
 =?us-ascii?Q?iRA7hYWQ5stVHtv8goLsDgMoqOerorol9ggyFxZbkee95ep1DutqyGD53Un2?=
 =?us-ascii?Q?0cJ8WAs79paQYpk4pQpHXuncZaRYixF+Pt4G2xYhCO/8VpCDYyQtUJ2Ekmoq?=
 =?us-ascii?Q?nGl9iyUo8RQJeIK6X7UZSiWTQ+weqGfclaW1Td8wuXDyagb1K7wJ5+y2h9a8?=
 =?us-ascii?Q?pD6uXks+py3XCRgNFt3jnIk4IOs8pr6HdFP5D7pxlawrOZYbDZlQjdzm9NL5?=
 =?us-ascii?Q?qNIjjNitfsua/+jK0VcxvQzeoKU/DTdSP5F4z75BpY4v7hxUcOKIE64ZW3M6?=
 =?us-ascii?Q?3bhOhGJ4jJ3wzxJlJ+JJb0ppdfHOn7X8O4rX99nChjsoxUzQ7qoWS4oWI3Xq?=
 =?us-ascii?Q?Jv7sRPnhLVlgk70A0Sp1aHEMO5oeDhhrs+1sgH+pbYawRPUogKVQl8qgTKid?=
 =?us-ascii?Q?qGaMH5VzsJ/FVSoAZEY6CTv7dtr63LNuOhH62fsGpQ5p5KJoF0bGm28/uWlZ?=
 =?us-ascii?Q?Dif6HwdBukBzA4Vo5Y4smj2nboJyMKgqB23NaOCrv9LqwYaAcXMMfwmV8CRQ?=
 =?us-ascii?Q?qeMo4b735KaSYPd/SDDgXtMkxZJ7Cs4xNKGnmzXkfi/FyJtBu0ZTfURE+IWM?=
 =?us-ascii?Q?cqYSlrBg3UWccvkza5SGTPg28+oMEN/OUNQVgDMWd7NMrVn+FRbOZ9n5wuN/?=
 =?us-ascii?Q?U+viUETsoA/zBG3GYeQnWxZiru4avX+DHIHOvuMxZ4X7A8+LXW/2X/MRbwn1?=
 =?us-ascii?Q?xLFux3PgXUEhvm+CaLd8ReDvCT1d+NoeLN5zZWvVZE4CxlB2U8qpTRSDoVtV?=
 =?us-ascii?Q?XxIeZeVWBpuYss2kLNlPbQvq1Ppp6L3GsagS2eYcRoxkiwcwRzP1CzBGUHYv?=
 =?us-ascii?Q?tIMKIW5epv2BiFbf/tU0UiEE4ywVw9b27QP6AhnactFVtNWylr6PLQJ7oJje?=
 =?us-ascii?Q?sCOzRidZkqxLeKNETSgd4Ysc7gYeJH94tw0SpGwANLcBXXie7vItLTN9uEfZ?=
 =?us-ascii?Q?peWLjjO3qhQnSDUmkWQ7UEvnSiPVtqQaMT53MBVTUhjL6fRzMmPwNdP0dToH?=
 =?us-ascii?Q?aqVaZ9Ay7KGp9ZNUWrX69sBVsnFHJ6rYL5KHQfnjhhO9LJ589J3TMhst4ytJ?=
 =?us-ascii?Q?t3bhdS1eM788ZADSm1KLnlIhLhAJ4oIgxNO57CSyqJSQ6t8fBN0b2bP/qk6J?=
 =?us-ascii?Q?wI0pvBgOsmv2TeMD/3EpWxy2GIIEkaKCY36NG4bUP5BECLIq16lgzj7NG1RA?=
 =?us-ascii?Q?o8EPInMJOq2+7JA1WI+AOoJMV8M5uZGtAwyIIILGAuewBVj5SD71OtPNNaJG?=
 =?us-ascii?Q?PDe2Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: OzUp6dh4AfkbwzoOyW641i34a8auZuLB0CaiGD7hOn5aY0Aqbdx50RFe5GFv9wl24QuMKSLUI9CFyanffjIRWsNOpiZteN326N/EHZmo7Ji+uKLPU2p0IjLaLTuS2wpV4xkBFcFq/NmAjqiYy1pYRs0vREi6GMqjguVoC5mYrqQy72mAi3sZbgyn3aKLuOrrQ+32Xxmp+TNR25Ps/sIutweDcCZGAdA4rmpvmdYV26D/JXhSDatVsRe1x4706tnomt6Dht2Kw0Vyek3N4lF4YtgsVekzX4ehAFPChNQtg88sdexGPUM+q55uaCeqVImmC24c4u3B7vf+9AWGFEHssGqYhtFchfLkCwVJ3vBu5O8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:ucYd2bwEhAVQs6jhyUmmchAubiL/wG0ghB0Wupm3/S+arcQUE/vCbv09SsoWUmfORUr5x7Kark3Xa34226gwJie753Lb5b6E9F9W/oraogvb5b2xnNJyu3txMVLU1pkodxfh3u4AggfPy/fcsDXukPi6JoEZMhLi0XAdYrIPJ4hwdeTqLdaPjLloXzAfz7rG1YD6Oyp1IvKDOIrgPBUal2mfocraUYQSTN16A6d4igARhnvHD5pReEGQDBn4FIrHezaSgQ8yrUdKxRRBCCTSSPXgh7ZuTJO9pd/+CgGh2hQAEaVJTN8bj7wAQhwB8KokWztdIhab38zqbAWazaV3AEm57Uzkr0o/d0oqiV6ATt9qS3vrxP1Uyva08gLeDyN2d9Ga6XWSoJ0pKvPIQDIxU6EsKm+W6piO4JUrTOKFeomNPg3+1mWJIyaCA2IWSFMibHcysCDW/klwctsvyEq/Sg==;5:D3IP+pQmTlyjXv9CLVPMymDXKKaqVXGKYATnU8VlKZp0ZJ+Ia+1vxz7jaUHMAvPoJPK6DR8i76P/j2IQyhzNm9OkBaScG9N4SExxmBulTPb4TGjSwGM+WRP3x5NWF9D+xpt7lpqXzWeCIIoQ6e4oA9pAKmfiursbuIwAYTkiVfw=;7:YHcfvdByeB39uE6M0HxUoN0lRTUGRPi5Lh2fHZr8A2RjNakA35sLmchdjKSVJ15Ee93NhYsdEC7pE783IjlCs5dU6Z6JT+4yxG66aacKn1Gj2fNQHOVgf90D8f3bnUOd52TSJh5n8sYuT0kMuQCLE6vXl4RO0iScsaeT8JGsmIF+D4Mf92JYuO52Od+NASkfBAVHf64GsVnHwoFXhxzdyB3hEJRgfKYnK7EMRcF3EvQlNd/FAU6J5GfiSzRbG8Sz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 18:16:10.6847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee0ac4e-4e7b-493b-c59d-08d5f19188af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65091
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

Hi all,

On Tue, Jul 24, 2018 at 11:09:40AM -0700, Paul Burton wrote:
> @@ -1273,6 +1274,21 @@ static bool prop_is_gpio(struct property *prop)
>  	if (!(streq(str, "gpios") || streq(str, "gpio")))
>  		return false;
>  
> +	/*
> +	 * *-gpios and *-gpio can appear in property names,
> +	 * so skip over any false matches.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(false_positives); i++) {
> +		if (strstr(prop->name, false_positives[i].prop))
> +			return false;

Of course as soon as I hit send I noticed this is strstr(), not
strcmp(), and this probably doesn't make much sense... Please ignore.

Thanks,
    Paul
