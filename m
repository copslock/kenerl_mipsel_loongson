Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 22:44:41 +0100 (BST)
Received: from wx-out-0102.google.com ([66.249.82.201]:22886 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133865AbWFMVoc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jun 2006 22:44:32 +0100
Received: by wx-out-0102.google.com with SMTP id t5so982258wxc
        for <linux-mips@linux-mips.org>; Tue, 13 Jun 2006 14:44:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=uT/8hinHjL++OaDcBc7vASg320Vte8RbAJ1+UNZ7y+FZZdnFLg2A1kE8RAY9fGs+88y1vTIaKhqh08EGqMgPxv/cS4QiD8/IpwDET5Cd4gXZwzsHk8x5Q26NuJhlWCyyXmJBHAnCGwXM1zU4MgBF0NBmAUeKbZzKijj6gwFPmNc=
Received: by 10.70.7.5 with SMTP id 5mr7930147wxg;
        Tue, 13 Jun 2006 14:44:28 -0700 (PDT)
Received: by 10.70.73.1 with HTTP; Tue, 13 Jun 2006 14:44:28 -0700 (PDT)
Message-ID: <e8180c7f0606131444g2b9f1703s2ef21f1ff1fb0880@mail.gmail.com>
Date:	Tue, 13 Jun 2006 14:44:28 -0700
From:	"Prasad Boddupalli" <bprasad@cs.arizona.edu>
To:	"Jonathan Day" <imipak@yahoo.com>
Subject: Re: Performance counters and profiling on MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060613212743.64709.qmail@web31506.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060612225848.GA7163@linux-mips.org>
	 <20060613212743.64709.qmail@web31506.mail.mud.yahoo.com>
X-Google-Sender-Auth: fc5e28bfe1d559bd
Return-Path: <p.boddupalli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bprasad@cs.arizona.edu
Precedence: bulk
X-list: linux-mips

Perfctr (http://user.it.uu.se/~mikpe/linux/perfctr/) and PAPI
(http://icl.cs.utk.edu/papi/) are precisely such attempts. Except that
MIPS ports of them do not seem to be available.

regards,
Prasad.

On 6/13/06, Jonathan Day <imipak@yahoo.com> wrote:
> Thank you for the valuable information.
>
> One thing I'd like to throw open to the list: there's
> one way to access the counters on the R4000-type
> processors, another on the version 2 MIPS64, yet
> another on the ix86, and so on.
>
> Would it make sense to place some standardised
> interface in, say, the assembly header files and hide
> the implementation-specific details? In the case of
> the R4000-type cores, this would need to involve some
> sort of counter device in the kernel which the macro
> would call to perform the priviledged instruction. (It
> feels a little bit of a hack, but it's the simplest
> way to provide access to resources that aren't made
> public.)
>
> What I'm thinking is that this generic interface would
> then be used on all other architectures, where such
> counters exist. That way, implementation-specific
> stuff can be abstracted out and programs that need
> access to performance counters can all be coded to a
> generic interface, rather than one interface for each
> version of every CPU API, which is inevitably going to
> be far more prone to error.
>
> Jonathan
