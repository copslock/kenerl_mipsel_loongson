Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2003 11:05:39 +0000 (GMT)
Received: from p508B5BAC.dip.t-dialin.net ([IPv6:::ffff:80.139.91.172]:35296
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225687AbTABLFj>; Thu, 2 Jan 2003 11:05:39 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h02B5Su14781;
	Thu, 2 Jan 2003 12:05:28 +0100
Date: Thu, 2 Jan 2003 12:05:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: chamak man <chamakmann@yahoo.co.in>
Cc: linux-mips@linux-mips.org
Subject: Re: System Call in MIPS
Message-ID: <20030102120528.A7401@linux-mips.org>
References: <20030102035704.91069.qmail@web8204.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030102035704.91069.qmail@web8204.mail.in.yahoo.com>; from chamakmann@yahoo.co.in on Thu, Jan 02, 2003 at 03:57:04AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 02, 2003 at 03:57:04AM +0000, chamak man wrote:

>    I am finding problems in adding a new system call
> for MIPS kernel.  Where can i get information on it. 

See include include/asm-mips/unistd.h and arch/mips/kernel/scall_o32.S.

In general adding new syscalls is considered a bad idea you may want to
look into using ioctl, sysctl(2) or procfs.

  Ralf
