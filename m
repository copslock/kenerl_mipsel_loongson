Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 10:07:48 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:4406 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038891AbXBAKHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 10:07:44 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 1 Feb 2007 19:07:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1AAB741D4E;
	Thu,  1 Feb 2007 19:07:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0711A410FD;
	Thu,  1 Feb 2007 19:07:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l11A7IW0036167;
	Thu, 1 Feb 2007 19:07:18 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 01 Feb 2007 19:07:17 +0900 (JST)
Message-Id: <20070201.190717.55145997.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, sam@catalyst.net.nz
Subject: Re: Kernel issues on R4000/R4000 SC and MC
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070131130926.GA29562@linux-mips.org>
References: <20070131130926.GA29562@linux-mips.org>
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
X-archive-position: 13873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 31 Jan 2007 13:09:26 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> Anyway, the issue boiled up again last week and was supposedly fixed for
> linux-2.6.17-rc7 which I've just merged.   I'd like to ask somebody with
> one of the affected CPUs to test this.  Below Nick Piggin's test program.

What is the expected output of the test program?

---
Atsushi Nemoto
