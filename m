Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 13:34:14 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:2297 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28795868AbYISMeG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 13:34:06 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JCXwqk030608;
	Fri, 19 Sep 2008 14:33:59 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JCXw7q030604;
	Fri, 19 Sep 2008 13:33:58 +0100
Date:	Fri, 19 Sep 2008 13:33:58 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dinar Temirbulatov <dtemirbulatov@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
In-Reply-To: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
Message-ID: <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl>
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Dinar Temirbulatov wrote:

> I noticed that mmap is not working properly under n32, o32 abis in
> MIPS64, for example if we want to map 0xb6000000 address to the
> userland under those abis we call  mmap and because the last argument
> in old_mmap is off_t and this type is 64-bits wide for MIPS64, we end
> up having for example 0xffffffffb6000000 address value. I am sure that
> this is not a glibc issue. Following patch adds 32-bit version of mmap
> and also it adds mmap64 support for n32 abi since mmap64 was
> implemented correctly for n32 too.

 Well, neither with the o32 nor with the n32 ABI are 0xb6000000 or
0xffffffffb6000000 (which is the n32's equivalent of the former) valid
user addresses, so your concern is?

  Maciej
