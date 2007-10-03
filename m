Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 13:20:54 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.187]:46605 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023203AbXJCMUq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 13:20:46 +0100
Received: by mu-out-0910.google.com with SMTP id w1so5288115mue
        for <linux-mips@linux-mips.org>; Wed, 03 Oct 2007 05:20:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=LEjw1IGxUb19AsCD24Asb8F76gLImol6AkB5lPCw0x8=;
        b=QqeYP0C7KbHgCI9Jwvt5lOf3+OHS0chknOrhDR8d6Sbc3o5LJ1dMPF2SAJxqV9dgaVrssdvH3D9dCLX2kR872AlZp/ODOuh3VcyjCBgqgUnFOlGB1IFSo+pSLa3vlK5y2BypniKzDJe8cP3lMSnS9pXZMHYVQTAZFvswVN3szIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LjFC8q/9PIYrNeAekU3Il0QJuie0TTWmAfsW02PYrA8muAmz3fQGc409pOkoQ6ZiBJpfEM/9VT2OC8eO2sM2xfXdBJtkxxnqThBSXdg1zlT994zYokpswchWZmxiGKWO4aQDvtqdyRQD3M8hxC5g9o7GUlCBBPB7rc8WTnEy5tk=
Received: by 10.82.189.6 with SMTP id m6mr13789874buf.1191414028199;
        Wed, 03 Oct 2007 05:20:28 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id y6sm697078mug.2007.10.03.05.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Oct 2007 05:20:27 -0700 (PDT)
Message-ID: <47038874.9050704@gmail.com>
Date:	Wed, 03 Oct 2007 14:17:56 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
In-Reply-To: <20071002154918.GA11312@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> I don't mind - it's just that I've never been a friend of leaving much
> debugging code or features around.  99% of the time it is just make the
> code harder to read and maintain.
> 

Yeah this kind of code is really hard to follow and therefore hard to
maintain I guess.

I'm wondering if we couldn't try to implement such code generator by
using a tools/scripts during the build process. This tool could emit
the assembler code during the early phase of the build into an
assembler file and then it could compiled like any other one. I see a
3 main benefits:

  - It would simplify a lot the kernel code.
  - Decrease the size of the kernel
  - Easy to read the generated disassembly

One issue to deal with is that some instructions need to be emitted
according to the type of the cpu which can only be determined at run
time. In this case we could leave some rooms into the generated code
for additional instructions which could be filled/patched during the
boot time by using a 'patch table'. If the cpu doesn't need to patch
the generated code then the useless space would be discarded when
installing the handler in its final place.

Just a thought but I'm probably missing something.

		Franck
