Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 15:10:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46002 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038850AbWJMOKy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 15:10:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9DEB4GV020986;
	Fri, 13 Oct 2006 15:11:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9DEB21Y020984;
	Fri, 13 Oct 2006 15:11:02 +0100
Date:	Fri, 13 Oct 2006 15:11:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Antonio SJ Musumeci <bile@landofbile.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
Message-ID: <20061013141101.GA19260@linux-mips.org>
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com> <20061013104250.GA16820@linux-mips.org> <452F9A41.4020505@landofbile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452F9A41.4020505@landofbile.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 13, 2006 at 09:53:05AM -0400, Antonio SJ Musumeci wrote:

> Should I apply my patch on top of this one?

No, the two patches conflict in what they're doing.  The important
part of your patch, the fix to the if condition I've already applied.

  Ralf
