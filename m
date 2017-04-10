Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 13:11:55 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:43641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990845AbdDJLLtD8Q0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 13:11:49 +0200
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1cxXDc-0003j7-4o; Mon, 10 Apr 2017 13:10:48 +0200
Date:   Mon, 10 Apr 2017 13:11:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, wuzhangjin@gmail.com,
        linux-mips@linux-mips.org, tglx@linutronix.de,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Message-ID: <20170410111146.ggqjyibnqszxzkq4@linutronix.de>
References: <20170404154957.19678-1-bigeasy@linutronix.de>
 <20170410103153.GK24555@vireshk-i7>
 <20170410110511.GE24214@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410110511.GE24214@linux-mips.org>
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

On 2017-04-10 13:05:11 [+0200], Ralf Baechle wrote:
> I noticed some of the other cpufreq drivers seem to be using similar
> constructs.

Don't worry, we are working on that.

>   Ralf

Sebastian
