Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:24:08 +0100 (CET)
Received: from mail-eopbgr770125.outbound.protection.outlook.com ([40.107.77.125]:57216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993030AbeKMWWGI3jGu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK8XzidZ0NoJ1prdojwOCVv728mzyDmgBqBOS7maq44=;
 b=kB7iMY7S2t7q6oNikLObNOXar52Ln17FvavV4DvS6f54JouuVaIMbYS+2Fyrx7VM//OaLUbQkfzYpMhFfazPO8NxgBE5c7+/tb57/Fn/aexTLCWxawwWasLc8f+iX3ll1mr5UdiLu1DETho5Q1ymUJq2Q5StkdDc6fuQYZ2AbyM=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:04 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] MIPS: DEC: DECstation defconfig refresh and new
  templates
Thread-Topic: [PATCH 0/3] MIPS: DEC: DECstation defconfig refresh and new
  templates
Thread-Index: AQHUe59OqKLqo1oqM0WHw73o1pYGkg==
Date:   Tue, 13 Nov 2018 22:22:04 +0000
Message-ID: <CY4PR2201MB1272EE0A0450B421A102D091C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0035.prod.exchangelabs.com (2603:10b6:300:101::21)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:3J1DRNawC8d2ZeB0t6r0NflRweP6QfC8EuOSHpnoE4SbbD+VLf16vzqVGR0lQ/ID4aq1/LegwD5YWkzKSBeucbRajV7riXxnthgTb/MjjbnwBc6ch4+dOADcGk6zdg57WLu6mjcy7G31gz+OFzBvxvZ0FFp48MDz1jGSMO1vpUs+WTwTqAc/OKxO5PpC/QQhRXfEpvNkPbNZWLUAZS+s8x2NGC8SDdbO6ejCUBOd6SG4XQqOP9/s4zD3iO/K8U5cBx/AwQczJXEk1tedAu5LUYIArtoTfb9G3SszAdOPBvhfV/hrTUsVbeutw3plOAJ4xei3GHBncFUzhFgL9ewLOOfjkaZUh7Sm60aFlqvCyRn3uM5Ey5ejiklFhaTISpVEk+7iedPK4Q5RrKVEG6t7NinoYrDkxaFkcMMPUvAgLN0naHA6eS6AhSeyeca6SG9YFLDAX7KZxx+36sB7E24vCg==;5:wsL13hlc8UDOJJvbuG8plUx/l8qq0x2SKuP5UPgGvQOMDkyfTj3Xzs97SaY0/1pHZQUQnvXAx0qoVcThg3yZdeXPbMuJhHowBq/bzNgZgV8o1HIkSI27wDTdiTWLVQEqjis/TmNsO300Rs0mmAX+9IWtEYFKlhH7heeQOwBETtY=;7:SNJdtWSjoJJ7XVtctzITkllwYMqrDcuieYnwD36KixQkDV99u40x2EFHWlX815VQHOVrRJqZUX9hb5/+Aa7dFE5YJO/8SD/hMsDPEuyMSJX/mdmqW1h+iYouNtMwqVLrAuEIU/qiYV9GoXe11BJyCw==
x-ms-office365-filtering-correlation-id: 83d808f0-4244-46b2-ed7c-08d649b67080
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB13506850615A03EF8C83E1B4C1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(450100002)(105586002)(66066001)(106356001)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(508600001)(4326008)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(14444005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(6916009)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H61NsUsO5u5RaVJv4ZSSFQbqRwSjasoOV22btZn//iNWHRRRxn5JFU4HFTx88m3FeNHF3wNnFyYUazopXHQr4dmLRZ8ARA79ktCb9tzNeoUmVM6suxQl0bOeK6w6p8c/24pslRd9ZpH9OYKB45bT7u7h0kVHDTDWP/hlYWX0RBjSsgTdVhsOjM+cWaAs7bWfBc9cFgQ44HmbWvyd+TIg1zyluDHVwpqheS/0eX9JMPDDrR2trw6y/2UGxzXZsHuDb+mxq69xJbMhqzUwsUWLQ6NSeHTBhn/1zOCmCg4jNZhJnctW6qD8akBWwZb30c9ghWAxLX2JNhvKrU4tzMwvclFthODTbbjGSdhh1B5HaW4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d808f0-4244-46b2-ed7c-08d649b67080
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:04.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67271
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

Maciej W. Rozycki wrote:
> Hi,
> 
> It's been a while since the DECstation defconfig has been last actually
> updated rather than merely regenerated.  My `git log' examination points
> at commit 3f821640341b ("[MIPS] DECstation defconfig update") from 2006.
> 
> We have since gained a bunch of new drivers and also some drivers were
> unnecessarily disabled.  Therefore I have decided to refresh the defconfig
> (1/3), and to make people's life easier also to provide an R4k version
> (2/3) and a 64-bit version (3/3), covering all the three base DECstation
> configurations.  Apart from being ready to use with actual systems these
> additional defconfigs should make it easier for automated tools to verify
> correctness of the non-R3k configurations.
> 
> These were all verified to build and boot multiuser.  Please apply.
> 
> Maciej

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
