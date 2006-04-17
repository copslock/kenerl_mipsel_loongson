Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 09:15:41 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:60193 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133728AbWDQIPb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 09:15:31 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 17 Apr 2006 17:27:52 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 07431207C0;
	Mon, 17 Apr 2006 11:09:48 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id EF2542026B;
	Mon, 17 Apr 2006 11:09:47 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3H29j4D084555;
	Mon, 17 Apr 2006 11:09:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 17 Apr 2006 11:09:45 +0900 (JST)
Message-Id: <20060417.110945.59031594.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	geoffrey.levand@am.sony.com, linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <444291E9.2070407@ru.mvista.com>
References: <444032A5.3030304@am.sony.com>
	<44415D17.1070005@ru.mvista.com>
	<444291E9.2070407@ru.mvista.com>
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
X-archive-position: 11122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 16 Apr 2006 22:50:17 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >    This is really strange place for that #ifdef -- 'wordlength' is 
> > determined much earlier in this function (and stop_page is set to 0x40 
> > for 8-bit case), shouldn't #ifdef be moved instead?
> 
>      What I think we actually need is more generic fix for RTL8019AS, not the
> board specific hacks -- if this RX ring stop page value limitation *really*
> needs to be enforced.

I agree with you.  Then how about something like
CONFIG_NE2000_RTL8019_BYTEMODE?  Also, setting 0xbad value to mem_end
can skip the Product-ID checking without inflating bad_clone_list.
Just a thought...

---
Atsushi Nemoto
