Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 15:50:31 +0200 (CEST)
Received: from [157.159.10.71] ([157.159.10.71]:46010 "EHLO smtp4.int-evry.fr")
	by lappi.linux-mips.net with ESMTP id S1101581AbYDANto convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Apr 2008 15:49:44 +0200
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 52348DB0015;
	Tue,  1 Apr 2008 15:48:30 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 3C7513EDCA1;
	Tue,  1 Apr 2008 15:48:29 +0200 (CEST)
Received: from ibook (mla78-1-82-240-17-188.fbx.proxad.net [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id B8ADD9012C;
	Tue,  1 Apr 2008 15:48:28 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] mips: remove MIPS_XXS1500
Date:	Tue, 1 Apr 2008 15:54:02 +0200
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
References: <20080330224025.GF28445@cs181133002.pp.htv.fi>
In-Reply-To: <20080330224025.GF28445@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Disposition: inline
X-UID:	944
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200804011554.03249.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hi Adrian,

Le lundi 31 mars 2008, Adrian Bunk a écrit :
> MIPS_XXS1500 has several compile problems like e.g. the
> #include <asm/keyboard.h> in arch/mips/au1000/xxs1500/board_setup.c
> having been broken by the removal of this header back in February 2004.

Nack, just emailed you with the fix.
