Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQCMT620916
	for linux-mips-outgoing; Mon, 26 Nov 2001 04:22:29 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAQCMQo20911
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 04:22:27 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAQBMGt05368;
	Mon, 26 Nov 2001 22:22:16 +1100
Date: Mon, 26 Nov 2001 22:22:16 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: dan@debian.org, linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011126222216.C30436@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E414@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E414@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Mon, Nov 26, 2001 at 09:59:52AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 09:59:52AM +0100, Andre.Messerschmidt@infineon.com wrote:

> init/main.o: In function `init':
> init/main.c:794: relocation truncated to fit: R_MIPS_GPREL16 execute_command
                                                ^^^^^^^^^^^^^^

Shit in, shit out.  You must be invoking the compiler with some option for
GP relative optimization.  Won't work.

  Ralf
