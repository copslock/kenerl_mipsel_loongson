Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 11:33:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54645 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbdH1JdcDC1Bz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2017 11:33:32 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3034EB2D44F19;
        Mon, 28 Aug 2017 10:33:23 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 28 Aug
 2017 10:33:25 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Mon, 28 Aug 2017 02:33:22 -0700
From:   Miodrag Dinic <Miodrag.Dinic@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>
Subject: RE: [PATCH v4 8/8] MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if
 MIPS_GENERIC
Thread-Topic: [PATCH v4 8/8] MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if
 MIPS_GENERIC
Thread-Index: AQHTGCO8zCH0uE7J3kGnsE7DpIV426KW9+qAgAKWrAo=
Date:   Mon, 28 Aug 2017 09:33:21 +0000
Message-ID: <232DDC0A2B605E4F9E85F6904417885F015D956D48@BADAG02.ba.imgtec.org>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-9-git-send-email-aleksandar.markovic@rt-rk.com>,<20170826105235.GF7433@linux-mips.org>
In-Reply-To: <20170826105235.GF7433@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Miodrag.Dinic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@imgtec.com
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

Hi Ralf,

Even though I agree with your approach in handling this issue is more appropriate,
but the reason we isolated this option just for MIPS_GENERIC was because we
are not quite sure which MIPS platforms were using this option (and effectively i8042 driver), except for Malta.
So, we decided to go with a safer solution and deselect it only for platforms which we are most sure aren't going to use it.

If you prefer to have this option sprinkled across platforms which are using it, please indicate which those are.

Kind regards,
Miodrag

________________________________________
From: Ralf Baechle [ralf@linux-mips.org]
Sent: Saturday, August 26, 2017 12:52 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; Bo Hu; Douglas Leung; James Hogan; Jin Qian; Paul Burton; Petar Jovanovic; Raghu Gandham
Subject: Re: [PATCH v4 8/8] MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if MIPS_GENERIC

On Fri, Aug 18, 2017 at 03:09:00PM +0200, Aleksandar Markovic wrote:

> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
>
> This effectively disables i8042 driver for MIPS_GENERIC kernel platform.
> Currently, only sead-3, boston and ranchu boards are supported by the
> MIPS generic kernel and none of them require this driver.
> More specifically, kernel would crash if it gets enabled, because
> i8042 driver would try to read from an non-existent IO register.

And many more platforms would beneftig from disabling this option because
let's face it, the i8042's heydays are over.  So rather than spreading
random depenencies on MIPS_GENERIC or other platforms through Kconfig
please push the select of ARCH_MIGHT_HAVE_PC_SERIO to the platforms.

  Ralf
