Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 19:00:06 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:50138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860183AbaGaRAEioSaG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 19:00:04 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6VGxn50008037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jul 2014 12:59:53 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6VGxkRp010046;
        Thu, 31 Jul 2014 12:59:46 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Thu, 31 Jul 2014 18:58:07 +0200 (CEST)
Date:   Thu, 31 Jul 2014 18:58:04 +0200
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
Message-ID: <20140731165804.GB16800@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net> <20140729193232.GA8153@redhat.com> <20140730164344.GA27954@localhost.localdomain> <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com> <20140731151630.GA7842@localhost.localdomain> <20140731164246.GA15974@redhat.com> <20140731164918.GC7842@localhost.localdomain> <20140731165423.GA16800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140731165423.GA16800@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41847
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

On 07/31, Oleg Nesterov wrote:
>
> On 07/31, Frederic Weisbecker wrote:
> >
> > On Thu, Jul 31, 2014 at 06:42:46PM +0200, Oleg Nesterov wrote:
> > >
> > > And if we change this, then the code above becomes racy. The state of
> > > TIF_XYZ can be changed right after the check. OK, it is racy anyway ;)
> > > but still this adds more confusion.
> >
> > No because all running tasks have this flag set when context tracking is
> > enabled. And context tracking can't be disabled on runtime.
>
> Yes, yes, please note that I said "if we change this".

And "it is racy anyway" connects to the problems we discuss in another
thread.

Oleg.
