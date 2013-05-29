Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 19:20:20 +0200 (CEST)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:46553 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835082Ab3E2RTmmgf-2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 May 2013 19:19:42 +0200
Received: by mail-pb0-f54.google.com with SMTP id ro12so9435493pbb.27
        for <multiple recipients>; Wed, 29 May 2013 10:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DqNdopBX7P/sLKx3ImUv26B035cHsY1opiPMQSu7DZM=;
        b=l1c3UwrNyGIMBgiRcMJNpGJ5fMgMYg8/PCZdeYzsHmkTNVeVdmZG32ZMjs9Tjk81Iy
         KYpZGXiqi1/q4vAR2PUvOQlFUSELadU69ODtL9uUtjwwep4pnLxTymfxzg0N+WhEjnyI
         +kb4UJX/XeiTFHQSnKEfwg21B8uapQBo4ay5DdC0DkVsYL5/+ftRLNoZMNBC93MvGsM2
         ye757xfTX6iuj8DBcjG5CKc3UP5fjJ9Y/CpvqlhsuXitSQzSe70ivVwCde3SnMOUeMEQ
         UQC/ja1En1l+CCsrbStiJW4ok6yLsioybn9+x91ITwZwhiCuq8WzWdkkCDd+wPXgVtFw
         rfaQ==
X-Received: by 10.68.178.229 with SMTP id db5mr3879090pbc.79.1369847974945;
        Wed, 29 May 2013 10:19:34 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qh4sm40671267pac.8.2013.05.29.10.19.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 10:19:33 -0700 (PDT)
Message-ID: <51A638A4.2000705@gmail.com>
Date:   Wed, 29 May 2013 10:19:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS)
References: <1369846916-13202-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1369846916-13202-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/29/2013 10:01 AM, James Hogan wrote:
> MIPS has 128 signals, the highest of which has the number 128. The

I wonder if we should change the ABI and reduce the number of signals to 
127 instead of this patch.

David Daney



> following command causes get_signal_to_deliver() to pass this signal
> number straight through to do_group_exit() as the exit code:
>
>    strace sleep 10 & sleep 1 && kill -128 `pidof sleep`
>
> However do_group_exit() checks for the core dump bit (0x80) in the exit
> code which matches in this particular case and the kernel panics:
>
>    BUG_ON(exit_code & 0x80); /* core dumps don't get here */
>
> This is worked around by changing get_signal_to_deliver() to pass
> min(info->si_signo, 127) instead of info->si_signo, so that this highest
> of signal numbers get rounded down to 127. This makes the exit code
> technically incorrect, but it's better than killing the whole kernel.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>
> This is based on v3.10-rc3.
>
> It's a little hacky, but aside from reducing the number of signals to
> 127 to avoid this case (which isn't backwards compatible) I'm not sure
> what else can be done. Any comments?
>
>   kernel/signal.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 113411b..69bc00f 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2366,8 +2366,12 @@ relock:
>
>   		/*
>   		 * Death signals, no core dump.
> +		 *
> +		 * MIPS has a signal number 128 which clashes with the core dump
> +		 * bit. If this was the signal we still want to report a valid
> +		 * exit code, so round it down to 127.
>   		 */
> -		do_group_exit(info->si_signo);
> +		do_group_exit(min(info->si_signo, 127));
>   		/* NOTREACHED */
>   	}
>   	spin_unlock_irq(&sighand->siglock);
>
