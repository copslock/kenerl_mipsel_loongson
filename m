Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 00:03:09 +0100 (BST)
Received: from c207079.adsl.hansenet.de ([IPv6:::ffff:213.39.207.79]:54286
	"EHLO gruft.cubic.org") by linux-mips.org with ESMTP
	id <S8225526AbVFXXCu>; Sat, 25 Jun 2005 00:02:50 +0100
Received: from cubic.org (starbase [192.168.10.1])
	by gruft.cubic.org (8.12.2/8.12.2) with ESMTP id j5ON1vm9003352
	for <linux-mips@linux-mips.org>; Sat, 25 Jun 2005 01:01:57 +0200
Message-ID: <42BC8B19.9000400@cubic.org>
Date:	Sat, 25 Jun 2005 00:37:13 +0200
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: adding another PCI based serial port board causing errors on
 db1550
References: <2db32b72050624155127a383a7@mail.gmail.com>
In-Reply-To: <2db32b72050624155127a383a7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

rolf liu wrote:

>the driver for the board also has function "register_serial" and
>"unregister_serial", which are already defined by au1x00-serial.c. So
>there comes "multiple deginition" of these functions. Any idea on this
>issue?
>  
>

I also needed another serial port. I have made register_serial and 
unregister_serial static in au1x00-serial.c so they will shadow the 
external functions with the same name and will not be exported and 
changed the name from ttyS to ttySA to avoid conflicts with serial.c.
After that it worked for me.

static struct console sercons = {
        .name           = "ttySA",
        .write          = serial_console_write,
        .device         = serial_console_device,
        .setup          = serial_console_setup,
        .flags          = CON_PRINTBUFFER,
        .index          = -1,
};
