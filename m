Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g26JLQt27459
	for linux-mips-outgoing; Wed, 6 Mar 2002 11:21:26 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g26JLN927456
	for <linux-mips@oss.sgi.com>; Wed, 6 Mar 2002 11:21:23 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16ig2G-0002i1-00; Wed, 06 Mar 2002 12:21:08 -0600
Message-ID: <3C865DF6.FFBE3AB@cotw.com>
Date: Wed, 06 Mar 2002 12:20:38 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Karasek <marc_karasek@ivivity.com>
CC: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
References: <1015435541.3714.33.camel@MCK_Linux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:
> 
> How many of you are involved with embedded linux development using a
> MIPS processor?
> 
A fair number of us. Over a hundred easily.

> What endianess have you chosen for your project and why?
> 
You don't really want to start this holy war, do you? That aside,
usually big endian is more useful in applications moving networking
type traffic or a fair amount of graphics processing. Little endian
is handy if you are porting applications from Windows or a lot of
your software is written in little endian.

That's my $.02.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
