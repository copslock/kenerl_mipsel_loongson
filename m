Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2016 02:35:31 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36816 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027146AbcD0Af1XMEF8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Apr 2016 02:35:27 +0200
Received: by mail-pa0-f43.google.com with SMTP id bt5so12579646pac.3
        for <linux-mips@linux-mips.org>; Tue, 26 Apr 2016 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAGm62OqMRH6+lOgkOMN/RdwsYRuuG71l3LG8zNekLU=;
        b=BsX1ELScwMAxhyo8nBnXashvP8O85df6CzjZox5cTQaPjgcsRoZYIga8bS9bDFpqWo
         FijRZwYk1a9Ur6KXE90L/VVZCqhJNHuDC7OTnVQXs6YVGYChLV8RtjI/z7mDRtD2G6y3
         78WLQ0/KfoQ4UsAMP8iJQB4sAeW7bFPnyE8XvJtB7QUCbc6tUtuA/7EwzsGY6DeHvGw3
         vOH4oF3iY4avfaneKo1RZcwIb+A00eTPlCnzfRA7ku3vYFjWBmk5jpPjneYaieTJ9289
         gPgSiX8H9T7GNF/qFwaS8GnHNkGFnXwpWNjwSuEg5Uy8gnPfH/CPjkpWZjlKMnaUWtMq
         uTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAGm62OqMRH6+lOgkOMN/RdwsYRuuG71l3LG8zNekLU=;
        b=UTQOs+jxKtBD5QeG4diPk4u4JU2lRT8DJyhXZ3zutN+K1mZokLR8SeHUhv+bY+uuY/
         mmEY/WlB/pKrH0hUwXLXnF0Y3eRusdvh2VPD2KzQEDJQQp/hJ61drbCctmMxgUMi9JWm
         HjwNljKfrcBUFJpKtH/JLcQe4S38T6qvFSQMPDEgfEMwfpCleuaQy2EGx6Dpk4M1sSzz
         ySD1dmlScHLPfBSFyvDtErBRzzMstOvW+0AJaawmkpP3qZzew02Q5R+/Jet/0J0LlGBP
         aTE/lHyireABWpyVlZRABKZAfZl4UFy7zJDvrNAkpcEYaxbEWCtEnFpVT/3gWwC6Qj0e
         psNw==
X-Gm-Message-State: AOPr4FW1KjH5i2jMZ3C5BKe6bAOjJw8P2DcvIWxgaMEgPTTEiGgiy8x1uBnzi4Vj5t0w0Q==
X-Received: by 10.66.218.161 with SMTP id ph1mr7650398pac.83.1461717321615;
        Tue, 26 Apr 2016 17:35:21 -0700 (PDT)
Received: from localhost ([110.70.50.108])
        by smtp.gmail.com with ESMTPSA id m184sm1191026pfb.22.2016.04.26.17.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 17:35:20 -0700 (PDT)
Date:   Wed, 27 Apr 2016 09:36:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Cleaning printk stuff in NMI context
Message-ID: <20160427003654.GB4782@swordfish>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461239325-22779-1-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergey.senozhatsky.work@gmail.com
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

On (04/21/16 13:48), Petr Mladek wrote:
> v5 adds changes suggested by Sergey Senozhatsky. It should not longer
> conflict with his async printk patchset.

passes my tests. (apart from that cosmetic-nano-nit) the series
looks good to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
