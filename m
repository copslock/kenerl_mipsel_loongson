Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2M1MbM28660
	for linux-mips-outgoing; Thu, 21 Mar 2002 17:22:37 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2M1MYq28657
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 17:22:35 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2M1OwV15459;
	Thu, 21 Mar 2002 17:24:58 -0800
Date: Thu, 21 Mar 2002 17:24:58 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Kernel compile with -O0
Message-ID: <20020321172457.A15031@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E828@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E828@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Thu, Mar 21, 2002 at 07:36:06PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 21, 2002 at 07:36:06PM +0100, Andre.Messerschmidt@infineon.com wrote:

> When I try to compile my 2.4.3 Kernel with -O0 I get a lot of undefined
> references to functions like __cli, clear_bit etc. during linking. With -O1
> it works.
> 
> Do I have to provide some special compile option to make this work?

Stupid answer: Yes, -O.

Less stupid answer - -O1 and higher imply function inlining which is
required to build the kernel.

  Ralf
