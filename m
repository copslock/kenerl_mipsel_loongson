Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 03:22:26 +0000 (GMT)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:45841
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225554AbUCZDWZ>; Fri, 26 Mar 2004 03:22:25 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 26 Mar 2004 03:22:23 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i2Q3MA1x053072;
	Fri, 26 Mar 2004 12:22:10 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 26 Mar 2004 12:22:58 +0900 (JST)
Message-Id: <20040326.122258.41628012.nemoto@toshiba-tops.co.jp>
To: phorton@bitbox.co.uk
Cc: linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4062F1A1.9070005@bitbox.co.uk>
References: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp>
	<20040325143319.GA873@linux-mips.org>
	<4062F1A1.9070005@bitbox.co.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 25 Mar 2004 14:50:09 +0000, Peter Horton <phorton@bitbox.co.uk> said:
>> This seems to be the same problem as reported by Peter Horton as
>> while ago; in his case that was with PIO IDE.
>> 
phorton> Looks like it.

phorton> The fix we're using on Cobalt's at the moment is below
phorton> (required for 2.4.x and 2.6.x).

phorton> Fixing it this way fixes the problem with both page cache
phorton> pages and swap pages.

phorton> For more details see the threads "Kernel 2.4.23 on Cobalt
phorton> Qube2 - area of problem" and "Instability / caching problems
phorton> on Qube 2 - solved ?"  from December last year.

Thanks, I agree (maybe I should read ML messages more carefully ...)

This patch fixes my problem also, thanks, but ... I do not think
r4k_flush_icache_page is a best place to fix since my test program is
not related I-cache at all.

I'm quite sure that it's a kernel bug and may cause problems if any
PIO block device (PIO ide, ide-cs, mtdblock, etc.) are used on CPUs
which have d-cache aliases (not only MIPS).  We need a correct fix ...

---
Atsushi Nemoto
