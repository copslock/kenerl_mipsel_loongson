Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBILUV416190
	for linux-mips-outgoing; Tue, 18 Dec 2001 13:30:31 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBILURo16187
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 13:30:27 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBIKUPg15856;
	Tue, 18 Dec 2001 18:30:25 -0200
Date: Tue, 18 Dec 2001 18:30:25 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "P.S.Santhosh" <ps.santhosh@gda.tech.co.in.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: SiByte SB1250 or Broadcom SBC12500
Message-ID: <20011218183025.A14945@dea.linux-mips.net>
References: <01121813364603.01162@gda_Santhosh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01121813364603.01162@gda_Santhosh>; from ps.santhosh@gda.tech.co.in.sgi.com on Tue, Dec 18, 2001 at 01:36:46PM +0530
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 01:36:46PM +0530, P.S.Santhosh wrote:
> From: "P.S.Santhosh" <ps.santhosh@gda.tech.co.in.sgi.com>
                                    ^^^^^^^^^^^^^^^^^^^^^^

And once you fix your nameserver you actually have chances of receiving
mail.

>   Hai..
> 
>   My name santhosh I doing one embedded project..
> shall I get
> 
>   1.Linux 64 bit Kernel
>   2. MIPS Kernel
>   3. Boot code for SiByte

The 64-bit kernel code for the Sibyte is still in it's early stages.  At
this time it seems better to try to get away with the 32-bit kernel
despite the ridiculous small 32-bit address space.

  Ralf
