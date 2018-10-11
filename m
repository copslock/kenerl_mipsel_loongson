Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2018 18:41:12 +0200 (CEST)
Received: from mail-sn1nam02on0122.outbound.protection.outlook.com ([104.47.36.122]:64896
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994635AbeJKQlIBL2pV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2018 18:41:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELynzicc1WbbL4ZzhQC5NAcGBHgkaj5N4yd6c14JI04=;
 b=dLYVLi8dhnYIzDMPnfGihmu+isGw1WKDUzkQls6vnKArd+Ih9om/cSIYwI9mQMgxi38vu2OTnq+E9sWMvaxhODBONLh0hWDSfwmqAKv2IBLLT3FlflcsgqraX1ELFr+MolhUNuhPdqjzV7mgoY5mGxwvVNeqAD89Qn0Lev4mpPI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1759.namprd22.prod.outlook.com (10.164.206.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Thu, 11 Oct 2018 16:40:56 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 16:40:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] MIPS: Ordering enforcement fixes for MMIO accessors
Thread-Topic: [PATCH 0/4] MIPS: Ordering enforcement fixes for MMIO accessors
Thread-Index: AQHUXp8F1GkQChn9TkCSJG6lsid2I6UaRRuA
Date:   Thu, 11 Oct 2018 16:40:55 +0000
Message-ID: <20181011164053.3irkm5dvl7sjzhao@pburton-laptop>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR06CA0098.namprd06.prod.outlook.com
 (2603:10b6:4:3a::39) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1759;6:e7th/+Lt6XmiwBFanuc+N2yu8YQy+BdmmSEnp9Ov4BMnSnSpMVUwEi45+7ng1M+Z8rHGC4FE8YvLZR+4cDFwHq2AryOp6n5nEeIPahACgncSb9whoOxLbVy9gjqR4pNBalO5Pg95oaov8Uw7gc+/h/v6Jps7qAJB5Np2caw8mKVziu1gTfgNVVTxu0Oo5XpKLY4bi5rLi/ers2az3CLBnuSJLMUJASaYWl/hrDnkq2acwayLFmBkuvOqqudFhX132PZyMIHclwpj2F7z2sF1lbdgsaVZEFwZFiavQHWnKKPqDOdfC/JhBTFfjPry0itC5QtOE8KzjJ5/ByTAYfQ4sOe+PCpJPIPgA51fXq3UA0VJRT3hkfYaGTa4BnDU/UsYYqwe5KhB2MUj4JiKtxm1xyJCIEVBRIsirDwrOuT/SBTAbgJ2Sv1OBREaWeyLcDxcZmC2eka/b3eTa8w2xCOarg==;5:C0UEcHZTT08DdotGU6pjmIMijlcugUKE6CkVyiYEvss8qBKcQxy6P33G1GLVLpCFHBULvcffDzUrYiBr7FIx1lifLAvZnKTuxxVh2HzxRVLWBVbM3Dety3f3ca7atmYKY1cvsR2lUsGGdDjOk2OAQNR0NOSQANdOzznr30G7wsU=;7:c05kpYwlj9FOdlgfWrK2eHkNVzW26TjzsCI4P0+FNU1Hh830WH+kBWPfqDmXV0e0hkZFKcF0N+tOCpagCWg4PjDa6JCu5QX4nu127h5XhKMw+u/fhsx4Dc6I8AUiY4tFczwCHX6VNDu47zRkNPVDihRjYeQnG5eZEPIV14gQGnU8s9x1qV44MoJTE+WmuBv743X0zLgK4WtrfhNEQYsjcxGhYOUy0lEIxSY5z1xtEiWr+M9jI3ch6VUCFzR8Rz2o
x-ms-office365-filtering-correlation-id: f3688df0-b98b-473f-728b-08d62f98509e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1759;
x-ms-traffictypediagnostic: MWHPR2201MB1759:
x-microsoft-antispam-prvs: <MWHPR2201MB175970B61439C9C4036270DDC1E10@MWHPR2201MB1759.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1759;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1759;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39840400004)(346002)(136003)(366004)(396003)(199004)(189003)(7736002)(256004)(14444005)(4326008)(76176011)(6116002)(33896004)(52116002)(316002)(1076002)(81156014)(229853002)(8936002)(8676002)(6246003)(81166006)(2900100001)(102836004)(186003)(2906002)(58126008)(446003)(11346002)(54906003)(105586002)(106356001)(476003)(386003)(6506007)(6436002)(5250100002)(6306002)(53936002)(97736004)(9686003)(6512007)(14454004)(5660300001)(508600001)(486006)(44832011)(33716001)(25786009)(99286004)(6486002)(71200400001)(71190400001)(42882007)(305945005)(68736007)(46003)(6916009)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1759;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tqO7gVcqdsYvMy4Fq0GjbOopxYyoNde+JHyZp9MzEzE7bi7Iq8EqubkSyJiXlbqzYjMXSOR3Jex0LNmkWQ1uwlze8YUcOlLWPZmFW9A1PyEy5Dr4if31eVN6AoNZjpuDVMXqZIskfLuyeqx2p0Ep4B5ja3b/YZvzzu3b6i5+DLNKW/hbhfF0wv4F8JMSCD8LjhW3k4M46epS5gUFs2xwYgr9bCWDyVFY9cgvKh34/k+6FMLnMA9sZ3mhvziow+Itb7qdSfGQoXIkZ2FHak7IWplysfaOYdX1BBzNT8W72Bzz5xTgWKLSnsZ87hpwpMrY05Pr7ZkDbn3juvtlcaeFwOrOCBgN+3ZGeYFc1a/mXZY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8CD445476D4EC4184F2380902058EF5@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3688df0-b98b-473f-728b-08d62f98509e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 16:40:55.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1759
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66746
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

Hi Maciej,

On Mon, Oct 08, 2018 at 01:36:55AM +0100, Maciej W. Rozycki wrote:
>  This patch series is a follow-up to my earlier consideration about MMIO 
> access ordering recorded here: <https://lkml.org/lkml/2014/4/28/201>.
> 
>  As I have learnt in a recent Alpha/Linux discussion starting here: 
> <https://marc.info/?i=alpine.LRH.2.02.1808161556450.13597%20()%20file01%20!%20intranet%20!%20prod%20!%20int%20!%20rdu2%20!%20redhat%20!%20com> 
> related to MMIO accessor ordering barriers ports are actually required to 
> follow the x86 strongly ordered semantics.  As the ordering is not 
> specified in the MIPS architecture except for the SYNC instruction we do 
> have to put explicit barriers in MMIO accessors as otherwise ordering may 
> not be guaranteed.
> 
>  Fortunately on strongly ordered systems SYNC is expected to be as cheap 
> as a NOP, and on weakly ordered ones it is needed anyway.  As from 
> revision 2.60 of the MIPS architecture specification however we have a 
> number of SYNC operations defined, and SYNC 0 has been upgraded from an 
> ordering to a completion barrier.  We currently don't make use of these 
> extra operations and always use SYNC 0 instead, which this means that we 
> may be doing too much synchronisation with the barriers we have already 
> defined.
> 
>  This patch series does not make an attempt to optimise for SYNC operation 
> use, which belongs to a separate improvement.  Instead it focuses on 
> fixing MMIO accesses so that drivers can rely on our own API definition.

Agreed, using the lightweight sync types is a whole other can of worms.
I did speak with the architecture team about the description of SYNC
recently (in the context of nanoMIPS documentation if I recall) and hope
the tweaks that were made to the architectural description of it might
help with using them one day soon.

>  Following the original consideration specific MMIO barrier operations are 
> added.  As they have turned out to be required to be implied by MMIO 
> accessors there is no immediate need to make them form a generic 
> cross-architecture internal Linux API.  Therefore I defined them for the 
> MIPS architecture only, using the names originally coined by mostly taking 
> them from the PowerPC port.
> 
>  Then I have used them to fix `mmiowb', and then `readX' and `writeX' 
> accessors.  Finally I have updated the `_relaxed' accessors to avoid 
> unnecessary synchronisation WRT DMA.

Thanks - this definitely leaves us in a better place than we were :)

All 4 patches applied to mips-next for 4.20.

Paul
