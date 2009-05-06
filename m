Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:42:42 +0100 (BST)
Received: from smtp-out.google.com ([216.239.45.13]:47529 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024489AbZEFSmf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 19:42:35 +0100
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id n46IgVWe000717
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 11:42:32 -0700
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1241635352; bh=xHWjgJtHuWOwFnADuUENAcK9ZhQ=;
	h=DomainKey-Signature:MIME-Version:Sender:In-Reply-To:References:
	 Date:X-Google-Sender-Auth:Message-ID:Subject:From:To:Cc:
	 Content-Type:X-System-Of-Record; b=KlWe0yI+VVsUrMtM4EMqwGkR0cDp4qs
	6756rvgHlo1bsx52YLfmlafRhrQp3tnhQFXl/8J683W7nmYSY4fGWDQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:sender:in-reply-to:references:date:
	x-google-sender-auth:message-id:subject:from:to:cc:content-type:x-system-of-record;
	b=CPOUVrmzW9wHpCJDhJSb6ufIh4ePQKN/VfUdE8OuzLRbm3xLOeyiPNJfTzyUth9jE
	4Pc3SxlKItSdPA6Y6i7ag==
Received: from gxk2 (gxk2.prod.google.com [10.202.11.2])
	by spaceape7.eur.corp.google.com with ESMTP id n46IgIco017821
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 11:42:29 -0700
Received: by gxk2 with SMTP id 2so534680gxk.3
        for <linux-mips@linux-mips.org>; Wed, 06 May 2009 11:42:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.129.8 with SMTP id g8mr2848236ybn.104.1241635349046; Wed, 
	06 May 2009 11:42:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	 <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Date:	Wed, 6 May 2009 11:42:29 -0700
X-Google-Sender-Auth: 34f73dae9eb1fcd5
Message-ID: <904b25810905061142s4e8d6e28p98c2ee315bd6b57d@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From:	Markus Gutschke <markus@chromium.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001e680f10f0eba75f046942c16b
X-System-Of-Record: true
Return-Path: <markus@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus@chromium.org
Precedence: bulk
X-list: linux-mips

--001e680f10f0eba75f046942c16b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Feb 28, 2009 at 10:23, Linus Torvalds <torvalds@linux-foundation.org
> wrote:

> And I guess the seccomp interaction means that this is potentially a
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It
> does seem to be enabled in at least Fedora kernels, but it might not be
> used anywhere.
>

In the Linux version of Google Chrome, we are currently working on code that
will use seccomp for parts of our sandboxing solution.


Markus

--001e680f10f0eba75f046942c16b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2009 at 10:23, Linus Torvalds <span dir=3D"ltr">&lt;<a href=
=3D"mailto:torvalds@linux-foundation.org">torvalds@linux-foundation.org</a>=
&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">

And I guess the seccomp interaction means that this is potentially a<br>
2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It<b=
r>
does seem to be enabled in at least Fedora kernels, but it might not be<br>
used anywhere.<br></blockquote></div><br>In the Linux version of Google Chr=
ome, we are currently working on code that will use seccomp for parts of ou=
r sandboxing solution.<br><br><br>Markus<br>

--001e680f10f0eba75f046942c16b--
