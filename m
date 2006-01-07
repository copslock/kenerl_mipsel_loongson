Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2006 07:35:49 +0000 (GMT)
Received: from dragonboat.cs.uoguelph.ca ([131.104.96.108]:39624 "EHLO
	dragonboat.cs.uoguelph.ca") by ftp.linux-mips.org with ESMTP
	id S8126484AbWAGHf2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jan 2006 07:35:28 +0000
Received: from beddie.cis.uoguelph.ca (marvin.cis.uoguelph.ca [131.104.48.131])
	by dragonboat.cs.uoguelph.ca (8.13.1/8.13.1) with ESMTP id k077cDWd021183;
	Sat, 7 Jan 2006 02:38:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id 53BA17E8F;
	Sat,  7 Jan 2006 02:36:17 -0500 (EST)
Received: from beddie.cis.uoguelph.ca ([127.0.0.1])
	by localhost (beddie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21768-06; Sat, 7 Jan 2006 02:36:16 -0500 (EST)
Received: from [192.168.0.104] (CPE001217cc2ab6-CM001371143eca.cpe.net.cable.rogers.com [70.30.137.118])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id 685557D0D;
	Sat,  7 Jan 2006 02:36:16 -0500 (EST)
Message-ID: <43BF6FE3.7030600@uoguelph.ca>
Date:	Sat, 07 Jan 2006 02:38:11 -0500
From:	Brett Foster <fosterb@uoguelph.ca>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	kernel coder <lhrkernelcoder@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Almost 80% of UDP packets dropped
References: <f69849430601062302if424acey70e98f86e0de36e6@mail.gmail.com>
In-Reply-To: <f69849430601062302if424acey70e98f86e0de36e6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cs-club.org
X-Scanned-By: MIMEDefang 2.52 on 131.104.96.108
Return-Path: <fosterb@uoguelph.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fosterb@uoguelph.ca
Precedence: bulk
X-list: linux-mips

kernel coder wrote:

>hi,
>    I was trying to measure the UDP reception speed on my borad which
>has MIPS 4kc processor with 133 MHZ speed.I was transfering 10mb file
>from intel pentium 4 machine to MIPS board,but the recieved file was
>only 900kB.
>  
>
UDP was not designed with reliability in mind -- it really isn't meant 
for sending a 10 meg file without a packet loss.

>When i further investigated the problem ,i came to know that the user
>application was not getting enough opportunities to get data from
>socket queue which caused almost 80% of packets to be dropped as
>socket queue had no free space.
>  
>
(Among other sources) I'm pretty sure this behaviour was discussed in:
Unix Network Programming, Vol. 1: The Sockets Networking API, Third Edition
(Something like page 257.)

I don't know if there is anything else going on with the kernel but...

Brett
