Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Apr 2010 21:10:40 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:43795 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492448Ab0DFTKf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Apr 2010 21:10:35 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NzEAS-0004wR-M8; Tue, 06 Apr 2010 19:10:32 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NzEAM-00058w-Nk; Tue, 06 Apr 2010 21:10:26 +0200
Date:   Tue, 6 Apr 2010 21:10:26 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
        such as BTB and RAS
Message-ID: <20100406191026.GD27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com> <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com> <20100402145401.GS27216@mails.so.argh.org> <1270258975.23702.18.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1270258975.23702.18.camel@falcon>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* Wu Zhangjin (wuzhangjin@gmail.com) [100403 03:50]:
> On Fri, 2010-04-02 at 16:54 +0200, Andreas Barth wrote:
> > * Wu Zhangjin (wuzhangjin@gmail.com) [100313 05:45]:
> > > This patch did clear BTB(branch target buffer), forbid RAS(return
> > > address stack) via Loongson-2F's 64bit diagnostic register.
> > 
> > Unfortunatly the Loongson 2F here still fails with this patch,
> > compiled with the new binutils and both options enabled.
> > 
> > Testcase: plain debian unstable chroot, build binutils in that chroot.
> > 
> > More ideas, codes, whatever welcome.


> This patch is not enough, please use the kernel(>=2.6.32) from
> http://dev.lemote.com/code/rt4ls or
> http://dev.lemote.com/code/linux-loongson-community

The kernel vmlinuz-2.6.33-lemote2f-bfs inside of
http://www.anheng.com.cn/loongson/install/loongson2_debian6_20100328.tar.lzma
(linked via linux-loongson-community) fails at the same place:

touch stamp-picdir
if [ x"-fPIC" != x ]; then \
          gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/regex.c -o pic/regex.o; \
        else true; fi
gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  ../../libiberty/regex.c -o regex.o
if [ x"-fPIC" != x ]; then \
          gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/cplus-dem.c -o pic/cplus-dem.o; \
        else true; fi


Any other kernel I should try?



Andi
