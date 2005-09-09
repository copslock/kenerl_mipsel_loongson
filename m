Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2005 07:41:48 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:55692 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8224951AbVIIGl2>; Fri, 9 Sep 2005 07:41:28 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 202C2C035;
	Fri,  9 Sep 2005 08:48:33 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 527131BC07E;
	Fri,  9 Sep 2005 08:48:34 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id B3B631A18A7;
	Fri,  9 Sep 2005 08:48:33 +0200 (CEST)
Subject: Re: MIPS SF toolchain
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	David Daney <ddaney@avtrex.com>
Cc:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
In-Reply-To: <432058C1.80106@avtrex.com>
References: <1126098584.12696.19.camel@localhost.localdomain>
	 <431F0850.8090804@avtrex.com>
	 <1126168866.25388.11.camel@orionlinux.starfleet.com>
	 <1126179199.25389.20.camel@orionlinux.starfleet.com>
	 <1126182122.25393.27.camel@orionlinux.starfleet.com>
	 <432058C1.80106@avtrex.com>
Content-Type: text/plain
Date:	Fri, 09 Sep 2005 08:48:22 +0200
Message-Id: <1126248502.20058.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > Can I just #ifdef this code if compiled for sf?
> > 
> 
> I do have some patches for glibc to get rid of these in a soft float 
> build.  

Can I see these patches, please?
(What is the #define for the FP?)

> However as Ralf Baechle said in the other message, the kernel FP 
> emulator works and is not that large of an overhead.

I also removed the FP Emulator in the kernel, just to be sure that
no SF ins are executed (I can send the patch to the list, but I know
there has already been discussion about this).

IMHO, if we say that we have a SF toolchain then there MUST NOT
BE any SF ins, otherwise we have a "semi soft float" toolchain.
Don't you agree?

BR,
Matej
