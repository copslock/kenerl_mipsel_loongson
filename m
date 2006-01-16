Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 12:08:48 +0000 (GMT)
Received: from aeryn.cs.uoguelph.ca ([131.104.20.160]:9355 "EHLO
	aeryn.cs.uoguelph.ca") by ftp.linux-mips.org with ESMTP
	id S8133443AbWAPMIY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 12:08:24 +0000
Received: from beddie.cis.uoguelph.ca (marvin.cis.uoguelph.ca [131.104.48.131])
	by aeryn.cs.uoguelph.ca (8.13.1/8.13.1) with ESMTP id k0GCBrWb016884;
	Mon, 16 Jan 2006 07:11:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id 2443B1EB20;
	Mon, 16 Jan 2006 07:09:47 -0500 (EST)
Received: from beddie.cis.uoguelph.ca ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30690-08; Mon, 16 Jan 2006 07:09:47 -0500 (EST)
Received: from [192.168.0.103] (CPE001217cc2ab6-CM001371143eca.cpe.net.cable.rogers.com [70.30.137.118])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id CC59F1EA74;
	Mon, 16 Jan 2006 07:09:46 -0500 (EST)
Message-ID: <43CB8D89.6070308@uoguelph.ca>
Date:	Mon, 16 Jan 2006 07:11:53 -0500
From:	Brett Foster <fosterb@uoguelph.ca>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Alex Gonzalez <langabe@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Setting gp on pic code
References: <c58a7a270601160204h41e5dca7pa9c26578b6b29f6f@mail.gmail.com>
In-Reply-To: <c58a7a270601160204h41e5dca7pa9c26578b6b29f6f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.52 on 131.104.20.160
Return-Path: <fosterb@uoguelph.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fosterb@uoguelph.ca
Precedence: bulk
X-list: linux-mips

Alex Gonzalez wrote:

>Hi,
>
>I am trying to set the gp register on pic code as follows:
>
>"la gp,_gp"
>
>Disassembling the resulting code,
>
>"lw gp,0(gp)"
>  
>
Yes, this is normal... Use the following to set up the GP:
        //init GP
        lui     gp,%HI(_gp)
        ori     gp,%LO(_gp)
