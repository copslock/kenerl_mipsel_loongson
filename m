Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7M6laT22187
	for linux-mips-outgoing; Tue, 21 Aug 2001 23:47:36 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7M6lY922183
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 23:47:34 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA19971;
	Tue, 21 Aug 2001 23:47:24 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA21424;
	Tue, 21 Aug 2001 23:47:25 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7M6k2a18254;
	Wed, 22 Aug 2001 08:46:03 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id IAA13918;
	Wed, 22 Aug 2001 08:46:01 +0200 (MET DST)
Message-Id: <200108220646.IAA13918@copsun17.mips.com>
Subject: Re: Magic numbers about stack layout
To: nemoto@toshiba-tops.co.jp (Atsushi Nemoto)
Date: Wed, 22 Aug 2001 08:46:01 +0200 (MET DST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20010822.144547.30190293.nemoto@toshiba-tops.co.jp> from "Atsushi Nemoto" at Aug 22, 2001 02:45:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

what is the purpose of replacing the magic numbers with code analysis?
And what will happen when you run userland with MIPS16 or MIPS16e code?

We have it on our work-list to eventually clean up all the places in the
kernel that inspect code to allow MIPS16(e) code as well, so adding more
code inspection points is a bad idea unless it really is necessary.

/Hartvig

Atsushi Nemoto writes:
> 
> ----Next_Part(Wed_Aug_22_14:45:47_2001_172)--
> Content-Type: Text/Plain; charset=us-ascii
> Content-Transfer-Encoding: 7bit
> 
> There are some magic constant numbers about stack layout in
> thread_saved_pc() and get_wchan() function.
> 
> I made a patch to eliminate these magic numbers.  This patch analyzes
> some functions prologue codes in heuristic way at run-time.  "ps -l"
> (and "MAGIC SYSRQ" feature) works fine with this patch.
> 
> ---
> Atsushi Nemoto
