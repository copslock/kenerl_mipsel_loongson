Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g721RuRw020791
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 18:27:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g721RuCf020790
	for linux-mips-outgoing; Thu, 1 Aug 2002 18:27:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g721RnRw020781;
	Thu, 1 Aug 2002 18:27:49 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07213; Thu, 1 Aug 2002 18:29:22 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17aJLz-001gBd-00; Thu, 01 Aug 2002 19:03:11 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17aJPV-00074A-00; Thu, 01 Aug 2002 19:06:49 +0200
Date: Thu, 1 Aug 2002 19:06:49 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
Message-ID: <20020801170649.GB15334@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020801152500.A31808@dea.linux-mips.net> <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl> <20020801184929.B22824@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801184929.B22824@dea.linux-mips.net>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
[snip]
> Back in time I prefered CONFIG_NONCOHERENT_IO over CONFIG_COHERENT_IO
> because the noncoherent case needs additional code and in general I'm
> trying to reduce the number of the #if !defined conditionals for easier
> readability.
> 
> The R10000 is our standard example why looking at the processor type doesn't
> work.  It's used in coherent mode in IP27 but in coherent mode but in
> coherent mode in IP28 or IP32.  Otoh I don't know of any system that

JFTR: non-coherent mode in IP28 or IP32.


Thiemo
