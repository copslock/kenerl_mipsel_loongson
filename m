Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0EIuDo17571
	for linux-mips-outgoing; Mon, 14 Jan 2002 10:56:13 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0EIu8g17568;
	Mon, 14 Jan 2002 10:56:09 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 1F9C5125C1; Mon, 14 Jan 2002 09:56:05 -0800 (PST)
Date: Mon, 14 Jan 2002 09:56:05 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Adrian.Hulse@taec.toshiba.com,
   linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020114095605.D30946@lucon.org>
References: <20020111214234.A5294@lucon.org> <Pine.GSO.3.96.1020114123330.10091B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020114123330.10091B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 14, 2002 at 12:35:57PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 14, 2002 at 12:35:57PM +0100, Maciej W. Rozycki wrote:
> On Fri, 11 Jan 2002, H . J . Lu wrote:
> 
> > ELF [0-9][0-9]*-bit [LM]SB [.]* (shared object | dynamic lib)
> 
>  Why not simply "lt_cv_deplibs_check_method=pass_all" like for other sane
> Linux platforms?  I'm running libtool in such a configuration since May
> with no negative side effects. 
> 

Please follow

http://sources.redhat.com/ml/binutils/2001-10/msg00358.html
http://sources.redhat.com/ml/binutils/2001-10/msg00406.html


H.J.
