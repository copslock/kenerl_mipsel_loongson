Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 08:55:12 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.227]:10908 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039085AbXBBIzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 08:55:08 +0000
Received: by qb-out-0506.google.com with SMTP id e12so113653qba
        for <linux-mips@linux-mips.org>; Fri, 02 Feb 2007 00:54:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=flzg7reEl1jrC2oWaZxSEiko8xJef0Fb1IBKYIsR1nnBUfRP0aGnxeY3H/VLjr/7MJFr6w7iEQPYtA74J/I5iRaVt8lN2qi+Ug3lQcve1pUQn+NtdT2Exmp0C4hxRpgzs/IUU9Gwes4cgfliRymKZK9qHJu4mSeAK6/VTI1pD+0=
Received: by 10.114.161.11 with SMTP id j11mr273696wae.1170406445963;
        Fri, 02 Feb 2007 00:54:05 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Fri, 2 Feb 2007 00:54:05 -0800 (PST)
Message-ID: <cda58cb80702020054h2973dd10u6e7421529439283@mail.gmail.com>
Date:	Fri, 2 Feb 2007 09:54:05 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Question about signal syscalls !
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070201181028.GA16964@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
	 <20070201135734.GB12728@linux-mips.org>
	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
	 <20070201181028.GA16964@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/1/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Feb 01, 2007 at 03:54:40PM +0100, Franck Bui-Huu wrote:
>
> > Let's take for example sys_sigreturn(). In my understanding this
> > syscall is used automatically when the signal handler returns. At this
> > time, I don't see the point to save the static registers since they
> > have been already saved by setup_sigcontext().
> >
> > Actually I don't see why they need to be saved/restored at all...
>
> There is no need.  Seems you found a harmless but longstanding but
> introduced by c40738a70f3e02e8554b78af334dc95356a78989.
>

OK. Just to be sure about what you meant, there are currently 2 places
where we save s0-s7 regs. One in setup_sigcontext() and one done by
save_static_function(). Do you mean that both savings are useless ?
It's actually what I'm thinking and if so
setup_sigcontext()/restore_sigcontext() have a harmless bug too.

-- 
               Franck
