Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 10:35:24 +0000 (GMT)
Received: from mx02.hansenet.de ([213.191.73.26]:38802 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20024204AbXLQKfQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Dec 2007 10:35:16 +0000
Received: from [213.39.184.147] (213.39.184.147) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 47612DF0009945EB for linux-mips@linux-mips.org; Mon, 17 Dec 2007 11:34:57 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 42B7547C0C
	for <linux-mips@linux-mips.org>; Mon, 17 Dec 2007 11:35:31 +0100 (CET)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	linux-mips@linux-mips.org
Subject: timer irq setup
Date:	Mon, 17 Dec 2007 11:35:22 +0100
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712171135.24569.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

In arch/mips/kernel/traps.c, per_cpu_trap_init() contains
code to set up the global cp0_compare_irq variable. Does
this make sense? I'd say that either the irq setup should
be moved to trap_init(), or cp0_compare_irq should be
changed to a per-cpu variable, depending on what the original
intention was.

tk
-- 
Thomas Koeller
thomas at koeller dot dyndns dot org
