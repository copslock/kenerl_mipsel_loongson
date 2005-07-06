Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 02:42:54 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.202]:63510 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8226300AbVGFBmh> convert rfc822-to-8bit;
	Wed, 6 Jul 2005 02:42:37 +0100
Received: by rproxy.gmail.com with SMTP id y7so1050199rne
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2005 18:42:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B7LuoSNwBtKomeNjqKjz/RYMyK4UemmDXxQvz6Dbv3Sh1qKfooiIs9tU8z6WCRAHUDJURG26EknemS56N0cOx03/ANePkYsxYwYin3pCzQ5/wBe37sbMntzuz3mXqB7jg/6YLkyOJed8SfN4ogpDR1LYA8HN84LFcAUCxf+yYO0=
Received: by 10.38.104.15 with SMTP id b15mr4495440rnc;
        Tue, 05 Jul 2005 18:42:56 -0700 (PDT)
Received: by 10.38.104.78 with HTTP; Tue, 5 Jul 2005 18:42:56 -0700 (PDT)
Message-ID: <dbce930205070518422c21be21@mail.gmail.com>
Date:	Tue, 5 Jul 2005 21:42:56 -0400
From:	David Cummings <real.psyence@gmail.com>
Reply-To: David Cummings <real.psyence@gmail.com>
To:	linux-mips@linux-mips.org
Subject: broken ip27 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <real.psyence@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: real.psyence@gmail.com
Precedence: bulk
X-list: linux-mips

Hello all,
   I have recently compiled kernel from cvs-source that will load from
arcload, but after "Entering Kernel" the machine hangs and the MSC
appears to be in a POD dex mode. I would  like to know if anyone is
familiar with this and if it's just a patch I'm missing or something.
Thanks
-Dave
-- 
The way that can be named is not the Way.
