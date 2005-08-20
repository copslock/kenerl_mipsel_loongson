Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2005 05:45:47 +0100 (BST)
Received: from mail.dvmed.net ([IPv6:::ffff:216.237.124.58]:1504 "EHLO
	mail.dvmed.net") by linux-mips.org with ESMTP id <S8224808AbVHTEp2>;
	Sat, 20 Aug 2005 05:45:28 +0100
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1E6LJE-0002gZ-7h; Sat, 20 Aug 2005 04:50:21 +0000
Message-ID: <4306B689.6050705@pobox.com>
Date:	Sat, 20 Aug 2005 00:50:17 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Finn Thain <fthain@telegraphics.com.au>
CC:	Roman Zippel <zippel@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Linux net <linux-net@vger.kernel.org>
Subject: Re: [PATCH] macsonic/jazzsonic drivers update (part 2)
References: <200503070210.j272ARii023023@hera.kernel.org> <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org> <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au> <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au> <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au> <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au> <20050616092257.GE5202@linux-mips.org> <Pine.LNX.4.61.0506162129450.31164@loopy.telegraphics.com.au> <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au> <42BEEC32.7040807@pobox.com> <Pine.LNX.4.61.0507130122220.4355@loopy.telegraphics.com.au> <Pine.LNX.4.63.0508201406350.3539@loopy.telegraphics.com.au>
In-Reply-To: <Pine.LNX.4.63.0508201406350.3539@loopy.telegraphics.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Finn Thain wrote:
> 
> On Wed, 13 Jul 2005, Finn Thain wrote:
> 
> 
>>On Sun, 26 Jun 2005, Jeff Garzik wrote:
>>
>>
>>>Patch looks OK to me.  Comments:
>>>
>>>1) Either Geert or Ralf can merge this, with my ACK.
>>>
>>>2) Would be nice to get it tested on the machines you list as untested.
>>>
>>>3) [possible problem in driver, not your changes] I wonder if IRQ_HANDLED is
>>>ever returned for shared interrupts?  I don't know enough about the platform
>>>interrupt architecture to answer this question.
>>>
>>>4) Remove casts to/from void.  This is especially noticable in all the casts
>>>of the netdev_priv() return value.
>>>
>>>5) If it doesn't cause too much patch noise, consider using enums rather than
>>>#defines, for numeric constants.  This gives the compiler more type
>>>information and makes the symbols visible in a debugger.  This is a
>>>-maintainer preference- issue overall, so don't sweat it if you disagree.
>>
>>
>>This patch removes the unecessary void* casts introduced in the first patch.
> 
> 
> Update:
> 
> The two patches referred to above have been tested on Jazz MIPS and
> ack'd off-list by Thomas Bogendorfer. He also added the cosmetic change below.
> 
> I think this is ready to be merged (Jeff?)
> 
> Roman, is your m68k DMA implementation ready for commit? Thomas will take 
> care of the Jazz one.

Can you please resend with full description and sign-off list?

i.e. rule #6 of

	http://linux.yyz.us/patch-format.html

Regards,

	Jeff
