Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 02:54:30 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:52359 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225348AbVCQCyQ>;
	Thu, 17 Mar 2005 02:54:16 +0000
Received: by wproxy.gmail.com with SMTP id 55so90889wri
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2005 18:54:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=lrojtX8i0uqXNkYOAgB7Z2YeOazSHAR21q/qaROH1MT1FsMuBkqBSYx7w/5Y/ZrQ5hw3KBDJUCZ89KJouv4Rz59hpkmj+10s2tN40gT9ux0I/S0ebrbKPH+IzJTRk0OzdE31Xcf6dVHTm6KJQZSdDjqX71AgfZPvvBlecqWcg+E=
Received: by 10.54.14.31 with SMTP id 31mr1443316wrn;
        Wed, 16 Mar 2005 18:54:09 -0800 (PST)
Received: by 10.54.28.68 with HTTP; Wed, 16 Mar 2005 18:54:09 -0800 (PST)
Message-ID: <2ccb2254050316185449699409@mail.gmail.com>
Date:	Thu, 17 Mar 2005 02:54:09 +0000
From:	Leonel Gayard <leonel.gayard@gmail.com>
Reply-To: Leonel Gayard <leonel.gayard@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How do I compile GCC to generate MIPS code ?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <leonel.gayard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: leonel.gayard@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

I have recently started to study the MIPS architecture. For instance,
I wanted to have GCC compile C code into MIPS assembly and run it in
SPIM. (I have an Intel machine running Linux).

So I want to try something like this:

gcc -Wall -pedantic -S --march=mips1 test.c

in order to have it generate MIPS assembly.

It does not work. All I get is:

cc1: error: bad value (mips32) for -march= switch
cc1: error: bad value (mips32) for -mcpu= switch

Clearly, I need to recompile GCC so it has MIPS in its available
architectures. Remark, this is not cross-compiling, because I want GCC
to run on an i686 machine, it just generates MIPS code.

Can any one help me do this ?

Thank you
Leonel
