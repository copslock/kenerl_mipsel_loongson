Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:42:26 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35626 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008086AbbK3QmYOgjae (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:42:24 +0100
Received: by pacej9 with SMTP id ej9so189671293pac.2
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DtKKNEB9Wd6iSiiYT31DgJnFmcpkY+yrzzPPo1eTwGg=;
        b=W0BPuAeWJeLORHva55ktRrG5++tiMMb23JZKW+4gB14b5qhLrgUQh40MKmSkLiD7No
         eWnk3y3MgfW8cUTRSNNYWsVlahx1dG4zWEcYU/X3aKF4KXY7+u2G2TMyiIdIleMk2qw5
         k2vyi5T5mhuGvK3zizPTSkm0B1iU/kRbj9JyinNb8shWwOVhYnVgoNNK5g24ejZ6DO1Y
         rR8evD97QY0sdArkJwuVQa2hIKFdMgYg+vDof39IJfD9emKCwFYQI2E9zUPXqZzpntSu
         fLkdfZrT4gTdL4W3zuQ+0LMhhsY1P5dIU+kL7CjVbIcAwl5CXfvfEDYY1zZ0vvBtcGxP
         PC0A==
X-Received: by 10.98.71.92 with SMTP id u89mr70880620pfa.143.1448901738298;
        Mon, 30 Nov 2015 08:42:18 -0800 (PST)
Received: from [17.114.48.58] ([17.114.48.58])
        by smtp.gmail.com with ESMTPSA id q129sm52279233pfq.19.2015.11.30.08.42.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 08:42:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary buffer
From:   yalin wang <yalin.wang2010@gmail.com>
In-Reply-To: <1448622572-16900-6-git-send-email-pmladek@suse.com>
Date:   Mon, 30 Nov 2015 08:42:04 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com> <1448622572-16900-6-git-send-email-pmladek@suse.com>
To:     Petr Mladek <pmladek@suse.com>
X-Mailer: Apple Mail (2.3094)
Return-Path: <yalin.wang2010@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yalin.wang2010@gmail.com
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


> On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> 
> Testing has shown that the backtrace sometimes does not fit
> into the 4kB temporary buffer that is used in NMI context.
> 
> The warnings are gone when I double the temporary buffer size.
> 
> Note that this problem existed even in the x86-specific
> implementation that was added by the commit a9edc8809328
> ("x86/nmi: Perform a safe NMI stack trace on all CPUs").
> Nobody noticed it because it did not print any warnings.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> kernel/printk/nmi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> index 8af1e4016719..6111644d5f01 100644
> --- a/kernel/printk/nmi.c
> +++ b/kernel/printk/nmi.c
> @@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
> struct nmi_seq_buf {
> 	atomic_t		len;	/* length of written data */
> 	struct irq_work		work;	/* IRQ work that flushes the buffer */
> -	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> +	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
> 				       sizeof(struct irq_work)];
> };
> 

why not define like this:

union {
struct {atomic_t		len;	
	struct irq_work		work;
}
unsigned char		buffer[PAGE_SIZE * 2] ;
}

we can make sure the union is 2 PAGE_SIZE .

Thanks
