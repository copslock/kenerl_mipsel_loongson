Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:43:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:47607 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022416AbXCWPnH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2007 15:43:07 +0000
Received: from localhost (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E3989B785; Sat, 24 Mar 2007 00:41:46 +0900 (JST)
Date:	Sat, 24 Mar 2007 00:41:46 +0900 (JST)
Message-Id: <20070324.004146.41631259.anemo@mba.ocn.ne.jp>
To:	Ravi.Pratap@hillcrestlabs.com
Cc:	ralf@linux-mips.org, miklos@szeredi.hu, linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD36D@MAILSERV.hcrest.com>
References: <20070323141939.GB17311@linux-mips.org>
	<36E4692623C5974BA6661C0B18EE8EDF6CD36D@MAILSERV.hcrest.com>
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
X-archive-position: 14635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 23 Mar 2007 10:51:32 -0400, "Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com> wrote:
> > Was this one found by code inspection or actually triggered 
> > by like FUSE?
> 
> It was actually triggered by FUSE.

Could you point us any good (simple, easy to install, independent from
any special device) FUSE program to test it?

---
Atsushi Nemoto
