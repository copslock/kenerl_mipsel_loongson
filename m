Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PHguR03425
	for linux-mips-outgoing; Mon, 25 Jun 2001 10:42:56 -0700
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PHgsV03422
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 10:42:54 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Mon, 25 Jun 2001 10:42:52 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from postal.sibyte.com (IDENT:postfix@[10.21.128.60]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id KAA01352; Mon, 25
 Jun 2001 10:42:53 -0700 (PDT)
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158]) by
 postal.sibyte.com (Postfix) with ESMTP id 326A71595F; Mon, 25 Jun 2001
 10:42:53 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017) id A441F686D;
 Mon, 25 Jun 2001 10:42:38 -0700 (PDT)
From: "Justin Carlson" <carlson@sibyte.com>
Reply-to: carlson@sibyte.com
Organization: Sibyte
To: "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: CONFIG_MIPS_UNCACHED
Date: Mon, 25 Jun 2001 10:35:43 -0700
X-Mailer: KMail [version 1.0.29]
References: <3B34BE3B.B72D40F1@mvista.com>
 <20010624214232.A18389@mvista.com>
 <001f01c0fd43$3865b680$0deca8c0@Ulysses>
In-Reply-To: <001f01c0fd43$3865b680$0deca8c0@Ulysses>
cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Message-ID: <0106251042380I.00703@plugh.sibyte.com>
X-WSS-ID: 1729A796199872-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 24 Jun 2001, you wrote:

> That's a position that would sound reasonable to someone working
> on Linux for legacy DEC/SGI systems, but not one that I would
> expect to satisfy someone working on embedded Linux.  It would
> need to be governed by a config option, but I would think
> that ultimately we need to have a Linux that can be ROMed
> and branched to directly from the reset vector.  Why force
> everyone doing an embedded MIPS/Linux widget to re-invent
> the wheel?

Because there are very good reasons for having a firmware seperate from
the OS.  Otherwise, you're more or less proposing a new run-time-environment
that has to do all the hardware sanitizations and initializations before we
get to the bootstrap environment.  That's going to be so system-specific and
disparate from the kernel that it doesn't, IMHO, make any sense to put it
there.  This is especially true since *not* having it in the kernel gives you
the chance to exploit the same firmware environment for non-linux OS'es. 

-Justin
