Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14Jj2O16812
	for linux-mips-outgoing; Mon, 4 Feb 2002 11:45:02 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14JixA16774
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 11:44:59 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g14IgqB09457;
	Mon, 4 Feb 2002 10:42:52 -0800
Subject: Re: madplay on mips
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3C5ED610.529C020E@mvista.com>
References: <1012843753.14993.106.camel@zeus> 
	<3C5ED610.529C020E@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 04 Feb 2002 10:46:54 -0800
Message-Id: <1012848414.15163.140.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-02-04 at 10:42, Jun Sun wrote:
> Pete Popov wrote:
> > 
> > Has anyone used madplay on mips to play mp3 files successfully? I've
> > tried it on two mips boards with different sound drivers, and in both
> > cases it plays the song slower and a bit muffled.  It works on x86 and
> > supposedly ppc.
> > 
> 
> I tried it before, and had the same results.
> 
> I looked over the system calls, and was pretty much sure that the problem was
> on madplay side, and not on the driver side.  One problem suspected was the
> floating point issue, but did get into it.

Even though madplay claims that no floating point is used, the
disassembly of the latest version shows otherwise. But I tried it on a
board with a cpu that does have a hardware floating point unit with the
same result.

Pete
