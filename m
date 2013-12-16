Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2013 02:27:37 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:41360 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3LPB1eWIsRO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Dec 2013 02:27:34 +0100
Received: from localhost (cpe-74-71-55-169.nyc.res.rr.com [74.71.55.169])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 358DF5879FF;
        Sun, 15 Dec 2013 17:27:29 -0800 (PST)
Date:   Sun, 15 Dec 2013 20:27:25 -0500 (EST)
Message-Id: <20131215.202725.1549146673897801643.davem@davemloft.net>
To:     msalter@redhat.com
Cc:     dmitry.torokhov@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux@arm.linux.org.uk,
        linux-arm-kernel@lists.infradead.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, lethal@linux-sh.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        gxt@mprc.pku.edu.cn, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1387122626.1979.136.camel@deneb.redhat.com>
References: <52ACA43F.2040402@zytor.com>
        <20131215103657.GB20197@core.coreip.homeip.net>
        <1387122626.1979.136.camel@deneb.redhat.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.1 (shards.monkeyblade.net [0.0.0.0]); Sun, 15 Dec 2013 17:27:31 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38718
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

From: Mark Salter <msalter@redhat.com>
Date: Sun, 15 Dec 2013 10:50:26 -0500

> On Sun, 2013-12-15 at 02:36 -0800, Dmitry Torokhov wrote:
>> How are we going to merge this? In bulk through input tree or peacemeal
>> through all arches first?
>
> They should all go together to eliminate the chance of bisect breakage.
> Either the input tree or maybe akpm tree.

This sounds good to me.
