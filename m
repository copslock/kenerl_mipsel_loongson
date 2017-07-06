Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 15:07:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7134 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993155AbdGFNHDS2Mix convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 15:07:03 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AC6FB87B911FD;
        Thu,  6 Jul 2017 14:06:53 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Jul
 2017 14:06:57 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Thu, 6 Jul 2017 06:06:53 -0700
From:   Miodrag Dinic <Miodrag.Dinic@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Aleksandar Markovic" <Aleksandar.Markovic@imgtec.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "James Hogan" <James.Hogan@imgtec.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        "jinqian@google.com" <jinqian@google.com>,
        "lfy@google.com" <lfy@google.com>, Bo Hu <bohu@google.com>
Subject: RE: [PATCH v2 0/7] MIPS: Miscellaneous fixes related to Android
 Mips emulator
Thread-Topic: [PATCH v2 0/7] MIPS: Miscellaneous fixes related to Android
 Mips emulator
Thread-Index: AQHS8CcogndMaCnPWEKsPjVNp/oNvqI67KqAgAvbCwc=
Date:   Thu, 6 Jul 2017 13:06:52 +0000
Message-ID: <232DDC0A2B605E4F9E85F6904417885F015D929D0F@BADAG02.ba.imgtec.org>
References: <1498665399-29007-1-git-send-email-aleksandar.markovic@rt-rk.com>,<20170628163011.GA17042@kroah.com>
In-Reply-To: <20170628163011.GA17042@kroah.com>
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
X-archive-position: 59029
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

Hi Greg,

> How well does these patches "work" with the recent goldfish
> images/kernels that are out there?  I know the goldfish platform has
> been revamped a lot recently, and I would not like to see these changes
> cause things to break there :)

Actually these changes have been in the Googles emulator kernel repo for
a long time and they fix issues found during Android testing :
https://android.googlesource.com/kernel/goldfish.git

So there should not be any regression with them.

> Also, any chance to get some google reviewers for these changes?  I
> don't think you added any to the cc: list, how come?

cc-ing Jin Quian, Bo Hu & Lingfeng Yang from Google.

Kind regards,
Miodrag

________________________________________
From: Greg Kroah-Hartman [gregkh@linuxfoundation.org]
Sent: Wednesday, June 28, 2017 6:30 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Douglas Leung; Goran Ferenc; James Hogan; Jiri Slaby; linux-kernel@vger.kernel.org; Miodrag Dinic; Paul Burton; Petar Jovanovic; Raghu Gandham
Subject: Re: [PATCH v2 0/7] MIPS: Miscellaneous fixes related to Android Mips emulator

On Wed, Jun 28, 2017 at 05:56:24PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>
> v1->v2:
>
>     - the patch on PREF usage in memcpy dropped as not needed
>     - updated recipient lists using get_maintainer.pl
>     - rebased to the latest kernel code
>
> This series contains an assortment of changes necessary for proper
> operation of Android emulator for Mips. However, we think that wider
> kernel community may benefit from them too.

This is nice, thanks for these.

How well does these patches "work" with the recent goldfish
images/kernels that are out there?  I know the goldfish platform has
been revamped a lot recently, and I would not like to see these changes
cause things to break there :)

Also, any chance to get some google reviewers for these changes?  I
don't think you added any to the cc: list, how come?

thanks,

greg k-h
