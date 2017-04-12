Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 22:10:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58142 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993928AbdDLUKjjCiTg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 22:10:39 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CKAakK031931;
        Wed, 12 Apr 2017 22:10:36 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CKASOf031929;
        Wed, 12 Apr 2017 22:10:28 +0200
Date:   Wed, 12 Apr 2017 22:10:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nicolai Stange <nicstange@gmail.com>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        John Crispin <john@phrozen.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: clockevent drivers: set ->min_delta_ticks and
 ->max_delta_ticks
Message-ID: <20170412201028.GA31873@linux-mips.org>
References: <20170326134403.16226-1-nicstange@gmail.com>
 <20170330194732.7126-1-nicstange@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330194732.7126-1-nicstange@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57680
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

On Thu, Mar 30, 2017 at 09:47:32PM +0200, Nicolai Stange wrote:

> In preparation for making the clockevents core NTP correction aware,
> all clockevent device drivers must set ->min_delta_ticks and
> ->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
> clockevent device's rate is going to change dynamically and thus, the
> ratio of ns to ticks ceases to stay invariant.
> 
> Make the MIPS arch's clockevent drivers initialize these fields properly.
> 
> This patch alone doesn't introduce any change in functionality as the
> clockevents core still looks exclusively at the (untouched) ->min_delta_ns
> and ->max_delta_ns. As soon as this has changed, a followup patch will
> purge the initialization of ->min_delta_ns and ->max_delta_ns from these
> drivers.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to push this to Linus.

  Ralf
