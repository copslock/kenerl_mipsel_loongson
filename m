Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 08:40:43 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:64395 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225195AbUEJHkm>;
	Mon, 10 May 2004 08:40:42 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i4A7ee0m020104;
	Mon, 10 May 2004 03:40:40 -0400
Received: from localhost (mail@vpnuser4.surrey.redhat.com [172.16.9.4])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i4A7ecv20487;
	Mon, 10 May 2004 03:40:38 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BN5Ov-0002Io-00; Mon, 10 May 2004 08:40:37 +0100
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
 table entry st_value
References: <045b01c43155$1e06cd80$8d01010a@prefect>
	<874qqpg2ti.fsf@redhat.com> <012701c43607$83aa65f0$8d01010a@prefect>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Mon, 10 May 2004 08:40:37 +0100
In-Reply-To: <012701c43607$83aa65f0$8d01010a@prefect> (Bradley D. LaRonde's
 message of "Sun, 9 May 2004 16:52:17 -0400")
Message-ID: <87pt9cwwzu.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Bradley D. LaRonde" <brad@laronde.org> writes:
>> An object should never use stubs if takes the address of the function.
>> It should only use a stub for some symbol foo if every use of foo is
>> for a direct call.
>
> OK.  So in a case where an object does take a pointer, does that mean that
> ld.so must fix the GOT entry for that symbol before handing control to the
> app (i.e. no lazy binding for that symbol)?

Right.  Such objects won't use a stub, they'll just have a normal
reference to an undefined symbol.  The dynamic loader must resolve
it in the usual way.

> I notice that the debian mipsel libpthread.so.0 in
> http://ftp.debian.org/pool/main/g/glibc/libc6_2.2.5-11.5_mipsel.deb has
> st_value == 0 for every UND FUNC, just like my x86 debian libraries.  This
> is very different than the uClibc libpthread.so where every UND FUNC has
> st_value != 0.  Interestingly if I link glibc's libpthread with uClibc's
> libc.so I see that most UND FUNCs then have st_value != 0.

You said in your original message that you'd recently upgraded to binutils
2.15-based tools.  Was your libpthread.so built with them?  If so, that would
explain it.  I think earlier versions of ld were overly pessimistic about when
stubs could be used.

FWIW, I have a glibc-based sysroot built with gcc 3.4 and binutils 2.15.
Its libpthread uses plenty of stubs.

Richard
