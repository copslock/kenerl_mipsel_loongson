Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f98IRVD23186
	for linux-mips-outgoing; Mon, 8 Oct 2001 11:27:31 -0700
Received: from moutvdom00.kundenserver.de (moutvdom00.kundenserver.de [195.20.224.149])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f98IRSD23182
	for <linux-mips@oss.sgi.com>; Mon, 8 Oct 2001 11:27:28 -0700
Received: from [195.20.224.204] (helo=mrvdom00.schlund.de)
	by moutvdom00.kundenserver.de with esmtp (Exim 2.12 #2)
	id 15qf7X-0005LI-00; Mon, 8 Oct 2001 20:27:19 +0200
Received: from pd95901a8.dip.t-dialin.net ([217.89.1.168] helo=thalreit.de)
	by mrvdom00.schlund.de with esmtp (Exim 2.12 #2)
	id 15qf7W-0002pN-00; Mon, 8 Oct 2001 20:27:19 +0200
Message-ID: <3BC1F004.75494A32@thalreit.de>
Date: Mon, 08 Oct 2001 20:27:16 +0200
From: Volker Jahns <Volker.Jahns@thalreit.de>
Organization: Thalreit/DE
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian <signal@shreve.net>
CC: linux-mips@oss.sgi.com
Subject: Re: Password recovery on IRIX box
References: <Pine.LNX.4.33.0110080908260.8853-100000@mercury.shreve.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Brian wrote:
> 
> I have an origin 200 I have been wanting to run linux on, its been sitting
> up for a while. Before I wipe out and install linux, I need to get in
> there to get some stuff of the drives.  But I do not know the root
> password.  Can anyone direct me to password recovery procedures for IRIX?
> 
> Brian
> 
> -----------------------------------------------
> Brian Feeny, CCIE #8036    e: signal@shreve.net
> Network Engineer           p: 318.222.2638x109
> ShreveNet Inc.             f: 318.221.6612
OK, a good and fast way is to boot into IRIX w/ its installation cd.
Then mount the root partition and fix /etc/passwd.

-- 
Volker Jahns, Volker.Jahns@thalreit.de, http://thalreit.de
