Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 21:42:23 +0200 (CEST)
Received: from pizda.ninka.net ([216.101.162.242]:44188 "EHLO pizda.ninka.net")
	by linux-mips.org with ESMTP id <S1123903AbSJNTmW>;
	Mon, 14 Oct 2002 21:42:22 +0200
Received: from localhost (IDENT:davem@localhost.localdomain [127.0.0.1])
	by pizda.ninka.net (8.9.3/8.9.3) with ESMTP id MAA30498;
	Mon, 14 Oct 2002 12:35:11 -0700
Date: Mon, 14 Oct 2002 12:35:10 -0700 (PDT)
Message-Id: <20021014.123510.00003943.davem@redhat.com>
To: hjl@lucon.org
Cc: aoliva@redhat.com, rsandifo@redhat.com, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021014123940.A32333@lucon.org>
References: <20021014110118.B30940@lucon.org>
	<orelas24n2.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014123940.A32333@lucon.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@redhat.com
Precedence: bulk
X-list: linux-mips

   From: "H. J. Lu" <hjl@lucon.org>
   Date: Mon, 14 Oct 2002 12:39:40 -0700
   
   Can gcc not to emit nop nor noreorder when it tries to fill the delay
   slot with nop?

All the surrounding instructions scheduled by GCC are within
noreorder sections aren't they?

If so, the assembler has nothing to put into the delay
slot.

If not, you have a valid point, we should just remit the branch
by itself with no reorder/macro section attributes.
