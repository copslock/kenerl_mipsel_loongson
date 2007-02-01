Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 14:55:47 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.235]:24938 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038949AbXBAOzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 14:55:42 +0000
Received: by qb-out-0506.google.com with SMTP id e12so52977qba
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 06:54:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SkXTeqZBbeJGcCiYhNhC/PoV6re7nKjS4LjRWGbS8liZ97x8boKrro7CSL1oUP2U5rthwbD/dw3dzU7qRBXTmL7DywdgymaCH81PpNev1EWU1q4aK5WhJC3aUkOM72AqdOilvje0KePFhXlRfTAoWixIpl07MLF68BnzGa1IewA=
Received: by 10.114.75.1 with SMTP id x1mr151496waa.1170341680550;
        Thu, 01 Feb 2007 06:54:40 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Thu, 1 Feb 2007 06:54:40 -0800 (PST)
Message-ID: <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
Date:	Thu, 1 Feb 2007 15:54:40 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Question about signal syscalls !
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070201135734.GB12728@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
	 <20070201135734.GB12728@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On 2/1/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> The values of those registers need to be preserved so they can later be
> copied into the signal frame.
>

Let's take for example sys_sigreturn(). In my understanding this
syscall is used automatically when the signal handler returns. At this
time, I don't see the point to save the static registers since they
have been already saved by setup_sigcontext().

Actually I don't see why they need to be saved/restored at all...

Let's say that process P1 sends a signal X to process P2 which has a
handler defined for signal X and assume that the static registers are
not saved at all.

Signal X is received by P2. The signal handler is now executed in user
mode. At this point what are the values of the static registers ? I
would say they have the same values (let's call this state S) when P2
got interrupted. Once the signal handler returns into the kernel mode
by executing 'syscall __NR_sigreturn' instructions, static registers
still have state S and this state is normally preserved during
sys_sigreturn syscall execution. So when resuming the normal execution
of P2, the static registers have the correct values.

What am I missing ?

Thanks
-- 
               Franck
