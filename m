Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 05:06:05 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:23602 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037687AbWJZEGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Oct 2006 05:06:03 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 26 Oct 2006 13:06:02 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E8A4A41ABE;
	Thu, 26 Oct 2006 13:05:54 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id DCEED41A5B;
	Thu, 26 Oct 2006 13:05:54 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9Q45qW0099413;
	Thu, 26 Oct 2006 13:05:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 26 Oct 2006 13:05:52 +0900 (JST)
Message-Id: <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
To:	anemo@mba.ocn.ne.jp
Cc:	creideiki+linux-mips@ferretporn.se, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061025.174504.71086461.nemoto@toshiba-tops.co.jp>
References: <20061024140614.GB27800@linux-mips.org>
	<6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
	<20061025.174504.71086461.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 25 Oct 2006 17:45:04 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > 2. Timekeeping is broken. The clock in /proc/driver/rtc seems correct, but
> > the system clock advances at about 1/16 of real time.
> 
> Is this problem still happen if you disabled CONFIG_OPROFILE ?

I think I found the problem at last.

static struct clocksource clocksource_mips = {
	.name		= "MIPS",
	.rating		= 250,
	.read		= read_mips_hpt,
	.shift		= 24,
	.is_continuous	= 1,
};

This shift value is too large for ip27 HPT (1.25MHz).

	temp = (u64) NSEC_PER_SEC << clocksource_mips.shift;
	do_div(temp, mips_hpt_frequency);
	clocksource_mips.mult = (unsigned)temp;

If mips_hpt_frequency is less than 0x1000000 (16777216), temp would be
larger than possible 32bit value.  I'll cook a patch later but until
then you can use lesser shift value, for example, 20.

---
Atsushi Nemoto
