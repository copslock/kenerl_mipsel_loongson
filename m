Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 07:24:30 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:4384
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224833AbVAGHYZ>; Fri, 7 Jan 2005 07:24:25 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Jan 2005 07:24:24 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 66A1C239E1D; Fri,  7 Jan 2005 16:24:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j077OLRm012403;
	Fri, 7 Jan 2005 16:24:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 07 Jan 2005 16:24:21 +0900 (JST)
Message-Id: <20050107.162421.104029430.nemoto@toshiba-tops.co.jp>
To: mudeem@Quartics.com
Cc: linux-mips@linux-mips.org
Subject: Re: mipes-linux-ld: final link failed: Bad value
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1B701004057AF74FAFF851560087B16106469D@1aurora.enabtech>
References: <1B701004057AF74FAFF851560087B16106469D@1aurora.enabtech>
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
X-archive-position: 6830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 6 Jan 2005 18:47:11 +0500 , Mudeem Iqbal <mudeem@Quartics.com> said:
mudeem> I have built a toolchain using the following combination

mudeem> binutils-2.15
mudeem> gcc-3.4.3

As I reported on 06 Nov 2004 ("failed to merge string constant?"),
binutils-2.15 + gcc-3.4.x (at least gcc 3.4.2) will produce broken
output.  binutils-2.15.92.0.2 or later will be OK with gcc 3.4.

---
Atsushi Nemoto
