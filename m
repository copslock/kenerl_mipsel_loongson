Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2005 07:31:39 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:61448 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8226197AbVDOGbX>; Fri, 15 Apr 2005 07:31:23 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T7052afa4d3dc8038166a4@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Fri, 15 Apr 2005 14:32:59 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.1)
          with ESMTP id 2005041514331591-7675 ;
          Fri, 15 Apr 2005 14:33:15 +0800 
Message-ID: <001b01c54184$b918b5a0$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: Re: initrd problem
Date:	Fri, 15 Apr 2005 14:31:14 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.1|January 28, 2004) at
 2005/04/15 =?Bog5?B?pFWkyCAwMjozMzoxNQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.1|January 28, 2004) at 2005/04/15
 =?Bog5?B?pFWkyCAwMjozMzoxOA==?=,
	Serialize complete at 2005/04/15 =?Bog5?B?pFWkyCAwMjozMzoxOA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips



Hi Kumba,
I used your patch for 2.6.11 on MIPS kernel, and found that it lost the
definition "kernel_physaddr".
Could you tell me where is it?

Regards,
Colin



----------------------------------------------------------------------------
---------------


Ed Martini wrote:
> Background:
>
> I'm trying to get 2.6.11 to run on a MIPS Malta board with Yamon.  The
> kernel that comes with the board is 2.4.18 with an embedded ramdisk that
> runs some scripts to install RPMS via NFS or CD-ROM.  The kernel is
> converted to s-records via objcopy(1), and loaded into memory via tftp.
> I want to do something similar with 2.6.latest.
>
> Problem:
>
> On or about Nov 21 of last year, the CONFIG_EMBEDDED_RAMDISK disappeared.
>
> http://www.linux-mips.org/archives/linux-mips/2004-11/msg00135.html
>
> In it's place it is suggested to use the tools in arch/mips/boot, so I
> tried it.  I can cross-compile the kernel, and I get an ELF vmlinux.  I
> can convert it to ecoff with elf2ecoff, and attach an initrd image with
> addinitrd.  The problem begins here.  I end up with an ecoff format
> kernel which is not recognized by objcopy(1), and therefore no s-records.
>
> It seems there is a program called gensrec that would do the job, but
> google doesn't want to tell me where to get it.  Some IRIX binary perhaps?
>
> Solution?
>
> Should I put CONFIG_EMBEDDED_RAMDISK and its ilk back into my kernel, or
> write an ELF version of addinitrd?  Other ideas?
>
> Thanks in advance.

The future is purportedly in the feature known as initramfs.  See the file
Documentation/early-userpace/README for more details on how that is supposed
to work.

That said, I tried initramfs a few times, but either due to lack of
understanding, or broken support code in 2.6.10, I couldn't get it to
properly
load an initrd bundled in, so I forward-ported a patch I wrote that
originally
fixed CONFIG_EMBEDDED_RAMDISK to work with any ABI to 2.6.10, and it worked
rather well.  I'm sticking with this method until I find more/better docs on
how to use initramfs properly.

If you're interested, the patch I use can be found here:
http://dev.gentoo.org/~kumba/mips/misc/misc-2.6.10-add-ramdisk-back.patch
[2.6.10]
http://dev.gentoo.org/~kumba/mips/misc/misc-2.6.11-add-ramdisk-back.patch
[2.6.11]


--Kumba
