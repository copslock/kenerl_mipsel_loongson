Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jun 2003 15:46:19 +0100 (BST)
Received: from pop3.galileo.co.il ([IPv6:::ffff:199.203.130.130]:15801 "EHLO
	galileo5.galileo.co.il") by linux-mips.org with ESMTP
	id <S8225202AbTFOOqQ>; Sun, 15 Jun 2003 15:46:16 +0100
Received: from galileo.co.il ([10.2.2.45])
	by galileo5.galileo.co.il (8.12.6/8.12.6) with ESMTP id h5FFiBlH028763;
	Sun, 15 Jun 2003 17:44:12 +0200 (GMT-2)
Message-ID: <3EEC9513.80905@galileo.co.il>
Date: Sun, 15 Jun 2003 17:47:31 +0200
From: Baruch Chaikin <bchaikin@il.marvell.com>
Organization: Marvell Israel
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie question)
References: <20030610131519.47A8BC5FD7@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Return-Path: <bchaikin@galileo.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bchaikin@il.marvell.com
Precedence: bulk
X-list: linux-mips

All,

To conclude, the recommendation here is to:
o	Compile with uClibC or dietlibc
o	Use busybox
o	Gain extra 0.5 MB space

Another question is the file system itself.  What is the recommendation 
here - JFFS, CRAMFS, anything else?...

Thanks for your answers!
-	Baruch.


Wolfgang Denk wrote:
> In message <20030610125623.GC30175@rembrandt.csv.ica.uni-stuttgart.de> you wrote:
> 
>>># ls -l lib | grep -v '^[ld]'
>>>total 2433
>>
>>I conclude ELDK consists of little more than the basic networking utilities,
> 
> 
> The ELDK (Embedded Linux Development Kit) consists of MUCH more (more
> than 400 MB if you install everything).
> 
> I was just talking about the  ramdisk  image.  You  are  right,  this
> contains busybox plus basic networking utilities. For this framework,
> the compressed image size is about 1.3 MB.
> 
> 
>>and the libc-related parts eat up most of the space. A more feature-rich
>>system probably can't afford to waste that much.
> 
> 
> The oriiginal poster mentioned that he has 2.5 MB available, so if he
> uses something like the framework I mentioned he  still  has  1.2  MB
> compressed size available. This is a _lot_.
> 
> 
> If memroy really gets tight, there are other  places  where  you  can
> save space, for example the O.P. wrote:
> 
> 
>>  0.5 MB is allocated for the firmware code
>>  1.0 MB for the compressed kernel image
>>  2.5 MB for the (compressed?) file system
> 
> 
> The reservation for both the firmware and for  the  kernel  image  is
> more  than generous; 256 kB + 768 kB should be sufficient, too. Which
> gives another 0.5 MB for application stuff.
> 
> 
> Please understand me right: I do not want  to  deny  that  uClibc  or
> dietlibc  are  fine  methods  to  optimize  the memory footprint of a
> system. But for a starter it is probably much easier to use  standard
> libraries as long as there is memory available.
> 
> For the current thread the keyword was "strip". 
> 
> 
> Best regards,
> 
> Wolfgang Denk
> 


-- 
This message may contain confidential, proprietary or legally privileged 
information. The information is intended only for the use of the 
individual or entity named above. If the reader of this message is not 
the intended recipient, you are hereby notified that any dissemination, 
distribution or copying of this communication is strictly prohibited. If 
you have received this communication in error, please notify us 
immediately by telephone, or by e-mail and delete the message from your 
computer.
