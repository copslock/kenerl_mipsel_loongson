Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62JwtRw018360
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 12:58:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62Jwtwr018359
	for linux-mips-outgoing; Tue, 2 Jul 2002 12:58:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-157.ka.dial.de.ignite.net [62.180.196.157])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62JwnRw018336
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 12:58:50 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g62K2RU09771;
	Tue, 2 Jul 2002 22:02:27 +0200
Date: Tue, 2 Jul 2002 22:02:27 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips@oss.sgi.com
Subject: Re: Patch for NEC VR5000 support (part 1 of several for lasat board support)
Message-ID: <20020702220227.A9566@dea.linux-mips.net>
References: <3D21FF19.5020606@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D21FF19.5020606@murphy.dk>; from brian@murphy.dk on Tue, Jul 02, 2002 at 09:29:29PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 09:29:29PM +0200, Brian Murphy wrote:

> I have attached a patch which applies to the 2.4 branch and adds
> support for the NEC VR5000. This would be a first step in
> adding support for the Lasat architectures.
> 
> A comment from someone with cvs commit access would be nice
> this time.

As NEC's VR5000 is a plain normal R5000 why are you duplicating the
processor support with slight variations?

  Ralf
