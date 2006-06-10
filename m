Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2006 01:42:00 +0100 (BST)
Received: from jg555.com ([64.30.195.78]:36500 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8134050AbWFJAlv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2006 01:41:51 +0100
Received: from [172.16.0.159] (W2RZ8L4S01.jg555.com [::ffff:172.16.0.159])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Fri, 09 Jun 2006 17:41:46 -0700
  id 000201FA.448A154A.00002764
Message-ID: <448A1497.3000909@jg555.com>
Date:	Fri, 09 Jun 2006 17:38:47 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	Jonathan Day <imipak@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: where I can find a crosscompiler for BCM1255
References: <20060609172443.23749.qmail@web31505.mail.mud.yahoo.com>
In-Reply-To: <20060609172443.23749.qmail@web31505.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> I have built cross-compilers for the Broadcom BCM1250
> using the instructions and patches on the "Linux From
> Scratch" website. You need to look for the
> cross-compiler version of their guide, then select
> "browse online" and finally "mips64" to get to the
> instructions/patches for building for the 64-bit MIPS
> platforms.
>
> Do NOT use their kernel or kernel patches - use the
> version in the git repository on linux-mips.
>
>   

Johnathan, I'm on of the developers of CLFS, did you  run into a problem 
with the patches? The patch is diff  kernel.org and linux-mips.org 
kernels. Just curious, if we missed something let me know.
