Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2003 23:40:46 +0000 (GMT)
Received: from smtp02.infoave.net ([IPv6:::ffff:165.166.0.27]:16092 "EHLO
	smtp02.infoave.net") by linux-mips.org with ESMTP
	id <S8225210AbTAOXkp>; Wed, 15 Jan 2003 23:40:45 +0000
Received: from opus ([204.116.3.125])
 by SMTP00.InfoAve.Net (PMDF V6.1-1IA5 #38777)
 with ESMTP id <01KR9VGY9P2S91AB87@SMTP00.InfoAve.Net> for
 linux-mips@linux-mips.org; Wed, 15 Jan 2003 18:40:01 -0500 (EST)
Date: Wed, 15 Jan 2003 18:41:16 -0500
From: Justin Pauley <jpauley@xwizards.com>
Subject: MOPD problems
To: linux-mips@linux-mips.org
Message-id: <1042674081.2735.102.camel@Opus>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7bit
Return-Path: <jpauley@xwizards.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jpauley@xwizards.com
Precedence: bulk
X-list: linux-mips

I downloaded the mopd server and installed a bunch of the patches until
mopd compiled. I downloaded the mopimage and put it in my /tftpboot/mop
with the correct name. However, after running mop with "mopd -d eth0"
and then running "boot 3/mop" on my decstation nothing happens. However,
I have noticed that when I run a packet dumping software (etherreal) and
then I try it I get this on my mopd:

MOP DL 8:0:2b:2e:77:40   > ab:0:0:1:0:0      len   11 code 08 RPR
MOP DL 0:d0:9:f8:fc:a5   > 8:0:2b:2e:77:40   len    1 code 03 ASV
MOP DL 8:0:2b:2e:77:40   > 0:d0:9:f8:fc:a5   len   11 code 08 RPR
MOP DL 0:d0:9:f8:fc:a5   > 8:0:2b:2e:77:40   len 1058 code 02 MLD

This in my syslog:
Jan 15 18:30:47 opus mopd[18215]: 8:0:2b:2e:77:40 (1) Do you have
08002b2e7740? (Yes)
Jan 15 18:30:47 opus mopd[18215]: 8:0:2b:2e:77:40 Send me 08002b2e7740

but then my Decstation produces something similar to the following:

>> boot 3/mop

???
? PC: 0x.....
? CR: 0x....
? SR: 0x....
? VA: 0x0
? ER: 180....
? MER: 0x162....

and then returns back to the console ">>".
(note that the ... were added by me to replace a long line of
numbers/letters)


if you know of something I can try, please let me know.

Thanks,
Justin Pauley
