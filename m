Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2006 07:00:09 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.207]:42318 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8126484AbWAGG7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jan 2006 06:59:51 +0000
Received: by wproxy.gmail.com with SMTP id 36so3005044wra
        for <linux-mips@linux-mips.org>; Fri, 06 Jan 2006 23:02:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YxkG56eHgDUukODYCBCprgk+yrQAsIJBInd2m0rabMIsK0c/+vqNtizBmfDzRLcK3tYbdJ0p/Yt9vJen9H/ujuWADjjFIXGvnTg8Arf+FVJ32qqtbuZMs2+g3Ccmv13YWIZZEWQ8Bsr9mykYJOmb9xp8fSFFVZ37CTiOOUfqXwE=
Received: by 10.54.139.2 with SMTP id m2mr5774314wrd;
        Fri, 06 Jan 2006 23:02:37 -0800 (PST)
Received: by 10.54.147.20 with HTTP; Fri, 6 Jan 2006 23:02:37 -0800 (PST)
Message-ID: <f69849430601062302if424acey70e98f86e0de36e6@mail.gmail.com>
Date:	Fri, 6 Jan 2006 23:02:37 -0800
From:	kernel coder <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Almost 80% of UDP packets dropped
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
    I was trying to measure the UDP reception speed on my borad which
has MIPS 4kc processor with 133 MHZ speed.I was transfering 10mb file
from intel pentium 4 machine to MIPS board,but the recieved file was
only 900kB.

When i further investigated the problem ,i came to know that the user
application was not getting enough opportunities to get data from
socket queue which caused almost 80% of packets to be dropped as
socket queue had no free space.

When i increased the socket recieve buffer size,it resulted in
increase in no. of packets recieved .When i slow slowed down the
transmitter , it also caused more packets to be recieved.

But the above mentioned mechanism only decreased no. of lost
packets.But there was no way that i could increase UDP reception speed
because the user application was not getting enough opportunities to
read packets in burst of UDP packets.

I noticed that user application started recieveing packets after
Kernel had recieved all the UDP packets.

Please tell me how can i make sure that user application or udp client
running MIPS 4kc processor gets enough opportunities to dequeue
packets from socket buffer so that lost of packets could be reduced to
minimal and also the size of UDP recieved file in a specific interval
of time could be increased.

lhrkernelcoder
