Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EJgwG11677
	for linux-mips-outgoing; Thu, 14 Jun 2001 12:42:58 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EJgvP11674
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 12:42:57 -0700
Received: from dot.cygnus.com (dot.cygnus.com [205.180.230.224])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id MAA13284;
	Thu, 14 Jun 2001 12:42:56 -0700 (PDT)
Received: (from rth@localhost)
	by dot.cygnus.com (8.11.0/8.11.0) id f5EJgtY28930;
	Thu, 14 Jun 2001 12:42:55 -0700
X-Authentication-Warning: dot.cygnus.com: rth set sender to rth@redhat.com using -f
Date: Thu, 14 Jun 2001 12:42:55 -0700
From: Richard Henderson <rth@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010614124255.C28888@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org,
	binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
References: <20010613212940.A22683@lucon.org> <20010614101951.B28824@redhat.com> <20010614114117.A3092@lucon.org> <20010614120543.B28888@redhat.com> <20010614122550.B3668@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614122550.B3668@lucon.org>; from hjl@lucon.org on Thu, Jun 14, 2001 at 12:25:50PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 14, 2001 at 12:25:50PM -0700, H . J . Lu wrote:
> 1. I see PIC_FUNCTION_ADDR_REGNUM be $25. gp is $28.  How does your
> patch restore $28?

That should be pic_offset_table_rtx instead.

> 2. I assum you set length to 8 for o64. Has anyone checked if the
> instruction is 8 byte on o64?

It may be 8 on o32 as well -- consider the nop that the
assembler may add.

> 2. Did you remove (set_attr "mode" "SI") for o64?

As far as I can tell that is not used except for mult/div
scheduling.


r~
