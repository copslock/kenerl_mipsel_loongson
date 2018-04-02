Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Apr 2018 07:59:51 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:42794
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeDBF7oeYzwg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Apr 2018 07:59:44 +0200
Received: by mail-wr0-x243.google.com with SMTP id s18so12425625wrg.9;
        Sun, 01 Apr 2018 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8S9j2GGiF6Hq0Ve0gp08kcpf5x+zmb5JGAyHhh8nX3A=;
        b=mRWIiq1YCiNEshVpIeud/3kWUb5WXPPOKk0dM5K2GdMhqgC1iYgkbzw4KORY0u68/m
         BetUrvTjPHbCQuuLIKCfBToMGsvegUHk8lkk1NwY/W9ysX8E4Ozl+yErcFmHhMKP7el1
         81oOjTsTsPFQRGWIWZ9u8g2saiMtCPudnxgUAnDs2q/+OSchqLb3psIdsZslYXQHB2N9
         bIDZvLjHSQZ35gtr0q0+D0y7TlYmmED6tX/4ktfdh9HeA/0uP2aPJ8m8vuGhGVFmknDl
         I0/jtIc5Uax54RYLxlnkx2p11PsjIAApq5WbSKUtrHxu8bc5b4HEqwouw1yIv6Ge0Oco
         T6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8S9j2GGiF6Hq0Ve0gp08kcpf5x+zmb5JGAyHhh8nX3A=;
        b=fkTUcmhnoS3nI4Y3gAgOACkH1QzQ4YNvR+QOY8qKTmk9ESi6t7zgHO3sj4R7Rzt6E+
         kn/8VnJm6/0Ei76pRJFBqULuqci5rt3BMp4n6uElE5XvmWNuEiFvbFJxPvves/CVQ9wd
         o//UFvYgn3DCKRT7wchxt1a4b7xjdtHTyDDJ5aHFQHjvMPa53a+P84u2VVmesDmtoUHl
         KUA5X3Pcq/l7St4/sg143mKqcIK+KtLd5ygbOW7Ehd5DRBtEHjUPh7zDDOsWadO2CpsI
         kGJCDKzVVjng4IYOQlR85EhsYK53iPS/SMGKimgQj0K5xYLLLvhXJvUPZozLD7ZWrhvV
         d6XA==
X-Gm-Message-State: AElRT7Hg6RuU4Zv6HGp4dT3AMQJfww9xMuJdZN4KGce9RXxY5Hvwr+IH
        5TUkPmIzbTrj0+LOmfge0x4=
X-Google-Smtp-Source: AIpwx48Z6vSPk6tP46uVV0AzPws5nCZTYDuU3wUxI22YLf9DkxZ6sAFmCSvkzmWvnk7tRmYxhvgrHA==
X-Received: by 10.223.152.83 with SMTP id v77mr5800519wrb.225.1522648779035;
        Sun, 01 Apr 2018 22:59:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i52sm25481354wra.82.2018.04.01.22.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 22:59:38 -0700 (PDT)
Date:   Mon, 2 Apr 2018 07:59:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shea Levy <shea@shealevy.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Landley <rob@landley.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180402055933.zbpyorktot2owzzu@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <20180330111517.rrx6gs2skkgk336j@gmail.com>
 <87bmf3rmq6.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmf3rmq6.fsf@xps13.shealevy.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Shea Levy <shea@shealevy.com> wrote:

> > Please also put it into Documentation/features/.
> 
> I switched this patch series (the latest revision v6 was just posted) to
> using weak symbols instead of Kconfig. Does it still warrant documentation?

Probably not.

Thanks,

	Ingo
