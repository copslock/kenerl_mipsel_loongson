Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2012 13:38:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52402 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903542Ab2AMMiC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jan 2012 13:38:02 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q0DCc1vY024389;
        Fri, 13 Jan 2012 13:38:01 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q0DCc1ww024388;
        Fri, 13 Jan 2012 13:38:01 +0100
Date:   Fri, 13 Jan 2012 13:38:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RESEND 01/17] MIPS: lantiq: reorganize xway code
Message-ID: <20120113123800.GA22597@linux-mips.org>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jan 11, 2012 at 09:44:18PM +0100, John Crispin wrote:

> +static inline void ltq_ebu_w32_mask(u32 c, u32 s, u32 r) {
> +	ltq_ebu_w32((ltq_ebu_r32(r) & ~c) | s, r);
> +}
> +
> +/* cgu access */
> +static inline void ltq_cgu_w32(u32 v, u32 r) {
> +	ltq_w32(v, ltq_cgu_membase + r);
> +};
> +static inline u32 ltq_cgu_r32(u32 r) {
> +	return ltq_r32(ltq_cgu_membase + r);
> +};
> +static inline void ltq_cgu_w32_mask(u32 c, u32 s, u32 r) {
> +	ltq_cgu_w32((ltq_cgu_r32(r) & ~c) | s, r);
> +}

Documentation/CodingStyle:

[...]

However, there is one special case, namely functions: they have the
opening brace at the beginning of the next line, thus:

        int function(int x)
        {
                body of function
        }

Heretic people all over the world have claimed that this inconsistency
is ...  well ...  inconsistent, but all right-thinking people know that
(a) K&R are _right_ and (b) K&R are right.  Besides, functions are
special anyway (you can't nest them in C).

[...]

So this formatting is heretic.  Pray 10 CodingStyle to Saint K&R.

  Ralf
