Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 01:20:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41943 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492106Ab0E3XUC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 May 2010 01:20:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4UNJuEx003829;
        Mon, 31 May 2010 00:19:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4UNJtIr003827;
        Mon, 31 May 2010 00:19:55 +0100
Date:   Mon, 31 May 2010 00:19:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100530231954.GA318@linux-mips.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
 <20100530153939.GA22352@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100530153939.GA22352@merkur.ravnborg.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 30, 2010 at 05:39:39PM +0200, Sam Ravnborg wrote:

> > Note: I tried to test a little with bigsur_defconfig
> > but get_user() is buggy. Or at least my gcc thinks that
> > first argument may be used uninitialized.
> > I think mips needs to fix the 64 bit variant of get_user().
> > I took a quick look but ran away.
> 
> My gcc:
> mips-linux-gcc (GCC) 4.1.2
> Copyright (C) 2006 Free Software Foundation, Inc.
> 
> I downloaded it from:
> ftp://ftp.linux-mips.org/pub/linux/mips/people/macro/RPMS/i386/

Uh, get_user.  The living envy the dead.  This may be the best macro soup
in the whole kernel.  The code is so horrible because it's a functions that
is used very frequently in the kernel.  Breathe at it, you get an extra
instruction and that expanded a few thousand times acrosst he kernel.  And
quite often I had to pick the ugly solution because the bogus warnings as
you are experiencing are haunting the implementation forever.

Since a few days I'm using binutils 2.20 and gcc 4.5.0; all defconfigs
are building ok.  I'm uploading the rpms (see list below signature) I
built for my own use to

  ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/
  http://ftp.linux-mips.org/pub/linux/mips/crossdev/

These were built on F12 and come with no userland libraries so are
perfect for your kernel-only use.

  Ralf

2daa8559f5287ae59bbcff5f84b71262  binutils-mips64el-linux-2.20-1.i686.rpm
dbd4531741d7154c74085bacca3667b1  binutils-mips64el-linux-2.20-1.x86_64.rpm
8c5d9d19c3f9b50d100490fe0e3b8c0e  binutils-mips64-linux-2.20-1.i686.rpm
5821dd4385a8b5329e2b75fe546ef627  binutils-mips64-linux-2.20-1.x86_64.rpm
0290f7a4be5903655144f2751e78b0ff  binutils-mipsel-linux-2.20-1.i686.rpm
8dfc605c430a9c0a14f3e62fc836bec1  binutils-mipsel-linux-2.20-1.x86_64.rpm
dfb88224bef5249ba6b2a6215409ea0b  binutils-mips-linux-2.20-1.i686.rpm
8575e9dbcee89d09cdaf44d0649f639f  binutils-mips-linux-2.20-1.x86_64.rpm
8b393e603db6217549d840c85b5fb2cb  cross-binutils-2.20-1.src.rpm
bd7a376b6aa693c0279d6c9cba178fb5  cross-gcc-4.5.0-1.src.rpm
2aa1e9710eb9df0cd475b56711ea6ac1  gcc-mips64el-linux-4.5.0-1.i686.rpm
ca364bfda7b855e86cd19335210700d6  gcc-mips64el-linux-4.5.0-1.x86_64.rpm
2ce8bc4ec8004acb1f0d089b5921287e  gcc-mips64-linux-4.5.0-1.i686.rpm
50c7115ff7c6793d008a4f1f8ecfb6eb  gcc-mips64-linux-4.5.0-1.x86_64.rpm
d20dd7b25fbfd54a3ac795608f20e680  gcc-mipsel-linux-4.5.0-1.i686.rpm
4a3172cdb4b78d2541c39304969377cb  gcc-mipsel-linux-4.5.0-1.x86_64.rpm
2fe8b5f2fefc76491e9b5013791dc5f9  gcc-mips-linux-4.5.0-1.i686.rpm
af54f71683d9c47ce21bbc1162f23d88  gcc-mips-linux-4.5.0-1.x86_64.rpm
