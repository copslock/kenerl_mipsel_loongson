Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2006 20:28:10 +0100 (BST)
Received: from web31514.mail.mud.yahoo.com ([68.142.198.143]:20048 "HELO
	web31514.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037850AbWIRT2F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Sep 2006 20:28:05 +0100
Received: (qmail 88938 invoked by uid 60001); 18 Sep 2006 19:27:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZYqE/2KuSL4ei8L20o6w1NF2/xtodZ0MCETlYpXyGb9Az5VhY4yDhSkGQXqkngg1Zwl1PC7LR4kIF9wR+ndROCu+HOhlBM7rKRM03qCe4CDL80rdzqT7IfhJ6+TJPSTgOVySCjnO7kzVFWnfwgzjE5CAxNXkvLYU/QpfT6kyMtg=  ;
Message-ID: <20060918192756.88936.qmail@web31514.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31514.mail.mud.yahoo.com via HTTP; Mon, 18 Sep 2006 12:27:56 PDT
Date:	Mon, 18 Sep 2006 12:27:56 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: RE: Kernel debugging contd.
To:	Manoj Ekbote <manoje@broadcom.com>
Cc:	Jonathan Day <imipak@yahoo.com>, linux-mips@linux-mips.org
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F2305D9C3@NT-SJCA-0752.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Any chance you could e-mail me a diff of the changes
you made? I really need to get this Broadcom board
back on its feet, preferably with the current kernel
as there's a lot of stuff that I need in it.

Thanks for any help you can give,

Jonathan Day

P.S. Oh, one other thing you might be able to help
with. A lot of tools I have for modifying the speed or
other parameters of ethernet chips are designed for
10/100 devices, but the 1250 works over a gigabit
interface. You wouldn't happen to have any tools that
would allow me to alter the state of the interface,
would you? I'm getting some weird behaviour, with it
switching to gigabit half-duplex, and would love to
have some kind of disgnostic tool to see what's
happening and modify the settings.

Again, thanks for any help - there's a lot with this
board that is simply stumping me.

--- Manoj Ekbote <manoje@broadcom.com> wrote:

> If I may add, the changes made when the
> flush_icache_page call was
> retired seems to cause this problem.
> I reversed some of the changes and the kernel boots
> fine atleast on
> 1480.
> 
> commit id : 4bbd62a93a1ab4b7d8a5b402b0c78ac265b35661
> 
> 
> /manoj
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf
> Of Ralf Baechle
> Sent: Saturday, September 16, 2006 6:02 PM
> To: Mark E Mason
> Cc: Jonathan Day; linux-mips@linux-mips.org
> Subject: Re: Kernel debugging contd.
> 
> On Fri, Sep 15, 2006 at 03:54:06PM -0700, Mark E
> Mason wrote:
> 
> > FWIW - this is the same place my boards are
> hanging (right after
> freeing
> > kernel memory).  I'd tracked it down to the commit
> that changed the
> > cache/page handling for the sibyte parts from the
> sb1 specific to the
> > generic codes -- but haven't found time to look
> into it further as
> yet.
> 
> Got a commit ID?
> 
>   Ralf
> 
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
