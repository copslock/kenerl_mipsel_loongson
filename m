Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 22:09:32 +0200 (CEST)
Received: from mail-ea0-f177.google.com ([209.85.215.177]:53618 "EHLO
        mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816384Ab3F1UJbYZJbx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 22:09:31 +0200
Received: by mail-ea0-f177.google.com with SMTP id j14so1227304eak.8
        for <multiple recipients>; Fri, 28 Jun 2013 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=SZR8wzkSG7wMox+TH3G6n9r2clYZ6Z353+d1THPnVgw=;
        b=qhW6Yr6K4jcsOHQkXAyGdWhSUOaiQNmRyvsXKNEWd20c6XbMN60MKOdcUrlNcg3qpM
         lkGoU3X926j0A2lTZ+KZmzkqLLTVdVNnk4igG+ESVlNTtiCF2WBjuD/3QSVrUuaUoNmH
         PCD2vTTnH/F07K+xaKNc7kp6ZrFuxVE+cxgxC//YxTMevSBrkueO1vwOCOSmV8+kNjbF
         JyoTNWzCJQiAiaWmgHbFEwAO9KScBfrAlwjDhxZ9aLjkPfkqiOmp9Bx7myCmBHwIiEbO
         5gn9gBlxF6MeUO445+UffGcPvvbUlE6w9aFLkNqus3Fmkt8BTeL9b9gZ1uVRucIorBZO
         CS2w==
X-Received: by 10.15.111.135 with SMTP id cj7mr15179992eeb.144.1372450166084;
        Fri, 28 Jun 2013 13:09:26 -0700 (PDT)
Received: from shadow (161.196.broadband4.iol.cz. [85.71.196.161])
        by mx.google.com with ESMTPSA id e44sm12525312eeh.11.2013.06.28.13.09.23
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 13:09:25 -0700 (PDT)
From:   Denys Vlasenko <vda.linux@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Date:   Fri, 28 Jun 2013 22:09:21 +0200
User-Agent: KMail/1.8.2
Cc:     Oleg Nesterov <oleg@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com> <20130626161452.GA2888@redhat.com> <20130626165900.GF7171@linux-mips.org>
In-Reply-To: <20130626165900.GF7171@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201306282209.21839.vda.linux@googlemail.com>
Return-Path: <vda.linux@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vda.linux@googlemail.com
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

On Wednesday 26 June 2013 18:59, Ralf Baechle wrote:
> On Wed, Jun 26, 2013 at 06:14:52PM +0200, Oleg Nesterov wrote:
> 
> > Or simply remove the BUG_ON(), this can equally confuse wait(status).
> > 128 & 0x7f == 0.
> > 
> > Still I think it would be better to change _NSIG on mips.
> 
> If it was that easy.  That's going to outright break binary compatibility,
> see kernel/signal.c:
> 
> SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
>                 sigset_t __user *, oset, size_t, sigsetsize)
> {
>         sigset_t old_set, new_set;
>         int error;
> 
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
>         if (sigsetsize != sizeof(sigset_t))
>                 return -EINVAL;
> 
> There are several more more syscalls performing tests like the above.

Reducing _NSIG to 127 (or 126) doesn't change sigset_t, so should be fine wrt above.
