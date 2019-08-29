Return-Path: <SRS0=4KhX=WZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D33C3A59F
	for <linux-mips@archiver.kernel.org>; Thu, 29 Aug 2019 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B1233FF
	for <linux-mips@archiver.kernel.org>; Thu, 29 Aug 2019 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VwOF8bMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfH2NFQ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:05:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36330 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfH2NFL (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 29 Aug 2019 09:05:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id r5so2483511lfc.3
        for <linux-mips@vger.kernel.org>; Thu, 29 Aug 2019 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+pz1tJCvEpXqhYntc4a+eXdQw4YkeZzY/CUqzEnQfhI=;
        b=VwOF8bMUMlpcVPjnH7KLm7q9YPGAJyoJCaqTHg0eB7cJNs33HPtWse0a6S+38yOz8O
         NHVqczdRdynKQIjzWAF9I3YpK+wBqgWsLCV+xSrpqG8v5x5MeuksDGvoajweRjwbjZ5a
         38t56VL/f1C5Tbh/lNpCLIQcFzQtYKavA1iaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+pz1tJCvEpXqhYntc4a+eXdQw4YkeZzY/CUqzEnQfhI=;
        b=Ryl0HozkwpZwoLcuNLIN1Ka9jGTaNtBqdnsMfDP+nhr3V+ARHuIi+CeGECc1RaUyat
         usJKV3MS+Yanc54Q6Mdp2KV8PuKJQ7gqog8auTksb7/AH+ecjUIiHOeK+JHjYzWt9Kst
         kcqUW0YyMmEauzGoi+XykTPZPKowIiQn2Q5bZqLf7vI0Vo9/z/1FqfK1u68GNLEC8YeC
         +9M3i/3qTkyTqJO0iA94wCeihs+6b9ZaTxofZE/faqVZLYMxQVxcgrlLaRQaBxbov4Y2
         D8boDiIUeDOhB284y++xIuhHJa7H4mvph0iXJAMDxZaDyr8u+mZ3JFr5ejYmFWzd5GNb
         N6HA==
X-Gm-Message-State: APjAAAWwxPh+trKty0xkW1xKPENcMSeF9uBC/5RL1I5/SxThi+gYAlej
        UU75hrIka7zjctXL5XwuqneQjg==
X-Google-Smtp-Source: APXvYqzC/znEm7g6SWABzaV06VBY2y9BWKEbRXRSbaRH8cAy80Qu1m8PhCO/oz8TivPdICdvt4gS+A==
X-Received: by 2002:a19:ef05:: with SMTP id n5mr6063058lfh.192.1567083908173;
        Thu, 29 Aug 2019 06:05:08 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j23sm346381ljc.6.2019.08.29.06.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 06:05:07 -0700 (PDT)
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Colascione <dancol@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
References: <20190820033406.29796-1-cyphar@cyphar.com>
 <20190820033406.29796-8-cyphar@cyphar.com>
 <CAKOZuesfxRBJe314rkTKXtjXdz6ki3uAUBYVbu5Q2rd3=ADphQ@mail.gmail.com>
 <20190829121527.u2uvdyeatme5cgkb@yavin>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <899401fa-ff0a-2ce9-8826-09904efab2d2@rasmusvillemoes.dk>
Date:   Thu, 29 Aug 2019 15:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829121527.u2uvdyeatme5cgkb@yavin>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 29/08/2019 14.15, Aleksa Sarai wrote:
> On 2019-08-24, Daniel Colascione <dancol@google.com> wrote:

>> Why pad the structure when new functionality (perhaps accommodated via
>> a larger structure) could be signaled by passing a new flag? Adding
>> reserved fields to a structure with a size embedded in the ABI makes a
>> lot of sense --- e.g., pthread_mutex_t can't grow. But this structure
>> can grow, so the reservation seems needless to me.
> 
> Quite a few folks have said that ->reserved is either unnecessary or
> too big. I will be changing this, though I am not clear what the best
> way of extending the structure is. If anyone has a strong opinion on
> this (or an alternative to the ones listed below), please chime in. I
> don't have any really strong attachment to this aspect of the API.
> 
> There appear to be a few ways we can do it (that all have precedence
> with other syscalls):
> 
>  1. Use O_* flags to indicate extensions.
>  2. A separate "version" field that is incremented when we change.
>  3. Add a size_t argument to openat2(2).
>  4. Reserve space (as in this patchset).
> 
> (My personal preference would be (3), followed closely by (2).)

3, definitely, and instead of having to invent a new scheme for every
new syscall, make that the default pattern by providing a helper

int __copy_abi_struct(void *kernel, size_t ksize, const void __user
*user, size_t usize)
{
	size_t copy = min(ksize, usize);

	if (copy_from_user(kernel, user, copy))
		return -EFAULT;

	if (usize > ksize) {
		/* maybe a separate "return user_is_zero(user + ksize, usize -
ksize);" helper */
		char c;
		user += ksize;
		usize -= ksize;
		while (usize--) {
			if (get_user(c, user++))
				return -EFAULT;
			if (c)
				return -EINVAL;
		}
	} else if (ksize > usize) {
		memset(kernel + usize, 0, ksize - usize);
	}
	return 0;
}
#define copy_abi_struct(kernel, user, usize)	\
	__copy_abi_struct(kernel, sizeof(*kernel), user, usize)

> Both (1) and (2) have the problem that the "struct version" is inside
> the struct so we'd need to copy_from_user() twice. This isn't the end of
> the world, it just feels a bit less clean than is ideal. (3) fixes that
> problem, at the cost of making the API slightly more cumbersome to use
> directly (though again glibc could wrap that away).

I don't see how 3 is cumbersome to use directly. Userspace code does
struct openat_of_the_day args = {.field1 = x, .field3 = y} and passes
&args, sizeof(args). What does glibc need to do beyond its usual munging
of the userspace ABI registers to the syscall ABI registers?

Rasmus

