Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1SI72j17099
	for linux-mips-outgoing; Thu, 28 Feb 2002 10:07:02 -0800
Received: from dea.linux-mips.net (a1as05-p107.stg.tli.de [195.252.187.107])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1SI6x917093
	for <linux-mips@oss.sgi.com>; Thu, 28 Feb 2002 10:06:59 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1SBcRG25832;
	Thu, 28 Feb 2002 12:38:27 +0100
Date: Thu, 28 Feb 2002 12:38:27 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Andre.Messerschmidt@infineon.com, linux-mips@oss.sgi.com
Subject: Re: Wait instruction on 5kc
Message-ID: <20020228123827.B25783@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E73C@dlfw003a.dus.infineon.com> <3C7D2474.6A2F3CA2@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D2474.6A2F3CA2@mips.com>; from carstenl@mips.com on Wed, Feb 27, 2002 at 07:24:52PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 27, 2002 at 07:24:52PM +0100, Carsten Langgaard wrote:

> > As a hack I changed it to nop (in r4k_wait() ), but I believe there is a
> > clever solution for this.
> 
> You can remove CPU_5KC from the case statement in check_wait in the file
> arch/mips/kernel/setup.c

Is there a way to probe for this bug, for example based on the ProductId
register?

  Ralf
