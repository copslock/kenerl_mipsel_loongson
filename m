Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2005 01:34:05 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:12322 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S3458499AbVKKBdq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Nov 2005 01:33:46 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 11 Nov 2005 01:36:26 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2B17420029;
	Fri, 11 Nov 2005 10:36:22 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1F79520025;
	Fri, 11 Nov 2005 10:36:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAB1aJhO017697;
	Fri, 11 Nov 2005 10:36:20 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date:	Fri, 11 Nov 2005 10:36:19 +0900 (JST)
Message-Id: <20051111.103619.25910589.nemoto@toshiba-tops.co.jp>
To:	matej.kupljen@ultra.si
Cc:	pantelis.antoniou@gmail.com, anemo@mba.ocn.ne.jp,
	linux-mips@linux-mips.org
Subject: Re: smc91x support
From:	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <1131644670.1478.4.camel@orionlinux.starfleet.com>
References: <20051111.001543.93019156.anemo@mba.ocn.ne.jp>
	<200511101737.09316.pantelis.antoniou@gmail.com>
	<1131644670.1478.4.camel@orionlinux.starfleet.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 10 Nov 2005 18:44:30 +0100, Matej Kupljen <matej.kupljen@ultra.si> said:
matej> How did you achieve this? By software or by using 10 Mbps
matej> switch?

I did by just change default settings like this:

	/* Set default parameters */
	lp->msg_enable = NETIF_MSG_LINK;
	lp->ctl_rfduplx = 0;
	lp->ctl_rspeed = 10;

#if 0	/* too many rx overruns on 100M... why? (less overruns on 10M) */
	if (lp->version >= (CHIP_91100 << 4)) {
		lp->ctl_rfduplx = 1;
		lp->ctl_rspeed = 100;
	}
#endif

matej> I found this mail from Nicolas on ARM mailing list:
matej> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-October/031736.html

Hmm... Thanks.

---
Atsushi Nemoto
