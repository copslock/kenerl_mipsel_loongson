Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54Kb8L03750
	for linux-mips-outgoing; Mon, 4 Jun 2001 13:37:08 -0700
Received: from dea.waldorf-gmbh.de (u-99-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.99])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54Kb2h03731
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 13:37:02 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f54Kaq827701;
	Mon, 4 Jun 2001 22:36:52 +0200
Date: Mon, 4 Jun 2001 22:36:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Native compile on the target using RedHat 6.1 rpms - Update
Message-ID: <20010604223652.C22903@bacchus.dhis.org>
References: <20010604174818.41079.qmail@web11904.mail.yahoo.com> <20010604192001.22785.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010604192001.22785.qmail@web11906.mail.yahoo.com>; from wgowcher@yahoo.com on Mon, Jun 04, 2001 at 12:20:01PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 04, 2001 at 12:20:01PM -0700, Wayne Gowcher wrote:

> /usr/bin/ld: /tmp/cca007591.o: ISA mismatch (-mips3)
> with previous modules (-mips1)
> /usr/bin/ld: /tmp/cca007591.o: uses different e_flags
> (0x102) fields than previous modules (0x2)
> Bad value: failed to merge target specific data of
> file /tmp/cca007591.o
> collect2: ld returned 1 exit status
> 
> Which I totally don't understand because I never set
> mips3 I set mips2.

The source itself sets the assembler to mips3 mode.

> I am coming to the conclusion that :
> 
> the egcs-1.03a compiler as found on the sgi web site
> only supports mips 1.

Wrong.

  Ralf
