Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 10:07:15 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:61760 "EHLO
        mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491839Ab0BBJHK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 10:07:10 +0100
Received: by ewy4 with SMTP id 4so268608ewy.27
        for <multiple recipients>; Tue, 02 Feb 2010 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=6Egs0spO6FXJ48X62qjvDFsHs+c0oFPxrMCGsuaJEVo=;
        b=UTh96+VQ2ammSmjpoOQYzbNmwlJvGubLTCJrhdYdfEME3A+GrmwsX07xtbwM4kqHYO
         vT9VDqS8FIi1eGr707W9N0Pd7qhkcB/+BP0naZHs58Eu18etiEBWd1RDb6GH0/wPYXHc
         ty1xK6+xQVHJruaI0WhBvIhKWSA0otMzXnzBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=S5O4sdHoeujkiVdZl6FhcUAoI2Fd0h0iJmdql9Jy3FuZ49Fae5aHTUPEr9Fkz+fZyX
         jJGZ59sqqSJqTSXcsO+/DsU9Xu2ppYZVvI8kIJ4a1fxOVhIsAfaxWL1daoqeA3ykcKiD
         Y4GyXWk02CsZhatEYot8FXzDOSiBNSiZ+hkA4=
Received: by 10.213.97.28 with SMTP id j28mr390459ebn.82.1265101623823;
        Tue, 02 Feb 2010 01:07:03 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 16sm4346211ewy.14.2010.02.02.01.07.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 01:07:02 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH urgent] MIPS: fix micro-assembly overflow in set_except_vector
Date:   Tue, 2 Feb 2010 10:06:35 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <201002011027.37521.florian@openwrt.org> <20100201103628.GA15661@alpha.franken.de>
In-Reply-To: <20100201103628.GA15661@alpha.franken.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201002021006.35731.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Thomas,

On Monday 01 February 2010 11:36:28 Thomas Bogendoerfer wrote:
> On Mon, Feb 01, 2010 at 10:27:37AM +0100, Florian Fainelli wrote:
> > Commit 24a6d9866c5f15ba7e5b14dc17be4b6edba21d0e broke
> > the installation of handlers for boards which have their
> > handlers above a 1 << 26 address. Fix this by making sure that
> > jump_mask does not excess 0xfc000000 and add the missing ~ operator
> 
> j can handle 28 bit jump targets (26 bit in instruction plus two 0 bits
> for 32bit aligment), so 0xf000000 was IMHO fine.

Corrected version below, thanks.
---
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH urgent] MIPS: fix micro-assembly overflow in set_except_vector

Commit 24a6d9866c5f15ba7e5b14dc17be4b6edba21d0e broke
the installation of handlers for boards which have their
handlers above 0xf0000000. Fix this by adding the missing
~ operator to jump_mask when loading the handler target
address into buf.

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Acked-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7693929..af176b8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1283,7 +1283,7 @@ void __init *set_except_vector(int n, void *addr)
 		u32 *buf = (u32 *)(ebase + 0x200);
 		unsigned int k0 = 26;
 		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
-			uasm_i_j(&buf, handler & jump_mask);
+			uasm_i_j(&buf, handler & ~jump_mask);
 			uasm_i_nop(&buf);
 		} else {
 			UASM_i_LA(&buf, k0, handler);
