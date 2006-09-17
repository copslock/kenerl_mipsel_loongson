Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 21:30:15 +0100 (BST)
Received: from gateway.codesourcery.com ([65.74.133.9]:20187 "EHLO
	gateway.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20027658AbWIQUaN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Sep 2006 21:30:13 +0100
Received: (qmail 27447 invoked by uid 1010); 17 Sep 2006 20:03:25 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	linux-mips@linux-mips.org
Mail-Followup-To: linux-mips@linux-mips.org, richard@codesourcery.com
Subject: Re: [PATCH] The o32 fstatat syscall behaves differently on 32 and 64 bit kernels
References: <87bqpexpcp.fsf@talisman.home>
Date:	Sun, 17 Sep 2006 21:03:24 +0100
In-Reply-To: <87bqpexpcp.fsf@talisman.home> (Richard Sandiford's message of
	"Sun, 17 Sep 2006 20:30:46 +0100")
Message-ID: <873baqxnub.fsf@talisman.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <richard@codesourcery.com> writes:
> I think this is just a case of a compat too far.  The o32 stat64 is the
> same as plain stat on n64, so 64-bit kernels can just use newfstatat.
> (n32 already does this, and works correctly as-is.)

Huh.  The last sentence sounded like a really useful addition when I
wrote it, but even so soon after the fact, I've no idea why.  It sounds
like I was implying that stat calls require conversion on n32, but that
certainly wasn't my intention.  Please ignore. ;)

Richard
