Received:  by oss.sgi.com id <S553733AbRCHQa3>;
	Thu, 8 Mar 2001 08:30:29 -0800
Received: from haliga.physik.TU-Cottbus.De ([141.43.75.9]:53518 "HELO
        haliga.physik.tu-cottbus.de") by oss.sgi.com with SMTP
	id <S553692AbRCHQaI>; Thu, 8 Mar 2001 08:30:08 -0800
Received: by haliga.physik.tu-cottbus.de (Postfix, from userid 7215)
	id 81FDB8D66; Thu,  8 Mar 2001 17:30:03 +0100 (MET)
Date:   Thu, 8 Mar 2001 17:30:03 +0100
To:     linux-mips@oss.sgi.com
Subject: Re: Question concerning Assembler error
Message-ID: <20010308173003.A17217@physik.tu-cottbus.de>
Mail-Followup-To: heinold@physik.tu-cottbus.de,
	linux-mips@oss.sgi.com
References: <3AA7B13F.F918E1F8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AA7B13F.F918E1F8@ti.com>; from jharrell@ti.com on Thu, Mar 08, 2001 at 09:20:15AM -0700
From:   heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Mar 08, 2001 at 09:20:15AM -0700, Jeff Harrell wrote:
> I am getting a strange error from the assembler that I am not quite sure
> what to make of it.  Here
> is the  Error and code snippet:
> 
> 
>      >make
>      mipsel-linux-gcc -D_ASSEMBLER_ -mcpu=r4600 -mips2 -Wall
>      -Wstrict-prototypes -O2 -fomit-frame-pointer -G -0
>      -mno-abicalls -fno-pic -pipe -mlong-calls -Wimplicit -c

Hm sorry cant help with the assembler problem, but which machine
has a 4600 Prozessor and run mipsel on it?

-- 


Henning Heinold
