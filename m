Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Feb 2007 22:32:14 +0000 (GMT)
Received: from jg555.com ([216.66.227.242]:15840 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S20027600AbXBXWcN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Feb 2007 22:32:13 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sat, 24 Feb 2007 14:31:10 -0800
  id 002DC559.45E0BCAE.00006991
Message-ID: <45E0BCA4.9020208@jg555.com>
Date:	Sat, 24 Feb 2007 14:31:00 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building 2.6.20.1 from source
References: <45E0A57F.4020304@jg555.com> <20070224205850.GA12637@linux-mips.org> <20070224211348.GB12637@linux-mips.org>
In-Reply-To: <20070224211348.GB12637@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, Feb 24, 2007 at 08:58:50PM +0000, Ralf Baechle wrote:
>
> Guess I should have eyeballed the error message for a few extra nanoseconds,
> my answer wasn't quite right.  Enabling the binary compat options would
> fix the build but leave the native N64 broken.  Below the fix.
>
>   Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
> index 10e9a18..e569b84 100644
> --- a/arch/mips/kernel/scall64-64.S
> +++ b/arch/mips/kernel/scall64-64.S
> @@ -470,4 +470,4 @@ sys_call_table:
>  	PTR	sys_get_robust_list
>  	PTR	sys_kexec_load			/* 5270 */
>  	PTR	sys_getcpu
> -	PTR	compat_sys_epoll_pwait
> +	PTR	sys_epoll_pwait
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index c5f590c..bcc4248 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -518,5 +518,5 @@ sys_call_table:
>  	PTR	compat_sys_get_robust_list	/* 4310 */
>  	PTR	compat_sys_kexec_load
>  	PTR	sys_getcpu
> -	PTR	sys_epoll_pwait
> +	PTR	compat_sys_epoll_pwait
>  	.size	sys_call_table,.-sys_call_table
>
>   
Thanx Ralf.!!!
