Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 09:16:08 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:60580 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037750AbWHRIQG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 09:16:06 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 18 Aug 2006 17:16:05 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BAF222047B;
	Fri, 18 Aug 2006 17:15:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id AEC1E20385;
	Fri, 18 Aug 2006 17:15:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7I8FwW0088776;
	Fri, 18 Aug 2006 17:15:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 18 Aug 2006 17:15:58 +0900 (JST)
Message-Id: <20060818.171558.89065994.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44E57161.5060104@innova-card.com>
References: <44E475C8.5000105@innova-card.com>
	<20060818.115213.108739385.nemoto@toshiba-tops.co.jp>
	<44E57161.5060104@innova-card.com>
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
X-archive-position: 12359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 Aug 2006 09:50:57 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >> +	unsigned long size = 0;
> > 
> > You must pass some non-zero size even if CONFIG_KALLSYMS was not set.
> > Otherwise schedule_mfi will not be initialized as expected.  Actually,
> > this is not a problem of this patch, but we missed this point on
> > previous cleanups for the get_frame_info()...
> 
> or maybe we can just fix get_frame_info() and make it more robust ?

Maybe.  But info->func_size == 0 is valid input when it was called via
show_backtrace.  If an exception occured on a first instruction of a
function, get_frame_info() should return 1.  So it would be easy to
give some appropriate (128?) size here.

---
Atsushi Nemoto
