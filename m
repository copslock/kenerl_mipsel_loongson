Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 11:36:48 +0100 (CET)
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34555 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013774AbbLNKgrCS942 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 11:36:47 +0100
Received: by mail-wm0-f47.google.com with SMTP id p66so55276212wmp.1;
        Mon, 14 Dec 2015 02:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=4NngPqTgsspC0+Awkp9E/B6rAsPyMxsWeOwjBYIh/R4=;
        b=OmzRX0fBx7aUdC9gUEaFHlbMsHLmPlZ9OBLsdzmnhIA5IUMKKVWit5M6JnaOUmxtG9
         D9A/DWfxmm3CXmq+Y73oqunLD9RnRFuHuOOBcQSOqk1xgQnBcW9acLX1u46xEBAYCWTC
         xtBpPZoibeq5m+jTW+hE8lEeccai+lVL9qs1lxJr49+q7qhbJUmeSNbNJlVmn5VzphB0
         s4vCruHW2Q0AE4hpzlQE+Vi9W0XlR9XlwyNCDcIkoJt/+lUkirNUY7Kmj/IjBaAYrr+3
         anTR3Tn1AN34NXPh55ewyQDdS5y2MSt3VslO8ZZSbHfBQdWwwHFcdJSjUWDIlGDaHnZw
         3aMg==
X-Received: by 10.194.235.138 with SMTP id um10mr27770152wjc.91.1450089401885;
        Mon, 14 Dec 2015 02:36:41 -0800 (PST)
Received: from ?IPv6:2a01:4240:2e27:ad85::19f? (f.9.1.0.0.0.0.0.0.0.0.0.0.0.0.0.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85::19f])
        by smtp.gmail.com with ESMTPSA id w203sm15393256wmg.15.2015.12.14.02.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2015 02:36:40 -0800 (PST)
Subject: Re: [PATCH backport v3.12..v3.14 2/4] MIPS: KVM: Fix ASID restoration
 logic
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <1449853615-6535-1-git-send-email-james.hogan@imgtec.com>
 <1449853615-6535-2-git-send-email-james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <566E9BB7.5000101@suse.cz>
Date:   Mon, 14 Dec 2015 11:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1449853615-6535-2-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 12/11/2015, 06:06 PM, James Hogan wrote:
> commit 002374f371bd02df864cce1fe85d90dc5b292837 upstream.

Applied 2/4 -- 4/4 to 3.12. Thanks.

-- 
js
suse labs
