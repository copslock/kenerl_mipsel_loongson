Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 14:50:20 +0000 (GMT)
Received: from p508B617B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.123]:63754
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224914AbUASOuT>; Mon, 19 Jan 2004 14:50:19 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0JEoIex009492;
	Mon, 19 Jan 2004 15:50:18 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0JEoHnU009491;
	Mon, 19 Jan 2004 15:50:17 +0100
Date: Mon, 19 Jan 2004 15:50:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: karthikeyan natarajan <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: In r4k, where does PC point to?
Message-ID: <20040119145017.GA9141@linux-mips.org>
References: <20040119074219.15886.qmail@web10106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119074219.15886.qmail@web10106.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 19, 2004 at 07:42:19AM +0000, karthikeyan natarajan wrote:

>     Basically, the PC points to the next instruction
> to
> be executed. But, in R4k, there are 8 instructions
> getting executed in parallel. Where does the PC point
> to? My understanding is that PC points to the next 
> instruction that will be entered into the pipeline.
>     Please correct me if i am wrong..

The fact that instructions are issued in a pipeline is not visible in
the EPC value.

  Ralf
