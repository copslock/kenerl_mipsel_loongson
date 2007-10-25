Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 20:25:34 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:6062 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026424AbXJYTZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 20:25:25 +0100
Received: by nf-out-0910.google.com with SMTP id c10so556140nfd
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 12:25:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=pSJnAsR12GTdtIbNP8xbo/q4/v3YpDTrJZqc6hmeRMQ=;
        b=kZGWBi+BjYD302c6U2K0mjzg7g5Y9Sf4H3imBHin7qC6F264JK3fLLeTgEQ344Bh2eRpCMD5jVOthMszPA5WaPKrJNW/cLYSFat/S6setjnoVo2ZEODkdJruCZRK/uaCNxWMCA0w7zNv7SAZOG/g2AVev+XDD9pP56gY/ZlcDYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=PqJub82cLqv2MtCOUfuikdMem4Eq/ydjtdTam6oBg0h3SxrN9c3yME5wpI6UNsvO7XuWYJjEyrCcSeWCuNZke68PZ/TzoSrtiV/lwS6kOIv9vQS/sN1AyCnL3DV9ApZ8LL5K8xDzK+IZmnM5814G4ohZClSyxZMc4mYYHiSOyfI=
Received: by 10.86.62.3 with SMTP id k3mr1573731fga.1193340314358;
        Thu, 25 Oct 2007 12:25:14 -0700 (PDT)
Received: from ?192.168.1.164? ( [84.150.255.131])
        by mx.google.com with ESMTPS id e9sm5160108muf.2007.10.25.12.25.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Oct 2007 12:25:13 -0700 (PDT)
Message-ID: <4720ED96.2090909@gmail.com>
Date:	Thu, 25 Oct 2007 21:25:10 +0200
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
References: <200710252108.43357.florian.fainelli@telecomint.eu>
In-Reply-To: <200710252108.43357.florian.fainelli@telecomint.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli schrieb:
> Remove the EXTRA_CFLAGS because it is useless (code compiles without warnings).

then where's the harm in leaving it in? It only forces you to think twice
(or apply tons of casts) when working with the au1x code.

>  obj-$(CONFIG_PCI)		+= pci.o
> -
> -EXTRA_CFLAGS += -Werror

MfG,
	Manuel Lauss
