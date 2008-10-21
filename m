Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 16:50:20 +0100 (BST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45538 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S22014608AbYJUPuR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Oct 2008 16:50:17 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m9LFoIBa027183;
	Tue, 21 Oct 2008 16:50:18 +0100
Date:	Tue, 21 Oct 2008 16:50:18 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
Message-ID: <20081021165018.28794974@lxorguk.ukuu.org.uk>
In-Reply-To: <48FDF6CB.4070605@caviumnetworks.com>
References: <48F51114.2010105@caviumnetworks.com>
	<20081020141750.d0610586.akpm@linux-foundation.org>
	<20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
	<48FDF6CB.4070605@caviumnetworks.com>
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
X-archive-position: 20830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> The question is:  What is the best way to initialize some (or all) fields of a structure *except* a single lock field that was previously initialized?

Move the initialisation - or at least memset to zero then spin_lock_init
and fill in the other fields later.
