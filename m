Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 23:00:10 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:52067 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867257Ab3LRWABhPH8w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Dec 2013 23:00:01 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 18 Dec 2013 13:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,509,1384329600"; 
   d="scan'208";a="452256438"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2013 13:59:50 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.5.110]) by
 ORSMSX103.amr.corp.intel.com ([169.254.2.114]) with mapi id 14.03.0123.003;
 Wed, 18 Dec 2013 13:59:50 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mark Salter <msalter@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 00/10] Kconfig: cleanup SERIO_I8042 dependencies
Thread-Topic: [PATCH v2 00/10] Kconfig: cleanup SERIO_I8042 dependencies
Thread-Index: AQHO+z/OuxcCzhfNTESZVWf9Hu2Bc5pagiFA
Date:   Wed, 18 Dec 2013 21:59:49 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D8CDD5@ORSMSX106.amr.corp.intel.com>
References: <1387295333-24684-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1387295333-24684-1-git-send-email-msalter@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <tony.luck@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38755
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

> This is v2 of the patch series. Changes from version 1:
>
>  o Added acks. arm, ia64, and sh are only ones without acks.

ia64 bits look OK

Acked-by: Tony Luck <tony.luck@intel.com>
