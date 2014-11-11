Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 10:33:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55913 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013352AbaKKJdoFa0Xk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 10:33:44 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAB9Xf6c027695;
        Tue, 11 Nov 2014 10:33:41 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAB9Xe2T027694;
        Tue, 11 Nov 2014 10:33:40 +0100
Date:   Tue, 11 Nov 2014 10:33:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 02/12] MIPS: Loongson: set Loongson-3's ISA level to
 MIPS64R1
Message-ID: <20141111093339.GA27259@linux-mips.org>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
 <1415081610-25639-3-git-send-email-chenhc@lemote.com>
 <20141110165907.GA11091@linux-mips.org>
 <CAAhV-H6zvHpGMvizbXOZU-E1aoxryU+L8Q1TSZoubB+72KM2AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6zvHpGMvizbXOZU-E1aoxryU+L8Q1TSZoubB+72KM2AQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Nov 11, 2014 at 09:14:48AM +0800, Huacai Chen wrote:

> In original code, both Loongson-2 and Loongson-3 are MIPS-III, after
> my patch, Loongson-2 is still MIPS-III and Loongson-3 is upgraded to
> MIPS64R1, so I think this is not "heavyhanded". Moreover, we need more
> tests to assure whether Loongson-3 is compatible with MIPS64R2 (except
> EI/DI), so set to MIPS64R1 is a safe way.

I see, I applied your patch.  However the cpu-probe.c part did reject
and I had to apply it manually so you may want to doublecheck the result
which I'm about to push to upstream-sfr.

Thanks!

  Ralf
