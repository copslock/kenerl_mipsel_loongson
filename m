Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 09:49:31 +0100 (BST)
Received: from topsns2.0.225.230.202.in-addr.arpa ([202.230.225.126]:43277
	"EHLO topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022752AbXFGIt2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 09:49:28 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 7 Jun 2007 17:49:27 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id D874141E85;
	Thu,  7 Jun 2007 17:49:01 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id CC20B41500;
	Thu,  7 Jun 2007 17:49:01 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l578n1AF049814;
	Thu, 7 Jun 2007 17:49:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 07 Jun 2007 17:49:01 +0900 (JST)
Message-Id: <20070607.174901.55513477.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
 crapectomy
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
References: <20070606185450.GA10511@linux-mips.org>
	<cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jun 2007 09:59:53 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> The other patch named "time-move-to_tm-to-lib.patch" create a new file
> in arch/mips/lib directory. This new file is called
> "to_tm.c". Shouldn't we call it something less specific like "time.c" ?

In long term, I think it should be removed and replaced by
rtc_time_to_tm() in drivers/rtc/rtc-lib.c (but it will require some
adjustments on caller-side for tm_year value).

---
Atsushi Nemoto
