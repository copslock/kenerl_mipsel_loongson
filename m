Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62GRvRw010097
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 09:27:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62GRvuN010096
	for linux-mips-outgoing; Tue, 2 Jul 2002 09:27:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62GRrRw010068
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 09:27:53 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020702163143.HQXH8262.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Tue, 2 Jul 2002 16:31:43 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7BE5B125D3; Tue,  2 Jul 2002 09:31:42 -0700 (PDT)
Date: Tue, 2 Jul 2002 09:31:42 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Eric Christopher <echristo@redhat.com>, bkoz@redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: Kernel ll/sc emulation?
Message-ID: <20020702093142.A14419@lucon.org>
References: <20020701192415.A2617@lucon.org> <Pine.GSO.3.96.1020702182354.27564D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020702182354.27564D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 02, 2002 at 06:24:40PM +0200
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 06:24:40PM +0200, Maciej W. Rozycki wrote:
> On Mon, 1 Jul 2002, H. J. Lu wrote:
> 
> > That is a news to me. I couldn't find it anywhere in the Linux mips
> > kernel. Could someone point me to the right place in the Linux mips
> > kernel source tree?
> 
>  See do_ri() in arch/mips/kernel/traps.c.
> 

Great. What is the first working ll/sc emulation kernel version?


H.J.
