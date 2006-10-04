Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2006 02:31:05 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:2861 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038977AbWJDBbD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Oct 2006 02:31:03 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 4 Oct 2006 10:31:01 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 8065F41823;
	Wed,  4 Oct 2006 10:30:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6D74C3D392;
	Wed,  4 Oct 2006 10:30:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k941UwW0099258;
	Wed, 4 Oct 2006 10:30:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 04 Oct 2006 10:30:58 +0900 (JST)
Message-Id: <20061004.103058.25910611.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix wreckage after removal of tickadj; convert to
 GENERIC_TIME.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061003201320.GB4934@linux-mips.org>
References: <S20038910AbWJCTjS/20061003193918Z+2409@ftp.linux-mips.org>
	<4522BDFC.5040701@ru.mvista.com>
	<20061003201320.GB4934@linux-mips.org>
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
X-archive-position: 12796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 3 Oct 2006 21:13:21 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> >    Well, be forewarned that with this patch, MIPS kernel now only has 
> > jiffy-precise time resolution. I.e. you could have killed all gettimeoffset 
> > handlers I suppose since there's nothing to call them from anymore. We need 
> > a clocksource patch added now to restore the old functionality (it's 
> > currently a part of the RT patch)...
> 
> After the other broken time patch it was most important to get the
> kernel buildable again.  We can still sort out the clock source.

This topic was raised on LKML a month ago.

http://lkml.org/lkml/2006/8/31/141

If you just wanted to fix the "undefined reference problem", replacing
"tickadj" with 500 (max ntp adjustment time) would be enough.

Of course, MIPS clock source would be preferred if it is available soon.

---
Atsushi Nemoto
