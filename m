Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 22:51:27 +0200 (CEST)
Received: from mail-eopbgr730115.outbound.protection.outlook.com ([40.107.73.115]:13920
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994601AbeITUvY3fRY0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 22:51:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZxy9iKoWOTK0vvPrvW7xoFegzrGfMNXSv7chx46+9Q=;
 b=OcRWGEjr7/HE8JFDyLxUhWT6IzwodTK158cvu3a+q9FR9Im173o5WGQaRH72Q3Vqqjcxb6maZsnHGySeDF3ErLSXyquY6A6vnf838VP/kv8GO/eHSyGQPMiJaZfd2IASMcE10fu+u66AiwG09cN7aZ5Rb/DCPp+mSQvD0/fkXZM=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB3991.namprd08.prod.outlook.com (52.135.194.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 20:51:14 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 20:51:14 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
Thread-Topic: [PATCH V2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
Thread-Index: AQHUUH7RsrCBmboufkKWPj5SW0ZjBKT5plYA
Date:   Thu, 20 Sep 2018 20:51:14 +0000
Message-ID: <20180920205112.x4mkeoktq3wfcuad@pburton-laptop>
References: <1537405863-31484-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1537405863-31484-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:3:ed::15) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB3991;6:A/PnKAqvV9M3AVAF0mv6LUaCjf2/QZHDxlwLdZKqaW1VNleCnaNn+cKwcDohZqZjkGa7ouM8Mq4kNrNOWvcjD2gS9KSGD+wnaMFQRJrmSIbXv3Mg82ngThGzEToWalwutqMhbgQQpWnQFiGDT6axxCPLEwd1CWQ3TzdnxenebF14SNuB9wperdYwitgehqH1sVh0u/TmpnXa1LQVXKwYooYas5qmUfQsPjYGa50jEcXJLX38DRTxdhxbZbheLUT5Go0seiNS6X5wxtZzGrQbbnBbFSEA9UZP3xwIR973nA0pRt4JZj6lZ67t9C46Dkha6NTrr/GP5v8cw8m69kafnacDrfaFvcL7jAClWc62eYIj8a6HQDjaemTwKwQ5Arxvcs1hwfnOntXq+1SCzJj2MlwyQnc9YitsM5P55LCnShai2k7QkRq4F05z/Xo4imbPUZ98ul0flEuSjzaSTq2Vwg==;5:0YqM9kKqLf72P+pf/xf1JwuFZG+klh6D/q5OMnJyi+faFbfqF5gYJ5XoCxlshCKMQgVmjwAwU1tiD1JA70TlSR0+0ekSB+YUcLC2X0e+7npDIeRxPodM/GfF8AELZrKyyuQOTIHyrqOn4mXjzUVlmZSIcokYgahTdScNzH2BUQI=;7:Pl62jGv0rKbqjoZ4rOKZgb5hbujOngaeqE3Ud92gyhfbgcZlo5KFhaTP5CGMj2Gblx0lJSVM7twlR7iwYRjUlHUVheZJ1GQzd1oW54sHrL3wo59+99GPSlPWxYn/Oe4uxoK0+LLca+q0NZZr/856uOYF68lOMfIxKK1sYztXJssaKk9Rc/v3lCKU1ZzWGUdkqUaHZ7yBpE+PMXlghIj4KNw3T7O6T85YBm6/I13IFqrHsxsEav2cthw4xI4wwzxi
x-ms-office365-filtering-correlation-id: 389fea43-7a8a-4a8c-fddf-08d61f3acdc6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB3991;
x-ms-traffictypediagnostic: BYAPR08MB3991:
x-microsoft-antispam-prvs: <BYAPR08MB3991AFAA7F7EC99BE638D0BBC1130@BYAPR08MB3991.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR08MB3991;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB3991;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(396003)(376002)(366004)(39850400004)(199004)(189003)(4326008)(6246003)(3846002)(14454004)(33716001)(81156014)(66066001)(1076002)(25786009)(33896004)(6116002)(9686003)(6512007)(2900100001)(97736004)(6436002)(6486002)(5660300001)(5250100002)(229853002)(53936002)(58126008)(102836004)(2906002)(305945005)(42882007)(106356001)(6916009)(39060400002)(478600001)(99286004)(486006)(386003)(316002)(6506007)(446003)(26005)(7736002)(14444005)(256004)(11346002)(52116002)(105586002)(8936002)(44832011)(68736007)(76176011)(8676002)(54906003)(81166006)(186003)(476003)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB3991;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ra45kX6bkb9OhXTXsmeYsiPzsoCifbYJmHnxNDQxkGUk3m1r5HN/zoGAhGimWSwybKh4x0N3FA9va6VpNPts0S3kFB2euI35JzLCgaAdD3c2oHDmfDUulusAnQ9gzEcHlG2SyeLHKWZdR6fDF+rJZGI1EJvpIh//HbWO6yWZ5WhjioKHKqtY6t/vOY9K1tXM/KD1V8IWqDl7dfrquhmiRV6H23UAOE9GVeUQI0wUK5SZXohdPvtv4lSX2ptLIW4Ho93Rms26K24oJgqKnH3GB4uuGvNZovE+Emtg3lZXe0sdkkdNPy6AGflRo/1IqdydATiW3fPYdMSXR/RjAMRz7tTBnpjGk1s+jg3kz9suqHM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D6AAE453CCF454FA73BC4673444AB4C@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389fea43-7a8a-4a8c-fddf-08d61f3acdc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:51:14.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3991
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66467
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

Hi Huacai,

On Thu, Sep 20, 2018 at 09:11:03AM +0800, Huacai Chen wrote:
> Original Loongson-3 pci_ops can only access standard pci config space,
> this patch let it be able to access extended pci config space.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/pci/ops-loongson3.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)

Thanks - applied to mips-next for 4.20, with a couple of tweaks to
satisfy checkpatch.

Paul
