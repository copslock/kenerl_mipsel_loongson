Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 18:56:13 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:13331 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993905AbdF2Q4Fe8bvg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Jun 2017 18:56:05 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2017 09:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,281,1496127600"; 
   d="scan'208";a="105238805"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2017 09:55:47 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.165]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.9]) with mapi id 14.03.0319.002;
 Thu, 29 Jun 2017 09:55:47 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>
CC:     Thor Thayer <thor.thayer@linux.intel.com>, "Gross, Mark"
        <mark.gross@intel.com>, Robert Richter <rric@kernel.org>, Tim Small
        <tim@buttersideup.com>, Ranganathan Desikan <ravi@jetztechnologies.com>,
        Arvind R. <arvino55@gmail.com>, Jason Baron <jbaron@akamai.com>, Michal Simek
        <michal.simek@xilinx.com>, =?utf-8?B?U8O2cmVuIEJyaW5rbWFubg==?=
        <soren.brinkmann@xilinx.com>, Ralf Baechle <ralf@linux-mips.org>, David Daney
        <david.daney@cavium.com>, Loc Ho <lho@apm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, "linux-mips@linux-mips.org"
        <linux-mips@linux-mips.org>
Subject: RE: [PATCH] EDAC: Get rid of mci->mod_ver
Thread-Topic: [PATCH] EDAC: Get rid of mci->mod_ver
Thread-Index: AQHS8L8YVgzNLmzzOE6EL6WXBCuPRKI8Dx3Q
Date:   Thu, 29 Jun 2017 16:55:46 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F612E6E02@ORSMSX114.amr.corp.intel.com>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 10.0.102.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <tony.luck@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
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

PiBhbnkgb2JqZWN0aW9ucz8NCj4NCj4gLS0tDQo+IEl0IGlzIGEgd3JpdGUtb25seSB2YXJpYWJs
ZSBzbyBnZXQgcmlkIG9mIGl0Lg0KDQpOb3BlLiAgWmFwIGl0Lg0KDQpBY2tlZC1ieTogVG9ueSBM
dWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0K
