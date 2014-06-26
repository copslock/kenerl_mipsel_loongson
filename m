Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 14:37:22 +0200 (CEST)
Received: from mail-wg0-f73.google.com ([74.125.82.73]:59366 "EHLO
        mail-wg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860036AbaFZMhSEHb1c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 14:37:18 +0200
Received: by mail-wg0-f73.google.com with SMTP id b13so357487wgh.4
        for <linux-mips@linux-mips.org>; Thu, 26 Jun 2014 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WJJLzoKtHRsLX63zBjvhkPte8WIkTtg1XKamPF1nlEQ=;
        b=n1czxBWwwQEgcG7cbwcBnE8mF57JKCxX6zmx3+TQuhJja2bBrSXX1phTNBM7HJwNeX
         IARU8pfJXM6s+w6iR/u+aIawSdv1cGQO1ClMf45kW9CqGAI3uLdQXVwJeUQsmWGx9Qps
         r1kVndOdiQISHyGLp5iuKTQcYb6NpOfBfawlPF4QZlXcjT1z8Rvr2N90SnrufLofCTki
         5bEEOFRiQt8nZy7uvj2nOKKjrnn5au4J0Ol7yKexqIqAjoWHAWdFz+tz+oDSpC0x51Df
         Nh4QvuSbbRP/9+WjwQAud1BSbkjzc/B+4Leg0tO05QgxwaIUl5iyeMM/Poc/sQv6rRfk
         JqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WJJLzoKtHRsLX63zBjvhkPte8WIkTtg1XKamPF1nlEQ=;
        b=Ed5mJyyj++vHd9p8KANHRa4DE6W0gPN7aPQntPbiEnCd5sSnSVNwRKvA9SmMUvE2RB
         wXpqIY0QHAc/lrYscxxwu/YSp/OEMtxXSB+CEfe0cWYUFrG3ZyyOeNqhF463ZoZo0gCT
         wKtAC5GtmYJZZ8++ce4IgSUn/+FaIXIcPpExR4WAob47GTU0GkxMUW4u9U1zq/D8s/zo
         +7SoFNA8Ewcz8qGwDPrlJwCt3WP5pibiCwSDlmVxUt/Ms14SUiXtXjM/BErQ7K4D48b1
         gPyBlCatbFltotEKlEX0LYywR/Ra9vrhIZKWPmXMs2OIAwmnODjkb3ItkEhRjBqDyfqq
         kPmA==
X-Gm-Message-State: ALoCoQnmCyeEPkNF4Bwbo5iO080ul354qpsYVdLTaqlzy27owj4LU14v0lnTTy4XxOG8YNNnd0/e
X-Received: by 10.180.39.196 with SMTP id r4mr442875wik.4.1403786231887;
        Thu, 26 Jun 2014 05:37:11 -0700 (PDT)
Received: from corp2gmr1-1.eem.corp.google.com (corp2gmr1-1.eem.corp.google.com [172.25.138.99])
        by gmr-mx.google.com with ESMTPS id l9si230811wiy.2.2014.06.26.05.37.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jun 2014 05:37:11 -0700 (PDT)
Received: from drysdale.lon.corp.google.com (drysdale.lon.corp.google.com [172.16.7.77])
        by corp2gmr1-1.eem.corp.google.com (Postfix) with ESMTP id AE78B1CA380;
        Thu, 26 Jun 2014 05:37:11 -0700 (PDT)
Received: by drysdale.lon.corp.google.com (Postfix, from userid 172398)
        id D005AE0C1B; Thu, 26 Jun 2014 13:37:10 +0100 (BST)
Date:   Thu, 26 Jun 2014 13:37:10 +0100
From:   David Drysdale <drysdale@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 2/9] seccomp: split filter prep from check and apply
Message-ID: <20140626123710.GA16204@google.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-3-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1403560693-21809-3-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <drysdale@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drysdale@google.com
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

On Mon, Jun 23, 2014 at 02:58:06PM -0700, Kees Cook wrote:
> In preparation for adding seccomp locking, move filter creation away
> from where it is checked and applied. This will allow for locking where
> no memory allocation is happening. The validation, filter attachment,
> and seccomp mode setting can all happen under the future locks.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/seccomp.c |   97 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 67 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index afb916c7e890..edc8c79ed16d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -515,6 +551,7 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>  	current->seccomp.mode = seccomp_mode;
>  	set_thread_flag(TIF_SECCOMP);
>  out:
> +	seccomp_filter_free(prepared);
>  	return ret;
>  }

I think this needs to be inside #ifdef CONFIG_SECCOMP_FILTER to match
the definition of seccomp_filter_free:

../kernel/seccomp.c:554:2: error: implicit declaration of function ‘seccomp_filter_free’ [-Werror=implicit-function-declaration]
