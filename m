Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:36:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64448 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22831518AbYJaORg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 14:17:36 +0000
Date:	Fri, 31 Oct 2008 14:17:36 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips <linux-mips@linux-mips.org>,
	"Malov, Vlad" <Vlad.Malov@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Check the range of the syscall number for o32
 syscall on 64bit kernel.
In-Reply-To: <490A4D3F.10700@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810311410020.11348@ftp.linux-mips.org>
References: <490A4D3F.10700@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Oct 2008, David Daney wrote:

> @@ -260,16 +260,15 @@ bad_alignment:
> 	END(sys_sysmips)
> 
> 	LEAF(sys_syscall)
> +	.set	noreorder

 Please indent branch delay slot instructions by one space if using this
mode.

> 	subu	t0, a0, __NR_O32_Linux	# check syscall number
> -	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
> +	beqz	t0, einval		# do not recurse
> +	sltu	v0, t0, __NR_O32_Linux_syscalls + 1

 Why not sltiu?  You do want to fit in the delay slot here.  Besides you 
should not need .set noreorder here -- GAS should be smart enough to swap 
sltiu with beqz here (and then you can actually use sltu quite safely).  
The rule of thumb is not to use .set noreorder unless absolutely necessary 
(such as modifying one of the registers used by a branch instruction 
immediately afterwards in its delay slot) as you have to take all the 
pesky details of instruction scheduling into account, including but not 
limited to the MIPS I load delay slots not everybody seems to be aware of.

 Adjust for the other hunk accordingly.

  Maciej
