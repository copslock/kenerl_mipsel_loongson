Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 00:40:13 +0000 (GMT)
Received: from m205-235.dsl.tsoft.com ([IPv6:::ffff:198.144.205.235]:38292
	"EHLO lists.herlein.com") by linux-mips.org with ESMTP
	id <S8225391AbTJ1AkL>; Tue, 28 Oct 2003 00:40:11 +0000
Received: from io.herlein.com (io.herlein.com [192.168.70.244])
	by lists.herlein.com (Postfix) with ESMTP id D6E8EA2F
	for <linux-mips@linux-mips.org>; Mon, 27 Oct 2003 16:48:27 -0800 (PST)
Date: Mon, 27 Oct 2003 12:41:39 -0800 (PST)
From: Greg Herlein <gherlein@herlein.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Pb1500 and PCMCIA booting?
In-Reply-To: <3F9DC719.50700@embeddededge.com>
Message-ID: <Pine.LNX.4.44.0310271238070.25452-100000@io.herlein.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <gherlein@herlein.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gherlein@herlein.com
Precedence: bulk
X-list: linux-mips

> just write some code (from the boot rom examples) that
> initializes the PCMCIA, knows how to peruse the file system of
> your choice, can read the kernel into memory and jump to it.  
> Put this code someplace in the flash so you can start it from
> yamon.

Sounds good.  Looks like I should be able to create a two 
partition CF card that has the kernel on one partition and the 
root filesystem on another.  Then, do as you suggest and cook up 
some raw code that can put the Au1500 in reset and access the CF 
directly, read the kernel into memory and jump to it.  If the 
kernel is rigged to then mount the root filesystem from the other 
partition, then I have a workable system on one CF.

For the real product, the cooked code that yamon would load 
would replace yamon and get loaded as a bootloader directly.

If anyone has suggestions, references, or comments, I'd love to 
hear them.

Greg
