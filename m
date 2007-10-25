Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 21:10:31 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:47816 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20027083AbXJYUKW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 21:10:22 +0100
Received: by ug-out-1314.google.com with SMTP id u2so661850uge
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 13:10:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=IEE6JY6gsW55CnJ34ht8TkslwcKImZpMtPjVcNTVbMI=;
        b=BmnN2uLXPjPGahAtxOsawRI7gTgTEpmC0bZszq3JSIiPCxdL9vE5c7tO1ELYoLE+fluHnT6cZ0v0dUxkoRLNzq7FtuqVSSr0hVIgeCWMP0lLUIf6VvwF5AifWmHpu03qcyDYRJudnnwNjzWkqwxH3otjL3SYPbt05beCosT97mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=QVHVWWABnL+fXPB8md9bLvMhbyB7lQ6EwtyOmN3/mbtbxyyqErJKe2moUQNI2lsTlmGAja1TuoVJlWadso8ayoWNI6WY7XtxJHKdE8Cyg4jt6M//WXcfHL7dVWpKtwZ0bJPHlWpAKzhvlyT2BSpD8lDpuXU5CAyHGVZGY4AnjI8=
Received: by 10.66.243.2 with SMTP id q2mr3644922ugh.1193343004946;
        Thu, 25 Oct 2007 13:10:04 -0700 (PDT)
Received: from ?192.168.1.164? ( [84.150.255.131])
        by mx.google.com with ESMTPS id g8sm5247687muf.2007.10.25.13.10.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Oct 2007 13:10:01 -0700 (PDT)
Message-ID: <4720F815.1000901@gmail.com>
Date:	Thu, 25 Oct 2007 22:09:57 +0200
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
CC:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
References: <200710252108.43357.florian.fainelli@telecomint.eu> <4720ED96.2090909@gmail.com> <200710252135.08423.florian.fainelli@telecomint.eu>
In-Reply-To: <200710252135.08423.florian.fainelli@telecomint.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli schrieb:
> Le jeudi 25 octobre 2007, Manuel Lauss a écrit :
>> then where's the harm in leaving it in? It only forces you to think twice
>> (or apply tons of casts) when working with the au1x code.
> 
> II could argue the same way, why not :p ?

Hehe ;)

> If your code has warning, you are very likely not to like the compiler stop on 
> it, but rather warn. Also if there are casts or any special conversion, 
> sparse checking will do a better job as far as I can tell.
> 

I tripped over it once or twice; but in the end I don't really whether
this stays or goes (not that it matters anyway)

Thanks,
	Manuel Lauss
