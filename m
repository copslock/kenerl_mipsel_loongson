Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 13:55:45 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:30987 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8224787AbUJRMzh>; Mon, 18 Oct 2004 13:55:37 +0100
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi [10.1.1.12])
	by lennier.cc.vt.edu (8.12.8/8.12.8) with ESMTP id i9ICtC0P089057;
	Mon, 18 Oct 2004 08:55:12 -0400 (EDT)
Received: from [127.0.0.1] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by vivi.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id BUW31750 (AUTH spbecker);
	Mon, 18 Oct 2004 08:55:10 -0400 (EDT)
Message-ID: <4173BD42.9050009@gentoo.org>
Date: Mon, 18 Oct 2004 08:55:30 -0400
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre.Messerschmidt@infineon.com
CC: linux-mips@linux-mips.org
Subject: Re: Mozilla Firefox compile problem
References: <34A8108658DCCE4B8595675ABFD8172709FAFE@dusse201.eu.infineon.com>
In-Reply-To: <34A8108658DCCE4B8595675ABFD8172709FAFE@dusse201.eu.infineon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Andre.Messerschmidt@infineon.com wrote:
> Hi,
> 
> I am trying to compile Mozilla Firefox 1.0PR with Montavista Pro 3.1 toolchain (I linked mips_fp_be to mips-linux), but I get the following error messages:
> 
> ---- snip ---------------------------------------------------
> mips-linux-g++  -I/opt/mvx/usr/X11R6/include -fno-rtti -fno-exceptions -Wall -Wconversion -Wpointer-arith -Wcast-align -Woverloaded-virtual -Wsynth -Wno-ctor-dtor-privacy -Wno-non-virtual-dtor -Wno-long-long -Wa,-xgot -pthread -pipe  -DDEBUG -D_DEBUG -DDEBUG_am -DTRACING -g -fno-inline -o nsIFileEnumerator nsIFileEnumerator.o           -L../../dist/bin -L../../dist/lib -L../../dist/bin -lxpcom  -L/data2/Sources/inca/mozilla/dist/lib -lplds4 -lplc4 -lnspr4 -lpthread -ldl   -ldl -lm
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub203()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub156()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub184()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub128()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub226()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub246()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub112()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub180()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub230()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub147()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub151()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub116()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub111()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub231()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub141()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub104()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub58()'
> ../../dist/bin/libxpcom.so: undefined reference to `nsXPTCStubBase::Stub53()'
> 
> ...
> 

https://bugzilla.mozilla.org/show_bug.cgi?id=71627

The patch there will fix the compile, but the resulting binary probably 
won't run.

Steve
