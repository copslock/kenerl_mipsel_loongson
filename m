Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:43:12 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.190]:10641 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035426AbXJNTnD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:43:03 +0100
Received: by mu-out-0910.google.com with SMTP id w1so1274918mue
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 12:42:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=onK8KdiqrRiD6yGri7nXg/KYOmOYpAwmSIsE6EncuC4=;
        b=IDUV5copfFuwjfoDiyGcMUo74W2Y2UY9paCNwDnJdkS/HcN/pZYM4mTaQn0Yx2tPgKlhVFuIEJFHnD7ixYL0DC0RPZ50dU6Z43n56l/CmxRMiGY0tROtTGfVvRShBYQnDjIpSwSXtJik72voXYBpRWxkld9PsweKFPYFgfqBfMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=La/FGLGX8YYEIBZAURElIXQaKPnPILmF2t8K7K/dniwSLYGaLkcUkKZ64h0ASztb56KUnY9cc2qsYc7BaFN1IGWivM+4w1DdXxzg7UBMW67yFUuiCcpA7KizehMXgiVN2g6i0iNZ+rgAIoBq5QffjDwxNatnfGz6D8b854TnWN4=
Received: by 10.86.54.3 with SMTP id c3mr4358370fga.1192390973047;
        Sun, 14 Oct 2007 12:42:53 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j2sm5739549mue.2007.10.14.12.42.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 12:42:52 -0700 (PDT)
Message-ID: <47127110.4060206@gmail.com>
Date:	Sun, 14 Oct 2007 21:42:08 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <20071011124410.GA17202@linux-mips.org>
In-Reply-To: <20071011124410.GA17202@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 11, 2007 at 11:52:30AM +0200, Franck Bui-Huu wrote:
> 
>> Other question: I noticed that the exit.data section is not
>> discarded. Could anybody give me the reason why ?
> 
> .exit.data and .exit.text may reference each other.  __exit functions
> generally get compiled into .exit.text but some constructs such as jump
> tables for switch() constructs may be compiled into address tables which
> gcc unfortunately will put into .rodata, so .rodata will end up
> referencing function addresses in .exit.text which makes ld unhappy if
> .exit.text was discarded.  So until this is fixed in gcc we can't
> discard exit code, unfortunately.
> 

Thanks for the details.

I actually don't see any point to move these tables in .rodata since
they're part of the code...

> It's actually an issue which doesn't strike very often, so users who are
> desparate for shrinking the kernel down could try to undo patchsets:
> 
>   6f0b1e5d266fb1d0da019c07b56ccc02c3a4f53a
>   ca7402fed2a76cd5a417ac4d375a5539dcb2b6de
> 
> and see if they can get away with it.  If the final kernel link succeeds,
> the build would be ok.
> 
> I think gcc should probably put the jump table into a .subsection if
> a section was explicitly requested, at least for non-PIC code.
> 

yes that would be great, and do the same for strings, data and we could
get rid of all __initxxx annotations.

		Franck
