Received:  by oss.sgi.com id <S553837AbRBSNeb>;
	Mon, 19 Feb 2001 05:34:31 -0800
Received: from home174.liacs.nl ([132.229.210.174]:16134 "EHLO
        fog.mors.wiggy.net") by oss.sgi.com with ESMTP id <S553815AbRBSNeL>;
	Mon, 19 Feb 2001 05:34:11 -0800
Received: (from wichert@localhost)
	by fog.mors.wiggy.net (8.11.2/8.11.2/Debian 8.11.2-1) id f1JDBUg17443
	for linux-mips@oss.sgi.com; Mon, 19 Feb 2001 14:11:30 +0100
Date:   Mon, 19 Feb 2001 14:11:30 +0100
From:   Wichert Akkerman <wichert@cistron.nl>
To:     linux-mips@oss.sgi.com
Subject: strace sysmips support (was: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call)
Message-ID: <20010219141130.C17354@cistron.nl>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010125165530.B12576@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Jan 25, 2001 at 04:55:31PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Previously Florian Lohoff wrote:
> From the strace i find
> 
> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149

FWIW, I've just put code in strace CVS to decode this properly. Looking
in my (stock Linus) kerneltree I noticed the sys_sysmips code assumes
it can get away with converting an int to a char*, which seems like a
wrong assumption to me..

I don't have my indy up and running at the moment, so the code is
completely untested. Feedback is welcomed :)

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
