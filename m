Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 14:33:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:31226 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022788AbXCZNdB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 14:33:01 +0100
Received: from localhost (p8030-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.30])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DAFEDB616; Mon, 26 Mar 2007 22:31:34 +0900 (JST)
Date:	Mon, 26 Mar 2007 22:31:34 +0900 (JST)
Message-Id: <20070326.223134.79300616.anemo@mba.ocn.ne.jp>
To:	Ravi.Pratap@hillcrestlabs.com
Cc:	ralf@linux-mips.org, miklos@szeredi.hu, linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070324.005029.63129427.anemo@mba.ocn.ne.jp>
References: <20070324.004146.41631259.anemo@mba.ocn.ne.jp>
	<36E4692623C5974BA6661C0B18EE8EDF6CD389@MAILSERV.hcrest.com>
	<20070324.005029.63129427.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 24 Mar 2007 00:50:29 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > The standard FUSE hello program triggers the bug every single time. All
> > you have to do is follow the example on the FUSE web page:
> > http://fuse.sourceforge.net 
> 
> Thanks!  I'll try it (with Ralf's patch) next week.

I confirmed current git tree works fine for me.  Thanks.
---
Atsushi Nemoto
