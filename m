Received:  by oss.sgi.com id <S553755AbRBHKbd>;
	Thu, 8 Feb 2001 02:31:33 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:59292 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553750AbRBHKbR>;
	Thu, 8 Feb 2001 02:31:17 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA29771;
	Thu, 8 Feb 2001 11:24:15 +0100 (MET)
Date:   Thu, 8 Feb 2001 11:24:14 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <3A819B80.7946F866@mvista.com>
Message-ID: <Pine.GSO.3.96.1010208111500.29177B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Jun Sun wrote:

> Moving forward I see MIPS mainly used in embedded systems.  I think need of
> using the same kernel binary for multiple CPUs is rare, especially for the
> "same" CPU with or without FPU.  Therefore having run-time detection is a
> waste of effort.  Half-config-half-runtime solution is pretty messy too.

 Since the run-time detection is about three lines of code (and the
resulting code consists of a similar number of CPU instructions) I
consider it no effort at all.  And remember not only hackers want to use
Linux -- not everyone is going to recompile his own kernel, and the MIPS
world is not limited to embedded devices -- there is quite a number of
MIPS workstation and server systems out there. 

 Neither crashing silently nor printing an obscure oops is not an option
when no FP hw is available and we require it for one reason or another. 

 I hope we will be able to build a generic MIPS kernel one day, just like
we can do for Alpha -- it would encourage redundant code removal which in 
turn would improve cleanness and consistency. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
