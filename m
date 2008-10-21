Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 10:39:11 +0100 (BST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55241 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S21986122AbYJUJjE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Oct 2008 10:39:04 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m9L9cXO5019303;
	Tue, 21 Oct 2008 10:38:33 +0100
Date:	Tue, 21 Oct 2008 10:38:33 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
Message-ID: <20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
In-Reply-To: <20081020141750.d0610586.akpm@linux-foundation.org>
References: <48F51114.2010105@caviumnetworks.com>
	<20081020141750.d0610586.akpm@linux-foundation.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> But yes, copying a spinlock by value is quite wrong.  Perhaps we could
> retain the struct assigment and then run spin_lock_init() to get the
> spinlock into a sane state?

Kind of irrelevant now however, the split of patches that caused the
original bug is over and the NR_IRQ removal patch half of it hit Linus
tree.

Alan
