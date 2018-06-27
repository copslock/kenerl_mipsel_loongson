Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2018 14:13:11 +0200 (CEST)
Received: from cannabis.dataforce.net ([195.42.160.49]:52561 "EHLO
        cannabis.dataforce.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991808AbeF0MNEqjPzD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2018 14:13:04 +0200
Received: by cannabis.dataforce.net (Postfix, from userid 12794)
        id 927A04A0009; Wed, 27 Jun 2018 15:13:03 +0300 (MSK)
Date:   Wed, 27 Jun 2018 15:13:02 +0300
From:   Georgi Guninski <guninski@guninski.com>
To:     linux-mips@linux-mips.org
Subject: Potential BUG_ON() in do_group_exit() on 4.17.2
Message-ID: <20180627121302.56nivw2adgov3fvn@sivokote.iziade.m$>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
header: best read with a sniffer
Return-Path: <guninski@guninski.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guninski@guninski.com
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

Does this BUG_ON() gets hit on mips?

in 4.17.2 ./kernel/exit.c

do_group_exit(int exit_code)
{
	struct signal_struct *sig = current->signal;

	BUG_ON(exit_code & 0x80);

|do_group_exit| is called from

./kernel/signal.c:2482:		do_group_exit(ksig->info.si_signo);

Appears to me si_signo can be 0x80 (in decimal 128) because of:

arch/mips/include/uapi/asm/signal.h:15:#define _NSIG		128

Probably testcase will be:
$kill -128 `pidof program`
