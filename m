Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 19:16:51 +0100 (BST)
Received: from fed1rmmtao11.cox.net ([IPv6:::ffff:68.230.241.28]:52884 "EHLO
	fed1rmmtao11.cox.net") by linux-mips.org with ESMTP
	id <S8225230AbUJTSQn>; Wed, 20 Oct 2004 19:16:43 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao11.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041020181626.ZZKF17415.fed1rmmtao11.cox.net@opus>;
          Wed, 20 Oct 2004 14:16:26 -0400
Date: Wed, 20 Oct 2004 11:16:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mips@linux-mips.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9] Export phys_cpu_present_map
Message-ID: <20041020181626.GH12544@smtp.west.cox.net>
References: <20041020171626.GG12544@smtp.west.cox.net> <20041020174905.GA12697@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020174905.GA12697@lst.de>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

[ Note that XFS has a similar problem, with cpu_possible() calls ]
On Wed, Oct 20, 2004 at 07:49:05PM +0200, Christoph Hellwig wrote:
> On Wed, Oct 20, 2004 at 10:16:26AM -0700, Tom Rini wrote:
> > In net/ipv6/icmp.c::icmpv6_init() there is a call to cpu_possible()
> > which preprocesses down to "test_bit(((i)), (phys_cpu_present_map).bits)"
> > If ipv6 is a module, phys_cpu_present_map (or cpu_possible_map which is
> > defined t phys_cpu_present_map) needs to be exported.
> 
> The loop in there should be rewritten as for_each_cpu which doesn't need
> this export.

Here's what I did:
--- linux-2.6.9.orig/net/ipv6/icmp.c
+++ linux-2.6.9/net/ipv6/icmp.c
@@ -691,10 +691,7 @@ int __init icmpv6_init(struct net_proto_
 	struct sock *sk;
 	int err, i, j;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-
+	for_each_cpu(i) {

But I still get the problem.  Further, on i386 cpu_possible() becomes
cpu_callout_map which is exported as well.

-- 
Tom Rini
http://gate.crashing.org/~trini/
