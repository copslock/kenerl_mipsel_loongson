Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8KA3aw18888
	for linux-mips-outgoing; Thu, 20 Sep 2001 03:03:36 -0700
Received: from zh.t2-design.com ([210.14.211.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8KA1ge18866
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 03:01:50 -0700
Received: from zh.t2-design.com ([210.14.211.118])
	by zh.t2-design.com (8.9.3/8.9.3) with ESMTP id SAA21382;
	Thu, 20 Sep 2001 18:04:56 +0800
Message-ID: <3BA9BE47.BEF47A87@zh.t2-design.com>
Date: Thu, 20 Sep 2001 18:00:39 +0800
From: william <william@zh.t2-design.com>
Reply-To: william@zh.t2-design.com
Organization: t2-design
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Murray <rmurray@cyberhqz.com>
CC: linux-mips@oss.sgi.com
Subject: Re: native gcc-3.0.1?
References: <20010920015742.A8317@neurosis.mit.edu> <20010919230953.B6044@cyberhqz.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ryan Murray wrote:

> On Thu, Sep 20, 2001 at 01:57:42AM -0400, Jim Paris wrote:
> > Does anyone have gcc-3.0.1 built as a native MIPS compiler?
>
> Debian built 3.0.1 natively...
>
> > It could also be that gcc-3.0.1 is simply broken when running natively
> > on MIPS.  Has anyone done this?  Any luck?
>
> When that was the version in Debian, it did work.
>
> > anyone has built gcc-3.0 or gcc-3.0.1 natively on MIPS, can you send
> > me the config.cache from your build?
>
> I don't have that around anymore, but I can send you the config.cache from
> a build of a 3.0.2 CVS snapshot...
>
> --
> Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
> The opinions expressed here are my own.
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

Hi,
       Just, I use GCC-3.0.1 to compile Linux kernel,except
ramdisk.o,everything seems fine.about ramdisk.o
because GCC-3.0.1 can't suppor failed to merge target specific data of file
../boot/ramdisk.ot ecoff-littlemips target.so I modified it as
elf32-littlemips,but when linking, compiler told me failed to merge specific
data of file ramdisk.o,from the output compiler message,it says ISA
mismatch(-mips1) with previous modules(--mips3) and used different
e_flags(0x0) fields than previous modules(0x100).What's wrong with it?
            Best regards
        william  20/9/2001
