Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 17:46:02 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:40246
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994542AbeIDPp72wi6B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2018 17:45:59 +0200
Received: by mail-it0-x243.google.com with SMTP id h23-v6so5368006ita.5
        for <linux-mips@linux-mips.org>; Tue, 04 Sep 2018 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZCq3fsoykODvc06c8DGlqnw6alow9yqLm2CgyNAQMI=;
        b=fxHSknQqjCNevmIcsd9V5qo2xDJJfPavarmOqbKb7ePq4cySOTWlc1lbbCXz01mQDa
         HZtXGBsOnQwGYt2VKcAVi5BiVyvmHCAviaCYWN8J9dSXSPzafM5oSqi/sPCa1X9lEhg7
         7llCULPaZ3zORBg7zyCykbBJSTS3m9iHrrY3IE6vL3X0Dt/SJ5vbE1m2SqKn90qOgafC
         TrmGJAVEhnwIRFXsOHzXuE9tUsELgatunT3j4KJT7oiTeVXsHt8dyFMuEahJEARlnj4h
         ai5K0PJ0D/RlWgynVdpz2F3vST4hUOaOVP0rm6Ursr185m37F9qozrD6qOwQo2MZkPRE
         +pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZCq3fsoykODvc06c8DGlqnw6alow9yqLm2CgyNAQMI=;
        b=M0y/2anipFZ7dc6G7Mtkp6JrOpcZxJUh0WCQamM4iyaz5nI4cQewDDpsR5Yx0u0b1K
         HAlCkHf61N+2mo2pnfPg3W1qHxRc8CJO1JjNZHAEE9+Jr+f1+olGypsXfr17l+ap+/DP
         8xFYwFrt+Hj+Jthtu3ftWeeoUZ42J3Al+Q7iQgTYSXRfciIxIrcK/QZN3DB8bp53DpN4
         Q6AjH1j44nASVUMhn3oGF5en892idC3cicU/AXgIL4TBurwjFLON5+1dejtYjHpsCTKD
         G0onI9fTQICcdvyOiNAdeaHphCsEU4JHbfK8AdQca1sBv+FHIsL5OC8tgVYewhPbB6C5
         iX9A==
X-Gm-Message-State: APzg51A3joU6NjaK/onTJxiHRRpuNCOcN9zyiEzfEsZWRK7cQfZ3LlyZ
        3qOPdtw3thuxpO9shzNxOQ9dsQ==
X-Google-Smtp-Source: ANB0Vday1g+n2udsgXujr+kp8wBF7ynIgDEx9IJNz4DQLQDvqqutB6BqwPm0b0yURtCCrXspIzOpkg==
X-Received: by 2002:a24:6c8a:: with SMTP id w132-v6mr707602itb.141.1536075952394;
        Tue, 04 Sep 2018 08:45:52 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u204-v6sm7063501itb.34.2018.09.04.08.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:45:51 -0700 (PDT)
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
To:     Henrik Austad <henrik@austad.us>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jan Kandziora <jjj@gmx.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, linux-security-module@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, kvm@vger.kernel.org,
        Henrik Austad <haustad@cisco.com>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cab5289c-7c53-28a8-b9b2-0c55c9f8d968@kernel.dk>
Date:   Tue, 4 Sep 2018 09:45:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <axboe@kernel.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: axboe@kernel.dk
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

On 9/3/18 4:15 PM, Henrik Austad wrote:
> This is a respin with a wider audience (all that get_maintainer returned)
> and I know this spams a *lot* of people. Not sure what would be the correct
> way, so my apologies for ruining your inbox.
> 
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise
> anyone what Documentation/sched/sched-design-CFS.txt covers)
> 
> A few years back it was mentioned that these files were no longer really
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.
> 
> A short status yields the following _outdated_ 00-INDEX files, first
> counter is files listed in 00-INDEX but missing in the directory, last
> is files present but not listed in 00-INDEX.

For the block related bits:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
