Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PK9xW10442
	for linux-mips-outgoing; Fri, 25 May 2001 13:09:59 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PK9tF10436
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 13:09:56 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4PJvfV06583;
	Fri, 25 May 2001 16:57:41 -0300
Date: Fri, 25 May 2001 16:57:41 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] mips64 typo and formatting fixes
Message-ID: <20010525165741.A6578@bacchus.dhis.org>
References: <20010524011053.J11643@rembrandt.csv.ica.uni-stuttgart.de> <20010523213448.D10516@foobazco.org> <20010525191934.A5281@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010525191934.A5281@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, May 25, 2001 at 07:19:34PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 25, 2001 at 07:19:34PM +0200, Thiemo Seufer wrote:

> It can't, since it is 64bit. :-)
> 
> >In the process of fixing the warnings in that file, ISTR
> >Ralf found a bug.
> 
> If the mentioned is the handling of 'sum' in csum_tcpudp_nofold,
> it's now corrected. I also changed formatting to the usual one.

Applied.

  Ralf
