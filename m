Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 12:38:53 +0200 (CEST)
Received: from cassidy.nuernberg.linuxtag.net ([212.204.83.80]:26125 "EHLO
	cassidy.nuernberg.linuxtag.net") by linux-mips.org with ESMTP
	id <S1121744AbSI1Kiw>; Sat, 28 Sep 2002 12:38:52 +0200
Received: by cassidy.nuernberg.linuxtag.net (Postfix, from userid 1006)
	id 79901EC277; Sat, 28 Sep 2002 12:42:39 +0200 (CEST)
Received: from hydra.linuxtag.uni-kl.de (VPN-Hydra [192.168.0.1])
	by cassidy.nuernberg.linuxtag.net (Postfix) with ESMTP id 59FF5EC0F5
	for <linux-mips@linux-mips.org>; Sat, 28 Sep 2002 12:42:35 +0200 (CEST)
Received: by hydra.linuxtag.uni-kl.de (Postfix, from userid 1034)
	id 288576A09; Sat, 28 Sep 2002 12:38:40 +0200 (CEST)
Date: Sat, 28 Sep 2002 12:38:40 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] dec_esp.c repair mmu_sglist breakage
Message-ID: <20020928103840.GA23300@linuxtag.org>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <20020928015947.GE7706@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928015947.GE7706@paradigm.rfc822.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <merker@linuxtag.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Sat, Sep 28, 2002 at 03:59:47AM +0200, Florian Lohoff wrote:

> through the whole issue of the mmu_sglist confusion and the broken
> reimplantation of mmu_sglist the dec_esp broke. Here is a fix
> to really remove the mmu_sglist and use scatterlist instead. With
> this the Decstation on this desk at least finds its partitions
> again and does not crash.

I tested the patch on my DS 5000/150 and it works there, too.
Could you please check it into the cvs? Without it the kernel
is de facto unusable on DECstations.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
