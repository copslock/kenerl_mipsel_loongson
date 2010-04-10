Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 10:10:54 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:40934 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S2097170Ab0DJIKr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Apr 2010 10:10:47 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1O0Vm9-0005IS-Nt; Sat, 10 Apr 2010 08:10:45 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1O0Vm3-0003zU-UL; Sat, 10 Apr 2010 10:10:39 +0200
Date:   Sat, 10 Apr 2010 10:10:39 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
        such as BTB and RAS
Message-ID: <20100410081039.GK27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com> <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com> <20100402145401.GS27216@mails.so.argh.org> <1270258975.23702.18.camel@falcon> <20100406191026.GD27216@mails.so.argh.org> <1270625455.17528.8.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1270625455.17528.8.camel@falcon>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* Wu Zhangjin (wuzhangjin@gmail.com) [100407 09:38]:
> On Tue, 2010-04-06 at 21:10 +0200, Andreas Barth wrote:
> [...]
> > 
> > The kernel vmlinuz-2.6.33-lemote2f-bfs inside of
> > http://www.anheng.com.cn/loongson/install/loongson2_debian6_20100328.tar.lzma
> > (linked via linux-loongson-community) fails at the same place:
> > 
> > touch stamp-picdir
> > if [ x"-fPIC" != x ]; then \
> >           gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/regex.c -o pic/regex.o; \
> >         else true; fi
> > gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  ../../libiberty/regex.c -o regex.o
> > if [ x"-fPIC" != x ]; then \
> >           gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/cplus-dem.c -o pic/cplus-dem.o; \
> >         else true; fi
> > 
> 
> When & where did you get the above information?
> 
> do you mean the kernel can not boot or there are some other problems
> after the kernel booting?
> 
> I guess: the whole system crashed when you was compiling something? then
> please ensure the as & ld is ok via fixing the NOPS with the tool
> (fix-nop.c) from  http://dev.lemote.com/code/linux-loongson-community :

The kernel does boot, but the whole machines crashes.

I know the fixups (I have adjusted binutils), but I need an kernel
that userland cannot crash (otherwise it gets a bit hard to run that
as debian buildd).


Andi
