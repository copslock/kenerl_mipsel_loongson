Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2014 22:44:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43092 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823120AbaBUVohRltJr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Feb 2014 22:44:37 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s1LLiW6b029615;
        Fri, 21 Feb 2014 22:44:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s1LLiS1k029614;
        Fri, 21 Feb 2014 22:44:28 +0100
Date:   Fri, 21 Feb 2014 22:44:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] cpuidle/mips: remove redundant cpuidle_idle_call()
Message-ID: <20140221214428.GJ19285@linux-mips.org>
References: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39367
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

On Mon, Feb 17, 2014 at 11:09:45AM -0500, Nicolas Pitre wrote:

> I noticed commit c0b5d598aefda in linux-next adds a call to 
> cpuidle_idle_call().  At the same time we're rationalizing the idle 
> handling code in order to integrate it with the scheduler proper.  
> Please note that a similar patch to the one below will be necessary once 
> everything gets merged together.

So how shall we merge this patch, shall I fold it into c0b5d598aefda or?

  Ralf
