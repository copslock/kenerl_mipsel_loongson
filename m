Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ABMIR09399
	for linux-mips-outgoing; Fri, 10 Aug 2001 04:22:18 -0700
Received: from dea.waldorf-gmbh.de (u-187-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.187])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ABMCV09375
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 04:22:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7ABKul24055;
	Fri, 10 Aug 2001 13:20:56 +0200
Date: Fri, 10 Aug 2001 13:20:56 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
Message-ID: <20010810132056.D23866@bacchus.dhis.org>
References: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACE@ntmsg0080.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACE@ntmsg0080.corpmail.telstra.com.au>; from Roger.Salisbury@team.telstra.com on Fri, Aug 10, 2001 at 01:59:59PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 01:59:59PM +1000, Salisbury, Roger wrote:

> how would I update /usr/bin/file ??
> ./configure spits this out
> 
> *** Warning: the command libtool uses to detect shared libraries,
> *** /usr/bin/file, produces output that libtool cannot recognize.
> *** The result is that libtool may fail to recognize shared libraries
> *** as such.  This will affect the creation of libtool libraries that
> *** depend on shared libraries, but programs linked with such libtool
> *** libraries will work regardless of this problem.  Nevertheless, you
> *** may want to report the problem to your system manager and/or to
> *** bug-libtool@gnu.org

That's a libtool bug.  My RH 7.0 port has the fix.

  Ralf
