Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2015 09:04:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37388 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008431AbbFIHExgdHFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Jun 2015 09:04:53 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5974mMu002808;
        Tue, 9 Jun 2015 09:04:49 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5974gWd002807;
        Tue, 9 Jun 2015 09:04:42 +0200
Date:   Tue, 9 Jun 2015 09:04:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] ssb: fix handling of ssb_pmu_get_alp_clock()
Message-ID: <20150609070442.GA2753@linux-mips.org>
References: <1433634771-23438-1-git-send-email-hauke@hauke-m.de>
 <20150607090223.13463c73@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150607090223.13463c73@wiggum>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47905
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

On Sun, Jun 07, 2015 at 09:02:23AM +0200, Michael Büsch wrote:

> Signed-off-by: Michael Buesch <m@bues.ch>
> 
> Can some MIPS people take this, please?

Will do, as usual.  Unfortunately this missed my last pull request so
it's going to Linus by the end of the week.

  Ralf
