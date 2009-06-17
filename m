Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 15:37:06 +0200 (CEST)
Received: from mail-ew0-f221.google.com ([209.85.219.221]:54524 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492874AbZFQNg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jun 2009 15:36:56 +0200
Received: by ewy21 with SMTP id 21so440922ewy.0
        for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 06:35:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eyBEAxnP38BDJ/QfIFmiplmX+gNdaApvK9d751e/WYA=;
        b=ZSbnyUjVCD4/ueidW1l+ONr4vtAgVk1S3PH3hcm5YBMGbkT5zIrEt6Jj5tkLQ3G/Ip
         ocGjDkZ2me7t7XJbAh5x0KH0UAtE7O37fxkHdm+r6HAg2+tH1S8ZlOG5WrAg9cvLMPbL
         rObVVeR3WcgoRKbsQVMVukSzfqrGw1JckOEkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YNn69S9ggtDcOTbA9JK0AMAMsl+wmdO7MQvGq6RJgnzrAvD5ia6fiQ01XLzk1K8I6s
         X8i/giEUc5hrPYbeFW+khtREjF+uGg0jii10u8CRIWLV+sobLBAOkAw/NarVrJhz8/48
         iRsFxWYiGrSLUlt/RA4Wuy7Hh7ScNfRh5g5BU=
Received: by 10.216.39.85 with SMTP id c63mr85805web.103.1245245728847;
        Wed, 17 Jun 2009 06:35:28 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm65138eyf.8.2009.06.17.06.35.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 06:35:27 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] -git compile fixes for MIPS
Date:	Wed, 17 Jun 2009 15:35:23 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <4A38A173.9010508@gmail.com>
In-Reply-To: <4A38A173.9010508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906171535.24453.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le Wednesday 17 June 2009 09:55:31 Manuel Lauss, vous avez écrit :
> Quick fixes for some compile failures which have cropped up
> in linus-git in the last 24 hours:
>
>    CC      arch/mips/kernel/time.o
> In file included from linux-2.6.git/include/linux/bug.h:4,
>                   from linux-2.6.git/arch/mips/kernel/time.c:13:
> linux-2.6.git/arch/mips/include/asm/bug.h:10: error: expected '=', ',',
> ';', 'asm' or '__attribute__' before 'BUG'
> linux-2.6.git/arch/mips/include/asm/bug.h: In function '__BUG_ON':
> linux-2.6.git/arch/mips/include/asm/bug.h:26: error: implicit declaration
> of function 'BUG'
>
>    CC      arch/mips/mm/uasm.o
> In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
> linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
> linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit declaration
> of function 'smp_processor_id' linux-2.6.git/arch/mips/mm/uasm.c: In
> function 'uasm_copy_handler': linux-2.6.git/arch/mips/mm/uasm.c:514: error:
> implicit declaration of function 'memcpy'
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks for fixing this !

Tested-by: Florian Fainelli <florian@openwrt.org>
