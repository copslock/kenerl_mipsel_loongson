Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 19:58:39 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.240]:44492 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20039258AbXBBT6f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 19:58:35 +0000
Received: by an-out-0708.google.com with SMTP id c8so680760ana
        for <linux-mips@linux-mips.org>; Fri, 02 Feb 2007 11:58:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJqwlcZIwgjWRIky8gcBWBnzNj/Oktg/28h3BqsvjtOvCSrYFJ2NFy0KhePCC6ja63AHWK5sFL7FG0Afk+FQ2f6iN35Poh88uTIdhMlQmDfcozQmMl5Kog4IIYA5C+cIUZ4Il+E/42uCPR5UXS30TcMi76yvqs4xsKy/95gc+Dc=
Received: by 10.114.108.15 with SMTP id g15mr363744wac.1170446311937;
        Fri, 02 Feb 2007 11:58:31 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Fri, 2 Feb 2007 11:58:31 -0800 (PST)
Message-ID: <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com>
Date:	Fri, 2 Feb 2007 20:58:31 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"David Daney" <ddaney@avtrex.com>
Subject: Re: Question about signal syscalls !
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <45C36D46.5040409@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
	 <20070201135734.GB12728@linux-mips.org>
	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
	 <45C21CFE.9060804@avtrex.com>
	 <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
	 <45C3611D.7000702@avtrex.com>
	 <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
	 <45C36D46.5040409@avtrex.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/2/07, David Daney <ddaney@avtrex.com> wrote:
> Franck Bui-Huu wrote:
> > David Daney wrote:
> >> The entire user context (i.e. the value of *all* registers) is replaced
> >> with the values stored in the sigcontext structure on the caller's
> >> stack.  If all registers are being restored from the sigcontext, then
> >> there is no need to save the current values of the registers, because
> >> they will never be used.
> >>
> >

Again, why do you think that all values of the registers are saved on
sys_sigreturn() ?


> > And now I'm starting to think that we don't need to save static regs in
> > setup_sigcontext() either...
> >
> All registers *must* be saved in the sigcontext.  That is part of the
> contract the kernel has with user code.
>

I'm just talking about _static_ registers which are s0-s7...

> On return from an asynchronous signal, *all* registers must contain the
> same values they had before the process was interrupted.
>

yes I agree and I've never said the contrary.
-- 
               Franck
