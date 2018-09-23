Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2018 02:23:29 +0200 (CEST)
Received: from mail-sn1nam01on0136.outbound.protection.outlook.com ([104.47.32.136]:24548
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991947AbeIWAXZrfIMg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Sep 2018 02:23:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+bBgmFpSznxZ46ceee9N5xB4EENnN/XLfDX+0VXBFk=;
 b=qX6BkiPM9quskEE+dG89/dnIOMf21rrU0XIsltywLt7P3tqV7S0l3TyIWtQyUwFYNPIyxH2USCrGuQYWCyI0JQfXZqp2gl+c/l0fypvCjaiNTLID5s2YTZXs2Mb71IoW7GpMB/uFR18IUUWf5nN1mR6DPQPX3Ex6QqM8vJuUPBs=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4535.namprd08.prod.outlook.com (52.135.234.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Sun, 23 Sep 2018 00:23:15 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Sun, 23 Sep 2018
 00:23:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
CC:     Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [PATCH v5 0/5] MIPS: kexec/kdump: Fix smp reboot and other issues
Thread-Topic: [PATCH v5 0/5] MIPS: kexec/kdump: Fix smp reboot and other
 issues
Thread-Index: AQHUShliJBIe/gWX3kO51R6v4Ng2PaT9EwYA
Date:   Sun, 23 Sep 2018 00:23:15 +0000
Message-ID: <20180923002312.tewwnbfcpxud3nrt@pburton-laptop>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
In-Reply-To: <20180911214924.21993-1-dzhu@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0036.namprd19.prod.outlook.com
 (2603:10b6:903:103::22) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4535;6:hEa9zn36O2q/INBFBS/C8yTwnTT9L/vRIl5fGq2f/OWdvAlDAzbmxu5oiJzSBFlA7QyNKjk01sauZYKPUI66x547hBm7OhWOZTSxuN3HtMdUaXUyUxSrwVB5z9vo/ept6EOblU7vpXkEyws22JJMfopZrOXTVf6vJ3hUqH5UBRV/aAUrIAo4GE/NBj5X8+5mSwTM3RbJog956oeArCHNNbhI6sjBo6G2in+WR8CDLhLaif5tNo5jne3xxgaBp4qVOziWPeV8gcaEQ5ZiAO7ql0UEhNdpLaNH4iPYwf2ywW6W8qyuzI/WRCzlipSP2EV+/iqTrj4UfkA2ffb/HX1d9AVEoLAkINVXcTu3Z67z64Muhg/EdLAHRNi/o56xu674VSVhgyYUf6pf2okmEiBjBxaCvWL7YSj2LlUv9xewXFE+9QmInod/4qTV6xrBe0qtt0ECw4wAPAVTJLEiDK65bg==;5:IveK/oLdZYAIG/viT01f3fwJFJsVQQGwG3wNrJ/oanFcXZNUvdn6XgbEi1/mb53IGh0R3GEPsCXvK+q9Heiv/wOxg+AaOqVHs4V5zbLEiv4mvMJBEdt9udUJ6HKRUD9wDjYIoxldXWQsCT+8W5u+exsS6+a6UlxvmfcMZYVU7C4=;7:n/8+NMPrJzXY41k9kZL2DS9W293fJ0QT+EhfoYHQTf4rodz1sxMU5i4J3WtsFvXl8mAtAcx7QSehM8QKKiQidUIKuYUZpG3ERzMDHc/4EsErA9I4im4Nr6vFyXb6dnkQ9MJiSm5FeFtXjZoeL7mfNg0ldvded/hxHyZwij1krITKFMc9y05FxCLJ/tQjpL66ybZfj8jN4rkUqjhudjGnfvbROKaYWWfSqLxb5n7YrSeXLzIp2wAKwVx9jwrY/LXR
x-ms-office365-filtering-correlation-id: afddc391-bbd8-49ad-6b7b-08d620eac0a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4535;
x-ms-traffictypediagnostic: BYAPR08MB4535:
x-microsoft-antispam-prvs: <BYAPR08MB4535032B7BB93B778664FB2DC1100@BYAPR08MB4535.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:BYAPR08MB4535;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4535;
x-forefront-prvs: 08041D247D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(346002)(366004)(396003)(39830400003)(189003)(199004)(2906002)(33716001)(97736004)(4326008)(5660300001)(316002)(58126008)(44832011)(11346002)(6486002)(229853002)(446003)(42882007)(46003)(53936002)(54906003)(6116002)(256004)(6246003)(8676002)(71200400001)(71190400001)(25786009)(14454004)(6862004)(1076002)(478600001)(5250100002)(68736007)(52116002)(81166006)(305945005)(7736002)(8936002)(102836004)(6506007)(386003)(6512007)(9686003)(486006)(6436002)(81156014)(476003)(106356001)(33896004)(105586002)(2900100001)(76176011)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4535;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H+9UReBMSMr0KlVCAS5Jpv/tGXdiiwBSYEyfHXpjvqtktgYOJiDPn1yloIg4Kl4IgiydxRIZwpfQbY9RtU58vIAkvClOONePYM+Apc4qNQSRvkQ0qywiQQSgfiUbLK57CW2ygWXDnk6RUUAnpYOYDxLiznZWDz8bI3eNxeP8CdLRuZBboXyz+x00Oh7cxzKpEbZ0GAXlTrEYcAzywMUk6bTxvE2aNEQazCywn3TE0QWFntiu+7a4ysVu6hrUAUhPQ48zMAftqYXhfsG6fm4HrhYtc1Hg32wF7qdWMuRwCBsaEaGL+iyAvFVwDY5zwyP+m7hu3BLCfKyx+lKRXFxBXjRX4OGMN0Ff6eDmBwBoDH4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1CBDA78A78765429F1CBC803606C2E8@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afddc391-bbd8-49ad-6b7b-08d620eac0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2018 00:23:15.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4535
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66489
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

Hi Dengcheng,

On Tue, Sep 11, 2018 at 02:49:19PM -0700, Dengcheng Zhu wrote:
> This is a rewrite of the series. Basically patches 1~3 address what we
> dissussed so far. Now it allows both methods - shutting off the nonboot
> CPUs and jumping to relocated_kexec_smp_wait on nonboot CPUs.
> 
> Caches are flushed before signaling reboot. CPUs are marked offline to
> prevent getting IPIs. Note that this is done prior to disabling local IRQ.
> 
> Patch #4 is unchnaged. Patch #5 is the previous #6 -- I'm still putting
> it in here with reasons mentioned in our discussion and in the patch
> description.

Thanks for putting in the time & effort to address my concerns :)

I've applied the series to mips-next for 4.20, with a minor tweak to
patch 2 fixing CONFIG_SMP=n builds.

Paul
