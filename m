Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 22:31:18 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.232]:65477 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133727AbWG1VbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Jul 2006 22:31:09 +0100
Received: by wr-out-0506.google.com with SMTP id i23so139122wra
        for <linux-mips@linux-mips.org>; Fri, 28 Jul 2006 14:31:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PaY+tdALS5e/4yLJGGfj5lft3gpWbLqq88yIqivITmOFCVaaSNqi+0yIWUsLxnyCps6Ub8VhoeHcZwja59a64ITUsXXASmJ2p1o5R1h4vMkxIYXGBVOblxI1iu3TySpBgtQA0Zsbecq7eWNi6yA6X1/jg7TfKMuoqIoUVLrvwoU=
Received: by 10.54.66.1 with SMTP id o1mr10076117wra;
        Fri, 28 Jul 2006 14:31:06 -0700 (PDT)
Received: from sauron.lan.box ( [200.180.163.244])
        by mx.gmail.com with ESMTP id 14sm386709wrl.2006.07.28.14.31.04;
        Fri, 28 Jul 2006 14:31:06 -0700 (PDT)
Date:	Fri, 28 Jul 2006 18:31:02 -0300
From:	Ricardo Nabinger Sanchez <rnsanchez@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	freebsd-mips@freebsd.org, linux-mips@linux-mips.org
Subject: Re: ld: cannot open crt1.o
Message-Id: <20060728183102.1f08dcd4.rnsanchez@gmail.com>
In-Reply-To: <20060728194204.GA28080@linux-mips.org>
References: <20060728162202.4567446d.rnsanchez@gmail.com>
	<20060728194204.GA28080@linux-mips.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-portbld-freebsd6.1)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rnsanchez@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rnsanchez@gmail.com
Precedence: bulk
X-list: linux-mips

Quoting  Ralf Baechle <ralf@linux-mips.org>
Sent on  Fri, 28 Jul 2006 15:42:04 -0400

> crt1.o is part of glibc; you only seem to have installed cross versions of
> binutils and gcc.

Yes, I installed the mipsel-* packages from ports, on 6.1-STABLE.  Does
it have to be glibc or can it be uClibc?

Anyway, I'll check my possibilities.  In case of further problems, I bug
you guys again.

Thanks.

ps: please note that I'm on a FreeBSD box.

-- 
Ricardo Nabinger Sanchez     <rnsanchez@{gmail.com,wait4.org}>
Powered by FreeBSD

  "Left to themselves, things tend to go from bad to worse."
