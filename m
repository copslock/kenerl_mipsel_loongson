Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1RJNZm13087
	for linux-mips-outgoing; Wed, 27 Feb 2002 11:23:35 -0800
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1RJNT913082
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 11:23:30 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id KAA13109;
	Wed, 27 Feb 2002 10:23:19 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id KAA16699;
	Wed, 27 Feb 2002 10:23:09 -0800 (PST)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g1RIMaA10945;
	Wed, 27 Feb 2002 19:22:36 +0100 (MET)
Message-ID: <3C7D2474.6A2F3CA2@mips.com>
Date: Wed, 27 Feb 2002 19:24:52 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre.Messerschmidt@infineon.com
CC: linux-mips@oss.sgi.com
Subject: Re: Wait instruction on 5kc
References: <86048F07C015D311864100902760F1DD01B5E73C@dlfw003a.dus.infineon.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andre.Messerschmidt@infineon.com wrote:

> Hi.
>
> Is there a patch available for the wait instruction bug in the 5kc (RTL
> Revision >= 2.1)?

It's been fixed in RTL revision >=2.3.

>
> As a hack I changed it to nop (in r4k_wait() ), but I believe there is a
> clever solution for this.

You can remove CPU_5KC from the case statement in check_wait in the file
arch/mips/kernel/setup.c

>
> regards
> --
> Andre Messerschmidt
>
> Application Engineer
> Infineon Technologies AG
