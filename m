Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 09:38:06 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:38713 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491117Ab0DGHiB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 09:38:01 +0200
Received: by pvc30 with SMTP id 30so130142pvc.36
        for <multiple recipients>; Wed, 07 Apr 2010 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ynjpFNLJ08qrQ4TdPqcIHJVIJHlGZztmAmBAdDDm7Qw=;
        b=GL81vD+k2x9Fiv2+hH/xcGp/OXrytbP7KWqb01l4dzu9AJuqx5jQJZFjv1RlZanv8s
         qGOZAi8O2sLMbTWyQS8/n+TS11jocVTReV1AXSIMkZ3UZFeD4zLydlYk1V05KeYGr8FF
         GbiAzt1MeBzVj5dw+M+mfpnH8I7xhlea+fAlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=G8kedf7n3ectiMEPwq/+ztEY4TWxkxG/iSTQLXm463x0gnaSTzLx9ifCsAjVdTjXVb
         SPlSwvYfs8JhsRpXQGSk8+i3GWvOKyOzNUPUIf0fOoa72FoyEk+AVTh4wOqwlFFJCN6u
         X8Cn38a+uh0QbzXu/bXJIYqPZyI27E/bzOCnM=
Received: by 10.142.59.16 with SMTP id h16mr3088891wfa.246.1270625872564;
        Wed, 07 Apr 2010 00:37:52 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm3479273pzk.2.2010.04.07.00.37.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 00:37:51 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
 such as BTB and RAS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100406191026.GD27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
         <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
         <20100402145401.GS27216@mails.so.argh.org>
         <1270258975.23702.18.camel@falcon>
         <20100406191026.GD27216@mails.so.argh.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 07 Apr 2010 15:30:55 +0800
Message-ID: <1270625455.17528.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2010-04-06 at 21:10 +0200, Andreas Barth wrote:
[...]
> 
> The kernel vmlinuz-2.6.33-lemote2f-bfs inside of
> http://www.anheng.com.cn/loongson/install/loongson2_debian6_20100328.tar.lzma
> (linked via linux-loongson-community) fails at the same place:
> 
> touch stamp-picdir
> if [ x"-fPIC" != x ]; then \
>           gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/regex.c -o pic/regex.o; \
>         else true; fi
> gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  ../../libiberty/regex.c -o regex.o
> if [ x"-fPIC" != x ]; then \
>           gcc -c -DHAVE_CONFIG_H -g -O2  -I. -I../../libiberty/../include  -W -Wall -Wwrite-strings -Wc++-compat -Wstrict-prototypes -pedantic  -fPIC ../../libiberty/cplus-dem.c -o pic/cplus-dem.o; \
>         else true; fi
> 

When & where did you get the above information?

do you mean the kernel can not boot or there are some other problems
after the kernel booting?

I guess: the whole system crashed when you was compiling something? then
please ensure the as & ld is ok via fixing the NOPS with the tool
(fix-nop.c) from  http://dev.lemote.com/code/linux-loongson-community :

$ ./fix-nop `which as`
$ ./fix-nop `which ld`

> 
> Any other kernel I should try?
> 

The kernel in the above link should boot, or you can compile one
yourself.

Regards,
	Wu Zhangjin
