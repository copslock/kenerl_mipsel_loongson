Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 01:55:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54311 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491919AbZHCXzX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Aug 2009 01:55:23 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n73NtbLt028774;
	Tue, 4 Aug 2009 00:55:37 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n73NtaE4028772;
	Tue, 4 Aug 2009 00:55:36 +0100
Date:	Tue, 4 Aug 2009 00:55:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	GCC Help Mailing List <gcc-help@gcc.gnu.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Relocation problem with MIPS kernel modules
Message-ID: <20090803235536.GB22543@linux-mips.org>
References: <20090730184923.GA27030@cuplxvomd02.corp.sa.net> <20090803092030.GB30431@linux-mips.org> <4A773B85.6010004@caviumnetworks.com> <20090803201521.GA24691@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090803201521.GA24691@cuplxvomd02.corp.sa.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 03, 2009 at 01:15:21PM -0700, David VomLehn wrote:

> > Actually I think it is the opposite:
> >
> > RELOCATION RECORDS FOR [.text]:
> > OFFSET   TYPE              VALUE
> > 00000000 R_MIPS_HI16       .bss+0x00000004
> > 00000008 R_MIPS_LO16       .bss+0x00000004
> > 00000014 R_MIPS_LO16       .bss+0x00000004
> >
> > We load the hi16 value into a register and then use multiple lo16  
> > offsets for the follow loads and stores to the same location.  On a  
> > read-modify-write we only want to load the base address one time.
> 
> This particular case is covered by the old MIPS Processor psABI:
> 
> 	R_MIPS_LO16 entries without an R_MIPS_HI16 entry immediately preceding
> 	are orphaned and the previously defined R_MIPS_HI16 is used for
> 	computing the addend.
> 
> The code in module.c looks like it implements the extension to which Ralf
> refers.

Which is useful for for branch delay slot scheduling like:

	...
	j	1f
	lui	a0, %hi16(hello)
	...
	j	1f
	lui	a0, %hi16(hello)
	...
1:	jal	printf
	addiu	a0, %lo16(hello)

hello:	.asciz	"hello, hola\n"

The next and logical extension would be to permit multiple R_MIPS_LO16
records following a sequence of one or more R_MIPS_HI16 relocs as long as
all relate to the same symbol - which would be simple to support in the
kernel.

  Ralf
