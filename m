Received:  by oss.sgi.com id <S554061AbQLBNGb>;
	Sat, 2 Dec 2000 05:06:31 -0800
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3453 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S554059AbQLBNGQ>;
	Sat, 2 Dec 2000 05:06:16 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 142CN5-0001Wk-00; Sat, 2 Dec 2000 13:06:31 +0000
Subject: Re: Support for smaller glibc
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Sat, 2 Dec 2000 13:06:28 +0000 (GMT)
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
In-Reply-To: <20001202050306.A12319@bacchus.dhis.org> from "Ralf Baechle" at Dec 02, 2000 05:03:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142CN5-0001Wk-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > solved.  But forking a smaller libc of standard glibc is nothing but the
> > St. Florian's principle ...
> 
> Ulrich is refusing to do anything with it. Do you have any suggestions?
> I will do my best to do it right. But I am afraid I cannot do it alone.

Ulrich is right. Start from a library that is intended to be modular and
embedded. Folks are already looking at using newlib for this. 

Alan
