Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 21:57:19 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:25610 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225219AbVDLU5E>;
	Tue, 12 Apr 2005 21:57:04 +0100
Received: by wproxy.gmail.com with SMTP id 57so1612650wri
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2005 13:56:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EXANG0ewYmVxOUmh9+F2NCgFYdaOBWQVX7p9N5RQSweNNejEpdm+zrTNllh7jk9hakE7VZreU+9Zi02r2kkFs5Brh19DO7VQpabYC2l0mS28sgoU6x/GN7xPpPV4tzK6mfMjeBBMZL0V7JiGz7e1CNPRkkUB8qlca2VNjRB3rFA=
Received: by 10.54.13.77 with SMTP id 77mr395014wrm;
        Tue, 12 Apr 2005 13:56:56 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Tue, 12 Apr 2005 13:56:56 -0700 (PDT)
Message-ID: <ecb4efd10504121356194d4d9f@mail.gmail.com>
Date:	Tue, 12 Apr 2005 16:56:56 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: troubles mmaping PCI device on Au1550
In-Reply-To: <479d91035fe1567525659393491e7ab9@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <ecb4efd10504101516482a9785@mail.gmail.com>
	 <479d91035fe1567525659393491e7ab9@embeddedalley.com>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

On Apr 12, 2005 11:22 AM, Dan Malek <dan@embeddedalley.com> wrote:
> The Au15xx uses 36-bit addressing for the PCI (among other) physical
> addresses.  The mmap() in your driver is the right thing, but you need
> to use io_remap_page_range() where the 2nd parameter is a phys_t.
> Your offset should be a phys_t type, and pci_resource_start() also
> returns a phys_t.

Yeah, this was exactly my problem. Last night I managed to find the
comment about this in au1000.h. Now I can happily mmap() the PCI
devices memory. Thanks!

                                --Clem
