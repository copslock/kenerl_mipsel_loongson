Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FJM18d010748
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 12:22:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FJM16D010747
	for linux-mips-outgoing; Mon, 15 Apr 2002 12:22:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FJLv8d010742
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 12:21:58 -0700
Received: from galadriel.physik.uni-konstanz.de (galadriel.physik.uni-konstanz.de [134.34.144.79])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id 891FD8D35; Mon, 15 Apr 2002 21:22:47 +0200 (CEST)
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16xC3r-0004sv-00; Mon, 15 Apr 2002 21:22:47 +0200
Date: Mon, 15 Apr 2002 21:22:47 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Chris Wright <chris_wright@mac.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux for MIPS on SGI Indigo2
Message-ID: <20020415212247.A18769@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: Chris Wright <chris_wright@mac.com>,
	linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1020415154230.19735J-100000@delta.ds2.pg.gda.pl> <3B792D54-50A4-11D6-B60A-0050E4AEBF2A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B792D54-50A4-11D6-B60A-0050E4AEBF2A@mac.com>; from chris_wright@mac.com on Mon, Apr 15, 2002 at 02:08:55PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 15, 2002 at 02:08:55PM -0500, Chris Wright wrote:
> I am looking for detailed instructions on installing a linux 
> distribution onto an SGI Indigo2 4400.  Thank you. --Chris
The graphics boards in the I2 are still all unsupported. You will have
to do a serial console install, see:
 http://www.linux-debian.de/howto/debian-mips-woody-install.html
and
 http://oss.sgi.com/mips/i2-howto.html
for details.
 -- Guido
