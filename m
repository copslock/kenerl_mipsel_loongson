Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g123baQ26856
	for linux-mips-outgoing; Fri, 1 Feb 2002 19:37:36 -0800
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [146.215.0.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g123bWd26853
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 19:37:32 -0800
Received: from mail2.sony.co.jp (mail2.sony.co.jp [43.0.1.202])
	by ns6.sony.co.jp (R8/Sony) with ESMTP id g122bJW20863;
	Sat, 2 Feb 2002 11:37:19 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id g122bIH12818;
	Sat, 2 Feb 2002 11:37:18 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id g122bIA12810;
	Sat, 2 Feb 2002 11:37:18 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id LAA08031; Sat, 2 Feb 2002 11:41:56 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id LAA20470; Sat, 2 Feb 2002 11:37:17 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g122bHJ12472; Sat, 2 Feb 2002 11:37:17 +0900 (JST)
Date: Sat, 02 Feb 2002 11:37:17 +0900 (JST)
Message-Id: <20020202.113717.68552217.machida@sm.sony.co.jp>
To: hjl@lucon.org
Cc: macro@ds2.pg.gda.pl, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <20020201151513.A15913@lucon.org>
References: <20020201102943.A11146@lucon.org>
	<20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


From: "H . J . Lu" <hjl@lucon.org>
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Date: Fri, 1 Feb 2002 15:15:13 -0800

> Why not? Can you show me a MIPS II or above CPU which doesn't have
> branch-likely instruction? From gcc,
> 
> /* ISA has branch likely instructions (eg. mips2).  */
> /* Disable branchlikely for tx39 until compare rewrite.  They haven't
>    been generated up to this point.  */
> #define ISA_HAS_BRANCHLIKELY    (mips_isa != 1                          \
>                                  /* || TARGET_MIPS3900 */)                      
> 
> Did I miss something?

I think we can assume CPU has branch-likely insns, if CPU has MIPS
ISA 2 or greater ISA, as H.J said. I don't know any exception of
this. If anyone know exceptions, please let us know.

(FYI: we can't assume CPU has LL/SC even if CPU has branch-likely
insns. )

HL's patch looks good for me.

---
Hiroyuki Machida
Sony Corp.
