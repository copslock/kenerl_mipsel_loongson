Received:  by oss.sgi.com id <S553668AbRADPqN>;
	Thu, 4 Jan 2001 07:46:13 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:53497 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553660AbRADPp4>; Thu, 4 Jan 2001 07:45:56 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868134AbRADPg3>;
	Thu, 4 Jan 2001 13:36:29 -0200
Date:	Thu, 4 Jan 2001 13:36:29 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	John Van Horne <JohnVan.Horne@cosinecom.com>
Cc:	"'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
Message-ID: <20010104133629.C936@bacchus.dhis.org>
References: <7EB7C6B62C4FD41196A80090279A29113D7353@exchsrv1.cosinecom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <7EB7C6B62C4FD41196A80090279A29113D7353@exchsrv1.cosinecom.com>; from JohnVan.Horne@cosinecom.com on Wed, Jan 03, 2001 at 05:36:44PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 03, 2001 at 05:36:44PM -0800, John Van Horne wrote:

> First, while the kernel builds just fine, when we use objcopy to convert the
> elf image into a binary
> image which we can download to our target, objcopy fails with warnings
> saying that it is writing
> sections to huge (i.e. negative) file offsets. When I use objdump to analyze
> the kernel image,
> I see that our start address of 0x80102584 has been turned into
> 0xffffffff80102584. I'm thinking that
> I need to tell ld something to stop it from doing this. Any ideas?

That's be ok.  32-bit MIPS addresses are sign-extended into 64-bit addresses.
Older binutils used to zero-extend addresses which was broken.  So what
you observe is actually the sympthom of a bug that got fixed.

> Second, the way we build our application, we first create a partially linked
> image, with the -r flag. Then 
> we run ld on this (and an additional object file). When we do this with the
> tools from cross-all-001027
> we get the following error on the second link step:
> 
> mips-linux-ld:  BFD internal error, aborting at
> /homes/local/mips-cross/crossdev-build/src/binutils-001027/bfd/elf32-mips.c
> line 6942 in _bfd_mips_elf_relocate_section
> 
> mips-linux-ld: Please report this bug.

Not good ...  Two possibilities.

 - it's fairly easy to make ld die in funny ways by feeding it with nonsense
   options, linker scripts or similar.
 - it's really a bug.

Assuming it's really a bug, can you extract a small test case that
demonstrate this bug?

> Actually, on the application we didn't get this far using
> binutils-mips-linux-2.8.1 and egcs-mips-linux-1.0.3a,
> so I have nothing to compare it to.  I'm not sure if this is a bug or if I
> should be passing some flags to gcc or ld.

It may well be a bug; especially -r is used relativly rarely so the code
isn't getting excercised too well.  I'd like to see it get fixed in the
current linker, though.

  Ralf
