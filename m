Received:  by oss.sgi.com id <S553721AbRAEAo1>;
	Thu, 4 Jan 2001 16:44:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:57646 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553786AbRAEAoC>; Thu, 4 Jan 2001 16:44:02 -0800
Received: from sydney.sydney.sgi.com (sydney.sydney.sgi.com [134.14.48.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id QAA04955; Thu, 4 Jan 2001 16:52:40 -0800 (PST)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com by sydney.sydney.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id LAA12000; Fri, 5 Jan 2001 11:42:42 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@ocs.com.au>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: ksymoops on origin
In-reply-to: Your message of "Thu, 04 Jan 2001 15:13:34 -0200."
             <20010104151334.C2525@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 05 Jan 2001 11:42:42 +1100
Message-ID: <1123.978655362@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001 15:13:34 -0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>Doesn't really solve the problem.  For example on an Origin we have a 32-bit
>userland but 64-bit kernel addresses which confuses ksymops and procps.

In what way does ksymoops get confused?  All its address handling
should be 64 bit.  As long as the kernel prints its addresses in full,
without removing the high order word, then the text handling should be
OK.  The only problem will be the default object format which is taken
from ksymoops itself.  Sparc also has this problem, from oops.c,
function Oops_eip.

        /* Special case for sparc64.  If the output target is defaulting to the
         * same format as ksymoops then the default is wrong, kernel is 64 bit,
         * ksymoops is 32 bit.  When we see an EIP from sparc64, set the correct
         * default.
         */
        if (!options->target && !options->architecture &&
            strcmp(bfd_get_target(ibfd), "elf32-sparc")) {
            options->target = "elf64-sparc";
            options->architecture = "sparc:v9a";
        }

I will add a special case for Origin if somebody can tell me:

  What oops string identifies a 64 bit kernel instead of 32 bit.
  What bfd_get_target() reports for a 32 bit ksymoops on Origin.
  What target and architecture to use for a 64 bit kernel.

Even without special case code for Origin, you can run ksymoops with
the -t and -a options to force the desired format, instead of
defaulting to the format of ksymoops.
