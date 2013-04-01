Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Apr 2013 18:58:38 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:52298 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823030Ab3DAQ6hHFyoE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Apr 2013 18:58:37 +0200
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ADF48585393;
        Mon,  1 Apr 2013 09:58:31 -0700 (PDT)
Date:   Mon, 01 Apr 2013 12:58:30 -0400 (EDT)
Message-Id: <20130401.125830.1655034418750471341.davem@davemloft.net>
To:     viresh.kumar@linaro.org
Cc:     rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        lethal@linux-sh.org, trenn@suse.de, bp@alien8.de,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 6/9] cpufreq: Don't check if cpu is online/offline for
 cpufreq callbacks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cd771cb37feb4e79172548ed342ad194ee31a384.1364820620.git.viresh.kumar@linaro.org>
References: <cover.1364820620.git.viresh.kumar@linaro.org>
        <cover.1364820620.git.viresh.kumar@linaro.org>
        <cd771cb37feb4e79172548ed342ad194ee31a384.1364820620.git.viresh.kumar@linaro.org>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (shards.monkeyblade.net [0.0.0.0]); Mon, 01 Apr 2013 09:58:33 -0700 (PDT)
X-archive-position: 36002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon,  1 Apr 2013 18:27:46 +0530

> cpufreq layer doesn't call cpufreq driver's callback for any offline cpu and so
> checking that isn't useful.
> 
> Lets get rid of it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For sparc bits:

Acked-by: David S. Miller <davem@davemloft.net>
