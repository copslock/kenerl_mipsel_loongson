Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 16:10:02 +0000 (GMT)
Received: from [IPv6:::ffff:194.90.152.129] ([IPv6:::ffff:194.90.152.129]:33432
	"EHLO mr.teledata-networks.com") by linux-mips.org with ESMTP
	id <S8225347AbUKIQJ5> convert rfc822-to-8bit; Tue, 9 Nov 2004 16:09:57 +0000
Received: from mr.teledata-networks.com (localhost.localdomain [127.0.0.1])
	by localhost.teledata-networks.com (Postfix) with ESMTP
	id E4B9E7C0070; Tue,  9 Nov 2004 18:08:09 +0200 (IST)
Received: from tndcmail.Teledata.Local (ADC-FW.ser.netvision.net.il [199.203
	.98.2])by mr.teledata-networks.com (Postfix) with ESMTPid D97177C006B; Tue,
	  9 Nov 2004 11:08:09 -0500 (EST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems debugging multithreaded program wirh gdbserver via ser
	 ial port
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 9 Nov 2004 18:08:47 +0200
Message-ID: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7D3@tndcmail.Teledata.Local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems debugging multithreaded program wirh gdbserver via se
	r ial port
Thread-Index: AcTF9uhy1PNdWjCyRbSJLlefLizejgAfkIvg
From: "Yoni Rabinovitch" <Yoni.Rabinovich@Teledata-Networks.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-mips@linux-mips.org>
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:34.41925 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Return-Path: <Yoni.Rabinovich@Teledata-Networks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yoni.Rabinovich@Teledata-Networks.com
Precedence: bulk
X-list: linux-mips

>> Simultaneously, in the gdbserver session (via minicom) I see:
>> +$OK#9a

>Um.... you're running with a serial port open on the same port you're
>trying to debug on?  That can't work.  Use one for console and the
>other for gdbserver, or come to some other arrangement if your board
>only has one.

OK, thanks. I now have this sorted out. It seems the only way it agrees to work
is if I start gdbserver in a minicom session, and then kill -9 the minicom session, and then connect
with gdb.

So, now I have basic (command line) gdb <-> gdbserver working OK over the serial connection.

However, I am trying to run gdb from a GUI front end, which is running gdb/mi.
What I am seeing is that the GUI is invoking gdb/mi stack-info-depth, which seems to be
causing a memory exception in frame_register_unwind ("Cannot access memory at address 0x2c").
Thus, even though gdb is able to decipher the stack, the error at the end of the backtrace causes
the gdb/mi GUI to choke.

How can I work around this ?

Thanks !! 
