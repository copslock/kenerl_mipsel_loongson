Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 23:27:56 +0100 (CET)
Received: from p508B6D85.dip.t-dialin.net ([80.139.109.133]:62369 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122118AbSKNW1z>; Thu, 14 Nov 2002 23:27:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAEMRm217583
	for linux-mips@linux-mips.org; Thu, 14 Nov 2002 23:27:48 +0100
Date: Thu, 14 Nov 2002 23:27:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114232748.A9839@linux-mips.org>
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114193924.A5610@linux-mips.org> <20021114113045.D1494@wumpus.internal.keyresearch.com> <20021114120746.E28717@mvista.com> <20021114211251.C5610@linux-mips.org> <20021114131232.B1706@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114131232.B1706@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Thu, Nov 14, 2002 at 01:12:32PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 14, 2002 at 01:12:32PM -0800, Greg Lindahl wrote:

> strace says:
> 
> socket(PF_PACKET, SOCK_DGRAM, 0)        = 4183
> socket(PF_PACKET, SOCK_DGRAM, 0)        = 4183
> socket(PF_PACKET, SOCK_DGRAM, 0)        = -1 EAFNOSUPPORT (Address family not supported by protocol)
> 
> printk says:
> 
> sys_socket returning 0
> sys32_socket returning 0
> sys_socket returning -124
> sys32_socket returning -124
> 
> Note strace sees 3 syscalls. I only printk at the return statement, 
> and there are 2 of those. I'll add more printks...

This smells alot like syscall restarting.  The first two times the
syscall fails with one of ERESTARTNOHAND, ERESTARTSYS or ERESTARTNOINTR,
then the third time is fails with EAFNOSUPPORT.

Enable CONFIG_PACKET and CONFIG_NETLINK_DEV.

The only bug here is strace being to stupid to filter out syscall restarts.

  Ralf
