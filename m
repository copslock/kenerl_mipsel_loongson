Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 11:34:21 +0000 (GMT)
Received: from mtagate8.de.ibm.com ([195.212.29.157]:51154 "EHLO
	mtagate8.de.ibm.com") by ftp.linux-mips.org with ESMTP
	id S28575132AbZCYLeP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 11:34:15 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.14.3/8.13.8) with ESMTP id n2PBXkEO282236;
	Wed, 25 Mar 2009 11:33:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n2PBXjxi852154;
	Wed, 25 Mar 2009 12:33:45 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n2PBXjDL028166;
	Wed, 25 Mar 2009 12:33:45 +0100
Received: from osiris.boeblingen.de.ibm.com (dyn-9-152-212-33.boeblingen.de.ibm.com [9.152.212.33])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n2PBXjSh028157;
	Wed, 25 Mar 2009 12:33:45 +0100
Date:	Wed, 25 Mar 2009 12:33:44 +0100
From:	Heiko Carstens <heiko.carstens@de.ibm.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] fs: Fix sign extension problem in sys_llseek
Message-ID: <20090325123344.409090a3@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20090325001303.GB24026@linux-mips.org>
References: <20090325001303.GB24026@linux-mips.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.7; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
Precedence: bulk
X-list: linux-mips

On Wed, 25 Mar 2009 01:13:03 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> In fs/read_write.c:
> 
> SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
>                 unsigned long, offset_low, loff_t __user *, result,
>                 unsigned int, origin)
> ...
>    	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
>                         origin);
> 
> On a 64-bit system that define CONFIG_HAVE_SYSCALL_WRAPPERS SYSCALL_DEFINEx
> will truncate long arguments to 32-bit and on some architectures such as
> MIPS sign-extended to 64-bit again.  On such architectures passing a
> value with bit 31 in offset_low set will result in a huge 64-bit offset
> being passed to vfs_llseek() and it failiing with EINVAL.

How is that possible? If you have CONFIG_HAVE_SYSCALL_WRAPPERS defined
then the wrapper will (in this case) cast offset_low from long to
unsigned long. It won't truncate or sign extend anything here.
The whole operation should be a NOP.

This is what you get after macro expansion (BUILD_BUG_ON removed):

long sys_llseek(unsigned int fd, unsigned long offset_high, unsigned long offset_low, loff_t * result, unsigned int origin);

static inline __attribute__((always_inline))
long SYSC_llseek(unsigned int fd, unsigned long offset_high, unsigned long offset_low, loff_t * result, unsigned int origin);

long SyS_llseek(long fd, long offset_high, long offset_low, long result, long origin)
{
	return (long) SYSC_llseek((unsigned int) fd, (unsigned long) offset_high, (unsigned long) offset_low, (loff_t *) result, (unsigned int) origin);
}

asm ("\t.globl " "sys_llseek" "\n\t.set " "sys_llseek" ", " "SyS_llseek");

static inline __attribute__((always_inline))
long SYSC_llseek(unsigned int fd, unsigned long offset_high, unsigned long offset_low, loff_t * result, unsigned int origin)
{
	[...]
}
