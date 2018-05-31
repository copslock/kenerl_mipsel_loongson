Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2018 00:23:34 +0200 (CEST)
Received: from mail1.bemta12.messagelabs.com ([216.82.251.12]:24615 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994688AbeEaWX1SdTU4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Jun 2018 00:23:27 +0200
Received: from [216.82.251.38] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-12.bemta-12.messagelabs.com id 4D/6E-31138-DD5701B5; Thu, 31 May 2018 22:23:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTYRTHfXbvtps6eZyKJ0mrkRbVVkbSwIQ
  gpAVSEkRgYV3ztg23OXZnaX2xD9Xc1Ka2wGFkvgSuWWDiW2Xmy8iIXoZQhqVSk5xCZWVKlO3u
  Tqvn0/85v//zv+ceDkVI+0UJFFNsZkwGWicThZM7+y4z8rEifHT7N/t25cSETawcmT6srHo8R
  yrtjmqxsnLGQyjdw8weker9r4+kqtv5Vqwa9/USqjZXmUg11NIqUM0MTpLZohyh1pBXWHxCqF
  lsTDF2RhU/8FjEpWgqworCKSm2ILhX0S62olUU4LPwxfpMzAHASwhstlHEu2oIqF6wE9yFxLc
  I6OjyinhiF4B7aUnIX94h6OloFXJhIpwG93w/SU7H4hRoedkTDCbwLIK705UCK6KoGKyBH24j
  79FCn/8VwZVj8Q742hnPlUmcDIMPxwhOS/Ax6PQ5g5FS7ELQeCGd06twBtx21wXrCCdCTc95A
  acJHA/emgYR/28Ymu4/J3gdB9Pvfwt5fy48bbMgvr4e2m1lIX8ieK/bED+LLhL6G18JeCCHzw
  4HwYMOBM6Bj6HXm+HL4ufQJHfDpUe+kC6AT3NW8bLHMugMBSWBq2KStKNU5z/N8loBU0+cJK+
  3wM0bM4QzOIBoGK79QNYj0oU2sozpNGOSKxV5Jq1aY9bTWp08NXWHQs+wLK1mdHQeqzhZqG9D
  gX0KC5wuNN+0tx+tpgSyOElNEj4qjcorzC/R0KzmuKlIx7D9aA1FyUDiMgdYtIlRM8WntLrAU
  i5joCJlsZIDHJawRlrPatU8eoLk1NjF8nJCShoKDUxCvKSZM2HOpCkyrEQsr7YXJSbESFCgKW
  mkkTHpteb/uR/FU0gWIznCpURqDeaVL/kDTQgCTcwkBpsw039RQimqnfqUMxA3sGFhblRu2Tm
  +17gnw+dvkrrfZLcI1x7OTc86F2Zvdg+X5K/LpJUOMsuVb7gTVWeYr3+ePPJu29YzsYv7Hrze
  1aS/lpbUO+sVfo9a0pS+SMptp6I9QwWPryRHns1M3u9YvCqr21Q1eqdhcOjmwRh1hGIWPJSno
  lt+SEayGjp1M2Fi6T9jZA4S1QMAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-7.tower-163.messagelabs.com!1527805404!159706164!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18753 invoked from network); 31 May 2018 22:23:24 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-7.tower-163.messagelabs.com with SMTP; 31 May 2018 22:23:24 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id B2AE3294002; Fri,  1 Jun 2018 07:23:23 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 1 Jun 2018 07:23:23 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 5D2A81AC001;
        Fri,  1 Jun 2018 07:23:23 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0183.outbound.protection.outlook.com [23.103.139.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 57517294001;
        Fri,  1 Jun 2018 07:23:23 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnTRNeDkPHzPTvt8ymshDTnK+Qd2FDmB0hkMG4DfLYY=;
 b=FftjxnJkm/BbFXmdvWTEf61seBam/tcwbAQKqDNxisJ07x5Jm0GKnChGbJF91cgH8Ta2XPi7mPkqB8llRx9XhTEBpVVWhuuLqjfqhQ6BWzXLAj/jSNba8aqw/+PVy4SWcMn59WMHdqwBfEn0hAfzGUllark9dbK20iboSLc2bl0=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB0652.jpnprd01.prod.outlook.com (10.167.158.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.820.11; Thu, 31 May 2018 22:23:22 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c%13]) with mapi id 15.20.0797.020; Thu, 31 May 2018
 22:23:22 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     Paul Burton <paul.burton@mips.com>
CC:     James Hogan <jhogan@kernel.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v3 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync
 for BCM47XX PCIe erratum
Thread-Topic: [PATCH v3 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Thread-Index: AQHT+SNFqDD+tzqtNkCegg2lw9/vFqRKaOWg
Date:   Thu, 31 May 2018 22:23:22 +0000
Message-ID: <TY1PR01MB095422E0FBF67B50E3D1F9F0DC630@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <20180531010240.16991-1-ikegami@allied-telesis.co.jp>
 <20180531010240.16991-2-ikegami@allied-telesis.co.jp>
 <20180531210622.btphkhpujfxnybq4@pburton-laptop>
In-Reply-To: <20180531210622.btphkhpujfxnybq4@pburton-laptop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0652;7:n+Wcfe0qwelQ01yv+e+tQ6BduQTyhnQ6z9SrxL2lLTPN12Rm4JUIy0+LAAycs6rNW9Kn/zXXJfhNYJXdqLs5vzFC09XnrgqAApctCR4pOXkNB952tscIYpXPj32xe0TGqsNdtitzNfeSdTDyNOaD39om7I78kcyIbSlq9dcZkoCe45nxSN/GCnSSFI+FUKbQuHH1DYv1JtYmrX6CoAWalgsktpSVjnayMao8Zsqin4OezJwrl2MI79RLSAhjBtGn;20:TztVTTFP0MkK7I0m7CAZeSIIPNksrasOkBsHK90YPUcq3qxcgKLCk+2l92ZKbZb7ArE77qnM8DaDNh2UiXWXtKdy9Uz2H4tRiEPronwz9hMXJ0iNuJjg3lXdNix9CfI9aY5Bp22fdUjn66zkyI8QwH4CoZm31OcsFOTcaWBsa1vUbRt1Iqzy2D+oY6UIlDAMIZ9Qu0dLLYAbQLTt26n9ZFFMcgRp0rWUMayh2/0WqQ5O/MmuJr9dTY6Q6460Is7f
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0652;
x-ms-traffictypediagnostic: TY1PR01MB0652:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB06522BA8FB2210E8AFA075C6DC630@TY1PR01MB0652.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0652;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0652;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39830400003)(396003)(376002)(346002)(199004)(189003)(13464003)(5660300001)(6436002)(26005)(53546011)(7696005)(316002)(6506007)(33656002)(68736007)(76176011)(6916009)(229853002)(8676002)(99286004)(74316002)(54906003)(102836004)(2906002)(305945005)(3280700002)(486006)(476003)(55016002)(8936002)(81166006)(81156014)(2900100001)(6116002)(3846002)(11346002)(446003)(3660700001)(7736002)(9686003)(14454004)(25786009)(97736004)(53936002)(6246003)(478600001)(66066001)(186003)(74482002)(106356001)(105586002)(39060400002)(86362001)(5250100002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0652;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: mfWHIW9xtCjjO6b+mVeGSYQ91kPfl8WPNjxcDAP4EGOg8fgmWuXR+eTr4LjGT3dyFaTdh200o5XFm1oGwh3rNap/vUDmQac3OhGDz/V0fAGmC+GSK3VDtxGfc/x+AMMGJYftx055rloccB6DA5Uf0O7UBTmTIb5j/OvIPSv7VI2Is0VxQh4jb5/c1m5+nTct
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 820348e1-a6ce-4982-8c6c-08d5c7451e95
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 820348e1-a6ce-4982-8c6c-08d5c7451e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 22:23:22.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0652
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64142
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

Thank you so much for your reviewing.

> My only other niggle would be questioning whether we really need the
> pr_info() - I'd probably go without it, but it's not a strong opinion so
> either way:

  I have just sent v4 patch without pr_info().

>     Reviewed-by: Paul Burton <paul.burton@mips.com>

  Also I added this Reviewed-by tag line into the commit message.

Regards,
Ikegami

> -----Original Message-----
> From: Paul Burton [mailto:paul.burton@mips.com]
> Sent: Friday, June 01, 2018 6:06 AM
> To: IKEGAMI Tokunori
> Cc: James Hogan; PACKHAM Chris; Hauke Mehrtens; Rafa³ Mi³ecki;
> linux-mips@linux-mips.org
> Subject: Re: [PATCH v3 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
> ExternalSync for BCM47XX PCIe erratum
> 
> Hi Tokunori,
> 
> On Thu, May 31, 2018 at 10:02:40AM +0900, Tokunori Ikegami wrote:
> > diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> > index 6054d49e608e..8fec219e1160 100644
> > --- a/arch/mips/bcm47xx/setup.c
> > +++ b/arch/mips/bcm47xx/setup.c
> > @@ -212,6 +212,13 @@ static int __init bcm47xx_cpu_fixes(void)
> >  		 */
> >  		if (bcm47xx_bus.bcma.bus.chipinfo.id ==
> BCMA_CHIP_ID_BCM4706)
> >  			cpu_wait = NULL;
> > +
> > +		/*
> > +		 * BCM47XX Erratum "R10: PCIe Transactions Periodically
> Fail"
> > +		 * Enable ExternalSync for sync instruction to take effect
> > +		 */
> > +		pr_info("ExternalSync has been enabled\n");
> > +		set_c0_config7(MIPS_CONF7_ES);
> 
> Great - this looks better placed than v2, and so long as this erratum
> only applies to systems using BCMA this looks good to me.
> 
> My only other niggle would be questioning whether we really need the
> pr_info() - I'd probably go without it, but it's not a strong opinion so
> either way:
> 
>     Reviewed-by: Paul Burton <paul.burton@mips.com>
> 
> Thanks,
>     Paul
