Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7EDYARw024876
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 14 Aug 2002 06:34:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7EDYAVX024874
	for linux-mips-outgoing; Wed, 14 Aug 2002 06:34:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7EDY6Rw024863
	for <linux-mips@oss.sgi.com>; Wed, 14 Aug 2002 06:34:07 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g7EDYiu6026657;
	Wed, 14 Aug 2002 14:34:44 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g7EDYhql026655;
	Wed, 14 Aug 2002 14:34:43 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Heap test
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA379C06@ATVX>
References: <7DF7BFDC95ECD411B4010090278A44CA379C06@ATVX>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 14:34:43 +0100
Message-Id: <1029332083.26226.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2002-08-14 at 14:21, Siders, Keith wrote:
> Does the kernel have a heap memory test? I could use one.

It does some sanity checking as it goes, but its very hard to do this in
a kernel. Virtually allocated spaces have guard pages. Physically
allocated space does not, but we do support slab poisoning to spot
scribbles in freed memory and failure to do initializations
