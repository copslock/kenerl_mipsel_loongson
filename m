Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LNKoB16673
	for linux-mips-outgoing; Sat, 21 Jul 2001 16:20:50 -0700
Received: from dea.waldorf-gmbh.de (u-151-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.151])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LNKkV16659
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 16:20:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6LNKGj27609;
	Sun, 22 Jul 2001 01:20:16 +0200
Date: Sun, 22 Jul 2001 01:20:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Greg Satz <satz@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010722012016.I25928@bacchus.dhis.org>
References: <20010721104144.A17894@lucon.org> <B77F222C.888C%satz@ayrnetworks.com> <20010721111315.A9479@lucon.org> <20010721205659.B25928@bacchus.dhis.org> <20010721120302.A10173@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721120302.A10173@lucon.org>; from hjl@lucon.org on Sat, Jul 21, 2001 at 12:03:02PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 12:03:02PM -0700, H . J . Lu wrote:

> > Actually for all code; we don't support GP optimization in any of our code
> > models.
> 
> Even for the user space code?

Yes.  GP optimization isn't comparible with SVR4 PIC code.  I don't see a
fundamental problem to get that to work but gcc refuses the use of -G with
PIC code.

What would limit the value of the GP optimization is that for alot of code
a single 64kb GP data segment is not large enough; the IRIX compiler and
Alpha binutils afaik support a multi-gp code model already.

> Do you have a testcase to show what should be the desired behavior? As I
> understand, the SHN_MIPS_SCOMMON section only appears in the relocatable
> files. You won't see it in
> executables nor DSOs. Are there any problems with SHN_MIPS_SCOMMON
> in .o files? Can we always pass `-G 0' to the assemebler for Linux.

It's already guanteed that we never use GP optimization.  The particular
case which was reported by the user was caused ld directly which defaults to
-G 8.  That's not an issue for userspace.

  Ralf
