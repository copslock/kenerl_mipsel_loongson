Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E5RwD30680
	for linux-mips-outgoing; Mon, 13 Aug 2001 22:27:58 -0700
Received: from dea.waldorf-gmbh.de (u-197-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.197])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E5Rsj30646
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 22:27:54 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E5Q2l05681;
	Tue, 14 Aug 2001 07:26:02 +0200
Date: Tue, 14 Aug 2001 07:26:02 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
Cc: "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: /usr/bin/file
Message-ID: <20010814072602.A5665@bacchus.dhis.org>
References: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAD3@ntmsg0080.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAD3@ntmsg0080.corpmail.telstra.com.au>; from Roger.Salisbury@team.telstra.com on Tue, Aug 14, 2001 at 11:40:48AM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 14, 2001 at 11:40:48AM +1000, Salisbury, Roger wrote:

> where do I get "libtoolize"

GNU libtools.

> glibc-2.2.3 needs  gcc-3.0 it seems. (checking version of gcc...
> egcs-2.91.66, bad ...*** Some critical program is missing or too old
> )

> gcc-3.0  needs rectification in [libgcc_s.so]  & [libgcc.a]  it seems (see
> make error below!)

linker problem.  If you still run gcc 1.2 then your ld is probably to
antique anyway.

  Ralf
