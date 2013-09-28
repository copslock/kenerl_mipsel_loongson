Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 23:15:29 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9061 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816288Ab3I1VP0X0PEP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Sep 2013 23:15:26 +0200
Received: (qmail 21623 invoked by uid 89); 28 Sep 2013 21:15:27 -0000
Received: by simscan 1.3.1 ppid: 21615, pid: 21619, t: 0.0937s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 28 Sep 2013 21:15:27 -0000
Message-ID: <524746EC.8030708@nod.at>
Date:   Sat, 28 Sep 2013 23:15:24 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0
 is special
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Am 28.09.2013 21:50, schrieb Aaro Koskinen:
> Currently the driver assumes that CPU 0 is handling all the hard IRQs.
> This is wrong in Linux SMP systems where user is allowed to assign to
> hardware IRQs to any CPU. The driver will stop working if user sets
> smp_affinity so that interrupts end up being handled by other than CPU
> 0. The patch fixes that.

You are right, sorry. I somehow mixed up the function names.

Thanks,
//richard
