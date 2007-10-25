Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 20:35:57 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:8876 "EHLO smtp1.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20024023AbXJYTfr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 20:35:47 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 2EF898E8B78;
	Thu, 25 Oct 2007 21:35:10 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 062B4D0E31C;
	Thu, 25 Oct 2007 21:35:10 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
Date:	Thu, 25 Oct 2007 21:35:07 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org
References: <200710252108.43357.florian.fainelli@telecomint.eu> <4720ED96.2090909@gmail.com>
In-Reply-To: <4720ED96.2090909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200710252135.08423.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le jeudi 25 octobre 2007, Manuel Lauss a écrit :
> then where's the harm in leaving it in? It only forces you to think twice
> (or apply tons of casts) when working with the au1x code.

II could argue the same way, why not :p ?

If your code has warning, you are very likely not to like the compiler stop on 
it, but rather warn. Also if there are casts or any special conversion, 
sparse checking will do a better job as far as I can tell.
