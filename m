Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 03:15:36 +0100 (BST)
Received: from web31512.mail.mud.yahoo.com ([68.142.198.141]:44198 "HELO
	web31512.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039510AbWJGCPd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Oct 2006 03:15:33 +0100
Received: (qmail 38256 invoked by uid 60001); 7 Oct 2006 02:15:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R1K3NnMHzeHJwfOUax5rd9FYokPBFcfUEypBmy2cYOLRo0xLpIUiW+w6vr1kLlVM5GZvac6YBkLdUVmjAzYII/GwI/KfMjtn1UtKp/npmHWvF+HXi6npwVLIvtBpPuCbQsURLeIjAdsViZNxIOiDL75JMyANBNmPw4vepxZNblc=  ;
Message-ID: <20061007021523.38254.qmail@web31512.mail.mud.yahoo.com>
Received: from [65.102.5.19] by web31512.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 19:15:23 PDT
Date:	Fri, 6 Oct 2006 19:15:23 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: CFE problem: starting secondary CPU.
To:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D3E7324@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I've seen the case where the second CPU did not start
on a Broadcom 1250 running a 64-bit kernel, but I
don't know if anyone has a good solution. I just
rigged the values in the Linux kernel so that it knows
about the second CPU. It's a godawful hack, but I
needed something quick at the time.

Personally, I am not a fan of CFE and would love to
know if there's a better way to bootstrap.

--- Kaz Kylheku <kaz@zeugmasystems.com> wrote:

> Anyone seen a problem like this? cfe_cpu_start()
> works fine on a
> 32 bit kernel, but not on 64.
> 
> I added a function to cfe/smp.c:
> 
>   static asmlinkage void dummy()
>   {
>     prom_printf("dummy called\n");
>   }
> 
> This serves as the simplest possible "hello world". 
> 
> If I substitute this for the function passed to
> cfe_cpu_start(),
> on a 32 bit kernel, the slave CPU calls the function
> and the
> message is printed on the serial console.
> 
> On a 64 bit kernel, the function is never reached.
> The API call returns,
> but the
> secondary CPU never calls in.
> 
> The sign-extension of the address looks good. The
> function pointer looks
> like
> FFFFFFFF8XXXXXXX. This is cast to long before being
> assigned into the
> right field
> of the CFE request structure, where it is converted
> to 64 bit unsigned.
> 
> Inside CFE, the CPU is just looping around waiting
> for the address to
> call with
> a direct jump.
> 
> So it's a puzzling problem.
> 
> 
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
