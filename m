Received:  by oss.sgi.com id <S553790AbQJ0X20>;
	Fri, 27 Oct 2000 16:28:26 -0700
Received: from u-162.karlsruhe.ipdial.viaginterkom.de ([62.180.18.162]:17671
        "EHLO u-162.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553669AbQJ0X2G>; Fri, 27 Oct 2000 16:28:06 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870696AbQJ0X1p>;
        Sat, 28 Oct 2000 01:27:45 +0200
Date:   Sat, 28 Oct 2000 01:27:45 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: userland packages
Message-ID: <20001028012745.B2813@bacchus.dhis.org>
References: <39F8CE01.3782BBF5@mvista.com> <20001027043432.F6628@bacchus.dhis.org> <39F9B7EF.D6469D07@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F9B7EF.D6469D07@mvista.com>; from jsun@mvista.com on Fri, Oct 27, 2000 at 10:14:23AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 27, 2000 at 10:14:23AM -0700, Jun Sun wrote:

> He is not telling the truth. :-)  See his very own MIPS-HOWTO,
> cross-compile section :
> 
> http://www.linux.sgi.com/mips-howto.html

So you probably never tried to crosscompile something with extensive
autoconf scripts like Gnome.  It's a major pain to get that done right.
Running the compiler is the trivial part of build some package ...

> Also, you can take a look of the rpm spec files for the toolchains I put
> on ftp.mvista.com/pub/Area51/mips_le/.  So far all my usrland stuff are
> cross-compiled - I don't have the luxury of a desktop MIPS with 1.6GB
> RAM.

I bet your heating makes less noise ...

  Ralf
