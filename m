Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2008 00:48:03 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22459 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22777942AbYJaAr5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 00:47:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490a55b30000>; Thu, 30 Oct 2008 20:47:47 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 17:47:47 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 17:47:47 -0700
Message-ID: <490A55B2.5080300@caviumnetworks.com>
Date:	Thu, 30 Oct 2008 17:47:46 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	"Malov, Vlad" <Vlad.Malov@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Check the range of the syscall number for o32 syscall
 on 64bit kernel.
References: <490A4D3F.10700@caviumnetworks.com>
In-Reply-To: <490A4D3F.10700@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2008 00:47:47.0165 (UTC) FILETIME=[4B0168D0:01C93AF2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
[...]
> diff --git a/arch/mips/kernel/scall64-o32.S 
> b/arch/mips/kernel/scall64-o32.S
> index 6c7ef83..d8b3cb1 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -174,14 +174,14 @@ not_o32_scall:
>     END(handle_sys)
> 
> LEAF(sys32_syscall)
> -    sltu    v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
> +    .set    noreorder
> +    subu    t0, a0, __NR_O32_Linux    # check syscall number
> +    beqz    t0, einval        # do not recurse
> +    sltu    v0, t0, __NR_O32_Linux_syscalls + 1
> +    dsll    t1, t0, 3
>     beqz    v0, einval
> -
> -    dsll    v0, a0, 3
> -    ld    t2, (sys_call_table - (__NR_O32_Linux * 8))(v0)
> -
> -    li    v1, 4000        # indirect syscall number
> -    beq    a0, v1, einval        # do not recurse
> +    .set    reorder
> +    lw    t2, sys_call_table(t1)        # syscall routine
> 

        ^^^ Clearly that should be ld not lw.  Not sure how that slipped 
in, Vlad's original patch had it correct.  Re-testing...


David Daney
