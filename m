Received:  by oss.sgi.com id <S553771AbRBTUhi>;
	Tue, 20 Feb 2001 12:37:38 -0800
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:55790
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553766AbRBTUhU>; Tue, 20 Feb 2001 12:37:20 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1KKb3h04162;
	Tue, 20 Feb 2001 21:37:03 +0100
Date:   Tue, 20 Feb 2001 21:37:03 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        linux-mips <linux-mips@fnet.fr>
Subject: Re: strace package
Message-ID: <20010220213703.B2086@bacchus.dhis.org>
References: <20010116134453.B12858@bacchus.dhis.org> <Pine.GSO.3.96.1010116171558.5546M-100000@delta.ds2.pg.gda.pl> <20010219133346.A17354@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010219133346.A17354@cistron.nl>; from wichert@cistron.nl on Mon, Feb 19, 2001 at 01:33:46PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Feb 19, 2001 at 01:33:46PM +0100, Wichert Akkerman wrote:

> Hmm, I guess I should fix that :)
> 
> I've started looking at strace again after not having had any time for
> it in a while, and strace 4.3 should appear in a week or so. If there
> are any problems with the MIPS support now is the time to tell me.
> I'm especially interesting in strace reporting umoven() errors while
> tracing a program.

Conincidentally I today built strace-cvs for MIPS before receiving your
message and found it to be working just fine.  The only bug which my
last several month old build from an older snapshot doesn't have is
that syscall 4129 (from memory, number may be incorrect) gets decoded
as a syscall with very many arguments (~ 20).  Will have to look into
it.

  Ralf
