Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 16:22:38 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:32678 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101694AbYCZOTF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 15:19:05 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2QEIOj2019652
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 07:18:25 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2QEIr0q004282
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 14:18:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2QEIrpK004281
	for linux-mips@linux-mips.org; Wed, 26 Mar 2008 14:18:53 GMT
Resent-From: ralf@linux-mips.org
Resent-Date: Wed, 26 Mar 2008 14:18:53 +0000
Resent-Message-ID: <20080326141853.GA4017@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from oss.sgi.com ([192.48.170.157]:12504 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101006AbYCZMOS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 13:14:18 +0100
Received: from p549F5321.dip.t-dialin.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2QBVUpo016060
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 05:13:40 -0700
Received: from oss.sgi.com ([192.48.170.157]:50569 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101652AbYCYSwe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Mar 2008 19:52:34 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2PIorOO014952
	for <linux-mips@linux-mips.org>; Tue, 25 Mar 2008 11:50:55 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2PIpOIY023108;
	Tue, 25 Mar 2008 18:51:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2PIpMu1023107;
	Tue, 25 Mar 2008 18:51:22 GMT
Date:	Tue, 25 Mar 2008 18:51:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: don't unmask timer IRQ early
Message-ID: <20080325185122.GA23095@linux-mips.org>
References: <200803242315.50423.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803242315.50423.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 24, 2008 at 11:15:50PM +0300, Sergei Shtylyov wrote:

> Defer the unmasking of the count/compare interrupt (IRQ5) till the clockevent
> driver initialization:
> 
> - only enable the cascaded IRQs 0 thru 4 in arch_init_irq(); kill the ALLINTS
>   macro -- this change is blessed by AMD as I saw it in their own patch; :-)
> 
> - do not force IRQ5 enabled in plat_time_init() if PM is enabled and there's
>   no 32 KHz crystal.
> 
> Update the copyrights (taking into account my prior changes), also removing
> Pete Popov's old email...

Queued for 2.6.26.  Thanks,

  Ralf
