Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4ED2QnC022351
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 14 May 2002 06:02:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4ED2QUT022350
	for linux-mips-outgoing; Tue, 14 May 2002 06:02:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4ED2KnC022335
	for <linux-mips@oss.sgi.com>; Tue, 14 May 2002 06:02:22 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA01844;
	Tue, 14 May 2002 15:02:39 +0200 (MET DST)
Date: Tue, 14 May 2002 15:02:38 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ldavies@agile.tv
cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: deleted /dev/zero
In-Reply-To: <3CE06604.2050800@agile.tv>
Message-ID: <Pine.GSO.3.96.1020514150109.1471B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 14 May 2002, Liam Davies wrote:

> The ltp mtest05 test had a bug in which it would remove /dev/zero when
> it cleaned up. Have you got an updated ltp suite?
> 
> This is the fix that they did in late March to the mtest05 test.
> 
> /ltp/ltp/testcases/kernel/mem/mtest05/mmstress.c:246
> -    if (strcmp(filename, "NULL") || strcmp(filename, "/dev/zero"))
> +    if (strcmp(filename, "NULL") && strcmp(filename, "/dev/zero"))
> 
> I suppose that there may be other LTP tests that could have similar
> bugs...

 Which only proves again one shouldn't run software as root unless
absolutely needed... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
