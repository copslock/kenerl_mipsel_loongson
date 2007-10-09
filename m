Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:33:43 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:1515 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022034AbXJIUdf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:33:35 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1327054nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:33:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=xxpWjs4qdvcJTHzLRUhaXSsLQAXgP5cePMqzI8LmVxM=;
        b=GHCaJNfaB7JWff/kTB6YIJyTJ9ngmfdsA0dsUPxWIacimhRJHSXjq4KKzzWcRFpM8QiYm3s8/q2Yg0f4F1N7v62vWnRAoPdaa9J+HzHBwHCoxKgCDVivqB0dfkP50CCpKmn1FGxhz/n9gAI2467lK5moIVE9UG8GQJJnxKjFUCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=CALsqpDQpeaft/lHNRH64BITBHh88GWa/LX0uJMjeIq2n3bbhVdT+6FKgWIzfZqjeHPzV0JYAE2QyrDpbbFyE6UCYYvIFqI+j5yYoKaiYOBAGQOr9bxaSwMz1ij6jWdLkVnzZKL714M12wFSNpSmH0jLRiXgvKcKRTYMg2PLiT4=
Received: by 10.86.78.4 with SMTP id a4mr6304494fgb.1191962014146;
        Tue, 09 Oct 2007 13:33:34 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id o11sm9142698fkf.2007.10.09.13.33.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:33:32 -0700 (PDT)
Message-ID: <470BE58A.9070709@gmail.com>
Date:	Tue, 09 Oct 2007 22:33:14 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org>
In-Reply-To: <20071005115151.GA16145@linux-mips.org>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> So I did a few experiments.  This is the size of tlbex for a malta_defconfig

I did too and it results into the patchset I'm going to send.

Basically it removes all arrays from the init.data section and make
them automatic variables. So it's pretty extreme and maybe if the
stack pressure is too high, we could balance it. This is done by patch
2,3,4.

   text    data     bss     dec     hex filename
   9840    3904    1568   15312    3bd0 arch/mips/mm/tlbex.o~before
   9776     576    1568   11920    2e90 arch/mips/mm/tlbex.o~after

While I was at it, I did some trivial cleanups witch patch 1,5,6.

Thanks,
		Franck
