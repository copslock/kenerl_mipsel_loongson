Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 01:05:12 +0000 (GMT)
Received: from holly.csn.ul.ie ([IPv6:::ffff:136.201.105.4]:41909 "EHLO
	holly.csn.ul.ie") by linux-mips.org with ESMTP id <S8225210AbTAPBFL>;
	Thu, 16 Jan 2003 01:05:11 +0000
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id 21F853F4BC; Thu, 16 Jan 2003 01:06:57 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 628BDE952; Thu, 16 Jan 2003 01:04:58 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 50307777F; Thu, 16 Jan 2003 01:04:58 +0000 (GMT)
Date: Thu, 16 Jan 2003 01:04:58 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: airlied@skynet
To: Justin Pauley <jpauley@xwizards.com>
Cc: linux-mips@linux-mips.org
Subject: Re: MOPD problems
In-Reply-To: <1042674081.2735.102.camel@Opus>
Message-ID: <Pine.LNX.4.44.0301160103580.10229-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <airlied@csn.ul.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: airlied@csn.ul.ie
Precedence: bulk
X-list: linux-mips


sometimes a long time agao.. you needed to manually add the ethernet
address of the decstation to the arp table on the host machine..

arp -s <decstation_hostname> <ethernet_address>

give that a go...

Dave.

On Wed, 15 Jan 2003, Justin Pauley wrote:

> I downloaded the mopd server and installed a bunch of the patches until
> mopd compiled. I downloaded the mopimage and put it in my /tftpboot/mop
> with the correct name. However, after running mop with "mopd -d eth0"
> and then running "boot 3/mop" on my decstation nothing happens. However,
> I have noticed that when I run a packet dumping software (etherreal) and
> then I try it I get this on my mopd:
>
> MOP DL 8:0:2b:2e:77:40   > ab:0:0:1:0:0      len   11 code 08 RPR
> MOP DL 0:d0:9:f8:fc:a5   > 8:0:2b:2e:77:40   len    1 code 03 ASV
> MOP DL 8:0:2b:2e:77:40   > 0:d0:9:f8:fc:a5   len   11 code 08 RPR
> MOP DL 0:d0:9:f8:fc:a5   > 8:0:2b:2e:77:40   len 1058 code 02 MLD
>
> This in my syslog:
> Jan 15 18:30:47 opus mopd[18215]: 8:0:2b:2e:77:40 (1) Do you have
> 08002b2e7740? (Yes)
> Jan 15 18:30:47 opus mopd[18215]: 8:0:2b:2e:77:40 Send me 08002b2e7740
>
> but then my Decstation produces something similar to the following:
>
> >> boot 3/mop
>
> ???
> ? PC: 0x.....
> ? CR: 0x....
> ? SR: 0x....
> ? VA: 0x0
> ? ER: 180....
> ? MER: 0x162....
>
> and then returns back to the console ">>".
> (note that the ... were added by me to replace a long line of
> numbers/letters)
>
>
> if you know of something I can try, please let me know.
>
> Thanks,
> Justin Pauley
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
