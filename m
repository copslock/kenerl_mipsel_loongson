Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OBVW111247
	for linux-mips-outgoing; Fri, 24 Aug 2001 04:31:32 -0700
Received: from dea.linux-mips.net (u-138-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OBVSd11244
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 04:31:29 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7OBSRo00426;
	Fri, 24 Aug 2001 13:28:27 +0200
Date: Fri, 24 Aug 2001 13:28:27 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: get_insn_opcode is broken (ll/sc emulation does not work)
Message-ID: <20010824132827.B325@dea.linux-mips.net>
References: <20010824.170621.85418510.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010824.170621.85418510.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Fri, Aug 24, 2001 at 05:06:21PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 24, 2001 at 05:06:21PM +0900, Atsushi Nemoto wrote:

> I found that get_insn_opcode(in traps.c) is broken.
> 
> 
> static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
> ...
> 	if (!get_user(opcode, epc))

Thanks, fixed!

  Ralf
