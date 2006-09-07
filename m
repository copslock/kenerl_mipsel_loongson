Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 07:53:23 +0100 (BST)
Received: from mail.syneticon.net ([213.239.212.131]:23009 "EHLO
	mail2.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S20038463AbWIGGxS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 07:53:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id BB9294CE9A;
	Thu,  7 Sep 2006 08:53:12 +0200 (CEST)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11857-03; Thu,  7 Sep 2006 08:53:10 +0200 (CEST)
Received: from [192.168.10.145] (xdsl-84-44-195-254.netcologne.de [84.44.195.254])
	by mail2.syneticon.net (Postfix) with ESMTP;
	Thu,  7 Sep 2006 08:53:10 +0200 (CEST)
Message-ID: <44FFC1D5.4060604@wpkg.org>
Date:	Thu, 07 Sep 2006 08:53:09 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060814)
MIME-Version: 1.0
To:	Domen Puncer <domen.puncer@telargo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: no USB device other than storage detected
References: <44FD6CE4.6010001@wpkg.org> <44FF25BE.5020901@wpkg.org> <20060907054302.GF5361@domen.puncer.telargo.com>
In-Reply-To: <20060907054302.GF5361@domen.puncer.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at syneticon.de
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Domen Puncer wrote:
> On 06/09/06 21:47 +0200, Tomasz Chmielewski wrote:
>> Tomasz Chmielewski wrote:
>>> I have a tiny router (ASUS WL-500g deluxe, MIPS CPU, 32 MB RAM, 2x 
>>> USB2), and would like to make it work with a USB DSL modem.
>>>
>>> Right now, it's running Debian and kernel 2.6.17, and boots off a 
>>> USB-stick.
>>>
>>> My problem is, that it only sees USB storage devices (USB sticks etc.).
>>>
>>> When I connect other devices (USB modem, webcam, microphone, keyboard, 
>>> printer etc.), they are not detected.
>>> By "not detected" I mean there are no "dmesg" entries with the device 
>>> name, and no devices, other than "USB storage", listed with "lsusb".
>>>
>>> I even compiled "USB verbose logging" in, but it only gives me a couple 
>>> of debug infos, no clue why the devices doesn't show up.
>> It looks that something's borked in 2.6.17 kernel.
>>
>> When I load ohci module, it complains a lot:
> 
> You say Ohci, but output is from Uhci, and the output in the first
> e-mail is from Ehci. :-)

Yes, I meant uhci of course (as errors indicate, seen below).
ehci works fine.


>> USB Universal Host Controller Interface driver v3.0
>> PCI: Fixing up device 0000:01:02.0
>> uhci_hcd 0000:01:02.0: no i/o regions available
>> uhci_hcd 0000:01:02.0: init 0000:01:02.0 fail, -16
>> uhci_hcd: probe of 0000:01:02.0 failed with error -16
>> PCI: Fixing up device 0000:01:02.1
>> uhci_hcd 0000:01:02.1: no i/o regions available
>> uhci_hcd 0000:01:02.1: init 0000:01:02.1 fail, -16
>> uhci_hcd: probe of 0000:01:02.1 failed with error -16
>>
>>
>> With 2.4.30 kernel, ohci module loads fine, and I can use all USB devices:
>>
>> # lsusb
>> Bus 002 Device 001: ID 0000:0000
>> Bus 001 Device 001: ID 0000:0000
>> Bus 001 Device 004: ID 03f0:3011 Hewlett-Packard
>> Bus 001 Device 003: ID 0471:0310 Philips PCVC730K WebCam [pwc]
>>
>>
>> Ideas what can be wrong?

-- 
Tomasz Chmielewski
http://wpkg.org
