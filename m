Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 16:27:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57812 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022760AbXCXQ11 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Mar 2007 16:27:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2OGRMEO023179;
	Sat, 24 Mar 2007 16:27:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2OGRLpp023178;
	Sat, 24 Mar 2007 16:27:21 GMT
Date:	Sat, 24 Mar 2007 16:27:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Implement flush_anon_page().
Message-ID: <20070324162721.GA12117@linux-mips.org>
References: <S20022532AbXCWXgp/20070323233645Z+1432@ftp.linux-mips.org> <20070325.001433.108739347.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070325.001433.108739347.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 25, 2007 at 12:14:33AM +0900, Atsushi Nemoto wrote:

> Move an external declaration of __flush_anon_page() to toplevel to
> avoid this sparse warning:
> 
> linux/arch/mips/mm/cache.c:92:6: warning: symbol '__flush_anon_page' was not declared. Should it be static?

Sometimes sparse is a PITA ...   Applied.

Thanks,

  Ralf
