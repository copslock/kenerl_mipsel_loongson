Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 22:27:17 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:1233 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825729Ab3FUU1LeB31p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jun 2013 22:27:11 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5LKR2rP003678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 21 Jun 2013 16:27:02 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-192.brq.redhat.com [10.34.1.192])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r5LKQvlK009425;
        Fri, 21 Jun 2013 16:26:58 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Fri, 21 Jun 2013 22:22:48 +0200 (CEST)
Date:   Fri, 21 Jun 2013 22:22:44 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Message-ID: <20130621202244.GA16610@redhat.com>
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com> <51C47864.9030200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C47864.9030200@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37095
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

On 06/21, David Daney wrote:
>
> On 06/21/2013 06:39 AM, James Hogan wrote:
>> Therefore add sig_to_exitcode() and exitcode_to_sig() functions which
>> map signal numbers > 126 to exit code 126 and puts the remainder (i.e.
>> sig - 126) in higher bits. This allows WIFSIGNALED() to return true for
>> both SIG127 and SIG128, and allows WTERMSIG to be later updated to read
>> the correct signal number for SIG127 and SIG128.
>
> I really hate this approach.
>
> Can we just change the ABI to reduce the number of signals so that all
> the standard C library wait related macros don't have to be changed?
>
> Think about it, any user space program using signal numbers 127 and 128
> doesn't work correctly as things exist today, so removing those two will
> be no great loss.

Oh, I agree.

Besides, this changes ABI anyway. And if we change it we can do this in
a more clean way, afaics. MIPS should simply use 2 bytes in exit_code for
signal number. Yes, this means we need replace 0x80/0x7f in exit.c by
ifdef'ed numbers. And yes, this means that WIFSIGNALED/etc should be
updated too, but this is also true with this patch.

Oleg.
