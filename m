Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7D57eF29414
	for linux-mips-outgoing; Sun, 12 Aug 2001 22:07:40 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7D57dj29411
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 22:07:39 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 58C573E90; Sun, 12 Aug 2001 21:55:32 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 81DDC13FD0; Sun, 12 Aug 2001 22:02:10 -0700 (PDT)
Date: Sun, 12 Aug 2001 22:02:10 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: FW: indigo2 kernel build failures
Message-ID: <20010812220210.D24560@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACC@ntmsg0080.corpmail.telstra.com.au>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 11:31:58AM +1000, Salisbury, Roger wrote:

> > I just wondering if  the UNKNOW  aspect "mips-unknown-linux-gnu" of
> > building packages has some detrimental affect
> > on the success of building a kernel.
> > IE
> > The machine status isn't detected properly.

Nope.  Even if it did the kernel wouldn't care.  Build gcc on a peecee
sometime and you'll see "i386-unknown-linux-gnu" and it will work as
well as gcc ever does.  Have some fun with it - maybe
"mips-fuckmeinthegoatass-linux-gnu" (STR) for your amusement or
"mips-notintel-linux-gnu" to make a statement.  It won't affect
anything.  Leave off the -gnu, though, and configure will kindly add
it back on, reminding you that it is, in fact, GNU/Linux, dammit.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
 	"There is no such song as 'Acid Acid Acid' by 'The Acid Heads'
	 but there might as well be." --jwz
