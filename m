Received:  by oss.sgi.com id <S553893AbQJ3WQx>;
	Mon, 30 Oct 2000 14:16:53 -0800
Received: from u-180.karlsruhe.ipdial.viaginterkom.de ([62.180.21.180]:13067
        "EHLO u-180.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553892AbQJ3WQk>; Mon, 30 Oct 2000 14:16:40 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869093AbQJ3Vlq>;
        Mon, 30 Oct 2000 22:41:46 +0100
Date:   Mon, 30 Oct 2000 22:41:46 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Jun Sun <jsun@mvista.com>, Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: userland packages
Message-ID: <20001030224146.G24185@bacchus.dhis.org>
References: <20001028012745.B2813@bacchus.dhis.org> <Pine.GSO.3.96.1001030112027.11987A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001030112027.11987A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Oct 30, 2000 at 11:27:25AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 11:27:25AM +0100, Maciej W. Rozycki wrote:

> > So you probably never tried to crosscompile something with extensive
> > autoconf scripts like Gnome.  It's a major pain to get that done right.
> 
>  Well, for sane scripts that can be handled easily by defining problematic
> cache variables to reasonable values.  The real problem are helper
> programs used to build architecture-dependent data, see e.g. tic in
> ncurses. 

Or as one more example rpcgen in libc.  Last I checked libc did cheat and
omit all the affected parts of libc when crosscompiling.  Não bom.

  Ralf
