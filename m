Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f66DPSi29796
	for linux-mips-outgoing; Fri, 6 Jul 2001 06:25:28 -0700
Received: from relay ([207.81.96.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f66DPRV29785
	for <linux-mips@oss.sgi.com>; Fri, 6 Jul 2001 06:25:27 -0700
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id JAA00539;
	Fri, 6 Jul 2001 09:57:32 -0400
Message-ID: <3B45BC99.E7135DD3@vcubed.com>
Date: Fri, 06 Jul 2001 09:26:49 -0400
From: Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor Corp.
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: vhouten@kpn.com, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction
References: <3B4573B8.9F89022B@mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Carsten,

I have seen the same thing on the same kernel version.

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.

Carsten Langgaard wrote:
> 
> Hi Karel,
> 
> I have tried the root-images tar-files: mipselroot-rh7-20010606 and
> mipsroot-rh7.
> The mipsroot-rh7 (bigendian) root image seem to work fine, but when
> I use the mipselroot-rh7-20010606 (littleendian) I get an illegal
> instruction.
> [cat:179] Illegal instruction 7c010001 at 2ac8b20c ra=00000000.
> 
> I'm using a 2.4.3 kernel.
> Anyone got an idea ?
> 
> /Carsten
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
