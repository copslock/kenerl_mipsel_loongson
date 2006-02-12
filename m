Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 20:13:48 +0000 (GMT)
Received: from networks.syneticon.net ([213.239.212.131]:8850 "EHLO
	mail2.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S3458484AbWBLUNh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 20:13:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id 8AFC03CBCC;
	Sun, 12 Feb 2006 21:19:48 +0100 (CET)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02644-17; Sun, 12 Feb 2006 21:19:42 +0100 (CET)
Received: from [84.44.217.177] (xdsl-84-44-217-177.netcologne.de [84.44.217.177])
	by mail2.syneticon.net (Postfix) with ESMTP;
	Sun, 12 Feb 2006 21:19:41 +0100 (CET)
Message-ID: <43EF985C.4060609@wpkg.org>
Date:	Sun, 12 Feb 2006 21:19:40 +0100
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mail/News 1.5 (X11/20060210)
MIME-Version: 1.0
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
	linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org> <43EF8C16.9020104@total-knowledge.com>
In-Reply-To: <43EF8C16.9020104@total-knowledge.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at syneticon.de
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Ilya A. Volynets-Evenbakh wrote:
> Canadian cross is when you build toolchain on system X to run on system
> Y, and generate code for system Z.

all right, so I misunderstood, I need to build gcc on system X to run on 
system Y.


> Are you sure it is what you want? I somehow suspect that you want to
> generate toolchain to build things
> natively on your mipsel box to run on said box. If that is true,
> buildroot (http://buildroot.uclibc.org) will do everything

Buildroot also builds gcc which works on let's say x86 and makes 
binaries for mipsel/uclibc).

I need the gcc binaries which will work on mipsel, and which will build 
for mipsel.


> for you. Also, I think crosstool does it by default as well (not 100%
> sure though). Look under your destination dir
> for <target>/bin/gcc.

Crosstool by default builds the binaries on system X that will run on 
system X and build for Y.

So now I have binaries that build for mipsel/uclibc on x86, but I can't 
build gcc that will work on mipsel/uclibc with it.


-- 
Tomasz Chmielewski
Software deployment with Samba
http://wpkg.org
