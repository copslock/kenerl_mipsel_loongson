Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f67CW1403893
	for linux-mips-outgoing; Sat, 7 Jul 2001 05:32:01 -0700
Received: from dea.waldorf-gmbh.de (u-6-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f67CVuV03882
	for <linux-mips@oss.sgi.com>; Sat, 7 Jul 2001 05:31:56 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f67CVQb30649;
	Sat, 7 Jul 2001 14:31:26 +0200
Date: Sat, 7 Jul 2001 14:31:26 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Ashu Joshi <ashu_joshi@ivivity.com>
Cc: "'Linux MIPS FNET'" <linux-mips@fnet.fr>, linux-mips@oss.sgi.com
Subject: Re: Kernel Version Question
Message-ID: <20010707143126.A19642@bacchus.dhis.org>
References: <25369470B6F0D41194820002B328BDD2097644@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25369470B6F0D41194820002B328BDD2097644@ATLOPS>; from ashu_joshi@ivivity.com on Thu, Jul 05, 2001 at 11:43:09AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 05, 2001 at 11:43:09AM -0400, Ashu Joshi wrote:

> We are about to embark on a project using MIPS Core with Linux as the OS. 
> 
> What is the recommendation of this group for the Kernel Version to be used. 
> 
> So far I have been successul in downloading the Kernel 2.4.1 from the MIPS
> Technologies FTP site and getting it to cross compile. However when I tried
> using the 2.4.5 Version from the SGI Site - I am getting compile errors
> complaining a bunch of missing routines.

Your report is lacking any details but I guess you were trying to build a
kernel for a malta board, right?  I still don't have a working Malta
configuration but I'm trying to glue the support for this board.  ATM I've
made it compile again and converted it to use the new interrupt
infrastructure, so give me a few more hours and I'll commit a hopefully
working version.

  Ralf
