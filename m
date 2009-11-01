Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 08:41:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38618 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492452AbZKAHlz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Nov 2009 08:41:55 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA17hIAr013203;
	Sun, 1 Nov 2009 08:43:19 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA17hHiW013201;
	Sun, 1 Nov 2009 08:43:17 +0100
Date:	Sun, 1 Nov 2009 08:43:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chih-hung Lu <winfred.lu@gmail.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH -v1] MIPS: a few of fixups and cleanups for the
	compressed kernel support
Message-ID: <20091101074317.GD4551@linux-mips.org>
References: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com> <a2dc26810910291916x1556eb21uecaa8bdeeb98baae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2dc26810910291916x1556eb21uecaa8bdeeb98baae@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 30, 2009 at 10:16:14AM +0800, Chih-hung Lu wrote:

> May I ask a question,
> what is the difference between "addu a0, 4" and "addiu a0, a0, 4"?

That's because you are human - you're smart enough to notice the difference
without even thinking about it :)

The machine instructions addu and addiu differ.  Addiu takes an immediate
constant as it's last op.  Addu takes a register instead.  Now the assembler
is trying to make things a little easier to us.  Depending on the type of
the last argument it will assemble an "addu" assembler instruction either
into an addiu or addu.

The other difference between the two instructions used in your example is
that the first has two operands, the other three operands.  If there is
only two operands, the assembler will implicitly assume, that the 2nd
register is the same as the first register.

Or in other words, the code generated from both will be entirely identical.

  Ralf
