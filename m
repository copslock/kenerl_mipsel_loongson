Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16KjmK31182
	for linux-mips-outgoing; Wed, 6 Feb 2002 12:45:48 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16KjfA31179;
	Wed, 6 Feb 2002 12:45:41 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id F18F7125C8; Wed,  6 Feb 2002 12:45:38 -0800 (PST)
Date: Wed, 6 Feb 2002 12:45:38 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Why does -g turn off filling the delat slot?
Message-ID: <20020206124538.A28632@lucon.org>
References: <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org> <20020205113017.A6144@lucon.org> <20020205135407.A8309@lucon.org> <20020206113259.A15431@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020206113259.A15431@dea.linux-mips.net>; from ralf@oss.sgi.com on Wed, Feb 06, 2002 at 11:32:59AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 06, 2002 at 11:32:59AM +0100, Ralf Baechle wrote:
> > 
> > There is an extra "nop" in the delay slot. I don't think gas is smart
> > enough to fill the delay slot. I will put back those ".set noredor".
> 
> The solution is to move the move instruction in front of the branch
> instruction.  The assembler will then move it into the delay slot:
> 

I found out why it didn't work for me. The problem is -g turns off
filling  the delay slot. The mips as has

    case 'g':
      if (arg == NULL)
        mips_debug = 2;
      else    
        mips_debug = atoi (arg);
      /* When the MIPS assembler sees -g or -g2, it does not do
         optimizations which limit full symbolic debugging.  We take 
         that to be equivalent to -O0.  */
      if (mips_debug == 2)
        mips_optimize = 1;
      break;  

It doesn't matter of you pass -O to as or not. I'd like to override it
if -O is seen.


H.J.
