Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61JC1nC016394
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 12:12:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61JC1YQ016393
	for linux-mips-outgoing; Mon, 1 Jul 2002 12:12:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61JBsnC016379;
	Mon, 1 Jul 2002 12:11:55 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 5A9BF8D35; Mon,  1 Jul 2002 21:15:45 +0200 (CEST)
Date: Mon, 1 Jul 2002 21:15:45 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20020701211545.D6454@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
References: <200206301157.g5UBvrwF019470@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206301157.g5UBvrwF019470@oss.sgi.com>; from ralf@oss.sgi.com on Sun, Jun 30, 2002 at 04:57:53AM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jun 30, 2002 at 04:57:53AM -0700, Ralf Baechle wrote:
> CVSROOT:	/home/pub/cvs
> Module name:	linux
> Changes by:	ralf@oss.sgi.com	02/06/30 04:57:53
> 
> Modified files:
> 	drivers/char   : Tag: linux_2_4 Config.in 
> 
> Log message:
> 	Delete duplicate and braindead code for CONFIG_INDYDOG.
You killed the wrong one:
 http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.2/1209.html
 -- Guido
