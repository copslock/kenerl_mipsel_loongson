Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g26JiQ627919
	for linux-mips-outgoing; Wed, 6 Mar 2002 11:44:26 -0800
Received: from mail.ivivity.com ([64.238.111.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g26JiL927916
	for <linux-mips@oss.sgi.com>; Wed, 6 Mar 2002 11:44:21 -0800
Received: from [192.168.1.161] (192.168.1.161 [192.168.1.161]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 107NP32Q; Wed, 6 Mar 2002 13:44:20 -0500
Subject: Re: Questions?
From: Marc Karasek <marc_karasek@ivivity.com>
To: sjhill@cotw.com
Cc: Linux MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <3C865DF6.FFBE3AB@cotw.com>
References: <1015435541.3714.33.camel@MCK_Linux> 
	<3C865DF6.FFBE3AB@cotw.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Mar 2002 13:43:25 -0500
Message-Id: <1015440234.19618.37.camel@MCK_Linux>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

No, I have been involved with too many sorties in the war already.  I
was just asking if there was any issues with one side or the other from
a purely technical aspect.

On Wed, 2002-03-06 at 13:20, Steven J. Hill wrote:
> Marc Karasek wrote:
> > 
> > How many of you are involved with embedded linux development using a
> > MIPS processor?
> > 
> A fair number of us. Over a hundred easily.
> 
> > What endianess have you chosen for your project and why?
> > 
> You don't really want to start this holy war, do you? That aside,
> usually big endian is more useful in applications moving networking
> type traffic or a fair amount of graphics processing. Little endian
> is handy if you are porting applications from Windows or a lot of
> your software is written in little endian.
> 
> That's my $.02.
> 
> -Steve
> 
> -- 
>  Steven J. Hill - Embedded SW Engineer
-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
678.990.1550 x238
678.990.1551 Fax
*************************/
