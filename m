Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 21:30:27 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:20990 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20043364AbXJRUaT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 21:30:19 +0100
Received: by nf-out-0910.google.com with SMTP id c10so250288nfd
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 13:30:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=IF9MgppG3PTMa4fKzju5B1U+a87DTPBxcxs0j713Vp0=;
        b=STdyhSgNou5Bt3Q31zBl4arsArmpqX7qovKAsRjzGeNZOEn2LFwDpra19m3SozI34Rkzv7n5yaMYZgT+ZUCFHWbXUAOAIiBxpEoyH+t2wiSUvglBr58dYc+zA5nUUl5sjcKi2QuyajQZ+hUZy78IgDbqyZEjbfMiWxX7+USjXNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IvBH7tk/tw8Nk1yfdVX6mM7NlTIBVvcyh0e7oThTeQHCJgN8xTDgcpjqOkfuhSL6PQO8xEW6b5mN7+5dVfHQ6J/mh8QXmPBZVMxa82O7pr4InGAU25NxpzqpD9qDKWOcSnbWPoWa5DWcz1l6AdUCaJ5pCAx4jrrGeVuvs8KBpAQ=
Received: by 10.86.84.5 with SMTP id h5mr721298fgb.1192739401257;
        Thu, 18 Oct 2007 13:30:01 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id d13sm2371252fka.2007.10.18.13.29.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Oct 2007 13:29:59 -0700 (PDT)
Message-ID: <4717C1FB.4030602@gmail.com>
Date:	Thu, 18 Oct 2007 22:28:43 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl> <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl> <4713C840.8080206@gmail.com> <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 15 Oct 2007, Franck Bui-Huu wrote:
> 
>> Well, since .init.bss is declared as follow:
>>
>> 	.init.bss (NOLOAD) : {
>> 		...
>> 	}
>>
>> data should not take any space in the image...
> 
>  The above only marks it as unloadable (cf. e.g. debugging information).  
> It is still there.
> 

So it seems there is no way from a linker script to specify that a
section has the nobits type, is it ?

After spending some fun time trying several different configurations
with gcc and ld, I noticed that gcc makes a section with @nobits
attribute if the section name starts with .bss.*

So calling .bss.init instead of .init.bss makes gcc do the right
thing. Here is a bit of tlbex.s:

		.word	0
		.section	.bss.init,"aw",@nobits
		.align	2
		.type	tlb_handler, @object
		.size	tlb_handler, 512
	tlb_handler:
		.space	512
		.align	2
		.type	labels, @object
		.size	labels, 1024
	labels:
		.space	1024


Another test I did is to put .init.bss (not .bss.init) section right
before .bss section in order to have only one segment to load. And it
makes magically ld do the right thing. I must admit that I don't
understand why, and the lack of documentation doesn't help...

Unfortunately I don't know if we can rely on one of these
behaviours. IOW if they're going to work with all supported versions
of gcc/ld.

Anyway, I'll resubmit a new patchset for futher discussion.

		Franck
