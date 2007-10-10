Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 20:29:43 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:62695 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20030240AbXJJT3e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 20:29:34 +0100
Received: by nf-out-0910.google.com with SMTP id c10so269269nfd
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 12:29:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=Cj1KA0ycsMPyEvaMnAGSvMmYD95SZaqjXpQrUxGpBc0=;
        b=uguyX1bb6zhhbMqinaPTqvOuq9J+O6clq/To9xiCUN26y38KdPDt6Rb4zz3+RW+qpPbtR+38BDkJ2XdWlEC2hoJ9Fj1/tKTOoLxUUexstyqLWXafXIsNoXmsZkBCRQxjRXPmsR0RjwR4K4mJX2R4LFJGeVZBdyuogVv4WdBgRI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=MiGuOwbcJY9PeeUNGpqQU+F3MEmLcByVZ4hjxDFIB8IJseinCNmnXMuviLVl451Ln6TahQ5oZarVAGABMyg3eqIE/ZPEsI04r6lwVIFGq4SbW1V2RCaCEuhd7rMagu3cTXqTNg4MZNiPOrMqsbWiaf4BQ05Sn8ZSR3L0mjq78WY=
Received: by 10.86.76.16 with SMTP id y16mr803452fga.1192044571220;
        Wed, 10 Oct 2007 12:29:31 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id v23sm2041141fkd.2007.10.10.12.29.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Oct 2007 12:29:30 -0700 (PDT)
Message-ID: <470D2804.2090107@gmail.com>
Date:	Wed, 10 Oct 2007 21:29:08 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the init.data
 section
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com> <470BE61F.5020108@gmail.com> <20071010142755.GA9325@linux-mips.org> <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 10 Oct 2007, Ralf Baechle wrote:
> 
>>> It increases the stack pressure a lot (more than 2500 bytes) but
>>> at this stage in the boot process, it shouldn't matter.
>> Even more for 64-bit kernel - and I would really like to keep reduce
>> the kernel stack for 64-bit kernels, THREAD_SIZE_ORDER 2 is already
>> slightly painful when memory becomes fragmented.
> 
>  I think the right fix is to implement "__initbss" along the lines of 
> "__initdata".
> 

yes I think so.

		Franck
