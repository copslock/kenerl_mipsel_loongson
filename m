Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9KtkX18061
	for linux-mips-outgoing; Fri, 9 Nov 2001 12:55:46 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9Ktb018056;
	Fri, 9 Nov 2001 12:55:37 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA03989; Fri, 9 Nov 2001 12:55:31 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA9KpnB10823;
	Fri, 9 Nov 2001 12:51:49 -0800
Message-ID: <3BEC418C.DB98CFFB@mvista.com>
Date: Fri, 09 Nov 2001 12:50:20 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim@jtan.com
CC: James Simmons <jsimmons@transvirtual.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
References: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com> <3BEC20D5.AD6ABBA6@mvista.com> <20011109144421.A30230@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
> 
> > You are probably referring to isa_slot_offset?
> >
> > isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> > send him a patch to get rid of it (as if he can't do it himself :-0) ?
> 
> How should it be properly done?
> 

Use an ax!

Jun

P.S., I meant "just delete it wherever it appears."
