Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12Lnmu27535
	for linux-mips-outgoing; Sat, 2 Feb 2002 13:49:48 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12Lnjd27484
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 13:49:45 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA29253;
	Sat, 2 Feb 2002 12:49:35 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA22911;
	Sat, 2 Feb 2002 12:49:32 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g12Kn7A24635;
	Sat, 2 Feb 2002 21:49:07 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id VAA15305;
	Sat, 2 Feb 2002 21:49:29 +0100 (MET)
Message-Id: <200202022049.VAA15305@copsun18.mips.com>
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
To: hjl@lucon.org (H . J . Lu)
Date: Sat, 2 Feb 2002 21:49:29 +0100 (MET)
Cc: justinca@ri.cmu.edu (Justin Carlson), dan@debian.org (Daniel Jacobowitz),
   macro@ds2.pg.gda.pl (Maciej W. Rozycki),
   machida@sm.sony.co.jp (Hiroyuki Machida), libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com, gcc@gcc.gnu.org
In-Reply-To: <20020202120354.A1522@lucon.org> from "H . J . Lu" at Feb 02, 2002 12:03:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


H . J . Lu writes:
> Does everyone agree with this? If yes, I can make a patch not to use
> branch likely. But on the other hand, "gcc -mips2" will generate code
> using branch likely. If branch likely doesn't buy you anything, 
> shouldn't we change gcc not to generate branch likely instructions?

I would say it's still too early to actively remove them. There are many
processors out there (certainly in the embedded world most of them)
without branch prediction, and for all of those branch-likelys actually
help performance.

/Hartvig
