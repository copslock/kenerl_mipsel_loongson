Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 05:41:51 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:35109
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225316AbTIKElS>; Thu, 11 Sep 2003 05:41:18 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 11 Sep 2003 04:41:16 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8B4f9gc058283
	for <linux-mips@linux-mips.org>; Thu, 11 Sep 2003 13:41:10 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 11 Sep 2003 13:43:23 +0900 (JST)
Message-Id: <20030911.134323.03974731.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: Re: mips64 _access_ok fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030911.124350.41627177.nemoto@toshiba-tops.co.jp>
References: <20030911.124350.41627177.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 11 Sep 2003 12:43:50 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> The mips64 _access_ok macro in 2.4 tree returns 0 if 'addr' +
anemo> 'size' == TASK_SIZE.

anemo> Also, __ua_size macro returus 0 if 'size' is negative constant.
anemo> I think we must not skip checking negative constant.

anemo> Here is a fix.  For 2.6 tree, only _access_ok fix will be
anemo> needed (__ua_size is already fixed).

I know this fix is not complete.  __access_ok(0, 0, __access_mask)
will return 0.

I could not find out good expression (i.e. no conditional branch) to
handle this case.

I suppose nobody do take care of this since addr 0 is invalid pointer
anyway.

---
Atsushi Nemoto
