Received:  by oss.sgi.com id <S553842AbRBSNfV>;
	Mon, 19 Feb 2001 05:35:21 -0800
Received: from home174.liacs.nl ([132.229.210.174]:18182 "EHLO
        fog.mors.wiggy.net") by oss.sgi.com with ESMTP id <S553823AbRBSNfR>;
	Mon, 19 Feb 2001 05:35:17 -0800
Received: (from wichert@localhost)
	by fog.mors.wiggy.net (8.11.2/8.11.2/Debian 8.11.2-1) id f1JCXk617400;
	Mon, 19 Feb 2001 13:33:46 +0100
Date:   Mon, 19 Feb 2001 13:33:46 +0100
From:   Wichert Akkerman <wichert@cistron.nl>
To:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        linux-mips <linux-mips@fnet.fr>
Subject: Re: strace package
Message-ID: <20010219133346.A17354@cistron.nl>
Mail-Followup-To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
	linux-mips <linux-mips@fnet.fr>
References: <20010116134453.B12858@bacchus.dhis.org> <Pine.GSO.3.96.1010116171558.5546M-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.3.96.1010116171558.5546M-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 05:18:46PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Previously Maciej W. Rozycki wrote:
>  Well, here is most of the information available from the site...
> 
>                  Welcome to http://strace.sourceforge.net/
> 
>       We're Sorry but this Project hasn't yet uploaded their personal
>                                 webpage yet.
>           Please check back soon for updates or visit SourceForge

Hmm, I guess I should fix that :)

I've started looking at strace again after not having had any time for
it in a while, and strace 4.3 should appear in a week or so. If there
are any problems with the MIPS support now is the time to tell me.
I'm especially interesting in strace reporting umoven() errors while
tracing a program.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
