Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 23:31:46 +0000 (GMT)
Received: from p508B6A65.dip.t-dialin.net ([IPv6:::ffff:80.139.106.101]:814
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225280AbUL0Xbm>; Mon, 27 Dec 2004 23:31:42 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBRNVVT0020251;
	Tue, 28 Dec 2004 00:31:31 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBRNVQMP020250;
	Tue, 28 Dec 2004 00:31:26 +0100
Date: Tue, 28 Dec 2004 00:31:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Habeeb J. Dihu" <macgyver@tos.net>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.6.9 Cobalt Tulip lockups.
Message-ID: <20041227233126.GA6680@linux-mips.org>
References: <200412272313.iBRNDgc6013040@starbase.tos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412272313.iBRNDgc6013040@starbase.tos.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 27, 2004 at 05:12:50PM -0600, Habeeb J. Dihu wrote:

> eth0: MII status 782d, Link partner report 45e1.
> eth0: 21143 negotiation status 000000c6, MII.
> Badness in local_bh_enable at kernel/softirq.c:141
> Call Trace: [<800b32c8>]  [<80084e28>]  [<80397ee8>]  [<80397f08>]
> [<80398af4>]  [<8029a374>]  [<800b87ac>]  [<800ad20c>]  [<8029ccbc>]
> [<802bc8b0>]  [<802bc918>]  [<802bcba8>]  [<802575bc>]  [<8027b370>]
> [<800abe34>]  [<800abe34>]  [<800b3168>]  [<800abebc>]  [<800abf80>]
> [<800ac6b8>]  [<8022e900>]  [<800ac34c>]  [<8022e900>]  [<800ac278>]
> [<800ac174>]  [<80279dec>]  [<80279980>]  [<800b8954>]  [<802b9458>]
> [<800b3168>]  [<80084808>]  [<800b3208>]  [<80084e18>]  [<80082908>]
> [<802dc1bc>]  [<80083180>]  [<802d89d8>]  [<8030ffdc>]  [<80303260>]
> [<802da298>]  [<80084e28>]  [<8029afb0>]  [<8029b330>]  [<80138718>]
> [<802dad80>]  [<80134538>]  [<800a4198>]  [<802d07c0>]  [<803031ec>]
> [<8030ffdc>]  [<80214364>]  [<80295864>]  [<800a7440>]  [<8030ffdc>]
> [<80214364>]  [<80295894>]  [<80295864>]  [<8029b7b4>]  [<80303ab8>]
> [<80303aa0>]  [<8020e0d4>]  [<800a7440>]  [<802120f4>]  [<800a40c8>]
> [<80310070>]  [<80398698>]  [<80398840>]  [<8029ca50>]  [<801d6f8c>]
> [<8029cd50>]  [<8039918c>]  [<801cab18>]  [<8039b554>]  [<8039c8a4>]
> [<801d8068>]  [<80397740>]  [<800bdbe8>]  [<801c7398>]  [<801c7274>]
> [<801c70cc>]  [<80086070>]  [<80086060>] 

Can you decode this dump?  Undecoded it's useless, decoded likely to
be useful ...

  Ralf
