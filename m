Received:  by oss.sgi.com id <S554034AbQKHUMV>;
	Wed, 8 Nov 2000 12:12:21 -0800
Received: from u-242.karlsruhe.ipdial.viaginterkom.de ([62.180.19.242]:5636
        "EHLO u-242.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S554015AbQKHUMG>; Wed, 8 Nov 2000 12:12:06 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869645AbQKHULz>;
        Wed, 8 Nov 2000 21:11:55 +0100
Date:   Wed, 8 Nov 2000 21:11:55 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: MIPS kernel!
Message-ID: <20001108211155.B870@bacchus.dhis.org>
References: <3A09753F.DB2457EE@isratech.ro> <004101c04969$b744b160$0323c0d8@Ulysses> <20001108151048.A13841@bacchus.dhis.org> <3A09B268.73303E91@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A09B268.73303E91@mips.com>; from kevink@mips.com on Wed, Nov 08, 2000 at 12:07:04PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 08, 2000 at 12:07:04PM -0800, Kevin D. Kissell wrote:

> > by default.  I just tried, egcs-1.1.2-2 also doesn't search silently in
> > other directories.  So it's not a problem of gcc itself which leaves the
> > makefiles.  If you find any instance of the wrong directories being
> > searched, please tell me.  Or better, include a patch :-)
> 
> I saw an instance of this on the order of a year ago.  I don't
> remember which compiler I was using, nor where I got it.  I have
> no ability nor really much desire to try to reconstruct the
> environment to reproduce the problem!

It think you can missconfigure a compiler to do something like that on a
i386-linux host by ``configure mips-linux'' or so.  That will or course
also hose your native compiler.

  Ralf
