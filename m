Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BNMjI18900
	for linux-mips-outgoing; Mon, 11 Feb 2002 15:22:45 -0800
Received: from dea.linux-mips.net (a1as09-p62.stg.tli.de [195.252.189.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BNMe918896
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 15:22:40 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1BMK1U05333;
	Mon, 11 Feb 2002 23:20:01 +0100
Date: Mon, 11 Feb 2002 23:20:01 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Johannes Stezenbach <js@convergence.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Florian Lohoff <flo@rfc822.org>,
   linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211232001.G4623@dea.linux-mips.net>
References: <20020211142708.GA2577@convergence.de> <Pine.GSO.3.96.1020211155920.18917F-100000@delta.ds2.pg.gda.pl> <20020211162844.GD2918@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211162844.GD2918@convergence.de>; from js@convergence.de on Mon, Feb 11, 2002 at 05:28:44PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 05:28:44PM +0100, Johannes Stezenbach wrote:

> >  Is gcc 3.x already stable enough to be used by people not directly
> > involved in gcc development?  More specifically for MIPS/Linux and
> > i386/Linux, for both the kernel and the userland?  I'm told it is not.
> 
> I'm reading about gcc 3.x code generation bugs every now and then,
> but so far I did not hit any of them.

I've fixed several kernel bugs that got triggered by building with 3.0.
We've got an a piece of inline assembler where a constraint gets ignored
by 3.0 resulting in bad code.  Add slow compilation and slow code.  3.0?
No way.  Yet.

  Ralf
