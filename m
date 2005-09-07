Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 16:26:55 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:35
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225263AbVIGP0k>;
	Wed, 7 Sep 2005 16:26:40 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Sep 2005 08:33:37 -0700
Message-ID: <431F0850.8090804@avtrex.com>
Date:	Wed, 07 Sep 2005 08:33:36 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: MIPS SF toolchain
References: <1126098584.12696.19.camel@localhost.localdomain>
In-Reply-To: <1126098584.12696.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2005 15:33:37.0210 (UTC) FILETIME=[83DA29A0:01C5B3C1]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Matej Kupljen wrote:
> Hi
> 
> Can somebody tell me, what is the right way to make a soft float
> toolchain. I tried with crosstool with different flags for configure
> and gcc, but the resulting binaries still contains the FP instructions, 
> like swc1.
> 
> I used --with-float=soft and --nfp for gcc configure,
> --without-fp for glibc configure, and compiled glibc
> with -msoft-float flag.
> 
> Am I missing something, or am I using the wrong flags?
> 
> GCC: 3.3.5
> GLIBC: 2.3.5
> BINUTILS: 2.15

On gcc 3.3.x --with-float=soft does nothing.  If you are using a MIPS32 
ISA processor you can configure it with --target=mipsisa32[el]-linux to 
get soft float and MIPS32 ISA by default.

But even better would be to use gcc 3.4.x or 4.0.x where 
--with-float=soft works.  I would also recommend binutils 2.16.1 or 
above as there are some severe bugs in the mips linker in earlier versions.

David Daney.
