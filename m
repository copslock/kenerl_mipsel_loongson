Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2ONM3t04641
	for linux-mips-outgoing; Sat, 24 Mar 2001 15:22:03 -0800
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f2ONM1M04638
	for <linux-mips@oss.sgi.com>; Sat, 24 Mar 2001 15:22:01 -0800
Received: (qmail 18652 invoked from network); 24 Mar 2001 23:21:57 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 24 Mar 2001 23:21:57 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: jbglaw@lug-owl.de
cc: linux-mips@oss.sgi.com
Subject: Re: elf2ecoff problem 
In-reply-to: Your message of "Sat, 24 Mar 2001 22:17:58 +0100."
             <20010324221757.B9810@lug-owl.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Mar 2001 09:21:56 +1000
Message-ID: <32583.985476116@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 24 Mar 2001 22:17:58 +0100, 
Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>./elf2ecoff /home/jbglaw/kernel_src/work/mips_linux/linux/vmlinux vmlinux.ecoff -a
>Non-contiguous data can't be converted.
> 17 .modinfo      00000018  ffffffff802730a0  ffffffff802730a0  001700a0  2**2
>                  CONTENTS, ALLOC, LOAD, READONLY, DATA

This may not be relevant but vmlinux should not have a .modinfo
section.  .modinfo is only created when code is compiled with -DMODULE
so why is it in vmlinux?

There was a recent change to the attributes of .modinfo, from CONTENTS,
READONLY to CONTENTS, ALLOC, LOAD, READONLY, DATA, this change was to
remove gcc warning messages.  insmod treats sections .modinfo and
.modstring as special cases and turns off the SHF_ALLOC flag, elf2ecoff
might need special processing for these sections.
