Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 16:14:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39094 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822678Ab3HAOOA3v057 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 16:14:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r71EDxPp004568;
        Thu, 1 Aug 2013 16:13:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r71EDw1B004567;
        Thu, 1 Aug 2013 16:13:58 +0200
Date:   Thu, 1 Aug 2013 16:13:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
Message-ID: <20130801141358.GB3466@linux-mips.org>
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org>
 <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
 <51F963E7.50407@gmail.com>
 <1687511.8JA8mPPmNW@lenovo>
 <51F9FD16.4030706@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51F9FD16.4030706@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37416
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

On Thu, Aug 01, 2013 at 08:15:50AM +0200, John Crispin wrote:

> >Whatever works for you. I still would like to understand why plat_time_init()
> >is not suitable for John's specific use case.
> 
> Hi Florian,
> 
> the reason is that fixing it in plat_time_init() works around the
> real problem. the double request of the irq is a symptom of the
> actual problem, which is, that the cevt-r4k sets up the timer during
> init and not during setup. additionally, plat_time_init is used to
> probe the cevt drivers from OF already. currently the mips code just
> assumes that on a r4k we always have and want to run the cevt-r4k.
> this assumption is wrong and can quickly be fixed by making the
> cevt-r4k use the correct api.
> 
> also fixing it this way allows the user to control the clocksource
> and change it at runtime via sysfs, a feature als not working
> currently on r4k as the cevt driver did not implement the set_mode()
> handler correctly. to be quite honest, i cannot think of a single
> way in which this can be fixed cleanly in the ralink
> plat_time_init() without using some weird heuristic. also if i fix
> this inside ralink plat_time_init() it is fixed only on ralink SoC
> and not on any other platform.

setup_irq() may fail but set_mode doesn't have a way to communicate an
error - other than leaving back a half-wrecked system so set_mode is not
a good place to do that kind of job.

How about using get_c0_compare_int() for a solution?  Currently
get_c0_compare_int() can not return an error.  If it could return a
negative value to indicate the unavailability of an interrupt for
cevt-r4k's use, that interrupt would be available for alternative use.

  Ralf
