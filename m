Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36BdYL24728
	for linux-mips-outgoing; Fri, 6 Apr 2001 04:39:34 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36BdXM24725
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 04:39:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA09889;
	Fri, 6 Apr 2001 04:39:36 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA03686;
	Fri, 6 Apr 2001 04:39:33 -0700 (PDT)
Message-ID: <00a401c0be8e$cfc065a0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Florian Lohoff" <flo@rfc822.org>, <debian-mips@lists.debian.org>
Cc: <linux-mips@oss.sgi.com>
References: <20010406130958.A14083@paradigm.rfc822.org> <20010406132214.D14083@paradigm.rfc822.org>
Subject: Re: first packages for mipsel
Date: Fri, 6 Apr 2001 13:43:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Fri, Apr 06, 2001 at 01:09:58PM +0200, Florian Lohoff wrote:
> There are multiple solutions to this problem:
>
> - ll/sc emulation in the kernel
>   Implementing an ll/sc emulation into the fast path of the illegal
instruction
>   handler and compile the glibc with ll/sc support.
>
> - repair sysmips
>   Sysmips is essentially broken - My fix i have sent to the linux-mips
list
>   is only a workaround but not a fix. Also there is currentl NO ISA I
support
>   in the sysmips implementation. I hope to get around to build a proper
>   fix this weekend in assembly.
>
> Probably we will do both - An even better solution would be to let the
glibc
> detect the ISA level or the existance of ll/sc in userspace and replace
_test_and_set
> with one or the other primitiv - Using sysmips on R3000 or ll/sc less
systems.

What advantage would there be to using sysmips() as opposed
to doing the ll/sc emulation?  It seems to me that the decode path
in the kernel would be just as fast, and there would be a single
"ABI" for all programs - the ll/sc instructions themselves.

            Kevin K.
