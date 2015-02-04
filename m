Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 11:19:39 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:59644 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011554AbbBDKThpesu0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Feb 2015 11:19:37 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 96D84283FEF;
        Wed,  4 Feb 2015 11:17:03 +0100 (CET)
Received: from dicker-alter.lan (p548C81C6.dip0.t-ipconnect.de [84.140.129.198])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Feb 2015 11:17:03 +0100 (CET)
Message-ID: <54D1F248.4090406@openwrt.org>
Date:   Wed, 04 Feb 2015 11:19:52 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Bolle <pebolle@tiscali.nl>, Wim Van Sebroeck <wim@iguana.be>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: SOC_MT7621?
References: <1423044809.23894.65.camel@x220>
In-Reply-To: <1423044809.23894.65.camel@x220>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 04/02/2015 11:13, Paul Bolle wrote:
> messages. Since I haven't received replies on other, more serious
> issues in over three months I assume John has disappeared.)

into thin air, *pooff*

> Is SOC_MT7621 still being worked on?

yes we dropped the series as it collided with the gic rework that
chromiun.org was working on. i hope to push it during the next merge
window. the 1004k support has just been flaky till now as there was
never any real silicon to test it on. the chromium people really did a
good job at making the gic code nicer.

quite an impressive Cc list you have there

	John
