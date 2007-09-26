Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 10:17:09 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:31237 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029436AbXIZJRA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 10:17:00 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1253753uge
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 02:16:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=9ACCp9DvDOQhsAJk+Got1WHJ0RE+CLmZlzKg5H7dsJo=;
        b=j0is6+Pnxg5/brBd3pCzs0/1TVmp74lP1TXsrMWJzWH/IV8bzCWa12TSGbfSzprBcVg/kqUybuj6jg1aKlgiGUubjt9uqNb5kN+2uCHR/ULEscKC6DzjERAkasKDuKTaIYsGH/ZQRN9rmjzg6xKVUjjfpa7mT+/ZnmsGUrcGn6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nNAIffAwtuKy33oMvSMjwDEh+RQEMGHUOY1d3speCoyficwzqY46ytiVvPBblMAzCKoYWIWdCpMxuv1N8ASuSngpVG/sSs2LhaJhLV4A9L7kep0oTbXZEW1R7nynBBXxlhXUY9kEWH4XmD69WhhfUYE2Pdy7D5Viz3iQRXBZ+Gg=
Received: by 10.66.220.17 with SMTP id s17mr1909904ugg.1190798202277;
        Wed, 26 Sep 2007 02:16:42 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id d13sm1137511fka.2007.09.26.02.16.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 02:16:39 -0700 (PDT)
Message-ID: <46FA2307.3090600@gmail.com>
Date:	Wed, 26 Sep 2007 11:14:47 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	tbm@cyrius.com, linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
References: <20070925181353.GA15412@deprecation.cyrius.com> <20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 25 Sep 2007 20:13:53 +0200, Martin Michlmayr <tbm@cyrius.com> wrote:
>> IP32 kernels that are built with CONFIG_BUILD_ELF64=y only produce an
>> exception when booted.  This worked with 2.6.19 and before.  I haven't
>> had a chance to dig deep yet but it seems both Franck Bui-Huu and
>> Atsushi Nemoto had patches in 2.6.20 that might have caused this.
>> This still happens with 2.6.22.  I cannot boot current git for other
>> reasons.
> 
> I think this is solved on current git a few weeks ago by this commit
> (not mainlined yet):
> 
>> Subject: [MIPS] Fix CONFIG_BUILD_ELF64 kernels with symbols in CKSEG0.

ISTR we kept 2 versions of __pa() for 64 bits kernels for
micro-optimization reason. And I think it was a mistake...

>> Date: 	Tue, 11 Sep 2007 11:12:03 +0100
>> Author: Ralf Baechle <ralf@linux-mips.org> Tue Sep 11 08:50:40 2007 +0100
>> Commit: db423f6e86c3c4c70edf3eaf504e22c467b9f97c
>> Gitweb: http://www.linux-mips.org/g/linux/db423f6e
>> Branch: master
> 
> It is just one liner and can be backported easily.

Hmm I didn't know about this change but I think it's a good one. It
basically removes one CONFIG_BUILD_ELF64 dependency in the _code_
which is good. CONFIG_BUILD_ELF64=y makes the kernel code weak since
the kernel will crash as soon as a CKSEG0 symbol will be
encountered. And ISTR that the bootloader/firmware on some platforms
doens't work with 64 bits symbols and objcopy is used after compiling
the kernel for these reasons. But I'm really not sure...

So IMHO, we should just forget the 4 micro-optimizations associated
with CONFIG_BUILD_ELF64 because it doesn't worth the pain it brings.

> And The Franck's patchset is already in linux-queue tree of lmo so
> should be in 2.6.24.
> 

Ah but as I suggested I think we should get rid of
KBUILD_64BIT_SYM32 in the code. This patchset won't work if the kernel
symbols are modified latter through objcopy or whatever...

What do you think ?

		Franck
