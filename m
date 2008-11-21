Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 10:00:31 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:32958 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S23812496AbYKUKA2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 10:00:28 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mALA0ado007343;
	Fri, 21 Nov 2008 10:00:36 GMT
Date:	Fri, 21 Nov 2008 10:00:35 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
Message-ID: <20081121100035.3f5a640b@lxorguk.ukuu.org.uk>
In-Reply-To: <49260E4C.8080500@caviumnetworks.com>
References: <49260E4C.8080500@caviumnetworks.com>
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
X-archive-position: 21353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 20 Nov 2008 17:26:36 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> MIPS: Make BUG() __noreturn.
> 
> Often we do things like put BUG() in the default clause of a case
> statement.  Since it was not declared __noreturn, this could sometimes
> lead to bogus compiler warnings that variables were used
> uninitialized.
> 
> There is a small problem in that we have to put a magic while(1); loop to
> fool GCC into really thinking it is noreturn.  

That sounds like your __noreturn macro is wrong.

Try using __attribute__ ((__noreturn__))

if that works then fix up the __noreturn definitions for the MIPS and gcc
you have.
