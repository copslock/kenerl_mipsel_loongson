Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 14:55:49 +0100 (CET)
Received: from [203.199.83.147] ([203.199.83.147]:40086 "HELO
	webmail25.rediffmail.com") by linux-mips.org with SMTP
	id <S1122118AbSKYNzs>; Mon, 25 Nov 2002 14:55:48 +0100
Received: (qmail 19961 invoked by uid 510); 25 Nov 2002 13:54:54 -0000
Date: 25 Nov 2002 13:54:54 -0000
Message-ID: <20021125135454.19960.qmail@webmail25.rediffmail.com>
Received: from unknown (203.197.184.56) by rediffmail.com via HTTP; 25 nov 2002 13:54:54 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: does read/write trasaction hangs indicate SDRAM problem..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I was trying to debug a page fault problem with watch exceptions 
but
since these exceptions (lower priority) come after the page fault 
and sometime it will also get deferred till ERL and EXL bits are 
cleared hence in this specific case they aren't helping me.

other option can be to take support of EJTAG debug available on 
my
CPU.

meanwhile i have noticed and simply tried to read the value and 
write
something on few userspace addresses(0x0 - 0x7fff_ffff) from my 
kernel and surprisingly it just hangs..ideally from my kernel i 
should be able to access all these addresses .

further VXWORKS port run fine on same piece of hardware ..does it 
looks like some mem bank configuration problem in my bootrom , or 
vxworks runs
it may be a matter of chance because of its specific 
configuration.

any suggestions ..

Best Regards,
Atul
