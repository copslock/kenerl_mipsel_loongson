Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 10:02:47 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:10562 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037627AbWIZJCp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 10:02:45 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 26 Sep 2006 18:02:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6A34F324CF;
	Tue, 26 Sep 2006 18:02:41 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5B37331EA8;
	Tue, 26 Sep 2006 18:02:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8Q92eW0065479;
	Tue, 26 Sep 2006 18:02:40 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 26 Sep 2006 18:02:40 +0900 (JST)
Message-Id: <20060926.180240.109570923.nemoto@toshiba-tops.co.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <C13EBDF2.724C%girishvg@gmail.com>
References: <20060926.004318.68160600.anemo@mba.ocn.ne.jp>
	<C13EBDF2.724C%girishvg@gmail.com>
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
X-archive-position: 12668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Sep 2006 11:22:26 +0900, girish <girishvg@gmail.com> wrote:
> The idea is to differentiate the Kseg0/Kseg1 segments in the physical area.
> Beyond these areas lies the mapped area (or the HIGHMEM). What complicates
> this matter further is their overlapping nature. The __pa()/__va() treated
> all addresses mapped into PAGE_OFFSET (8000_0000) area. The effort is to
> correctly differentiate these areas.

Yes, __va() and __pa() are used to convert an physical address from/to
an kernel logical address (i.e. low unmapped virtual address).

I think passing another sort of addresses to them is simply wrong.

P.S.
Please do not reply to git-commits@linux-mips.org.
---
Atsushi Nemoto
