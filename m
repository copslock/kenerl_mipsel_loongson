Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 00:53:41 +0000 (GMT)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:14724
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225200AbTB0Axk>; Thu, 27 Feb 2003 00:53:40 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h1R0rdPa002103
	for <linux-mips@linux-mips.org>; Wed, 26 Feb 2003 16:53:39 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h1R0rdvB002101
	for linux-mips@linux-mips.org; Wed, 26 Feb 2003 16:53:39 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 26 Feb 2003 16:53:39 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: volatile question
Message-ID: <20030227005338.GB2077@greglaptop.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

In the mips, mips64, and even the i386 arch, arch/kernel/smp.c has
this in smp_call_function:

        spin_lock(&call_lock);
        call_data = &data;

        /* Send a message to all other CPUs and wait for them to respond */
        for (i = 0; i < smp_num_cpus; i++)
                if (i != cpu)
                        core_send_ipi(i, SMP_CALL_FUNCTION);

call_data isn't volatile, it's a plain static *. So how can we be sure
that "call_data = &data" does anything other than change a register?

The i386 has a wb() after the assignment; we don't even have that.

greg
