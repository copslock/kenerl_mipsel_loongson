Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Aug 2010 22:51:56 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:59520 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491149Ab0H3Uvw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Aug 2010 22:51:52 +0200
X-Authority-Analysis: v=1.1 cv=tmcEYLAoDqwcE/92ninAvjUMbWeHvL1caymGjnMU8Ns= c=1 sm=0 a=vpGvh0kIRgkA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=G-rquTP6noglljKfgecA:9 a=Pb0_xuUuDIXLA5A0c6rsQMMMQ_4A:4 a=PUjeQqilurYA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:57516] helo=[192.168.23.10])
        by hrndva-oedge02.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.2.39 r()) with ESMTP
        id D4/E1-18983-2E91C7C4; Mon, 30 Aug 2010 20:51:46 +0000
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <AANLkTimU7uQjKnSwOGi2s9nb4K8LJRBdwkpQ=-vrRQLx@mail.gmail.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
         <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
         <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
         <AANLkTinBR3+OMX-taCsp6cn4_-cBn5gQ1ooUkX2XS81O@mail.gmail.com>
         <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
         <4C72B16B.5000101@caviumnetworks.com>
         <AANLkTimU7uQjKnSwOGi2s9nb4K8LJRBdwkpQ=-vrRQLx@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 30 Aug 2010 16:51:45 -0400
Message-ID: <1283201505.3656.25.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.2 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Tue, 2010-08-24 at 14:25 +0800, wu zhangjin wrote:

> So, this patch is necessary to fix the deadlock and icache problem on
> RMI XLS and it will also improve the performance via reducing the
> unnecessary ipi interrupt on RML XLS and Cavium.

I was about to mention the performance boost of the patch even on
machines not affected by the lock up.

When you enable function tracing, it can update 22,000 locations. Doing
a cache invalidate 22,000 times in a row, is not very efficient. Only a
full cache flush is needed at the end of the update (except for the
module updates, which are done on a live system).

-- Steve
