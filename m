Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PIpEk07390
	for linux-mips-outgoing; Fri, 25 May 2001 11:51:14 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PITuF06450
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 11:34:46 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA22390;
	Fri, 25 May 2001 15:13:04 +0200 (MET DST)
Date: Fri, 25 May 2001 15:13:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
In-Reply-To: <20010524164459.A19466@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010525130531.17652A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 24 May 2001, Daniel Jacobowitz wrote:

> They aren't the same for MIPS, though.  I exhibit as evidence the fact
> that my patch fixed the problem I was seeing.  I didn't know about 'R';
> I suppose that it is more correct.  'm' at least is closer than 'o',
> though.

 The following program cannot be compiled with gcc 2.95.3, because the
offset is out of range (I consider it a bug in gcc -- it should allocate
and load a temporary register itself and pass it appropriately as %0,
matching the "R" constraint; still it's better than generating bad code): 

int main(void)
{
	int *p;

	asm volatile(".set push\n\t"
 		".set noat\n\t"
		"lw $0,%0\n\t"
		".set pop"
		:
		: "R" (p[0x10000]));

	return 0;
}

After changing "R" to "m" or "o", bad assembly is generated if optimizing
as follows: 

 #APP
	.set push
	.set noat
	lw $0,262144($2)
	.set pop
 #NO_APP

Note that it's an expected behaviour -- there are no non-offsettable
address modes for MIPS.

> If 'R' will behave correctly, could that be applied to CVS, then?

 I suppose so -- I'm not in a position to apply changes. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
