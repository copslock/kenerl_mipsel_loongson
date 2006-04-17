Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 15:56:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:20932 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133600AbWDQO4d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 15:56:33 +0100
Received: from localhost (p1246-ipad213funabasi.chiba.ocn.ne.jp [124.85.66.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 466D4AE62; Tue, 18 Apr 2006 00:08:53 +0900 (JST)
Date:	Tue, 18 Apr 2006 00:09:18 +0900 (JST)
Message-Id: <20060418.000918.95064811.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	geoffrey.levand@am.sony.com, linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <444392CF.7070808@ru.mvista.com>
References: <444291E9.2070407@ru.mvista.com>
	<20060417.110945.59031594.nemoto@toshiba-tops.co.jp>
	<444392CF.7070808@ru.mvista.com>
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
X-archive-position: 11137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 17 Apr 2006 17:06:23 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > I agree with you.  Then how about something like
> > CONFIG_NE2000_RTL8019_BYTEMODE?
> 
>     Have you looked at the patch? RTL8019 is easily detectable at
> runtime, so the limitation is easily enforcable w/o extra Kconfig
> option, I think

Well, I meant something like:

#elif defined(CONFIG_NE2000_RTL8019_BYTEMODE)
#  define DCR_VAL 0x48
#else
#  define DCR_VAL 0x49

to avoid changing #elif line every time when we want to support a new
board with byte-mode RTL8019AS.  Of course, calculating DCR_VAL at
runtime would be much better but I'm not sure if we can do it ...

> >  Also, setting 0xbad value to mem_end
> > can skip the Product-ID checking without inflating bad_clone_list.
> > Just a thought...
> 
>     0xbad in dev->mem_end currently skips 8390 reset which is not a
> good thing for the clones for which it does work...

The 8390 reset will not skipped.  The difference is behavior _after_
detection of no reset ack, isn't it?

---
Atsushi Nemoto
