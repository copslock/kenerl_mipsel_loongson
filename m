Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 07:05:45 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.207]:39391 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133467AbWAQHFX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 07:05:23 +0000
Received: by uproxy.gmail.com with SMTP id m3so908150uge
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2006 23:08:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IsXbvF5+f4p/3zUIHNOI0+LLPv3wYIpLoZ9r3Cmf9IBqbBvV06PDLlcV4H/A7BjFLCY1f3wDNLKN/a9OGU2TULvhBKbEIbeR13RpYUbnUOcctRvE6/eT0ZLOeyxpozL6lBXJyDLW34sA9KX8JvU9ImO3wb7/lgOBBfkrmrFfZoc=
Received: by 10.49.17.20 with SMTP id u20mr293361nfi;
        Mon, 16 Jan 2006 23:08:51 -0800 (PST)
Received: by 10.48.243.16 with HTTP; Mon, 16 Jan 2006 23:08:51 -0800 (PST)
Message-ID: <38dc7fce0601162308m4f721bc8l548147643df81f87@mail.gmail.com>
Date:	Tue, 17 Jan 2006 16:08:51 +0900
From:	Youngduk Goo <ydgoo9@gmail.com>
To:	Dan Malek <dan@embeddedalley.com>, linux-mips@linux-mips.org
Subject: Re: using the 36bit physical address on AMD AU1200
In-Reply-To: <0879ce9aeb3034e5a7634c72e445fa6b@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <38dc7fce0601161940s5e4375dci798f66dff58d882@mail.gmail.com>
	 <0879ce9aeb3034e5a7634c72e445fa6b@embeddedalley.com>
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks Dan for the reply.

I set the TLB as you mentioned on the DM9000 driver in YAMON.
UINT32 pte[5];

pte[0] = 0;                                       /* TLB Entry : 0    */
pte[1] = 0x01FFE000;                      /* Page Mask : 16MB */
pte[2] = 0xD0000000;                       /* EntryHi: 0xD0000000 */
pte[3] = (0xD0000000>>2) | 0x0017;  /* EntryLo0            */
pte[4] = (0xD0100000>>2) | 0x0017;  /* EntryLo1            */

sys_tlb_write(pte);                 /* set the TLB entry 0 */
CP0_wired_write(2);	            /* wired register for 2 entry */

After setting, I could access DM9000 with the Base address 0xD0000000.
In here, I have some more questions.
1. I set the 1 TLB entry, so others does not affect the address translation.
   so Whenever I use the 0xD0000000, it always converted to 0xD 0000 0000
   on the bootloader.
   Am I right?
2. On the linux, If I want to use ioremap for Dm9000, Do I need to set the TLB
    and do not need to change the ioremap source code ?

Thank you in advance,
youngduk



On 1/17/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On Jan 16, 2006, at 10:40 PM, Youngduk Goo wrote:
>
> > I guess I need to convert this address to virtual address for access
> > it.
>
> You have to map it, yes.
>
> > But I don't know exactly how to do it. Do I need to configure the TBL?
> > I am using the YAMON as a bootloader. and try to access the DM9000.
>
> You will have to modify the YAMON source code to map TLB entries
> for the device.  Take a look at the sys_tlb_write() function along with
> ensuring you update the CP0 wired register so they don't disappear.
> Also, you will have to check what else may be doing this so you don't
> mess up other mappings.
>
> In Linux, all you need to do is call ioremap() and use the virtual
> address returned to you.
>
>        -- Dan
>
>
