Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MKxbp30198
	for linux-mips-outgoing; Tue, 22 Jan 2002 12:59:37 -0800
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MKxZP30195
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 12:59:35 -0800
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 22 Jan 2002 20:02:38 UT
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.11.6/8.11.6) with SMTP id g0MJvVW23530;
	Tue, 22 Jan 2002 11:57:31 -0800 (PST)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id LAA17118; Tue, 22 Jan 2002 11:58:53 -0800
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id NAA23910; Tue, 22 Jan 2002 13:52:53 -0600
Message-ID: <3C4DC5A1.3080105@esstech.com>
Date: Tue, 22 Jan 2002 14:03:45 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: ide dma in latest cvs
References: <3C4CA8C8.5010801@esstech.com> <3C4DB6DA.7F3E7386@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Did you check what the address is and why it is zero?  It seems to me this
> might be key ...


I see what the address is and why it's set to zero.  The address is the
address of a block of data to be transferred using dma, and it's set to
zero because the new interface in blk_rq_map_sg() passes parameters in a
page field instead an address field.  It looks like this is part of the
bio changes for 2.5 that work for x86 but haven't been updated for Mips.

I figured that someone else must have run into this and it sounds like
someone did.  I'll try what Vivien Chappelier recommended in his response.

Thanks.

Gerald
