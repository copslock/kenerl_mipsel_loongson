Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SDStb00442
	for linux-mips-outgoing; Mon, 28 Jan 2002 05:28:55 -0800
Received: from columba.eur.3com.com (columba.EUR.3Com.COM [161.71.169.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SDSoP00433
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 05:28:50 -0800
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.eur.3com.com  with ESMTP id g0SCUU709096;
	Mon, 28 Jan 2002 12:30:30 GMT
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g0SCSNQ08252;
	Mon, 28 Jan 2002 12:28:23 GMT
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256B4F.004578DE ; Mon, 28 Jan 2002 12:38:49 +0000
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
cc: linux-mips@oss.sgi.com, rajeshbv@intotoinc.com
Message-ID: <80256B4F.00416BF5.00@notesmta.eur.3com.com>
Date: Mon, 28 Jan 2002 11:39:56 +0000
Subject: Re: INSMOD failing on MIPS
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



>But when i link two '.o' files with ld as
>"mipsel-linux-ld -r -o temp.o temp.o temp1.o"
>and insert the output 'temp.o' it is crashing.

I've seen this before, I think the solution is to use:

mipsel-linux-ld -G 0 -r -o temp.o temp.o temp1.o

Without the '-G0' the linker places small common variables into a '.scommon'
section which insmod fails to relocate.

'insmod' should complain in this situation or try to relocate these symbols
properly.

     Jon Burgess
