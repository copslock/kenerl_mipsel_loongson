Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 16:02:29 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:14290 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021826AbXJHPCU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 16:02:20 +0100
Received: by nf-out-0910.google.com with SMTP id c10so950298nfd
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2007 08:02:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=lOR8VbnmHH7Rh8hzyz6WybuvTHCMIbp4lFPnpwX/k7M=;
        b=RtnVHc3v+1tBMCt3NWmiOHYaRbxDNZB5Ur1oOysNhrnc/pCNERfdWp5I7yM8rXYw5hkc0w1SqQXkJSxKrI3U6EoqomYCmk9lLNIwyak+y+lXhfjUR7KP9ULi/sMOy91V64FK2g7tlRp6kKZroBVckXwyEq/n7nr8HYO5vvPBTJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JSFwQI8oXzfxdNQZidFu7MxmmAMcO3lrm8dY2bFNpskbJ0qKkEOTi/y/HMg/FscHGWbDoVI0wLcmbSZP2ZdKJnz1l25fUvw5GEI5kepx+aVjErZDSSr1J6JVLKIQRdcffTnDXKpmM+l4m1kJ/7xhdesK9RAQlXfhYgL4eQDFgmk=
Received: by 10.82.165.13 with SMTP id n13mr25861934bue.1191855739835;
        Mon, 08 Oct 2007 08:02:19 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id u9sm8794768muf.2007.10.08.08.02.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Oct 2007 08:02:18 -0700 (PDT)
Message-ID: <470A4673.30604@gmail.com>
Date:	Mon, 08 Oct 2007 17:02:11 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64.0710051102300.32066@anakin>
In-Reply-To: <Pine.LNX.4.64.0710051102300.32066@anakin>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> For specialized systems, you can always introduce the option to generate
> the TLB handler at compile time:

What do you mean by "specialized system" ?

If for some platforms we could generate the TLB handlers at compile
time, we could do it for all platforms, specially if the handler only
depends on the cpu type, no ?

>   - Enhance tlbex.c to be able to compile it for the host, and generate
>     a fixed TLB handler, based on CONFIG_* options, if
>     CONFIG_STATIC_TLB_HANDLER (buried deep in depends on EMBEDDED &&
>     ADVANCED && I_KNOW_WHAT_I_AM_DOING) is set.

It may mean putting a lot of hacks in tlbex.c making it just a PITA to
enhance and to maintain. IMHO, just have a static TLB handler
generator is simpler specially if we don't need to patch the handler
later. But we need to be sure nothing can be discover at runtime only
for current and future supported cpus...

thanks,
		Franck
