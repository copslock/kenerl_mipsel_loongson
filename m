Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14DLVq17058
	for linux-mips-outgoing; Mon, 4 Feb 2002 05:21:31 -0800
Received: from dea.linux-mips.net (a1as01-p54.stg.tli.de [195.252.185.54])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14DLQA16969
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 05:21:26 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1467fO18828;
	Mon, 4 Feb 2002 07:07:41 +0100
Date: Mon, 4 Feb 2002 07:07:41 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: cgd@broadcom.com
Cc: hjl@lucon.org, Justin Carlson <justinca@ri.cmu.edu>,
   Daniel Jacobowitz <dan@debian.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com, gcc@gcc.gnu.org
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020204070741.A13799@dea.linux-mips.net>
References: <20020131231714.E32690@lucon.org> <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl> <20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org> <20020201151513.A15913@lucon.org> <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net> <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <yov5ofj65elj.fsf@broadcom.com>; from cgd@broadcom.com on Sun, Feb 03, 2002 at 03:29:28PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Feb 03, 2002 at 03:29:28PM -0800, cgd@broadcom.com wrote:

> At Sat, 2 Feb 2002 20:04:10 +0000 (UTC), "H . J . Lu" wrote:
> > Does everyone agree with this? If yes, I can make a patch not to use
> > branch likely. But on the other hand, "gcc -mips2" will generate code
> > using branch likely. If branch likely doesn't buy you anything, 
> > shouldn't we change gcc not to generate branch likely instructions?
> 
> Branch-likely instructions probably _do_ buy you something (at least,
> slightly less code size) on some CPUs, probably even some CPUs which
> are still being produced.

I benchmarked the performance improvment on R4000/R4400 by using branch
likely instructions to be in the range of 1-2% in a piece of pretty
"branchy" code, so we don't want to disable branch likely right entirely.
Newer CPU types, in particular those featuring branch prediction tend to
perform differently.

I suggest to enable branch likely in gcc for those > MIPS II CPUs where
they're known to improve performance or when optimizing for code size.
Unfortunately gcc's knowledge about such architecture details is rather
limited.

  Ralf
