Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g696UJRw028014
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 23:30:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g696UJXI028013
	for linux-mips-outgoing; Mon, 8 Jul 2002 23:30:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g696UARw028004;
	Mon, 8 Jul 2002 23:30:10 -0700
Received: from Hermes.suse.de (Charybdis.suse.de [213.95.15.201])
	by Cantor.suse.de (Postfix) with ESMTP
	id E34B1142D0; Tue,  9 Jul 2002 08:34:28 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To: "H. J. Lu" <hjl@lucon.org>
Cc: Carsten Langgaard <carstenl@mips.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Fix SHMLBA for mips (Re: LTP testing (shmat01))
References: <3D246924.542682B2@mips.com>
	<20020704193414.A29570@dea.linux-mips.net>
	<3D249181.D9147AAE@mips.com>
	<20020704215614.B29422@dea.linux-mips.net>
	<3D29CC6B.5090004@mvista.com>
	<20020708194539.C2758@dea.linux-mips.net> <3D29D65C.84630789@mips.com>
	<20020708112903.A14451@lucon.org>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 09 Jul 2002 08:34:27 +0200
In-Reply-To: <20020708112903.A14451@lucon.org> ("H. J. Lu"'s message of
 "Mon, 8 Jul 2002 11:29:03 -0700")
Message-ID: <hon0t1tnnw.fsf@gee.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


thanks, committed to both mainline and glibc 2.2,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
