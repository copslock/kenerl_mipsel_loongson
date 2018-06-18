Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 15:06:10 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:33433
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994571AbeFRNGETCxQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 15:06:04 +0200
Received: by mail-lf0-x242.google.com with SMTP id y20-v6so24568168lfy.0
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2018 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6M+7FVl7UAWt995uN4YV/iXiVEMLJuYi9KC5rV4Xvhg=;
        b=j4H9wsdaYCqdHSP+6oWZ7o6zAEfdposVdzVWiLtf4hUB+vwh95AnoRrPLr6eK6ygds
         OV/3viYrpu5HY7JYKhTuJPaw67TX2oPrfbb+E+L4YXEGlfP3kq42z+GRQ3K1G5LtGmbi
         c1McID+r5PvL+UaLwBX+oTcOl+ByxTVjYCr3Ovly0EB2t2Lx9ifD1bAy2UU/UrAyDDje
         qzz2T6jiRHaXYM+IJoWpZe+FCWSslYSIG1M3ix8QAWlyy4Yn52+PgSiRkgw9t8GTevp8
         uzm86ksSjwTNmJh1Onb7M1mbo5W8woUNKcsJe+bIPw9PlB5JbYwmnNvxMQQzJWdKTZyN
         DjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6M+7FVl7UAWt995uN4YV/iXiVEMLJuYi9KC5rV4Xvhg=;
        b=S57y3PEScVN+rEJJSVzOv41ZfUauq41i8D/3ddd6vpEdjm9EHHGGJt47IFtHSeZ403
         z/OxHrR2i92pOteUq+oCD8DcjREp2vyHGFcj2WRmmoK2kdZu/zwaapbZutRROUNwBkPy
         APuSAfZ6rPRuJhESyPRElr048YYFTCdisjFrA8DpGlVq9szVjLUDSOtPGb9c2d2iHd3+
         0ffqh0w38iGqXnCcVQf56aJ5FOUKC4rlhnFPIu4aRxKM+jFzTUXumuCfbZxNnT4PQbu+
         j7q3eHzPECq1evexzL/P5JFMqYIiCqg1CtOpGKNc9uwBZ236TbxyHsBr/IkPmWdeWoHC
         +vvw==
X-Gm-Message-State: APt69E3INEt0iuGy0jcmdFKIZWMjnIH5iYJK0yaNfYFH9RbIHTfr40ke
        t82iWNJ51vhqhEsgPRo8WImE5C0q/OvUXfIY1bc=
X-Google-Smtp-Source: ADUXVKKBH7gQ+x0RIza7Op3bS3fG4rHXF5OhBK61doYJog3K6k2s2IVUxioizgqr1XbI3ryDgB59urGQOm1g8QO8h6Q=
X-Received: by 2002:a19:141f:: with SMTP id k31-v6mr2833908lfi.23.1529327158393;
 Mon, 18 Jun 2018 06:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 06:05:57
 -0700 (PDT)
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 15:05:57 +0200
X-Google-Sender-Auth: nQn1PvnOf7LVKkGPFKtvcJW8Yog
Message-ID: <CAK8P3a2Yz-02On2K2U0+8+tR8RQCQ+KWh7CrtqL9L+FweP+TPQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from SYSCALL_DEFINEx()
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sat, Jun 16, 2018 at 2:53 AM, Paul Burton <paul.burton@mips.com> wrote:
> This series introduces infrastructure allowing compiler diagnostics to
> be disabled or their severity modified for specific pieces of code, with
> suitable abstractions to prevent that code from becoming tied to a
> specific compiler.
>
> This infrastructure is then used to disable the -Wattribute-alias
> warning around syscall definitions, which rely on type mismatches to
> sanitize arguments.
>
> Finally PowerPC-specific #pragma's are removed now that the generic code
> is handling this.
>
> The series takes Arnd's RFC patches & addresses the review comments they
> received. The most notable effect of this series to to avoid warnings &
> build failures caused by -Wattribute-alias when compiling the kernel
> with GCC 8.
>
> Applies cleanly atop master as of 9215310cf13b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
>

Sorry I dropped the ball on this earlier, and thanks a lot for picking
it up again! From what I can tell, your version addresses all issues
I was aware of, so we should merge that.

      Arnd
