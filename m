Received:  by oss.sgi.com id <S553757AbQLNSyb>;
	Thu, 14 Dec 2000 10:54:31 -0800
Received: from mail.ivm.net ([62.204.1.4]:13574 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553753AbQLNSyU>;
	Thu, 14 Dec 2000 10:54:20 -0800
Received: from franz.no.dom (port112.duesseldorf.ivm.de [195.247.65.112])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA08396;
	Thu, 14 Dec 2000 19:54:02 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.030222095511.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3A38E314.A22393DD@isratech.ro>
Date:   Sat, 22 Feb 2003 09:55:11 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Nicu Popovici <octavp@isratech.ro>
Subject: Re: YAMON.
Cc:     linux-mips@oss.sgi.com, Brady Brown <bbrown@ti.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 14-Dec-00 Nicu Popovici wrote:
> Thanks . Now I have a much bigger problem. I have to try to start this ATLAS
> board without a HDD and without ethernet. At reset it should give me a login
> prompt which I have to see throught the console. Can anyone help me ?

The linux-vr tree has a nice feature called XIP (eXecute In Place). This allows
to prepare a kernel to run directly out of ROM.

http://linuxvr-org

if that's what you're looking for.

-- 
Regards,
Harald
