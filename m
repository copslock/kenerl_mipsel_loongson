Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08KuB227035
	for linux-mips-outgoing; Tue, 8 Jan 2002 12:56:11 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08Ku8g27032
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 12:56:08 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g08Jtxn4027134;
	Tue, 8 Jan 2002 11:56:00 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g08Jtv4A027125;
	Tue, 8 Jan 2002 11:55:58 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 8 Jan 2002 11:55:55 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: balaji.ramalingam@philips.com
cc: linux-mips@oss.sgi.com
Subject: Re: keyboard config with serial console
In-Reply-To: <OFCDD0C848.3B1D3360-ON88256B3B.006C6227@diamond.philips.com>
Message-ID: <Pine.LNX.4.10.10201081153000.26671-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



> Itseems that in order to configure keyboard drivers one should define
> CONSOLE_VT. 

Correct. With the standard tree you need CONSOLE_VT. 

> I just have a serial uart and I dont know if I can use a
> CONFIG_SERIAL and CONFIG_SERIAL_CONSOLE and still
> configure my keyboard.

You can use serial tty/console along side a VT console.

> I think many keyboard function calls are linked with the virtual terminal
> related files. Is it possible to configure the keyboard drivers with a
> serial console?

I know it is possible to use a keyboard without a VT via the input layer. 
I reworked the console system for 2.5.X so you can use a keybaord without
a VT. I'm slowly intergrating this now into the dave jones tree. 

> Have anyone tried this before?

Yes. 

http://linuxconsole.sf.net
