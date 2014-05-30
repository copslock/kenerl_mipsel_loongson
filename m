Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 11:05:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60198 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822106AbaE3JFHgNnDH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 11:05:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4U955Yf016913;
        Fri, 30 May 2014 11:05:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4U954XN016912;
        Fri, 30 May 2014 11:05:04 +0200
Date:   Fri, 30 May 2014 11:05:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH][next: 3.16] MIPS: BCM47XX: Slightly clean memory
 detection
Message-ID: <20140530090504.GJ5157@linux-mips.org>
References: <1397904586-9773-1-git-send-email-zajec5@gmail.com>
 <CACna6ryVwqeSW22R3QrE1DcRkRmrJFWbpuHHm55DiazqXfabqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6ryVwqeSW22R3QrE1DcRkRmrJFWbpuHHm55DiazqXfabqw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40380
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

On Fri, May 30, 2014 at 10:45:41AM +0200, Rafał Miłecki wrote:

> On 19 April 2014 12:49, Rafał Miłecki <zajec5@gmail.com> wrote:
> > Patch was tested on devices with 64 MiB and 256 MiB of RAM.
> > It documents every part nicely and drops this hacky part of code:
> > max = off | ((128 << 20) - 1);
> 
> I can't see this patch in any git tree. Am I missing some, or was this
> patch forgotten?

Nope - if it's in patchwork it's not forgotten.  Just slightly burried.
Really, patchwork is the ledger.  If a patch is there, don't resend or
I will hate you ;-)  If it's not there but should be, enquire.  If it's
marked "Accepted" but doesn't show up anywhere - enquire.

  Ralf
