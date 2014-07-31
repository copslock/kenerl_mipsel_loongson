Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 18:44:49 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:39013 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6842577AbaGaQorauEHA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 18:44:47 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6VGiVtN001224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jul 2014 12:44:31 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6VGiRfr009651;
        Thu, 31 Jul 2014 12:44:28 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Thu, 31 Jul 2014 18:42:50 +0200 (CEST)
Date:   Thu, 31 Jul 2014 18:42:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Message-ID: <20140731164246.GA15974@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net> <20140729193232.GA8153@redhat.com> <20140730164344.GA27954@localhost.localdomain> <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com> <20140731151630.GA7842@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140731151630.GA7842@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 07/31, Frederic Weisbecker wrote:
>
> On Wed, Jul 30, 2014 at 10:23:34AM -0700, Andy Lutomirski wrote:
> >
> > At the end of the day, the syscall slowpath code calls a bunch of
> > functions depending on what TIF_XYZ flags are set.  As long as it's
> > structured like "if (TIF_A) do_a(); if (TIF_B) do_b();" or something
> > like that, it's comprehensible.  But once random functions with no
> > explicit flag checks or comments start showing up, it gets confusing.
>
> Yeah that's a point. I don't mind much the TIF_NOHZ test if you like.

And in my opinion

	if (work & TIF_XYZ)
		user_exit();

looks even more confusing. Because, once again, TIF_XYZ is not the
reason to call user_exit().

Not to mention this adds a minor performance penalty.

> > If it's indeed all-or-nothing, I could remove the check and add a
> > comment.  But please keep in mind that, currently, the slow path is
> > *slow*, and my patches only improve the entry case.  So enabling
> > context tracking on every task will hurt.
>
> That's what we do anyway. I haven't found a safe way to enabled context tracking
> without tracking all CPUs.

And if we change this, then the code above becomes racy. The state of
TIF_XYZ can be changed right after the check. OK, it is racy anyway ;)
but still this adds more confusion.

I feel that TIF_XYZ must die. But yes, yes, I know that it is very simple
to say this. And no, so far I do not know how we can improve this all.


But again, again, I won't insist. Just another "can't resist" email,
please ignore.

Oleg.
