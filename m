Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PN9dK01332
	for linux-mips-outgoing; Mon, 25 Mar 2002 15:09:39 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PN9aq01329
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 15:09:36 -0800
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id XAA01793;
	Mon, 25 Mar 2002 23:22:55 -0800
Message-ID: <3C9FAEB5.2070201@mvista.com>
Date: Mon, 25 Mar 2002 15:11:49 -0800
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Y.H. Ku" <iskoo@ms45.hinet.net>
CC: Marc Karasek <marc_karasek@ivivity.com>, linux-mips@oss.sgi.com
Subject: Re: BootLoader on MIPS
References: <NGBBILOAMLLIJMLIOCADAELACCAA.iskoo@ms45.hinet.net>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Y.H. Ku wrote:

> Hi everybody,
> 
> I trace PMON into mips.S, and find the entry "_go".
> the entry transfer control to client prog.
> 
> I am confused of what information PMON transfer to MIPS's BOOTLOADER
> and transfer to which entry point of BOOTLOADER.
> 
> I found the bd_t struct of PPCBOOT.h for PPCBOOT package on POWERPC platform.
> It is corresponding POWERPC-LINUX data structure bd_info in ~/include/asm/mbx.h 
> (register r3~r7)
> 
> I just can not find the entry for MIPS's one. (can not find corresponding baget.h's one)
> 
> Could anybody tell me what is the information (register inforation) PMON transfer
> to bootloader?
> 
> Or anybody can disscuss with me,
> 


NEC provides PMON for DDB5476.  You should be able to get it if it is not
already on the board.

Jun
