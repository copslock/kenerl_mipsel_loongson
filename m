Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 09:34:32 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:42438 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8224974AbVIEIeM>; Mon, 5 Sep 2005 09:34:12 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 69996C028;
	Mon,  5 Sep 2005 10:40:51 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id E437D1BC089;
	Mon,  5 Sep 2005 10:40:52 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 9CA8C1A18B4;
	Mon,  5 Sep 2005 10:40:53 +0200 (CEST)
Subject: Re: possible serial driver fixup for au1x00 in 2.6?
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	rolf liu <rolfliu@gmail.com>
Cc:	ppopov@embeddedalley.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b7205070609215b750fea@mail.gmail.com>
References: <2db32b720507011756247735d6@mail.gmail.com>
	 <1120266383.5987.46.camel@localhost.localdomain>
	 <2db32b72050705124078a48aed@mail.gmail.com>
	 <1120633817.5724.26.camel@localhost.localdomain>
	 <2db32b7205070609215b750fea@mail.gmail.com>
Content-Type: text/plain
Date:	Mon, 05 Sep 2005 10:40:54 +0200
Message-Id: <1125909654.19482.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I just give 8250.c a dirty hack, letting it just manage the additional
> serial ports. So there are two serial driver in the system at the same
> time :(  Sound funny.

Can we see the hack, please ? :-)

BR,
Matej
