Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18IUpu06839
	for linux-mips-outgoing; Fri, 8 Feb 2002 10:30:51 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18IUmA06836
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 10:30:49 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 5EA31125C8; Fri,  8 Feb 2002 10:30:47 -0800 (PST)
Date: Fri, 8 Feb 2002 10:30:47 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc-2.96-99 optimization bug?
Message-ID: <20020208103047.A6079@lucon.org>
References: <20020208.193731.48536791.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020208.193731.48536791.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Fri, Feb 08, 2002 at 07:37:31PM +0900
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 08, 2002 at 07:37:31PM +0900, Atsushi Nemoto wrote:
> I found gcc 2.96 (gcc-2.96-99.1.mipsel.rpm in H.J.Lu's RedHat 7.1)
> outputs wrong code for this short program.
> 
> It seems one 'bnez' in good code (at 4007c4) was lost in bad code.
> 
> Is this a know problem?  If so, is there any patches available?
> 

gcc 3.1 seems fine. No one is working on gcc 2.96. I am working on
a new Linuxx/mips which will use gcc 3.1.


H.J.
