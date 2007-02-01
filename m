Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 13:57:38 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52379 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038963AbXBAN5g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 13:57:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l11DvZfO012933;
	Thu, 1 Feb 2007 13:57:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l11DvYYi012932;
	Thu, 1 Feb 2007 13:57:34 GMT
Date:	Thu, 1 Feb 2007 13:57:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
Message-ID: <20070201135734.GB12728@linux-mips.org>
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 01, 2007 at 11:43:13AM +0100, Franck Bui-Huu wrote:

> I'm probably missing something very obvious so the subject could have
> been "Dumb question of the week". So please be nice when answering ;)
> 
> I'm wondering why we need to save/restore the static registers
> (s0...s7) when dealing with some  signal system calls. Specially all
> of them which are declared by using save_static_function() macros.

The values of those registers need to be preserved so they can later be
copied into the signal frame.

  Ralf
