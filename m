Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 17:17:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:1426 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573978AbXAWRRE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 17:17:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NHH31K026626;
	Tue, 23 Jan 2007 17:17:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NHH39k026625;
	Tue, 23 Jan 2007 17:17:03 GMT
Date:	Tue, 23 Jan 2007 17:17:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 3/7] signal: clean up sigframe structure
Message-ID: <20070123171703.GA26510@linux-mips.org>
References: <1169561903878-git-send-email-fbuihuu@gmail.com> <11695619031474-git-send-email-fbuihuu@gmail.com> <20070123143541.GD18083@linux-mips.org> <cda58cb80701230700j70f8e447o27f64091be9d57f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80701230700j70f8e447o27f64091be9d57f5@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 04:00:42PM +0100, Franck Bui-Huu wrote:

> and didn't notice that the symbol could be defined to 0 below. I'll
> fix it but just for my information what the point to do this ?

Some of the _WAR constants are used in if statements which produces much
less messy looking code than piles of #ifdefs.

  Ralf
