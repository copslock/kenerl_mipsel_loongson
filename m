Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6I8HTRw019438
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 01:17:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6I8HT9R019437
	for linux-mips-outgoing; Thu, 18 Jul 2002 01:17:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6I8HORw019428
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 01:17:25 -0700
Received: from pippin.physik.uni-konstanz.de (pippin.physik.uni-konstanz.de [134.34.144.92])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP id 5164B8D35
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 10:17:46 +0200 (CEST)
Received: from agx by pippin.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 17V6Tp-0004AO-00; Thu, 18 Jul 2002 10:17:45 +0200
Date: Thu, 18 Jul 2002 10:17:45 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: Indy Composite video input
Message-ID: <20020718081745.GA15938@pippin>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <02071715501808.03661@wilde.langlois-comp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02071715501808.03661@wilde.langlois-comp.com>
User-Agent: Mutt/1.3.28i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
On Wed, Jul 17, 2002 at 03:50:18PM -0700, Mark Langlois wrote:
> I have been trying to find information on how to use the Indy's composite 
> video and s-video inputs with Linux.  Anyone have any information on codecs, 
> video capture etc. with these devices?
The driver vor the vino is still under development. Ladislav Michl is
working on this. Documentation on the vino can be found at:
 ftp://oss.sgi.com/pub/linux/mips/doc/indy/vino
Regards,
 -- Guido
