Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EJPq309909
	for linux-mips-outgoing; Thu, 14 Jun 2001 12:25:52 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EJPpP09905
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 12:25:51 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 69215125BA; Thu, 14 Jun 2001 12:25:50 -0700 (PDT)
Date: Thu, 14 Jun 2001 12:25:50 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Richard Henderson <rth@redhat.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010614122550.B3668@lucon.org>
References: <20010613212940.A22683@lucon.org> <20010614101951.B28824@redhat.com> <20010614114117.A3092@lucon.org> <20010614120543.B28888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614120543.B28888@redhat.com>; from rth@redhat.com on Thu, Jun 14, 2001 at 12:05:43PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 14, 2001 at 12:05:43PM -0700, Richard Henderson wrote:
> + 
> + (define_insn "exception_receiver"
> +   [(unspec_volatile [(const_int 0)] 4)]
> +   "TARGET_ABICALLS && (mips_abi == ABI_32 || mips_abi == ABI_O64)"
> +   "*
> + {
> +   rtx loc;
> + 
> +   operands[0] = gen_rtx_REG (Pmode, PIC_FUNCTION_ADDR_REGNUM);
> + 
> +   if (frame_pointer_needed)
> +     loc = hard_frame_pointer_rtx;
> +   else
> +     loc = stack_pointer_rtx;
> +   loc = plus_constant (loc, current_frame_info.args_size);
> +   operands[1] = gen_rtx_MEM (Pmode, loc);
> + 
> +   return mips_move_1word (operands, insn, 0);
> + }"
> +   [(set_attr "type"   "load")
> +    (set_attr "length" "8")])
>   

I have 3 questions:

1. I see PIC_FUNCTION_ADDR_REGNUM be $25. gp is $28.  How does your
patch restore $28?

2. I assum you set length to 8 for o64. Has anyone checked if the
instruction is 8 byte on o64?

2. Did you remove (set_attr "mode" "SI") for o64?

Thanks.


H.J.
