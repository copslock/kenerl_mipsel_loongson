Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 22:53:37 +0200 (CEST)
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:35336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994601AbeITUx2j7By0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 22:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RvCmkmO6Bzcbv5AgjJNwbGU3N91G5zuOIMgi03OnGY=;
 b=Vkox50BEUMBW0rfOsZ/lJAhtVb986YkMIYgYfm01u2QRO/pOjx77r89BCGZn8j+Ci4ytGsCxw5i3+Pl4QJmouh8B4c+2jQaaqhIpCzGHbQhNBUgydtTCLBtr47ZFY7KgzpS6G22/ZgyJRS2x7fPDeudBaSyPu3IVe6wS26KffAs=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4821.namprd08.prod.outlook.com (20.176.255.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 20:53:17 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 20:53:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 2/2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
Thread-Topic: [PATCH 2/2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
Thread-Index: AQHUTLlv55mCPi4wOkyVU5zYQaVnDqT2sgQAgAAhKACAAttJAA==
Date:   Thu, 20 Sep 2018 20:53:17 +0000
Message-ID: <20180920205316.vbme4nupvge4n2t2@pburton-laptop>
References: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
 <1536991273-20649-2-git-send-email-chenhc@lemote.com>
 <20180918231714.oibdygquyojqud45@pburton-laptop>
 <CAAhV-H6r0Zy8KXLvPm12dRqNAEVm-YBztPAGefe6V1-NGn_zXA@mail.gmail.com>
In-Reply-To: <CAAhV-H6r0Zy8KXLvPm12dRqNAEVm-YBztPAGefe6V1-NGn_zXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4821;6:VqkAAoubvYN1PkDzybjgIZmXmpQnRwsrdapIjcHl1ITyNgUUDWXSVQPoDh419HzQHcLepKhZ+AAneJzux+suRoDCnOM9erguooV+DrzDz/BzKVwPaVFHpQzceE3SmL8lo96G6aFj2GqsYVzOGdbKelWB7M9jTn/u5+5hKbwrhA1r5VSjfm16WY+O5dcFxZdXRztyoFeUsjwNNJxIQixu6A46p7wFB4/1YHZjCbcgocGEJW97P9xv/7dVUGeCSjHgs502Wr+AfO+8DXB56+2YQZ1j3tgLFoidGyUVVZR6KDLz9iSHoI3R7SMApFl8WJiUQ4yRZOGm2bnNgZVjRXahMDGUH5A0zMAgeBAnw13w3QWAX4+0GKsOxY5PAgqTZnYtr5mqt4J5Cif0YGz82u+5e1eFl3Jte/6QkBeQf5AGfXH2u/686Fk29V55xQQ7X6URt7JlZcOH07XeUssJ8wj++A==;5:/wLO592yNdgFUTI5CRrNPOVh2lXBK5fzKGLdNZGdylXtw7ifP243UC7ybeTPaHoMB6MHwfxSSKSbIAV02vAJpeoOJRyukN7cwc9uLgB9a4znBgFf9qmMcfZK7UUvcwGcvRIobu2ba53KAx4KZGGw8p25BpzCCQxh27KNeKuNas4=;7:9Y9zC15tvWlVvgbQRjTfa60gPYrXG6uRF4h36kjIBZS2ji33ZlxuXlbZYabP62TwLrQVlBrQH+VUj72zaYqDhrp1k0AWN/2PytEeW08Tbp2T1D+xct/+bWDWyz/WH2RutR8kVSaSiMNQZ7VJI2DsOJoyzLkNAwl06+EeRvYW/RhkDgkUwcwCREkU7Gfs1CjsL26HOheSwKglwpxVTdtPRdI4lG3UGQa7Ee2sglPHZY0PI0UxQXzOl0CH4puA7Ok7
x-ms-office365-filtering-correlation-id: 1e59110b-9212-490d-05f7-08d61f3b173e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4821;
x-ms-traffictypediagnostic: BYAPR08MB4821:
x-microsoft-antispam-prvs: <BYAPR08MB4821956BB698011F610E679FC1130@BYAPR08MB4821.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR08MB4821;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4821;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(136003)(39850400004)(396003)(366004)(199004)(189003)(2900100001)(42882007)(26005)(5660300001)(9686003)(3846002)(11346002)(8936002)(446003)(93886005)(7736002)(81166006)(33716001)(2906002)(8676002)(6486002)(53936002)(97736004)(14454004)(6436002)(6916009)(229853002)(66066001)(6512007)(44832011)(4326008)(1076002)(6506007)(316002)(106356001)(102836004)(58126008)(81156014)(186003)(54906003)(33896004)(478600001)(39060400002)(99286004)(76176011)(305945005)(5250100002)(105586002)(486006)(6116002)(25786009)(6246003)(256004)(476003)(386003)(68736007)(52116002)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4821;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OL3NgSDlE1xEeTGfACOpuwtIQKC1CYt9/r4/gA0YGUT7z8WhZ8kdQcXOoS4qTG+RjlNN03t8VSsxy18Y7RgjP7oxziCEc8s37iV+lqHf8JFd/hnz7mB67rmCY/wKJvrN0bdQzuRGumviCodh9ZMyQL/848sNT7lGeRIRpuezu4O7YoDtJz6rIibgifyN7XiXIlv6533o6OosUf6u6WnskHrjbPBMvjn6KdWdzZUQNguOou1/m8dw3JE1kOdL1uABrRq9ypQWCez/tEbn9Mm7AWDmw64TbH2+ocFC08iHNWduTTQ5/RFuxeXSyzUC9bRNlPkPF9TAwOr+VohIGJ23Q7UgUeP2CTSV4SaGrwwZrl0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5B06A631900864A9D5DD4250C3375F3@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e59110b-9212-490d-05f7-08d61f3b173e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:53:17.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4821
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66468
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

On Wed, Sep 19, 2018 at 09:15:54AM +0800, Huacai Chen wrote:
> I will improve this patch, and could you please read my new comments
> on the VDSO patch?

Yes, I saw your response. As mentioned I'm not keen to unconditionally
take away 4MB of the user address space, so I'm looking at whether we
can fix your issue without that.

Thanks,
    Paul
