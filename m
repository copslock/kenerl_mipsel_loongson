Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 16:40:05 +0200 (CEST)
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:62048
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993885AbeDOOj6wMDHu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 16:39:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a/YJ1B/1tQqNis0/ycjrSOvlF9s7Cl4bgBCGptC94mM=;
 b=itglF/LDbpOT9S9c6VKCBvF70Xfo00q8rP3gqhO0ycx2dcEFZuAyxrmASRPQbI+2EHfZRFY18f3zL6nBusgtTOEp2GMMOFQAx+iEkMnPw1cXNhpEuLg8nTbELNn2B1LaTyS5NVUsFQrVUCcr8LWBbsdRG5ahIl2TolgcMXBqlfU=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Sun, 15 Apr 2018 14:39:48 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0715.004; Sun, 15 Apr 2018
 14:39:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     James Hogan <jhogan@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5git3dFULHUMUCcLZ/m4cWq6qP43woAgAkQ+AA=
Date:   Sun, 15 Apr 2018 14:39:48 +0000
Message-ID: <20180415143946.GO2341@sasha-vm>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-48-alexander.levin@microsoft.com>
 <20180409201242.GC17347@saruman>
In-Reply-To: <20180409201242.GC17347@saruman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:p3v4Kvk9jR3u9F5dkb+KkDMxc+6rUm/uh5xkcBi9ujtG6JLCxARMf3sHgYpPp9YbpTD1MASyHBzVkupGO8f4KK50y1xA18BGNciSAgv7jIgdxcOnc17R2bfqBxQZPjpOBtVMA4RkvTOcJBO16+IQVQXqoMTAt5k0XXUUC80JRxcdgUCD9D79Rbi3vOA66MxLiCyslmJW2W/Hhen9O9XfmbPP/W8UrWea9XXubUxCQonTO7mQOBQJS0BMYTprJ+1N;20:QmngTDbFH5dP9jnl3YNkHJ5OEcXWasp+osUk4PJ+ATF2KkILbS2GBRRx46JQ2wumLa628PbQB8fJC61aNgZe7Q0l9jEtR9O/ViAjFWQbHwfezguZZ+qwNPCZJwBJ80ooE1xdIshzDNH5cfyPQStgJYm8a7qbWxUSQ+iEeHYl0Dw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB104780C37742C2D294484C3FFBB10@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(199004)(189003)(69234005)(68736007)(5660300001)(97736004)(25786009)(26005)(2906002)(10090500001)(3846002)(86362001)(6116002)(478600001)(2900100001)(10290500003)(229853002)(14454004)(72206003)(6486002)(105586002)(66066001)(3660700001)(33656002)(3280700002)(8936002)(81166006)(81156014)(53936002)(1076002)(54906003)(9686003)(6512007)(8676002)(99286004)(76176011)(102836004)(86612001)(476003)(33896004)(11346002)(446003)(6506007)(6246003)(305945005)(33716001)(7736002)(4326008)(22452003)(486006)(6436002)(186003)(5250100002)(106356001)(316002)(6916009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lA9s4g9XKBO2PRO+jldiHCvF2MhJJL1+i+4uGeHuO7REHT3z+yJ1ZXxA19oruOJcWbQH8m8Ved6U8AgMDkm40Gh4Ue3LqVgmocfuz477AP4E1//cP6N3dvwN6qd3boy7GJq+jVFIl8AytgTraIktIVMLmU/kBHn7rDGOYoDH5BtnJ0pTRALxXARBZkrVzU5s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3BC5A9F59EBA94BAA52163265182304@namprd21.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b5529759-6d1d-447b-b851-08d5a2debd31
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5529759-6d1d-447b-b851-08d5a2debd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:39:48.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

On Mon, Apr 09, 2018 at 09:12:42PM +0100, James Hogan wrote:
>On Mon, Apr 09, 2018 at 12:17:24AM +0000, Sasha Levin wrote:
>> From: Paul Cercueil <paul@crapouillou.net>
>>
>> [ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]
>>
>> Previously, the clocks with a fixed divider would report their rate
>> as being the same as the one of their parent, independently of the
>> divider in use. This commit fixes this behaviour.
>>
>> This went unnoticed as neither the jz4740 nor the jz4780 CGU code
>> have clocks with fixed dividers yet.
>
>FYI this one isn't strictly necessary for backport since JZ4770 support
>is new in 4.16, but its probably harmless too.
>
>Cheers
>James

I'll drop it, thanks James!
From Alexander.Levin@microsoft.com Sun Apr 15 16:44:54 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 16:45:01 +0200 (CEST)
Received: from mail-bn3nam01on0123.outbound.protection.outlook.com ([104.47.33.123]:61628
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993928AbeDOOoympcsu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 16:44:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/WCryBd9VzOzpYgFtzgBQew3l6acjwTMOlgYARTrMmM=;
 b=FLa0k2otLxrhPgbWlZAg7fcOh296xQR7eMOgDpgicyboOmC7vslbkOmh4+uaosl8adMRYuWG0irIwWpw285fvfuQ0aqcaQ5YM7UH+/nVABHUf8jf4thrDiWFaS/83CUozaveZpjzMGmclEMXZ5DXq0DY0v4VjHMAgoho0gnuRhI=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (52.132.133.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Sun, 15 Apr 2018 14:44:45 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0715.004; Sun, 15 Apr 2018
 14:44:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     James Hogan <jhogan@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Topic: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Index: AQHTz5iLqRoxliRgSEKMEGprDVcqeKP43ecAgAkTfIA=
Date:   Sun, 15 Apr 2018 14:44:45 +0000
Message-ID: <20180415144443.GR2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-43-alexander.levin@microsoft.com>
 <20180409200838.GB17347@saruman>
In-Reply-To: <20180409200838.GB17347@saruman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Q++DI3ASyEbCG5EVKjNslATTlF2txQh+AtKqxNXOGMU6r7Jk9+xKOR/qjRevx9us/EBokjVcrXq65jqwQw3DT7QZ5Kylz3WByXuDWvTLRUps1UvGrCHYYiJqguaR2PV7KOzXU6DjVlM/Gt8zOtNDYZOHZWqBvz29+V1IbAtthzsGtygJUBKi7aR8QP55rx1bNvxyGZMsY6hv/axt0uXCVHMWJ6zwOjoDWYAka2u/tFaBAcZhXvJhTtD9bhX81TGY;20:d5MOXPuEmSRApExA3HlWA8lzY753WXwS5PDiaJPVhsvWPmkXOMZimwfGer3MsL/UlmnngVp/mCEyUY4VnGO38Y84oIW4IgSdGdmcyOu/3FGibvWroC1pgn26XWGLB7TxDK8XTdUClbDqoMDJ0KPCIA/VnlAOm/NjBJbusPSFMfc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0983E356357457C7833E7953FBB10@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501347)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(6506007)(5250100002)(7736002)(102836004)(229853002)(6916009)(9686003)(6512007)(99286004)(76176011)(305945005)(33896004)(2906002)(1076002)(575784001)(86362001)(3660700001)(86612001)(53936002)(2900100001)(106356001)(3280700002)(105586002)(33656002)(6246003)(486006)(22452003)(10090500001)(14454004)(476003)(11346002)(72206003)(446003)(25786009)(26005)(6116002)(3846002)(66066001)(33716001)(6486002)(4326008)(68736007)(186003)(5660300001)(316002)(10290500003)(97736004)(8936002)(8676002)(81166006)(81156014)(6436002)(478600001)(54906003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l41PTpopSZeySvanoB+L8z6kaT/U0fBkHzTJMSPGmPplYIkX4b2+7an50XRsY4iA51XPp/LKw7EJ1eUtAFEAID0PlfVhGqLg4jV3pGcau58V968GDMLSGa046asDJpEHntgNRYwGtP8BaAUWK0D6F1tB6CmHYoGKe38DNk24xcTh5Lz7B3Zi3xdWjLzhOBnD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4189D4C1E5693469236E6E4724659E0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 46ab6969-bcf2-4ba9-90d8-08d5a2df6e32
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab6969-bcf2-4ba9-90d8-08d5a2df6e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:44:45.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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
Content-Length: 607
Lines: 17

On Mon, Apr 09, 2018 at 09:08:38PM +0100, James Hogan wrote:
>On Mon, Apr 09, 2018 at 12:20:20AM +0000, Sasha Levin wrote:
>> From: Maarten ter Huurne <maarten@treewalker.org>
>>
>> [ Upstream commit 1f7412e0e2f327fe7dc5a0c2fc36d7b319d05d47 ]
>>
>> According to config2, the associativity would be 5-ways, but the
>> documentation states 4-ways, which also matches the documented
>> L2 cache size of 256 kB.
>
>JZ4770 support is new in 4.16, so no need for this to be backported.
>More likely it'll just break the build due to references to
>MACH_INGENIC_JZ4770.
>
>Cheers
>James

Now removed, thanks James!
From BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org Sun Apr 15 16:59:55 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:00:01 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:39450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeDOO7zMueKu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 16:59:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LYPaiE3wDJg0+pilf34gNm69Ac6EUWTYANNPb1A4Fc4=; b=H1P+SOjvgGHTR/YoB2n/G8EwJ
        OH0+VVE2IzyAI9A9rdAGJwA5TqSv6ElOuuGVbegAZFozPMcSR9IIPPOiYSitlkaLmpsDknKYw1bGi
        UruhsaQbO+N1pTkpSDY1g5pmopb2ZURccx8pv4ttITWKeIn8gPyR2I+XXWBBY+3uvBF8xi8t+hVO3
        r83Vnc8QyXQ9+tOHLXJzya1A5MYqbzcFzdpEXARaj61lyDEcWU2r4JWD8uR7WdMkhh9GN2skgIjNP
        ZGBqvcj9qLY+PJIdYYdwy4Q89G6HuWvZ9nsAjaukVv+2DzXATWnFVc74YavAn6yZdRvJXjpJlHCnm
        vk2Av2dgA==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j89-0005Zl-NC; Sun, 15 Apr 2018 14:59:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: centralize SWIOTLB config symbol and misc other cleanups
Date:   Sun, 15 Apr 2018 16:59:35 +0200
Message-Id: <20180415145947.1248-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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
Content-Length: 153
Lines: 4

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.
