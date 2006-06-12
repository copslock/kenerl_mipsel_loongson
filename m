Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2006 21:03:53 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.226]:35023 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133653AbWFLUDo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Jun 2006 21:03:44 +0100
Received: by wr-out-0506.google.com with SMTP id 71so1202775wri
        for <linux-mips@linux-mips.org>; Mon, 12 Jun 2006 13:03:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TM6FX72IPnNiP3QO1bUHuiEuAzIiFpcVxR1iZkGo5Y4YYoGG5eNn4OEfXICvlYtBHLNVjwI+/JxeiCXHVjYQZ0aO3RjZzaxClXVC/JE6xBZDgVHnBuTptKmMkS1qor1dYh0qg5WehSBC16bqO+uPs62BeFpdydCGNniUqX9bWVI=
Received: by 10.85.2.9 with SMTP id e9mr7245360aui;
        Mon, 12 Jun 2006 13:03:43 -0700 (PDT)
Received: by 10.85.9.16 with HTTP; Mon, 12 Jun 2006 13:03:43 -0700 (PDT)
Message-ID: <816d36d30606121303u4e6529aat24bf60cd6ae8c37c@mail.gmail.com>
Date:	Mon, 12 Jun 2006 16:03:43 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Juergen Sell" <juergen.sell@gmail.com>
Subject: Re: Support for Vadem/Clio with NEC VR4121 anyone?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <c2c892590606120819m3cf64540n7cfcc8cd0e7fa394@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c2c892590606120819m3cf64540n7cfcc8cd0e7fa394@mail.gmail.com>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

The current 2.6 kernel has a good support base for VR41XX processors,
I am working with a 2.6.15 on a VR4121 MobilePro. I had some problems
booting 2.6.16, but never really looked much into it, instead im still
working on pcmcia support on my device.

Try booting one of these and hooking up a serial console, after that
it's a matter of having the right external device drivers. Most of the
vrc4171 function drivers are out there and can be found easily;
although if your device uses a different set of controllers for
peripherals such as LCD, PCMCIA and sound then it might need some more
work on your side.

Ricardo

On 6/12/06, Juergen Sell <juergen.sell@gmail.com> wrote:
> Hi,
> I did aquire such a device, by now 5 years old. From what I found
> searching various archives it might have had linux vr or linux mips
> support at one point around 2001 but
> this seem to be lost? (I even found a binay of a 2.3.99 linux kernel,
> but no docs, no config no modules, nothing else. So that seems pretty
> useless, right?)
>
> Anyway I would very much prefer Linux over the embedded win/ce.
> Now I am wondering whether any current pointers or configuration is
> available to get me started? A working kernel config file might be a
> good start (for a recent kernel perhaps?).
> By now I have a boot-loader that works under win/ce and loads from a
> cf-card (tested with the above mentioned linux kernel binary).
