Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 01:57:55 +0000 (GMT)
Received: from web30906.mail.mud.yahoo.com ([68.142.200.159]:8071 "HELO
	web30906.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134014AbVKPB5h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 01:57:37 +0000
Received: (qmail 45716 invoked by uid 60001); 16 Nov 2005 01:59:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4pNIqsXN2JoDG7V0Y1gqeEp4KT9yRBIok7b6ygFkkAEyvR0IKz5kLaWo0x98qFgbsnF/OUG7a0oTncAKQ3IJlAW0O7/5DW5RmTY7JSlK5HWbhK62pwYS7JH73rUjcMZPR2WtjUzERkDARzcw2bXA90q7Y2C6bFsv1ElGp30AcZo=  ;
Message-ID: <20051116015932.45714.qmail@web30906.mail.mud.yahoo.com>
Received: from [12.44.186.158] by web30906.mail.mud.yahoo.com via HTTP; Tue, 15 Nov 2005 17:59:32 PST
Date:	Tue, 15 Nov 2005 17:59:32 -0800 (PST)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: Calibrating delay loop... crashes
To:	Nguyen Thanh Binh <n_tbinh@yahoo.com>, linux-mips@linux-mips.org
In-Reply-To: <20051116013634.74656.qmail@web30711.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Its probably hung at that point since the timer
interrupt never came.

Thanks
Manish Lachwani

--- Nguyen Thanh Binh <n_tbinh@yahoo.com> wrote:

> Hello all,
> 
> When booting Monta Vista Linux on Memec board
> (Virtex-4 FX12 LC), it crashed after printing the
> following message:
> 
>     "Calibrating delay loop..."
> 
> By looking at the source code, I found that in the
> init/main.c the problem came from the
> calibrate_delay
> function: jiffies was not incremented (jiffies was
> always equal to 0).
> 
> Have anyone get the similar problem or any
> experience
> to fix it?
> 
> Thank you.
> 
> Binh Nguyen
> 
> 
> 
> 		
>
___________________________________________________________
> 
> To help you stay safe and secure online, we've
> developed the all new Yahoo! Security Centre.
> http://uk.security.yahoo.com
> 
> 
