Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:46:36 +0100 (BST)
Received: from smtp-out.google.com ([216.239.45.13]:47909 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024498AbZEFSq3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 19:46:29 +0100
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id n46IkRdq028848
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 11:46:27 -0700
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1241635588; bh=Q+b/Cs+fXaDVVEvdP3PKlSD0wvU=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=LLWlJgYDqD/+O6t64S
	94iXOMvBke4XwAHkI+kNyPCVIJXlKsJV/24plAr3cRz2QRuLD4KsI7uZQtkagFvncoe
	A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=q8oC4wIOhKToS6RK0kv7SFiCUWBJ/mj+/cHDBwGiQEto6ZvkY/1yVDbZQpioTAg2f
	pN1fZvu/fvUXnDGKYwkvA==
Received: from gxk24 (gxk24.prod.google.com [10.202.11.24])
	by zps77.corp.google.com with ESMTP id n46IkOtu030043
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 11:46:25 -0700
Received: by gxk24 with SMTP id 24so643183gxk.10
        for <linux-mips@linux-mips.org>; Wed, 06 May 2009 11:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.133.10 with SMTP id k10mr1157642ybn.225.1241635584390; 
	Wed, 06 May 2009 11:46:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	 <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Date:	Wed, 6 May 2009 11:46:24 -0700
Message-ID: <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From:	=?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?= 
	<markus@google.com>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-System-Of-Record: true
Return-Path: <markus@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus@google.com
Precedence: bulk
X-list: linux-mips

On Sat, Feb 28, 2009 at 10:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And I guess the seccomp interaction means that this is potentially a
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It
> does seem to be enabled in at least Fedora kernels, but it might not be
> used anywhere.

In the Linux version of Google Chrome, we are currently working on
code that will use seccomp for parts of our sandboxing solution.


Markus
