Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 03:06:07 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.200]:41621 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeEaBGAt5lJt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 03:06:00 +0200
Received: from [216.82.242.46] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-8.bemta-8.messagelabs.com id DE/9C-16135-77A4F0B5; Thu, 31 May 2018 01:05:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTURzHd3bv7q7m9DQ1f41MWg96zVz0WKA
  VETKDInr8k73u6uaW27TdWYZgmmXqrGZq1ECyt1pSmYW16GH2MIJyRpBYTnSU00QsBLG03d1p
  9d+X8/mc8/uew6EJ+QtKQbOZVtZiZoxKKphc8vQ0qzq0Liw57tmVII3bbZNqPvRs1ZS8HiQ19
  vIzUs2p3peE5mYzu5rSdv3+RmofOD5LtR2ex4S2rqaQ0r6orhVre5s6yY3UNonBrEvL3C3Rj3
  3vkKb/DM38UV9E5KCrIUUomJbjAgSej26qCAXRgLNg+G6tmAeAxxB0Os5JBKuUANfb235C4hs
  E1Jc6pfwWOS4XQ4V9lWB9QeD+2E/ygMJLwekZ8ecIPAeqWx5KeYnAnxB0uO74B4ZjPfR5bGJB
  MkB/2ysk5MVwvvU5wWcSz4bKV5/8vgxvh8vHr1LCtCoEw7ZR/+YgnAAtb775KyEcDaUPc/3rB
  I4CV+mlwO0wXHn0jhByJPR0jUoEfye8rStAwvoMqLcVBvxocF2wIeE1GkiwH2uVCEAFA+XlhA
  DuI8grc4oFMB9ODzQFJsTDiWceXyPal1Ph7GjSuFLQ5Ajo06HmZCdpR2rHP12FvBAqnYOBvAC
  uXewlHP4HmAzN57vJSkTWoLkcaznIWlSLl8fqLIYUvdXEGIwqdZwm1sRyHJPCGhkdF7snzVSH
  fF/qiEiEGlB79/pGNJUWKyNlrVmhyfJQXdrew3qG0++yZBhZrhFNo2klyFYkhSXLJ1vYFDZzn
  8Ho+5fjGOgQZYQsiMcyLp0xcYYUAb1BKro9v7iYkJPmNDOriJJF8xLmJX2GeeKI8d/tQtGKcB
  kSiUTykHTWYjJY/+deFEUjZbgsiT8lxGC2Tkzy+kqIfSW6SybxJazMX6TIQVvyTulze4wx7pd
  tOWtXaZ1Da9TXl62dh/Ni+jqHvQk/C97da3xwIPF63ab3iwjtjuyjU8LUqTscw/dmrs735qmy
  h4y9t+yDZcEzfzW0k4rUgQ0jXSW3njRX5O6viKsfrUpsURRPmi7VzGpTFm1W69K/3u74EFu1k
  joQGR/homofXVaSnJ5RzycsHPMH/Yo1gtgDAAA=
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-12.tower-96.messagelabs.com!1527728758!104866358!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11006 invoked from network); 31 May 2018 01:05:58 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-12.tower-96.messagelabs.com with SMTP; 31 May 2018 01:05:58 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 03B7E294002; Thu, 31 May 2018 10:05:58 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 31 May 2018 10:05:57 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id A036F1AC001;
        Thu, 31 May 2018 10:05:57 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0180.outbound.protection.outlook.com [23.103.139.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 99FB8294001;
        Thu, 31 May 2018 10:05:57 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXWD4mN9K3fqADd3cLns0Cfsq6Wd7SwYhpXLlRXL0qw=;
 b=dXzncTdeW6zdDOs+RYjyW1wUcF79B4lpjGISveBW07T9cnffbbxwBXf9eYOzjRv6MYzlwwtPkAL7mLGEk5lxf2O+7vd1Wq4u3gCwDs8gmBc1MMHqnUN5NhzdQYQ41evNBPqAkW11TuXXDiHEG8kQEDgi6Ulx25zLgMftqx+4Y1o=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB1532.jpnprd01.prod.outlook.com (52.133.162.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.797.11; Thu, 31 May 2018 01:05:56 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c%13]) with mapi id 15.20.0797.020; Thu, 31 May 2018
 01:05:55 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     Paul Burton <paul.burton@mips.com>
CC:     James Hogan <jhogan@kernel.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rafa~B Mi~Becki <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v2 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync
 for BCM47XX PCIe erratum
Thread-Topic: [PATCH v2 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Thread-Index: AQHT+GtgJnE4w78axkCScsWrxCGwWKRJBc2Q
Date:   Thu, 31 May 2018 01:05:55 +0000
Message-ID: <TY1PR01MB0954638FF312010E00C03BC3DC630@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
 <20180528002451.2622-2-ikegami@allied-telesis.co.jp>
 <20180530230955.ggmiv2r5b2gkfczm@pburton-laptop>
In-Reply-To: <20180530230955.ggmiv2r5b2gkfczm@pburton-laptop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1532;7:TzjOSpnYk7F61wfmkA1G1ATXf9woWBn3wYnh/cdGWZ8Fie2K5nvOjgjB7mbrxnExUwRMOcx6ihJDTDazUmCyhHTOduLJOO89A4/+PrnDSyWqIz1VGp6oJxJpzzWoJxY6wANQjZnze5peUyLetqf+UwFMnaWOvMYiXrht8a7d9wUNdHYmwZTifkt/rKCH6uE2TMgArHCJ+8l+Ii5Q+d9At/pWPCTEi/DGG3yJtAcglF5L4EN0JS+84+y147V6Fzrq;20:cxITmXwW5Q/KC9km2WPJ69LsikNtWmIwOSlXtPo/bo3tksc5DChj+cjF3eCHkU3vxELpNbq1kBdZcHcbzv8S+QafBUTSlSDx5HIInZQ7FjuuS6iVCUTRQOpdQbl6MVmBjVEInhv8Mw61wtQC98JGSFMQtjqU1zrQeDErZN0Z34ftBDiKFCJVW3WJe1Wg61NS+kb1ZkyTiwwHjZ3iiof7Ew+1Xev5i4vuV2oK/EnVuSVjmqkqMIwM/zBSauRUGDNA
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1532;
x-ms-traffictypediagnostic: TY1PR01MB1532:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB15322B91AD4F1CF6355F3344DC630@TY1PR01MB1532.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1532;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1532;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(346002)(366004)(39380400002)(376002)(189003)(199004)(13464003)(6916009)(102836004)(66066001)(3280700002)(2906002)(6506007)(59450400001)(53546011)(11346002)(2900100001)(446003)(7696005)(8936002)(5250100002)(305945005)(7736002)(478600001)(316002)(74482002)(6436002)(476003)(74316002)(86362001)(81156014)(9686003)(53936002)(229853002)(25786009)(26005)(4326008)(14454004)(6246003)(33656002)(68736007)(3846002)(3660700001)(8676002)(81166006)(39060400002)(5660300001)(106356001)(105586002)(54906003)(55016002)(186003)(97736004)(76176011)(486006)(99286004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1532;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 1Ob64fXha5mZv5K9EBB1FwItWVIXHkl48cOx1zgARP3BKNN1vDrRHruXaxT4D+8Kfo1VFb6M4b/sQxpfQ/sRPvTrOL/vEmh3sxWFkE9ObI+m1CqD/Wt2Y32EAXE0sIvMbU5lk2+if4Tkj0Ddaq1M6VB/C0Ywo4s2FxT4YSmYzazUuOd5UrqM4RUPmhQRAgHU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6c422348-7cc2-406d-465e-08d5c692a9c8
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c422348-7cc2-406d-465e-08d5c692a9c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 01:05:55.7855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1532
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ikegami@allied-telesis.co.jp
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

Hi Paul-san,

Thanks for your reviewing and advices.

> Could this be moved to platform-specific code, in order to avoid the
> platform-specific #ifdef in generic code?
> 
> For example, this would seem like a good fit for the existing
> bcm47xx_cpu_fixes() function.

  I have just fixed this by v3 patch series so please review again.

Regards,
Ikegami

> -----Original Message-----
> From: Paul Burton [mailto:paul.burton@mips.com]
> Sent: Thursday, May 31, 2018 8:10 AM
> To: IKEGAMI Tokunori
> Cc: James Hogan; PACKHAM Chris; Hauke Mehrtens; Rafa~B Mi~Becki;
> linux-mips@linux-mips.org
> Subject: Re: [PATCH v2 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
> ExternalSync for BCM47XX PCIe erratum
> 
> Hi Tokunori,
> 
> On Mon, May 28, 2018 at 09:24:51AM +0900, Tokunori Ikegami wrote:
> > diff --git a/arch/mips/kernel/cpu-probe.c
> b/arch/mips/kernel/cpu-probe.c
> > index cf3fd549e16d..75039e89694f 100644
> > --- a/arch/mips/kernel/cpu-probe.c
> > +++ b/arch/mips/kernel/cpu-probe.c
> > @@ -427,8 +427,18 @@ static inline void check_errata(void)
> >  		 * making use of VPE1 will be responsable for that VPE.
> >  		 */
> >  		if ((c->processor_id & PRID_REV_MASK) <=
> PRID_REV_34K_V1_0_2)
> > -			write_c0_config7(read_c0_config7() |
> MIPS_CONF7_RPS);
> > +			set_c0_config7(MIPS_CONF7_RPS);
> >  		break;
> > +#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
> > +	case CPU_74K:
> > +		/*
> > +		 * BCM47XX Erratum "R10: PCIe Transactions Periodically
> Fail"
> > +		 * Enable ExternalSync for sync instruction to take effect
> > +		 */
> > +		pr_info("ExternalSync has been enabled\n");
> > +		set_c0_config7(MIPS_CONF7_ES);
> > +		break;
> > +#endif
> 
> Could this be moved to platform-specific code, in order to avoid the
> platform-specific #ifdef in generic code?
> 
> For example, this would seem like a good fit for the existing
> bcm47xx_cpu_fixes() function.
> 
> Thanks,
>     Paul
