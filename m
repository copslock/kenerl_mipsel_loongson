Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 22:26:51 +0100 (CET)
Received: from nixon.xkey.com ([209.245.148.124]:58501 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1122118AbSKNV0v>;
	Thu, 14 Nov 2002 22:26:51 +0100
Received: (qmail 5832 invoked from network); 14 Nov 2002 21:26:39 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 14 Nov 2002 21:26:39 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gAELCWr01830;
	Thu, 14 Nov 2002 13:12:32 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 14 Nov 2002 13:12:32 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114131232.B1706@wumpus.internal.keyresearch.com>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114193924.A5610@linux-mips.org> <20021114113045.D1494@wumpus.internal.keyresearch.com> <20021114120746.E28717@mvista.com> <20021114211251.C5610@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114211251.C5610@linux-mips.org>; from ralf@linux-mips.org on Thu, Nov 14, 2002 at 09:12:51PM +0100
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 14, 2002 at 09:12:51PM +0100, Ralf Baechle wrote:

> Unlikely to help him.  The return value 4183 of socket that he's observing
> is the syscall number of socket(2).

Thank you, I should have noticed that one right off.

My sprinkle of printks already tells me that strace is a liar - no
surprise there.

strace says:

socket(PF_PACKET, SOCK_DGRAM, 0)        = 4183
socket(PF_PACKET, SOCK_DGRAM, 0)        = 4183
socket(PF_PACKET, SOCK_DGRAM, 0)        = -1 EAFNOSUPPORT (Address family not supported by protocol)

printk says:

sys_socket returning 0
sys32_socket returning 0
sys_socket returning -124
sys32_socket returning -124

Note strace sees 3 syscalls. I only printk at the return statement, 
and there are 2 of those. I'll add more printks...

-- greg
