Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ1Wh325290
	for linux-mips-outgoing; Tue, 18 Dec 2001 17:32:43 -0800
Received: from buzz.ichilton.co.uk (pc3-stoc4-0-cust138.mid.cable.ntl.com [213.107.175.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ1Weo25287
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 17:32:41 -0800
Received: by buzz.ichilton.co.uk (Postfix, from userid 100)
	id D197A1CE3B9; Wed, 19 Dec 2001 00:32:33 +0000 (GMT)
Date: Wed, 19 Dec 2001 00:32:33 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: linux-mips@oss.sgi.com
Subject: Re: Kernel Wont Boot on I2 - Not the kernel!
Message-ID: <20011219003233.A30407@buzz.ichilton.local>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20011217010926.H6423@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217010926.H6423@woody.ichilton.co.uk>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

Solved - it was a combination of needing rarp populating with the I2's
mac due to an I2 firmware bug and also me forgetting console=ttyS0 :)


Bye for Now,

Ian



Ian Chilton
E-Mail: ian@ichilton.co.uk
Web:    http://www.ichilton.co.uk
