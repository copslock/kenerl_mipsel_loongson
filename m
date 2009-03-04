Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 08:20:07 +0000 (GMT)
Received: from mail-bw0-f161.google.com ([209.85.218.161]:11931 "EHLO
	mail-bw0-f161.google.com") by ftp.linux-mips.org with ESMTP
	id S20808057AbZCDIUC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2009 08:20:02 +0000
Received: by bwz5 with SMTP id 5so3321613bwz.0
        for <multiple recipients>; Wed, 04 Mar 2009 00:19:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=lGXEOxqlUvUhIyniZDhZLqw8iFSzkmVqTBczFaoGz9Y=;
        b=hjZ34u3lS+mRXWTNJEKD+dIpEqBev8IYYwx6gra1BXaI+FEWRPCP8AU2Ej1qHiT7QS
         fPZt9UKndYK0k0YZra91p2o6pmStOA30oJLnHOTcysemvPJc5derOlEaE08QkKxJTzPe
         VRw+jnz5wPwr3DaOc3FWgFB0Z+JC8ak/CNXdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=yAK5Rqcdjes/4TP4oSbYG9+An2+eyxvmNYTtTwBfxiPwWnV1zhCxGWi41CeB5vGb2g
         Z5wbDdPmQBBsRf1+1FxmhKeGWb8FmlIHzfHooIhUhLJB7tmO7V/u1bEcUE8XxyKDfhvi
         KcYa0sNg5qQAl92/B98q+MykzvpcNn6QvgFZk=
Received: by 10.181.49.3 with SMTP id b3mr2883689bkk.21.1236154795855;
        Wed, 04 Mar 2009 00:19:55 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id 17sm14268659bwz.81.2009.03.04.00.19.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 00:19:54 -0800 (PST)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Date:	Wed, 4 Mar 2009 09:19:28 +0100
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Cc:	"Maciej W. Rozycki" <macro@codesourcery.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com>
In-Reply-To: <49AD6139.60209@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200903040919.29294.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Tuesday 03 March 2009 17:56:25 David Daney wrote:
>[ ... ]
> When (and if) we move the sigreturn trampoline to a vdso we should be
> able to maintain the ABI.

 it's more a matter of “when” rather than “if”.
 there is still an intention here to use XI (we
 have SmartMIPS), which requires not using the
 signal (or FP) trampoline on the stack.

 moving the signal trampoline to a vdso (which
 is(? was?) called, maybe misleadingly, ‘vsyscall’,
 on other architectures) is the obvious solution to
 that part of the puzzle.  and yes, it is possible
 to maintain the ABI; the signal trampoline is still
 also put on the stack, and modulo XI, would work if
 used — the trampoline-on-stack is simply not used
 if there is a vdso with the signal trampoline.

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
