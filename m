Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 08:30:20 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.190]:458 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027003AbXKDIaM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 08:30:12 +0000
Received: by mu-out-0910.google.com with SMTP id g7so1254206muf
        for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 01:30:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=uaygN2JDcMA9z53Vkfu/fThIq+UgfiWdVKAEhk1udf8=;
        b=pvT6fsXwrkR7QW8njbTYlImPNeyOcaF68qfdBzmHq9KZwYXPakKgyotHqDIM9rpKMXaRcqQeoFQyNy+NiZqHBuVyOdaPCuKN812Fwo7xsnzDZebTySsLRXMHaPL/MtgfSDHL1iMXIhRXRzttdIyrHr0/e+DA7gdQIWn6qvTxk2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gaWT+o+wL++VSe60THnU+OQjmYenYEAcAKqEeEjg270epE5rN/tdAGzah+T1xg8ks8NGcJhQ2l9xbVSRNw2UxyfQqxCI+iZ9Fb48QtOc3ucuxjh8ZLwSXNn5oW9LKAKXCtySEZdijENtFYntw0BnHuBpgGY/3ZGQ1AyZzW+kJTI=
Received: by 10.86.66.1 with SMTP id o1mr2379265fga.1194165011740;
        Sun, 04 Nov 2007 01:30:11 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm9311814fkf.2007.11.04.01.30.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Nov 2007 01:30:09 -0700 (PDT)
Message-ID: <472D82D1.1050401@gmail.com>
Date:	Sun, 04 Nov 2007 09:29:05 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl> <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl> <4713C840.8080206@gmail.com> <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl> <4717C1FB.4030602@gmail.com> <Pine.LNX.4.64N.0710191239490.13279@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710191239490.13279@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 18 Oct 2007, Franck Bui-Huu wrote:
>> After spending some fun time trying several different configurations
>> with gcc and ld, I noticed that gcc makes a section with @nobits
>> attribute if the section name starts with .bss.*
> 
>  Exactly how GCC sets section flags is mostly determined by 
> default_section_type_flags() in gcc/varasm.c; some flags are set elsewhere 
> too.  This is with HEAD of GCC.
> 

It seems that we can rely on this behaviour. I looked at gcc 4.1.2/3.2
sources and they made a section part of .bss if the section name starts
with ".bss.".

>> Another test I did is to put .init.bss (not .bss.init) section right
>> before .bss section in order to have only one segment to load. And it
>> makes magically ld do the right thing. I must admit that I don't
>> understand why, and the lack of documentation doesn't help...
> 
>  Hmm, isn't what `info ld' says enough?

Hmm, I'm must be blind but I missed that each time I read it. Could
you point out the section number please ?

OK, I think the best thing to do now is to respin the patchset and
submit it linux arch mailing list.

thanks,

		Franck
