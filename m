Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7LhJT24377
	for linux-mips-outgoing; Fri, 7 Dec 2001 13:43:19 -0800
Received: from ux11.sp.cs.cmu.edu (UX11.SP.CS.CMU.EDU [128.2.198.38])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7LhFo24373
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 13:43:15 -0800
Received: from GLOVEBOX.AHS.RI.CMU.EDU by ux11.sp.cs.cmu.edu id aa13071;
          7 Dec 2001 15:42 EST
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence
	points, add const modifiers
From: Justin Carlson <justinca@ri.cmu.edu>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <01b801c17f5d$0af02180$5601010a@prefect>
References: <20011207121416.A9583@dev1.ltc.com>
	<Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be>
	<20011207123833.A23784@nevyn.them.org>
	<20011207160636.B23798@dea.linux-mips.net>
	<20011207131521.A3942@neurosis.mit.edu>
	<1007753789.1680.1.camel@GLOVEBOX.AHS.RI.CMU.EDU>
	<20011207144343.A4417@neurosis.mit.edu> 
	<01b801c17f5d$0af02180$5601010a@prefect>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 15:44:15 -0500
Message-Id: <1007757856.2046.3.camel@GLOVEBOX.AHS.RI.CMU.EDU>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-12-07 at 15:23, Bradley D. LaRonde wrote:
> > Okay, so it's a bad example, but.. :)  Maybe Brad has a better one.
> 
> From drivers/net/wireless/heremes.h:
> 
> <snip>
> /* Register access convenience macros */
> #define hermes_read_reg(hw, off) (inw((hw)->iobase + (off)))
> #define hermes_write_reg(hw, off, val) (outw_p((val), (hw)->iobase + (off)))
> That won't compile with the do {...} while(0)s left in io.h.  My patch lets
> hermes.h (and all other io code that I've tested) compile.
> 
> heremes.h compiles as-is on other platforms.  Why should mips snub it for
> some dubious value of do {...} while(0)?
> 

Because using (foo(),bar()) syntax to cram in a compound statement is
just silly and a bad idea IMHO.  The real Right Thing is to fix the
compiler and use inline functions instead of macros in just about all of
these cases. 

But, given as this puts me in the category of wanting to change other
people's code just for the sake of a preferred coding style, I suppose I
have to cede the point.  :)

-Justin
