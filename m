Received:  by oss.sgi.com id <S554031AbRA1MAH>;
	Sun, 28 Jan 2001 04:00:07 -0800
Received: from Cantor.suse.de ([194.112.123.193]:19 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S554020AbRA1L7g>;
	Sun, 28 Jan 2001 03:59:36 -0800
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 7E0C91E10C; Sun, 28 Jan 2001 12:59:34 +0100 (MET)
Received: from gromit.rhein-neckar.de ([192.168.27.3])
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14MqQa-00024h-00; Sun, 28 Jan 2001 12:55:28 +0100
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 75B341EA2A; Sun, 28 Jan 2001 12:55:27 +0100 (CET)
Mail-Copies-To: never
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Justin Carlson <carlson@sibyte.com>, linux-mips@oss.sgi.com
Subject: Re: GDB 5 for mips-linux/Shared library loading with new binutils/glibc
References: <0101261750492Y.00834@plugh.sibyte.com>
	<Pine.GSO.3.96.1010127084850.29150E-100000@delta.ds2.pg.gda.pl>
	<20010127110106.F867@bacchus.dhis.org>
From:   Andreas Jaeger <aj@suse.de>
Date:   28 Jan 2001 12:55:27 +0100
In-Reply-To: <20010127110106.F867@bacchus.dhis.org> (Ralf Baechle's message of "Sat, 27 Jan 2001 11:01:06 -0800")
Message-ID: <u8itmz28nk.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle <ralf@oss.sgi.com> writes:

> On Sat, Jan 27, 2001 at 09:01:47AM +0100, Maciej W. Rozycki wrote:
> 
> >  I've contributed all patches I've written myself.  Unfortunately, most of
> > the code needed for gdb 5.0 to run on MIPS was taken from the 4.x CVS at
> > oss.sgi.com.  As such it is required all authors of patches have to have
> > their copyright assigned to FSF before committing them to the gdb CVS.
> > 
> >  I've asked people to resolve ownership of the code here some time ago,
> > but it seems nobody is really interested in getting this code into
> > official gdb, sigh... 
> 
> The only people who have contributed amounts of code large enough for the
> FSF to requires an assignment are David Miller (davem@redhat.com) and
> myself.  I've already signed an assignment with the FSF and I'm also sure
> David has.  I btw. cannot remember having seen any mail from you regarding
> copyright assignments of GDB.

David has only disclaimers for Binutils and GCC but not for GDB in the
FSF list.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
