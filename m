Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GABPX21898
	for linux-mips-outgoing; Thu, 16 Aug 2001 03:11:25 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GABDj21895
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 03:11:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA03622;
	Thu, 16 Aug 2001 12:12:57 +0200 (MET DST)
Date: Thu, 16 Aug 2001 12:12:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Simon Gee <simong@oz.agile.tv>, linux-mips@oss.sgi.com,
   gcc-bugs@gcc.gnu.org
Subject: Re: MIPS, profiling, and not working
In-Reply-To: <20010814164438.A22825@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010816115717.1274K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 14 Aug 2001, Daniel Jacobowitz wrote:

> *sigh* Yes, I think the adjustment was meant to be made before the
> call.  Perhaps binutils should warn about things in the "delay slot" of a
> macro?

 .set nomacro?

 There is usually no need to force an instruction into a delay slot
(unless there are nonobvious dependencies, but then you probably want to
avoid macro expansions anyway).  You may just place it before a
branch/jump and gas will move it into the slot itself if it finds it can.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
