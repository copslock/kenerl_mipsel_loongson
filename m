Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 12:37:27 +0200 (CEST)
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:10450
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990432AbdJKKhTF2fAv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 12:37:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hJ2fR9Sy4uj77xcJHW8+P6TV+cEPuqMtF1xw8u6klJQ=;
 b=bqtmwGSqtGBorBI1mGsLhLP2xdnt37e3bLjLG3XduaKc5Tz9uCS08QtvrAeMd2iaQ8IAieLjXZVUzJuVchd3OuWjL6Ej1o4Zps5dNyCuWWiqsvRRrAAxs2oZoCF4beM2JY69EPU4qda++L+i/7drI9WOm8TAXB/sx58O7oHp0u0=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (10.164.122.158) by
 MWHPR03MB2717.namprd03.prod.outlook.com (10.168.207.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Wed, 11 Oct 2017 10:37:06 +0000
Received: from BN1AFFO11FD016.protection.gbl (2a01:111:f400:7c10::134) by
 BN6PR03CA0092.outlook.office365.com (2603:10b6:405:6f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.56.11 via Frontend Transport; Wed, 11 Oct 2017 10:37:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD016.mail.protection.outlook.com (10.58.52.76) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.77.10
 via Frontend Transport; Wed, 11 Oct 2017 10:37:05 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id v9BAb46l029103
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 11 Oct 2017 03:37:04 -0700
Received: from NWD2MBX6.ad.analog.com ([fe80::55b9:119:62f8:e884]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Wed, 11 Oct 2017 06:37:03 -0400
From:   "Wu, Aaron" <Aaron.Wu@analog.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Steven Miao <realmz6@gmail.com>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [Adi-buildroot-devel] [PATCH 4/7] i2c: gpio: Augment all
 boardfiles to use open drain
Thread-Topic: [Adi-buildroot-devel] [PATCH 4/7] i2c: gpio: Augment all
 boardfiles to use open drain
Thread-Index: AQHTL5jkaWkT6h1N00aAnR6YZ/47MaLb+ZYAgAKgbSA=
Date:   Wed, 11 Oct 2017 10:37:03 +0000
Message-ID: <649EF91064D35D40B9C93A225BF41674ADD7CEFD@NWD2MBX6.ad.analog.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-5-linus.walleij@linaro.org>
 <20171009142824.GB17971@linux-mips.org>
In-Reply-To: <20171009142824.GB17971@linux-mips.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYXd1MlxhcHBk?=
 =?us-ascii?Q?YXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjll?=
 =?us-ascii?Q?MzViXG1zZ3NcbXNnLTFjMzM2MGJiLWFlNzAtMTFlNy04OTc5LTY0MDA2YTdh?=
 =?us-ascii?Q?NDljOFxhbWUtdGVzdFwxYzMzNjBiZC1hZTcwLTExZTctODk3OS02NDAwNmE3?=
 =?us-ascii?Q?YTQ5Yzhib2R5LnR4dCIgc3o9IjEzOTkiIHQ9IjEzMTUyMTkxODIwMTI4ODgw?=
 =?us-ascii?Q?NSIgaD0ic0d0SHdmdk1pUkF2bEJBR25SeWtHdnhjYjYwPSIgaWQ9IiIgYmw9?=
 =?us-ascii?Q?IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBS3dCQUFCbDJK?=
 =?us-ascii?Q?RGVmRUxUQVNzNVVlaU5SSDF4S3psUjZJMUVmWEVDQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUhBQUFBQThBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QVFBQkFBQUFJWVIzV0FBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFRQmZB?=
 =?us-ascii?Q?SE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4QWRB?=
 =?us-ascii?Q?QnBBR1VBY2dBeEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFH?=
 =?us-ascii?Q?VUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?QT0iLz48L21ldGE+?=
x-originating-ip: [10.99.24.225]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(39860400002)(346002)(376002)(2980300002)(438002)(377454003)(24454002)(189002)(13464003)(199003)(53754006)(356003)(7636002)(7696004)(102836003)(4326008)(7736002)(86362001)(6306002)(39060400002)(54906003)(6246003)(53376002)(3846002)(5250100002)(2900100001)(478600001)(230783001)(97756001)(2920100001)(246002)(6116002)(8676002)(305945005)(5660300001)(106002)(229853002)(72206003)(106466001)(8936002)(54356999)(1720100001)(76176999)(966005)(55846006)(23726003)(110136005)(55016002)(14454004)(50986999)(46406003)(8746002)(33656002)(189998001)(316002)(2950100002)(50466002)(2906002)(47776003)(53546010);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2717;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b071ca-e27d-45ad-0a3a-08d510940405
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(8251501002)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR03MB2717;
X-MS-TrafficTypeDiagnostic: MWHPR03MB2717:
X-Forefront-Antispam-Report-Untrusted:  
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2717;20:iFZbuzVnZo0G1Wr2fcHNPGCU9Ts6iF2sTz05GF0W6HnMgDCvLSsmPqvNPYZnkP/rlChnyUo0Ye4y7eK9WgZEKvm3y2FH2MCfERVI9gSrH/7CuQ4OamW+QBHtmk/qd7LDfs8go6UfSGn6qbSMt/Z3S/XHUrnc9MlxM9sZD6Qw25M/K9szX/mcZA2DJ5aAXrZobQoUohcJn0tSAaq+SUDgHjGcZYAT5zJqu05oaHITYs30eGHX3cfl3ejsUlAzQTHTpIU0GudDfftKY6V15uj/fd6xNHijZYkph7s1T5SQPimdX8bHAyi9Er07KvaqJxgCMwLJobfTLt8CPow5hoZYAKlDpmx+OEXzoTqg9CZOLfd4qGVRu9oCzEukiOAhn1cotUqbuoar8d9gWPr2/48iFdTT5CEv/W+ymDINv+CpMM+K+C64k7FJugQgZDj2HWWnXV/hQOeyYPFhOHdUE1I8/IsCX/mL74zijafk1QU8Sft2ngNeegr1ibHH1WyhgdGc;4:6wtJ+PJ89LSdZNYV979jqRiiy4V2tdKxkvfW10iXc3mK5TObaTMJCM1nVK6l9quTxSlzAgDQrWLbbFCSNU4Mu+Df/WfR3y/qkIDxKBz0rTJ/F/LPDarECQqZ/8jFMB0QhXzjJA6zfYiAq+uyOS+QCjrJfMzLE1tU5cogwI5k2ZrquHDXcUB/9D62q3DFAxuVz+BW7FxW2GIHmf5sVJMHT3MEOF7b79q6Z7fmRn13/a2RnlaLvVUNc1mbm0BU+lWuXOyWth/o98kpl9cU2meyQw0DHZBaUr+GDTchIv1859LhaNysNdXZ4wgwR+mBMOOgBf7UPdF5gD33IvycXsjDO+opxhTe7E0B3CPi+wv4Xz17mFuBHF/sdjnHA/2hVMNSGymNBtQzRNk+yZlM446dLA==
X-Exchange-Antispam-Report-Test: UriScan:(143289334528602)(9452136761055)(258649278758335)(42262312472803);
X-Microsoft-Antispam-PRVS: <MWHPR03MB2717F30472513EEB63424283E04A0@MWHPR03MB2717.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(100000703101)(100105400095)(10201501046)(6055026)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR03MB2717;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR03MB2717;
X-Forefront-PRVS: 0457F11EAF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2717;23:SDD+51BvxbJ1TWyBLlVcgkowPLZBQuALbm92MMPkS?=
 =?us-ascii?Q?BeVW73Cjs/LmWT/CWORv0Bk/I0spxQ+9Z5OGGZAD9gGxvyDAy72f64eTfdma?=
 =?us-ascii?Q?sxMuaKuHT4v5V+XmI4EIZVGN0fS8DQ4UXTZRjIZVnQDa4pJiZMIhc6R0HqJb?=
 =?us-ascii?Q?z1zXbg5ia/BilctQxNdD7FpiQBZ1KYcPC71fY6UCEqJO8Rm2FYM1bv/Tj+25?=
 =?us-ascii?Q?XML5Jka1ir/3hQOwiPX5KStp5k0cPPBhuKNl2ujgymOYzDdePmQTM2PJVLWL?=
 =?us-ascii?Q?1b0Xew27trB6TXjJGEfobFXeSPZ+peZAqZuKw6SdU9GKivkpqKaVMg/6ltDl?=
 =?us-ascii?Q?DN6wMbhTkFZa1Bbnd1GkzYzSf/+PSa6RBOAOp9CR7x66Hu2uRPO0ZAVxkxfv?=
 =?us-ascii?Q?qJzKxK9eY/XMwEbCK5BaaAJXTjvUDkZPIT3ojLpOBaBey89NxXZy8r9VZexG?=
 =?us-ascii?Q?ifMOcRvZc6TB06M0ng9uV31iDHnSpO3EzAOuX5NmMiQtesr8ZCvwK61odoP6?=
 =?us-ascii?Q?RfUbaBIE5hcdCtP3jVEqAewiuovCVjnWl1OZZWHKt7wr0QzaY5JzBBOrZOMj?=
 =?us-ascii?Q?KIG/+2clKl2Cfur7kG8CaWCFvGjslFjekEpqiTdcYrSEYOlnDzTvWlWY0Wtk?=
 =?us-ascii?Q?X+SLJ0KYZjHh8Wtd87ygAPrl83DRss2Hal7F3KEiUO5huza8nliLL6r3LuR1?=
 =?us-ascii?Q?ko9Kltyqtcc4fvyzHXtN49holb2sTQqQCWdzUkvK4S17h1KZYWpmA0u3N89y?=
 =?us-ascii?Q?rC+oT/4rE1d86HMOqdEcPDGL+q/0/V/oRTPb1Ld0Wy4kbibfyxtcD41rh4tm?=
 =?us-ascii?Q?zHlZuaj8US+VFr+l5XCJ6pxNUQ3eBkfNO5N4gFXzN9dU9SD54ocOBLgMS5m+?=
 =?us-ascii?Q?y4C9Ted2RHTmgRPcCMUwWxcBl/SXxI8xrM+l4/1yoMoytA3s727Uu37QeqQD?=
 =?us-ascii?Q?vZ1M2TRHLkjyCmLFKBx3nCA1ab8MZAXxGVarAFS9S4vjtTXUs5nRrYTKHh5F?=
 =?us-ascii?Q?6+0/cBxUGhzMSbaXfuMDl2i5uEVOZOI+QkLHYA91+23YxlOx6IWUHXTW5anP?=
 =?us-ascii?Q?5OY70rSL4mWR9wY5HmqXglplQj4IRpYGHhsG4erZdQPmbrgWJ5PJ0yBNkp/i?=
 =?us-ascii?Q?S/2XPLDP0+unWpKlaeXrvqGVKlPOfD5Fy4WxencETa8j5lvI93OIrLRfod8M?=
 =?us-ascii?Q?2MD5cRWogP3NEIeR73IjwI2eMLMJDwxxnEuzi30v2el3A/6uQ5VjQy2wjaSM?=
 =?us-ascii?Q?zUzqrHkHsaL7CXrvIWvksmK0fFnvyPp+Wr18TGDf/RYvAyTGccbk8plaliQh?=
 =?us-ascii?Q?CVYMb6VPNfpt/QzD2NGZOavj77b6TscCqxvwrp6UzBex4HlqKsUPeq+AjAHp?=
 =?us-ascii?Q?Y13aHH7MlsWkSe/YT7DTLACYs48+KSGrSWbGOOkwJ4fL3Yk?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2717;6:KqKnFO7YpFjy2V94gr5ks5GpaO0KwZmChtEqq6jPQvVqPK4dJKRgeEIKNLLuNTecd54/fW35AELqrwUqU5/vuCfgsP26ludnBgNkUowSpnA/lTqD1x830H1F1HkTk+jS7HG1+Xeim9p2zZVcdR6xLD92VbmpnpuuLZ7hkTR2chMFMYTCX4qebiTmIhSjR3RgblqxBR9roacD9I6irZ2ndHbE91/q9sCuu1aiNpEGto5sDkb2oeVmlwHi6Rf8jviUMmv3A0GdT3TQ9dyoA4QanpdLHOzb5cc5eSMRa2m5FGfbab+m3xAJGSBxmXq66G1/SSQsdvVc6sM2VhHecroivw==;5:gZdYOnwg+pI8O6mDlswc7eyiYABYrdWT+u6yX6kmvqEOVcKZRI8rkpwVFvppFV4wSrOuvE2BVjbOAakvxjqZ9z7+NcW2jxXbJGzBKPuu3NBRwKu3GhFPmAEcMcY2cmosvx6YghEkrn3mD48ikOaJ+Q==;24:4RsAwG6Qr+h2W+biY75sSiOK57vR6sxSUQ9evzytONmzJoBFPb7/HNZTPipLDnPBg7QCEjq/EJJwuxE6/gwVl1HtqFCTY5L4dz2tmv0H9sY=;7:xA2YlwaNrR6xBFVI3byLgYZSQ3IPZ3e0RN6IjUov1Vh3H4Ln5NtxATrAOGoelm/6pHZNmknmYwe8yEDOsFiTeYDp1y1Z1NSP+1AiXM4IRgXBMwllLdBSuKa7rfJzAtkY10m6aX2S3w0BbEBWGr+ghkT//BKCUUEQdX6UY/ybGzCDemp6YO2oHyvd3XF23r1HPuow8ARaokU4xG9oJkXtbJklTLmLFMSAbGncQfTlkaY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2017 10:37:05.0344
 (UTC)
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2717
Return-Path: <Aaron.Wu@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aaron.Wu@analog.com
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

Steven is no longer working on this for ADI. Acked by me if this works. Thanks.

Best regards,
Aaron Wu
Analog Devices Inc.

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Monday, October 09, 2017 10:28 PM
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org; Steven Miao <realmz6@gmail.com>; adi-buildroot-devel@lists.sourceforge.net; Geert Uytterhoeven <geert@linux-m68k.org>; linux-i2c@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: Re: [Adi-buildroot-devel] [PATCH 4/7] i2c: gpio: Augment all boardfiles to use open drain

On Sun, Sep 17, 2017 at 11:39:03AM +0200, Linus Walleij wrote:

> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most engaging tech sites, Slashdot.org! http://sdm.link/slashdot _______________________________________________
Adi-buildroot-devel mailing list
Adi-buildroot-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/adi-buildroot-devel
