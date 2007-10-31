Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 18:30:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49570 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576517AbXJaSa1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 18:30:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VIU7Nm031583;
	Wed, 31 Oct 2007 18:30:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VIU6HF031582;
	Wed, 31 Oct 2007 18:30:06 GMT
Date:	Wed, 31 Oct 2007 18:30:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Hyon Lim <alex@alexlab.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: implementation of software suspend on MIPS. (system log)
Message-ID: <20071031183006.GA30155@linux-mips.org>
References: <dd7dc2bc0710301215m1a5b8d7at85c9afc7976dc21d@mail.gmail.com> <20071031132553.GF14187@linux-mips.org> <dd7dc2bc0710311115x51dfab0bt97cdd810d21d120c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7dc2bc0710311115x51dfab0bt97cdd810d21d120c@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 03:15:11AM +0900, Hyon Lim wrote:

> The problem is resume process.
> Some page copy and other remaining process wasn't implemented.
> The code of resume process should be implemented on arch/xxx/power/swsusp.S
> So it should be implemented by assembly.
> That's the problem...
> I've no idea about complex assembly programming. :-)
> Could you recommend any pdf or website?

See MIPS Run (ISBN 0120884216) is _the_ best book on this topic.  Maybe
a library near you already has it, it's the de facto standard book on
the topic.

  Ralf
