Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 12:53:39 +0200 (CEST)
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:35297
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992408AbeF1KxcqukH1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2018 12:53:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=keysighttech.onmicrosoft.com; s=selector1-keysight-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSDUpjkkE7ILhCPQUIzEaWh/soDKv50cewCWKH8F/Qw=;
 b=j9CU0x8+/RjqTgZdEsEX4vs2tEYNt/xsLmkbuf7D+1M0yeot6AFRdlAjdDCxRtFhkLL62csTCQwLgvllmjmTK9Gzv7xTN0QIQxk0A6G+dvXzF1b5Yf8ZxWP4eN/yph7+WYcfKmRiPPX4Tp7jO1cQza0KWP5UW0NPBLKPb2dFtL4=
Received: from BN7PR17MB2244.namprd17.prod.outlook.com (20.176.24.149) by
 BN7PR17MB2148.namprd17.prod.outlook.com (20.176.23.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Thu, 28 Jun 2018 10:53:22 +0000
Received: from BN7PR17MB2244.namprd17.prod.outlook.com
 ([fe80::cd6c:4153:542a:4435]) by BN7PR17MB2244.namprd17.prod.outlook.com
 ([fe80::cd6c:4153:542a:4435%5]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 10:53:22 +0000
From:   <catalin.vasile@keysight.com>
To:     <linux-mips@linux-mips.org>
Subject: Mark kernel page as read-only
Thread-Topic: Mark kernel page as read-only
Thread-Index: AQHUDs4M/GrSAw7490SLqdvZF2prLw==
Date:   Thu, 28 Jun 2018 10:53:22 +0000
Message-ID: <BN7PR17MB22440CB0C1698E7641812FBFF54F0@BN7PR17MB2244.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=catalin.vasile@keysight.com; 
x-originating-ip: [89.136.174.114]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR17MB2148;7:Lb9GE4vXlaMTwRPz1bSRlK0w1Hki3gwTVx9JulpMT+PfbST/Q9tCmYlQ7Psl53msVrZqNmbZXv9BG0UZl5PeaLCU1/bCOwZgIB3VVxbNk6qr+Rk0Dl75UuRH6m1RLd45JyK9v2hYJ5Wz99YF6oTVGuSppKnLi4IHhfvwNncd51H6+0xjLTqCNkil/1shYaYgO1kkN+4/3r3a5ZY1iy3luWCOB6ZVxAgrBfNPuCAHVFqkkNG/NzGyRTsUeiuzlyDd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a334fff0-f745-483f-43fb-08d5dce55e36
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR17MB2148;
x-ms-traffictypediagnostic: BN7PR17MB2148:
x-microsoft-antispam-prvs: <BN7PR17MB21481626189C065A10BAC347F54F0@BN7PR17MB2148.namprd17.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR17MB2148;BCL:0;PCL:0;RULEID:;SRVR:BN7PR17MB2148;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(305945005)(33656002)(66066001)(26005)(476003)(2351001)(81156014)(8936002)(74316002)(6116002)(105586002)(3846002)(53936002)(8676002)(14454004)(558084003)(6916009)(486006)(99286004)(81166006)(7696005)(106356001)(186003)(7736002)(68736007)(316002)(5640700003)(102836004)(97736004)(2501003)(6506007)(55016002)(6436002)(2906002)(478600001)(5660300001)(9686003)(86362001)(256004)(25786009)(2900100001)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR17MB2148;H:BN7PR17MB2244.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: keysight.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N+tMxBfjdPtsgB2XWaeMtfmI+ANTnPQfG3XrrEzWXG0nlxz3UqWPqW09Z11JP6SHptPK8PbTSdTccumEAgHV6dPCKfwqA5xl99a5OxTTeCAbvBF/aI6wIzcCb8Jg5ljuwvt9xBMr+YuUBAiUl8/nSudiDYq+6F1ztOpMlGgZDtDIdPhS3C6X/yZqYBZE6VqAWKHdFsurBmLwpSHjL4/zNXjpaGIQNSMQqTZxwXncW1RDPu7cG2KofCbvOT1iPVp0iIzzSzJtyWJjnT2Mvxj8taJLbhU2LwFFN5hEnmuPo3SFymn0JzxopMVKgh2+BgCDDAa035dm3QDfzFDx+L55icE2/Kfx9E/jdLM8GBBjPOE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a334fff0-f745-483f-43fb-08d5dce55e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 10:53:22.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR17MB2148
Return-Path: <catalin.vasile@keysight.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.vasile@keysight.com
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

Hi,

I have some pages allocated through __get_free_pages(). Is there a way to set such a page's protection to be read-only? I am working with an octeon2 mips platform.

Best regards,
Catalin Vasile
From pburton@wavecomp.com Thu Jun 28 19:44:53 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 19:45:00 +0200 (CEST)
Received: from mail-dm3nam03on0133.outbound.protection.outlook.com ([104.47.41.133]:6608
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993514AbeF1RowrGn6X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 19:44:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2hbU/RpNrMfDcGBHrQK1fdgngJiOkhbLslHvjWtG3U=;
 b=KX9fP6svkZu5lahRdl/cm2r9K5F6jxEzEsaplBL86UV3mGJVn/AZm2WtKuCFy25itn1RgUvn4LgEPzeV8rDMnlsEvWU67lseUM2T0sLumHGBncrKo0HGMs90oqSY+drN5QAz566U602wZUhPqn0VRpxwXmQRGy6fa2qnvtTXLUk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Thu, 28 Jun 2018 17:44:42 +0000
Date:   Thu, 28 Jun 2018 10:44:39 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     catalin.vasile@keysight.com
Cc:     linux-mips@linux-mips.org
Subject: Re: Mark kernel page as read-only
Message-ID: <20180628174439.kij5iagryisovb5q@pburton-laptop>
References: <BN7PR17MB22440CB0C1698E7641812FBFF54F0@BN7PR17MB2244.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR17MB22440CB0C1698E7641812FBFF54F0@BN7PR17MB2244.namprd17.prod.outlook.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:4:16::19) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6eb164f-2cd2-447d-236d-08d5dd1ed476
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:0hr6d4DVWOMfkEBNEQ+bo9AJIZJFH7eXP7dKw2mFnFnMvtkHUCwVaWlmSo4Jj3cVBI5fPYIs7vRsA5NUvDvmS0i49Y16gUYZsdyDqjvXcu/03wASRGb9QPnhG5pRrt4btvmFrjjBTyE2BsJD+gosF/bn4qoLDUY9+As17bh6DaZJdPD6gM9ww7v4bB5g7OyTYxF5i2QZgN1s7BkceIZGdjuyDCl2zIkJiwf/TEyZB27zEOCuWJqwTNSWg3evTCJ5;25:ncUPMrUyB8kRm2oJ+jW8dtKIpt6r2SbLcVLAUgwDosALurJ9/s6FUScAOEmkm2KQCISicDSiBos1Ji7ehHrvUa/Gc4MORx+sRpcJcpkRE1OlCsfkYrDYlojVjssgLsv8RRAz8MQaIVNhwgSd3O4bnHWLTcyz/SuF9nacNxtwzw+AQ0qY8kD+FfD3tJPqUt7avvjL9DvrduWaykVKoVlN1t9GkO7stPtItAP1D8UfvcuCcyAoAfoD1+IEH13Kt8UxlzIe6NFuFAberZ9FcaHMGNjCyFgytUdiMsosM3oLOoTZ7g4Rkpp7UQGuqktcWMKYKRej/BdegFHCcN4EnNQ9ww==;31:Walo+umaE7uKeWknV+ZF254f4d3s6w9GboaRicfF11zzgR2fUdYwOBOd/MSqHUMB0pagQ5dZfj+1spQnpY7H9ElRQiKYZA6kAkLn+o4HiQa1UnFvN36t9a0x1r43MpCAFEiKgIOw4bMougLADpXg9OfK15ZAxsmmugU/8T6j4rxiFau0qJ1EzlAbD7xAm7yJbEMcrxYoHEcb82y0aEP+A+X0PurG0Y8JaCD+UjgtQI0=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:IFnHJZp3yIxsjk9p29RFuBBE7dxbSkXYXQchhdDtJe504+/HJVGoAJqqV+hp8ffNC7FZb0ROptpJIQ57PiB5+dzLecgJeupncm+Q16mQ7kwJGsxskbU5Ha8NL23Z5+M0sln+8zbqgbi2jNycXXVsoTVMSLbt6E49HPLq+RlaF/ogHUl19JiGQWp9NPekWqaGl9JZ6LBkOTUNYX2o/odFbU6dgYcw2aVMiRd2YEK3jiKUalx3xHHnTQBWPujT8z6S;4:c1yXDT8wg1j7t+EBsYAQ7/zuxz0UvJj0vF1GmVzf1quXsQc+WZvLQCCRT1B6MCPRSoQcEjoy0xrXuDQlnkDJhE4kwmGDj1CDPkp/rkKHemJYFNVCLzArdibzZifXxr5BYU7GuZbNUTPQGa+dLdKyjTgMk/EzhW304OerTN4T2TS0POdQ00hsIFVZmaBcl1Jkn35DtXCnkvbgFPu6f3+2d5FvrKoUgTS80y7AxuIKEpWwe4z0PPEqVnfZCIcF1qOpk9lfJ9UQ8gwvXs850wzOdA==
X-Microsoft-Antispam-PRVS: <BN7PR08MB49326C79099B1311CE3B9857C14F0@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(136003)(39840400004)(396003)(346002)(189003)(199004)(2351001)(53936002)(81156014)(68736007)(44832011)(8676002)(81166006)(305945005)(486006)(7736002)(76176011)(6496006)(316002)(446003)(6116002)(3846002)(23726003)(476003)(6246003)(97736004)(5660300001)(11346002)(33896004)(52116002)(1076002)(25786009)(4326008)(9686003)(8936002)(16526019)(6666003)(26005)(106356001)(2906002)(956004)(6916009)(386003)(186003)(229853002)(42882007)(478600001)(33716001)(16586007)(58126008)(76506005)(105586002)(50466002)(2361001)(47776003)(66066001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:XfDxb/EdPxFZagxo9tG6Vd3PsVbquJv/AoH1tbdSL?=
 =?us-ascii?Q?KM/MyRGAL2JuYkZtTk3HuoFFPv71VjVNyi904vsj3UyK4mgn7BTJTaRel+va?=
 =?us-ascii?Q?aBiFf12sbDw6ee+jUzOPWJbNq9fUY9Cpuc4V4IvHrxifQ9fu9zX394zArbmd?=
 =?us-ascii?Q?dzBAYhRt1/se/NOpO39Du7iYvxl8rpyAwgQ0s38Nfzzcm2aLy71lBVW4iYn/?=
 =?us-ascii?Q?VIXdI60lTj9DfsfZSoR27GA23T/E7J7zkjqAC28eMkEkO94loP6NaiM8Sx+m?=
 =?us-ascii?Q?03spa0sojigFXjJMucwqZJ55JzMt7xvDIVSpXDk1jdXiQ54SJlpR+DwTZhnJ?=
 =?us-ascii?Q?mA0hb6dFKouaUA8SGKTn4TB6Cc/+gjRpD1dMaYqD3IbVJpq5n4qwoVCuH7lY?=
 =?us-ascii?Q?9m+TYn/EoanGQOCJGBS1fjloopLx9mDZkUfp3CDxu3BQGR3fX6rA71ByEOak?=
 =?us-ascii?Q?QtKTqvcrE7s6PVk6jiz8AP156rLYHkiVfjhjWqLWcpSucGJ9qItaS5tcSujF?=
 =?us-ascii?Q?VbNzT1RLwK0eufSQTciPX5uEN6hNTstopSviCqUo20NXGUqJN9xIw8Xy8AZ6?=
 =?us-ascii?Q?p9Nybjjd2sxz/6NeOkZo8kd3Q3wBR7Mqi+OBPvPJ/2k8D9si8Z4RMf36CuKN?=
 =?us-ascii?Q?87F34GMVbzNDwHkxxS0NpUW7Zg4Xpqtc65zgWDJ0XmB7RBSkRFlCOZywL0o/?=
 =?us-ascii?Q?eY4MXdjJRfFQouAjjSd9mX4jWlNcfRsrK0VDEqPIPtlXOMU/xYhgNF1XiJx0?=
 =?us-ascii?Q?UH0zZ7k709HDvVykiU+Hrh+QsZF+pkydOIGT/bZyvXqOvf1prju8DVAtH7wb?=
 =?us-ascii?Q?ApFx1JIe73bzAFqw3/KGmrGV3F/vtnhOIt9BdRI8iVeIvVVdK48FYK8XdAZM?=
 =?us-ascii?Q?S0E4yipnLuQmI7C23zrBqAXmZjvoNA49Y3eJiynB4i/hD+1dnx7tasZ6rBzp?=
 =?us-ascii?Q?ybXxLYW+m2JPvthulNaWL3OCGd4rf0ZwH4EO3pNcyvLdoRTU/UtmXWx7JGwM?=
 =?us-ascii?Q?1Ii1IrR6gHjpbev2FoXxZBdOO+GI+qMr8VoDBZtf3utZwoGNPEhLwEpuxfkr?=
 =?us-ascii?Q?B7uCsrkYI1yjAs8wc3CaEew7ybWuyan12wsyNpo04vZVEpmubJc+JeX8sYU8?=
 =?us-ascii?Q?PgQk6JnAypMWiG+Z/Tn/2Qw6btKpBcIQ2TI52akyIQb1M3l01vHIk7qyo7ml?=
 =?us-ascii?Q?DvL0G9sISonvUAwhb9s62aoY051RMAqUFyKOP5KI7+W5kIB+i8wrfUinctxF?=
 =?us-ascii?Q?SCqIYQKYGTJCYClmfhSnMY+b3XBfv5wYQ6kj7+nK4SkUvEQPVrLEIKHGM03v?=
 =?us-ascii?Q?dmmgBmCDOJEUrvkGr1aHvjdKPylhCFX6u/yE6EMPzhv?=
X-Microsoft-Antispam-Message-Info: XrqXx6Ina9FX9YeygaykPys1VPdm4TwDDxmU2etCu5+ytEmXqDlUzO1ejnGB91k9SS/POqPzc4rDw5odD2hdkp0RVjwZmLcU7Hw/0dqBdDz6loeagrSmw/noHS00uvo34vxGEdMNBtd4cS2/Ly6IYe11LnXUFQ9RBaB0iBeNy1AyI0VHV9NjpGrtDU3Ht9zuAp4doG64VhjEKRWWPs664vKo2ydqMPZrnYY5u9w7n/J/Hs/3Oq0iiYQokAIlVuMv/Y5IzEg94l+k/31RMMHhXpz0rBqryuSQN8+zB4XPchz7/0HsIKjKk1QcuxbJcgzuuvWECGYJOsVqC5/AnOrHe3oI1+q8jwl5ISwwNqjPd6g=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:lNLivh30hT3MeJWIorvzTHoxDHfB9mxQiqr+KfDsGLopm9u74QOaCb0ewhiU+cZJjfME1jbMQK5jKosYQq4eA2IL4Xz2dzw1fVYuqtSO2/uwG27ooVYFlnstXSssGluTkyjRwI2B80S03vJXPN7MZ+DFLJ0/uMTkpMiayQ7YzR8ZyrVXKqPyTtFpXoQqRzj3TL4/sov3IFhuAdKOxVBjMFjM+/aOwdXgZnPjzUYGvIwJn5AbhTc2g+2aniauc4RlSv5rGPYmGYXYTYTNrGzGtPcZ2yeWbhqmNjsO1w3vfBoYSGUWNZVp23b5SMBlwNX0icV7vgoayOE6d3q7tXyTfdtlutZQ6vN7IR2r78pvrNIACq8V3dRHPdxyDDWs6/PIR4+TcFk47K81XXTOCfO70y5+R4b1wL7uGpRELjvbLRyfyW4hgz0evq3buTzZMnm+MfOyzqOrDEylUAmwMypSkA==;5:sPweaIE0CCcX1vPn9JyuCrb+7Bwb2mASHRNpRdodKXJTOrH19PXQ9pLBStuyz3zU1uxtP6GX5c3pgFZzXhSJKuqWM433Qas8EtNVeyn7B6qslpeVsBbh7pejTbWqYGWobWACO4t2V760zG8hgiH7cIOKm9RtLVD2EOg9j7hYe00=;24:+qyNzqaL8MNe3QDKpdDkKCdQw6eKmpwt3bdtibW9cAi/MD75/XLi+ibUlzfnWgilGLvLaryMhXBXj/kgw9lw4FGupuVzRygu65sOZFjfX6A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;7:XrrNhS72Icl6ll1jxlL/FxZpTgdodBswOv+GDMMe5SJvMYkyNRhntEgwABK9Z19oW2p95+ESH8isMoZizgLMa7AFepg2pqs7pSNZOR6mM5BiryWUFO5PfwH3OyvBpsj6cMysWYN16bnErXtO/+IW2iZgm3ji7SHdcJ0LNgQVPsCVGLSgKfvaJnRM+J2SpN4fXCs5JaG2rUwfz9jTTGEncnKU1WFZCfnEeRlhaAAtl+PF7mMxAVhm5Iim1YzytmD3
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 17:44:42.3871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eb164f-2cd2-447d-236d-08d5dd1ed476
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64489
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
Content-Length: 554
Lines: 15

Hi Catalin,

On Thu, Jun 28, 2018 at 10:53:22AM +0000, catalin.vasile@keysight.com wrote:
> I have some pages allocated through __get_free_pages(). Is there a way
> to set such a page's protection to be read-only? I am working with an
> octeon2 mips platform.

__get_free_pages() is going to give you a virtual address in the
unmapped (c)kseg0 segment, which you cannot modify the protection of.

One option might be to switch away from __get_free_pages() towards using
alloc_pages(), followed by vmap() with a read-only prot argument.

Thanks,
    Paul
