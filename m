Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g26JuLN28428
	for linux-mips-outgoing; Wed, 6 Mar 2002 11:56:21 -0800
Received: from coplin09.mips.com ([80.63.7.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g26JuE928424
	for <linux-mips@oss.sgi.com>; Wed, 6 Mar 2002 11:56:14 -0800
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g26IspK06935;
	Wed, 6 Mar 2002 19:54:51 +0100
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200203061854.g26IspK06935@coplin09.mips.com>
Subject: Re: Questions?
To: marc_karasek@ivivity.com (Marc Karasek)
Date: Wed, 6 Mar 2002 19:54:51 +0100 (CET)
Cc: sjhill@cotw.com, linux-mips@oss.sgi.com (Linux MIPS)
In-Reply-To: <1015440234.19618.37.camel@MCK_Linux> from "Marc Karasek" at Mar 06, 2002 01:43:25 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

It also depends on which new drivers you expect to use and thus need to
port from the x86 world. I can certainly tell you that we always start
off with LE for driver porting, for obvious reasons (x86, PCI), and then
go BE after that.

/Hartvig

Marc Karasek writes:
> 
> No, I have been involved with too many sorties in the war already.  I
> was just asking if there was any issues with one side or the other from
> a purely technical aspect.
> 
> On Wed, 2002-03-06 at 13:20, Steven J. Hill wrote:
> > Marc Karasek wrote:
> > > 
> > > How many of you are involved with embedded linux development using a
> > > MIPS processor?
> > > 
> > A fair number of us. Over a hundred easily.
> > 
> > > What endianess have you chosen for your project and why?
> > > 
> > You don't really want to start this holy war, do you? That aside,
> > usually big endian is more useful in applications moving networking
> > type traffic or a fair amount of graphics processing. Little endian
> > is handy if you are porting applications from Windows or a lot of
> > your software is written in little endian.
> > 
> > That's my $.02.
> > 
> > -Steve
> > 
> > -- 
> >  Steven J. Hill - Embedded SW Engineer
> -- 
> /*************************
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc.
> marc_karasek@ivivity.com
> 678.990.1550 x238
> 678.990.1551 Fax
> *************************/
