Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9MMCfP17270
	for linux-mips-outgoing; Mon, 22 Oct 2001 15:12:41 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9MMCdD17267
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 15:12:39 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A406F125C8; Mon, 22 Oct 2001 15:12:38 -0700 (PDT)
Date: Mon, 22 Oct 2001 15:12:38 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Klaus Naumann <spock@mgnet.de>
Cc: linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com
Subject: Re: The Linux binutils 2.11.92.0.7 is released.
Message-ID: <20011022151238.A30586@lucon.org>
References: <20011021091125.A1774@lucon.org> <Pine.LNX.4.21.0110222242190.18455-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110222242190.18455-100000@spock.mgnet.de>; from spock@mgnet.de on Mon, Oct 22, 2001 at 10:43:00PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 22, 2001 at 10:43:00PM +0200, Klaus Naumann wrote:
> > 2. Even if you do, you may overflow GOT table.
> 
> Well, even adding -fpic doesn't help a whole lot.
> What is a GOT table ? And do you see any fix for the problem ?

See

http://sources.redhat.com/ml/binutils/2001-09/msg00299.html



H.J.
