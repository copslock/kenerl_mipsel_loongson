Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 22:21:10 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52641 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1123903AbSJNUVJ>; Mon, 14 Oct 2002 22:21:09 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9EKKwP29562;
	Mon, 14 Oct 2002 16:20:58 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9EKKvxB013362;
	Mon, 14 Oct 2002 18:20:57 -0200
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9EKKtQn013358;
	Mon, 14 Oct 2002 17:20:55 -0300
To: "H. J. Lu" <hjl@lucon.org>
Cc: "David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021014123940.A32333@lucon.org>
	<20021014.123510.00003943.davem@redhat.com>
	<20021014125549.A32575@lucon.org>
	<20021014.125134.98070597.davem@redhat.com>
	<20021014130932.A32693@lucon.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 14 Oct 2002 17:20:55 -0300
In-Reply-To: <20021014130932.A32693@lucon.org>
Message-ID: <orwuokzs9k.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 14, 2002, "H. J. Lu" <hjl@lucon.org> wrote:

> If gcc just emits

> 	bne     $2,$0,$L7493
> 	j       $L2

IIRC, that's exactly what GCC will emit if you don't tell it to try to
fill delay slots.  If it tries to fill delay slots and fails, I doubt
the assembler is going to succeed at that.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
