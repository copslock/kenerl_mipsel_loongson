Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 15:23:49 +0100 (BST)
Received: from smtp106.plus.mail.re1.yahoo.com ([69.147.102.69]:15537 "HELO
	smtp106.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20040168AbXJPOXd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 15:23:33 +0100
Received: (qmail 377 invoked from network); 16 Oct 2007 14:22:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=akM0+42tI/BIy9qBq8LPS2ng6yVM0NcC0Mg7LDGOlqtRIli5Wr9YpZeuBdIaixNDttJFESksHCINMFwCHFqiG2vS7FzlvI2rfr/auhTUYyrKQDRv5oz7LkK87KhaNiBKfoxR3mo3U/py+gO7SykHAKYdR4XhlJB06Qnu52+Og9M=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp106.plus.mail.re1.yahoo.com with SMTP; 16 Oct 2007 14:22:27 -0000
X-YMail-OSG: _jSJVpsVM1lwdW4ofPMRs0DecSg.HJPA71EbCNv9BGrEQfHFyTTIWoMIhTAfxjgOywITMgKmWrtWfF4fjCCZMBo.gMRMfMy86xnVqkyylZGBXtKzuvqr2.gidDcA
Date:	Tue, 16 Oct 2007 10:13:38 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	veerasena reddy <veerasena_b@yahoo.co.in>
cc:	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to use TLB to prevent Linux accessing a particular memory
 region 
In-Reply-To: <431051.14949.qm@web8408.mail.in.yahoo.com>
Message-ID: <Pine.LNX.4.64.0710161001550.21385@pixie.tetracon-eng.net>
References: <431051.14949.qm@web8408.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


Really, it sounds more like you want a custom driver that "owns" that 
region of memory so it's marked as used and this driver is the gate 
keeper.  I wonder if the console frame buffer driver for the mips ip32 
arch might be a good example for you as it swallows a several meg chunk of 
memory for the display.

-S-

On Tue, 16 Oct 2007, veerasena reddy wrote:

> Hi,
>
> I have a board, which has two processors ( one is MIPS
> on which Linux-2.6.18 kernel runs and another is DSP
> based processor) and 32MB DDR.
>
> Out of 32MB of DDR 8MB is reserved for use by DSP
> processor. But the MIPS processor downloads firmware
> into this reserved memory for the DSP.
>
> Now, is it possible to use the TLB to prevent Linux
> from accessing the reserved memory after the firmware
> has been downloaded?
>
> Also we'd need to remove those TLB entries if the
> firmware would ever need to be reloaded to the DSP'
> memory region.
>
> What are the APIs to be used to achieve the above?
>
>
> Thanks in advance.
>
> Regards,
> Veerasena.
>
>
>      5, 50, 500, 5000 - Store N number of mails in your inbox. Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
>
>
