Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 11:06:28 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:48378 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225548AbUDMKG1>;
	Tue, 13 Apr 2004 11:06:27 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id TAA04623;
	Tue, 13 Apr 2004 19:06:20 +0900 (JST)
Received: 4UMDO01 id i3DA6JX23676; Tue, 13 Apr 2004 19:06:19 +0900 (JST)
Received: 4UMRO00 id i3DA6I119784; Tue, 13 Apr 2004 19:06:18 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 13 Apr 2004 19:06:18 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Benjamin Collar <collar@onlinehome.de>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: Hello
Message-Id: <20040413190618.5c3c2a66.yuasa@hh.iij4u.or.jp>
In-Reply-To: <200404131138.22725.collar@onlinehome.de>
References: <200404131138.22725.collar@onlinehome.de>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Tue, 13 Apr 2004 11:38:22 +0200
Benjamin Collar <collar@onlinehome.de> wrote:

> Greetings
> 
> I've joined this mailing list because I've started a new project: I want to 
> port linux 2.6 to the Agenda VR3 PDA.
> 
> The Agenda already runs Linux--2.4.0 I think, based on the kernel that was at 
> linux-vr.org but now appears to be gone.
> 
> I'm totally a beginner here, so please bear with me :)
> 
> What I'm doing at the moment is, I'm trying to understand where all of the 
> code has gone! There is a different directory structure in 2.6. If someone 
> can answer these questions, I'd very much appreciate it:
> 
> 1. What's the difference between a NEC 4181 and NEC 41xx? In 2.6 there are 
> subdirectories for each of these, while in the VR kernel all the code was in 
> arch/mips/41xx. The Agenda is a 4181. Should I be using the 4181 common code 
> or the 41xx?

VR4181 is not same as other VR4100 series.
We already have codes for VR4181 in arch/mips/vr4181.
You can start from these codes.

> 2. Where did linux-vr go? Does anyone know where I can get the patches?

http://www.linux-mips.org/cvsweb/linux-vr/

Yoichi
