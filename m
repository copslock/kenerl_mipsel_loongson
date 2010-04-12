Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Apr 2010 05:35:07 +0200 (CEST)
Received: from mail-yx0-f200.google.com ([209.85.210.200]:53604 "EHLO
        mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491197Ab0DLDfD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Apr 2010 05:35:03 +0200
Received: by yxe38 with SMTP id 38so1871395yxe.22
        for <multiple recipients>; Sun, 11 Apr 2010 20:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=zh72fpVOCjDaNrxDkh4Dnio0mk1NNBZd53oS8Gk4UbI=;
        b=AF8IndCrw4oKDVutp68vldwlIAEa8eqd/kpKG1u8TE7zaIK5YHgKfEPh7uwqGjU2zj
         qkgRtLlLaLosNIlFsf1JmBGfZbGkTzXTEjAvmyOjZerx4N9/hIkzKvrlWMewrTgsKpJx
         U4JH8uTHi0H9BvWpKmLaebI/33+KnscMr5jvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=FjDuh/JFlYyAYXcciKybqu7T2amlverhDx5sEjhz5dMsdJ+y6ZnohQaSl50PNGnWuL
         GhEOoVmJ7djNZxZOMOcvzzTYY/Wg2F9tSXW3KA0p0KjeYWm1pgnSoLZhTU6XfMKCjFWt
         twuTeqoRATwQEmujvwjDsVtmnv21vGqVlW24g=
Received: by 10.100.88.10 with SMTP id l10mr5558083anb.184.1271043296063;
        Sun, 11 Apr 2010 20:34:56 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3630818iwn.3.2010.04.11.20.34.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 20:34:54 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
 such as BTB and RAS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100410081039.GK27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
         <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
         <20100402145401.GS27216@mails.so.argh.org>
         <1270258975.23702.18.camel@falcon>
         <20100406191026.GD27216@mails.so.argh.org>
         <1270625455.17528.8.camel@falcon>
         <20100410081039.GK27216@mails.so.argh.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 12 Apr 2010 11:33:59 +0800
Message-ID: <1271043239.1917.11.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2010-04-10 at 10:10 +0200, Andreas Barth wrote:
> * Wu Zhangjin (wuzhangjin@gmail.com) [100407 09:38]:
> > On Tue, 2010-04-06 at 21:10 +0200, Andreas Barth wrote:
> > [...]
> > > 
> > > The kernel vmlinuz-2.6.33-lemote2f-bfs inside of
> > > http://www.anheng.com.cn/loongson/install/loongson2_debian6_20100328.tar.lzma
> > > (linked via linux-loongson-community) fails at the same place:
> > > 
> > > touch stamp-picdir
> > > if [ x"-fPIC" != x ]; then \
> > >           gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/regex.c -o pic/regex.o; \
> > >         else true; fi
> > > gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  ../../libiberty/regex.c -o regex.o
> > > if [ x"-fPIC" != x ]; then \
> > >           gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/cplus-dem.c -o pic/cplus-dem.o; \
> > >         else true; fi
> > > 
> > 
> > When & where did you get the above information?
> > 
> > do you mean the kernel can not boot or there are some other problems
> > after the kernel booting?
> > 
> > I guess: the whole system crashed when you was compiling something? then
> > please ensure the as & ld is ok via fixing the NOPS with the tool
> > (fix-nop.c) from  http://dev.lemote.com/code/linux-loongson-community :
> 
> The kernel does boot, but the whole machines crashes.
> 
> I know the fixups (I have adjusted binutils), but I need an kernel
> that userland cannot crash (otherwise it gets a bit hard to run that
> as debian buildd).
> 
> 

The userland canot be prevented from crash without user-space fixups,
that's why we need the fix-nop.c to fix the NOPs in the binaries of
user-land applications or using the -mfix-loongson-nop to compile the
user-land applications.

If you just need to rebuild debian, you just need to fix the NOPs in the
as and ld with fix-nop.c as I have mentioned before:

$ ./fix-nop $(which as)
$ ./fix-nop $(which ld)

Regards,
	Wu Zhangjin
