Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 16:02:38 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:23364 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995078AbdHIOCZjLpC6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 16:02:25 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2017 07:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,348,1498546800"; 
   d="scan'208";a="1160867129"
Received: from irsmsx108.ger.corp.intel.com ([163.33.3.3])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2017 07:02:18 -0700
Received: from irsmsx112.ger.corp.intel.com (10.108.20.5) by
 IRSMSX108.ger.corp.intel.com (163.33.3.3) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Wed, 9 Aug 2017 15:02:18 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.250]) by
 irsmsx112.ger.corp.intel.com ([169.254.1.122]) with mapi id 14.03.0319.002;
 Wed, 9 Aug 2017 15:02:18 +0100
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Mark Brown <broonie@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Mehrtens, Hauke" <hauke.mehrtens@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Thread-Topic: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Thread-Index: AQHTEJkla2ZOI5AY2UK8gYMNJvv32qJ717iAgAA2lfA=
Date:   Wed, 9 Aug 2017 14:02:16 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
 <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
In-Reply-To: <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 10.0.102.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@intel.com
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



> -----Original Message-----
> From: linux-spi-owner@vger.kernel.org [mailto:linux-spi-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Wednesday, August 9, 2017 1:44 PM
> To: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: ralf@linux-mips.org; linux-mips@linux-mips.org; linux-
> mtd@lists.infradead.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; martin.blumenstingl@googlemail.com;
> john@phrozen.org; linux-spi@vger.kernel.org; Mehrtens, Hauke
> <hauke.mehrtens@intel.com>; robh@kernel.org; andy.shevchenko@gmail.com;
> p.zabel@pengutronix.de; kishon@ti.com; mark.rutland@arm.com
> Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
> 
> On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:
> 
> > Do not check which flash type the SoC was booted from before
> > using this driver. Assume that the device tree is correct and use this
> > driver when it was added to device tree. This also removes a build
> > dependency to the SoC code.
> 
> Why?  Is this assumption reliably true?

Yes. We only have one type of flash interface in the device tree, as they 
are connected to the shared EBU (External Bus Unit).
