Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QLwlr11659
	for linux-mips-outgoing; Fri, 26 Oct 2001 14:58:47 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QLwj011654
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 14:58:45 -0700
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9QM0gB22265
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 15:00:42 -0700
Subject: rm7k
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.09.08.08 (Preview Release)
Date: 26 Oct 2001 15:00:53 -0700
Message-Id: <1004133653.7556.11.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

tlb-r4k.c is used for the rm7k, but this piece in probe_tlb() fails:

if (!(config & (1 << 31)))
     /* 
      * Not a MIPS32 complianant CPU.  Config 1 register not
      * supported, we assume R4k style.  Cpu probing already figured
      * out the number of tlb entries.
      */
      return;


Bit 31 on the rm7k indicates whether or not scache is present. If scache
is not present (disabled), the above test passes and we end up reading
config1, which doesn't exist, so we setup the tlbsize to a bogus value.

Pete
