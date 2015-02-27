Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 07:20:00 +0100 (CET)
Received: from mail-we0-f182.google.com ([74.125.82.182]:41559 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006155AbbB0GT7QUZOT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 07:19:59 +0100
Received: by wevm14 with SMTP id m14so17520135wev.8;
        Thu, 26 Feb 2015 22:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1aLQfJbuN6xHhxPcEBptYZQzUBbS3OCl0noG3mDP9PY=;
        b=qR/swnnl+vcKsZIWRRV/i0wjhbcBRIYlO83Hg68Yte1lYw4xJ0NPYreQ0VNoVledTG
         EGEsYZGiJYWHKozB7JZ33aytMXHPKus8V6iBFa3lnVpINSgybu5bCe5Coj/H18C6Q6Ph
         kfmp0bBAXaGMh03Gqz2WS/irBUGw+EEdirn+bGgFRO56zbtQwJy5ndJBSFf92Q6YpwjS
         MBw7Pgn8RRP59/wWAWYeOFFOZA0Y/eccvfRT2lMx6Ln80OUCnUaRAOL49bEYPFxzg1Lx
         2AKd1Hg8BANtVagGVKbtg02LzGVibikgkw+5OkcbckqP0XkqwsePHkWD13iOlPfnr6Sc
         kxHw==
X-Received: by 10.180.39.203 with SMTP id r11mr3119781wik.67.1425017994464;
        Thu, 26 Feb 2015 22:19:54 -0800 (PST)
Received: from gmail.com (540331C6.catv.pool.telekom.hu. [84.3.49.198])
        by mx.google.com with ESMTPSA id l6sm4449110wjx.33.2015.02.26.22.19.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 22:19:53 -0800 (PST)
Date:   Fri, 27 Feb 2015 07:19:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Behan Webster <behanw@converseincode.com>,
        Ismael Ripoll <iripoll@upv.es>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150227061949.GA25810@gmail.com>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425006434-3106-1-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46039
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


* Kees Cook <keescook@chromium.org> wrote:

> This separates ET_DYN ASLR from mmap ASLR, as already 
> done on s390. The various architectures that are already 
> randomizing mmap (arm, arm64, mips, powerpc, s390, and 
> x86), have their various forms of arch_mmap_rnd() made 
> available via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For 
> these architectures, arch_randomize_brk() is collapsed as 
> well.
> 
> This is an alternative to the solutions in: 
> https://lkml.org/lkml/2015/2/23/442

Nice!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
