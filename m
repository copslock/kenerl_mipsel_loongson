Received:  by oss.sgi.com id <S553982AbQLAPea>;
	Fri, 1 Dec 2000 07:34:30 -0800
Received: from mail.ivm.net ([62.204.1.4]:52777 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553705AbQLAPeF>;
	Fri, 1 Dec 2000 07:34:05 -0800
Received: from franz.no.dom (port46.duesseldorf.ivm.de [195.247.65.46])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id QAA13814;
	Fri, 1 Dec 2000 16:33:46 +0100
X-To:   ralf@oss.sgi.com
Message-ID: <XFMail.001201163348.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <001901c05b67$8c88ab60$0deca8c0@Ulysses>
Date:   Fri, 01 Dec 2000 16:33:48 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: Indigo2 Kernel Boots!!!
Cc:     linux-mips@oss.sgi.com, Klaus Naumann <spock@mgnet.de>,
        Jesse Dyson <jesse@winston-salem.com>,
        Ralf Baechle <ralf@oss.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 01-Dec-00 Kevin D. Kissell wrote:
> 
>> > When the init process fires up, it opens /dev/console as the
>> > console output device.  A default SGI workstation installation
>> > file system will have /dev/console bound to the major/minor device
>> > node of the graphics display console.  If you want to run with a serial
>> > console, you must therefore change this to bind /dev/console
>> > to the serial port.  You can do this by doing an explicit mknod,
>> > or by linking to the appropriate serial port device node,
>> > which is usually /dev/ttyS0.
>>
>> Which both are wrong.  /dev/console should be a char device major 5, minor
> 1.
>> There is no need to change this ever except for very old kernels.  With
> 2.2
>> or 2.4 whenever people change /dev/console's major/minor it's usually
> painting
>> over some bug.
> 
> Having been through the exercise a dozen or more times with
> the SGI 2.2 kernel distributions for the Indy, I would be fascinated
> to know what bug I was painting over, and where the correct
> procedure was documented.

linux/Documentation/serial-console.txt

-- 
Regards,
Harald
