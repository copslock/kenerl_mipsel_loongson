Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2006 15:08:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:56831 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037726AbWIOOIf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2006 15:08:35 +0100
Received: from localhost (p4242-ipad34funabasi.chiba.ocn.ne.jp [124.85.61.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CD4FFB6AE; Fri, 15 Sep 2006 23:08:27 +0900 (JST)
Date:	Fri, 15 Sep 2006 23:10:29 +0900 (JST)
Message-Id: <20060915.231029.74752822.anemo@mba.ocn.ne.jp>
To:	treestem@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Add cache info to /proc/cpuinfo
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45097A89.4060303@gmail.com>
References: <45097A89.4060303@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 14 Sep 2006 11:51:37 -0400, Peter Watkins <treestem@gmail.com> wrote:
> This patch shows you more details about the cache using /proc/cpuinfo.
> It also shows the TLB page size.

Unfortunately this patch will not work for users of c-r3k.c and
c-sb1.c.  These does not fill correct values to cpu_data for now.

Also, current_cpu_data should not be used in show_cpuinfo.  You can
use cpu_data[n] instead.

# I know now show_cpuinfo _is_ using current_cpu_data in some place.
# These should be fixed.  A patch have been sent to Ralf already.

---
Atsushi Nemoto
