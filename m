Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 15:17:31 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:35332 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021858AbXC0OR2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 15:17:28 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2116673uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 07:16:27 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Kg9doZFwgCoC/hLc4ebZYd4+zjWtVvntLkSRXtMeoiXOXRL5Sb4Em1InKSGyAmhvMdNq0XwaE0Nu/6AVYt8YlBDO6cnQe9qH4I6keeFOte+0nhXLcFdMJ9M85hU31PMAiYXa7a7YPsvfxfLb9BCyM6UCZ98hI7gTaitzR1KIKoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z9EncHQBUFQtPO9jCmymh3cCe6GyIGJVBJr+qEoLhhukPDupnPV6VlasLfE/zbRzhFzVhcIDfE+/dmIgWz6WLY+wdhYLaRGNjwhk2xs9UXcXXdV8fGENDmngn2GSRHCyhhWWDmRXcR06aZ7hVZDJNd8dx6fif4FLnJB/AT26DGg=
Received: by 10.114.130.1 with SMTP id c1mr3169024wad.1175004986456;
        Tue, 27 Mar 2007 07:16:26 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Tue, 27 Mar 2007 07:16:26 -0700 (PDT)
Message-ID: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com>
Date:	Tue, 27 Mar 2007 16:16:26 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Early printk recent changes.
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm wondering how arch/mips/kernel/early_printk.c is supposed to be used.

I've already an early console that needs some setup before registering
it. In the current context I can't do that anymore. Of course I can do
it once in prom_putchar() but quite frankly I do not see the real
point to make this common for all platforms.

Moreover I used to call setup_early_printk() sooner in my prom setup code.

BTW, it seems some '__init' and '__init_data' are missing...
-- 
               Franck
