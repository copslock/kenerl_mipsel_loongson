Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0BBswL17040
	for linux-mips-outgoing; Fri, 11 Jan 2002 03:54:58 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0BBskg17036;
	Fri, 11 Jan 2002 03:54:46 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA12487;
	Fri, 11 Jan 2002 11:54:26 +0100 (MET)
Date: Fri, 11 Jan 2002 11:54:24 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] disable interrupt for non-LLSC atomic set
In-Reply-To: <3C3E458A.B2AEC3CA@mvista.com>
Message-ID: <Pine.GSO.3.96.1020111115109.11015A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 10 Jan 2002, Jun Sun wrote:

> The current MIPS_ATOMIC set code for no-LLSC case does a load and store with
> interrupt open.  This is potentially dangerous as an interrupt could happen
> in-between and cause the value changed inside the interrupt handler. 

 No need to -- no sane interrupt handler will ever access a user's atomic
variable. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
