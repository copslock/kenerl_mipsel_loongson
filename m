Return-Path: <SRS0=/lG2=RK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D596C43381
	for <linux-mips@archiver.kernel.org>; Thu,  7 Mar 2019 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB13A20684
	for <linux-mips@archiver.kernel.org>; Thu,  7 Mar 2019 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b86uG8cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfCGKD6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:03:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33237 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCGKD6 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 7 Mar 2019 05:03:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so11057800pfd.0
        for <linux-mips@vger.kernel.org>; Thu, 07 Mar 2019 02:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=7gnGNWCnkJWOjYXupwGGNhpRty3Z8TqIlsYWM5aG56M=;
        b=b86uG8cw+yXH0jlhkIzyyW77HsWtPH04NU0YkPI7zR17s2fGQNR/6PDUkAXLM90RtC
         qinJEtoX3tNLjZLmk9eDs1UbjDhePGM8VPPviqELGv0GvLJx9Ci8gbsanluKZTurSJUU
         RD5ImrrYOklbV4PMd20JZzwe3IxJX8H4vaZbdwzj6Q3SPOP3jCkpBi2I2EhPpPdQiT89
         r2GPncxu9IE5jv0JbzbI1xFbnPZb8OJoHHPSVBffrzSTPBEn+Fx2+bNA+oqwDKANWVI9
         xkqlxn/uvpztjWjyvIXsJszbmjrg9DzBZhlymXE6Nc8RtxKQiiW8Wj/WDP1+YOVSW8Qw
         LGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=7gnGNWCnkJWOjYXupwGGNhpRty3Z8TqIlsYWM5aG56M=;
        b=Ku9sbHtrOA0GysdkHvmTwLa6wl8Ra7M/H0SLJhsLLSzc/CUPnmN6IkyyLLeEhRUQuE
         0XnGe2GWo1hST3E+qt8yXd2GmubgrNNPuvnklfr9PrjkjYpidxhLpAXukB7CIhylmq7P
         2+PPsDOXALwHmUYkikq6QsIkXwrBux0UWU5vCGYCz9Xxt+EiRdqd4IxcWVwmWDKnUy3d
         Edr69bUvtnXeRqI5jS8PxV9qbVbD+hd+fKNdxrKFFkU1a/wzk6TxrvR2VwMRMsVqJ6ec
         lUk0hGE8e/ffjbJ4v4oMTA01htaT6w60Zp2FnfdOLFAvlxQ5zwYXzO75+wHU5u/kZWyC
         x0CQ==
X-Gm-Message-State: APjAAAUof7VSKr4s8jY3G5gDogWnAXvNXq6h5lFVD626jHfIefpHpolT
        q3CqxHBCBJUMp6PDnUhNmeTHRQ==
X-Google-Smtp-Source: APXvYqyRdOmcA9i7KJ/JA5Li5DqquwXzPoW1rUoQVCq5VUwBvZEbGcP1v8zkpA+hwAa+LWcl9dYT2Q==
X-Received: by 2002:a63:cc15:: with SMTP id x21mr10860173pgf.380.1551953036854;
        Thu, 07 Mar 2019 02:03:56 -0800 (PST)
Received: from [100.146.253.212] ([208.54.86.130])
        by smtp.gmail.com with ESMTPSA id v9sm6749667pfg.130.2019.03.07.02.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:03:56 -0800 (PST)
Date:   Thu, 07 Mar 2019 11:03:45 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190307091218.2343836-1-arnd@arndb.de>
References: <20190307091218.2343836-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] signal: fix building with clang
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <F5AA685F-C48B-4067-A70F-AC942C90F770@brauner.io>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On March 7, 2019 10:11:52 AM GMT+01:00, Arnd Bergmann <arnd@arndb=2Ede> wro=
te:
>clang warns about the sigset_t manipulating functions (sigaddset,
>sigdelset,
>sigisemptyset, =2E=2E=2E) because it performs semantic analysis before
>discarding
>dead code, unlike gcc that does this in the reverse order=2E
>
>The result is a long list of warnings like:
>
>In file included from arch/arm64/include/asm/ftrace=2Eh:21:
>include/linux/compat=2Eh:489:10: error: array index 3 is past the end of
>the array (which contains 2 elements) [-Werror,-Warray-bounds]
>        case 2: v=2Esig[3] =3D (set->sig[1] >> 32); v=2Esig[2] =3D set->s=
ig[1];
>                ^     ~
>include/linux/compat=2Eh:138:2: note: array 'sig' declared here
>        compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
>        ^
>include/linux/compat=2Eh:489:42: error: array index 2 is past the end of
>the array (which contains 2 elements) [-Werror,-Warray-bounds]
>        case 2: v=2Esig[3] =3D (set->sig[1] >> 32); v=2Esig[2] =3D set->s=
ig[1];
>                                                ^     ~
>include/linux/compat=2Eh:138:2: note: array 'sig' declared here
>        compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
>        ^
>
>As a (rather ugly) workaround, I turn the nice switch()/case statements
>into preprocessor conditionals, and where that is not possible, use the
>'%' operator to modify the warning case into an operation that clang
>will not warn about=2E Since that only matters for dead code, the actual
>behavior does not change=2E
>
>Link: https://bugs=2Ellvm=2Eorg/show_bug=2Ecgi?id=3D38789
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> arch/mips/include/uapi/asm/signal=2Eh |  3 +-
> include/linux/signal=2Eh              | 72 ++++++++++++++---------------
> 2 files changed, 37 insertions(+), 38 deletions(-)
>
>diff --git a/arch/mips/include/uapi/asm/signal=2Eh
>b/arch/mips/include/uapi/asm/signal=2Eh
>index 53104b10aae2=2E=2E8e71a2f778f7 100644
>--- a/arch/mips/include/uapi/asm/signal=2Eh
>+++ b/arch/mips/include/uapi/asm/signal=2Eh
>@@ -11,9 +11,10 @@
> #define _UAPI_ASM_SIGNAL_H
>=20
> #include <linux/types=2Eh>
>+#include <asm/bitsperlong=2Eh>
>=20
> #define _NSIG		128
>-#define _NSIG_BPW	(sizeof(unsigned long) * 8)
>+#define _NSIG_BPW	__BITS_PER_LONG
> #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
>=20
> typedef struct {
>diff --git a/include/linux/signal=2Eh b/include/linux/signal=2Eh
>index 9702016734b1=2E=2Eb967d502ab61 100644
>--- a/include/linux/signal=2Eh
>+++ b/include/linux/signal=2Eh
>@@ -82,35 +82,33 @@ static inline int sigismember(sigset_t *set, int
>_sig)
>=20
> static inline int sigisemptyset(sigset_t *set)
> {
>-	switch (_NSIG_WORDS) {
>-	case 4:
>-		return (set->sig[3] | set->sig[2] |
>-			set->sig[1] | set->sig[0]) =3D=3D 0;
>-	case 2:
>-		return (set->sig[1] | set->sig[0]) =3D=3D 0;
>-	case 1:
>-		return set->sig[0] =3D=3D 0;
>-	default:
>-		BUILD_BUG();
>-		return 0;
>-	}
>+#if _NSIG_WORDS =3D=3D 4
>+	return (set->sig[3] | set->sig[2] |
>+		set->sig[1] | set->sig[0]) =3D=3D 0;
>+#elif _NSIG_WORDS =3D=3D 2
>+	return (set->sig[1] | set->sig[0]) =3D=3D 0;
>+#elif _NSIG_WORDS =3D=3D 1
>+	return set->sig[0] =3D=3D 0;
>+#else
>+	BUILD_BUG();
>+#endif
> }
>=20
>static inline int sigequalsets(const sigset_t *set1, const sigset_t
>*set2)
> {
>-	switch (_NSIG_WORDS) {
>-	case 4:
>-		return	(set1->sig[3] =3D=3D set2->sig[3]) &&
>-			(set1->sig[2] =3D=3D set2->sig[2]) &&
>-			(set1->sig[1] =3D=3D set2->sig[1]) &&
>-			(set1->sig[0] =3D=3D set2->sig[0]);
>-	case 2:
>-		return	(set1->sig[1] =3D=3D set2->sig[1]) &&
>-			(set1->sig[0] =3D=3D set2->sig[0]);
>-	case 1:
>-		return	set1->sig[0] =3D=3D set2->sig[0];
>-	}
>+#if _NSIG_WORDS =3D=3D 4
>+	return	(set1->sig[3] =3D=3D set2->sig[3]) &&
>+		(set1->sig[2] =3D=3D set2->sig[2]) &&
>+		(set1->sig[1] =3D=3D set2->sig[1]) &&
>+		(set1->sig[0] =3D=3D set2->sig[0]);
>+#elif _NSIG_WORDS =3D=3D 2
>+	return	(set1->sig[1] =3D=3D set2->sig[1]) &&
>+		(set1->sig[0] =3D=3D set2->sig[0]);
>+#elif _NSIG_WORDS =3D=3D 1
>+	return	set1->sig[0] =3D=3D set2->sig[0];
>+#else
> 	return 0;
>+#endif
> }
>=20
> #define sigmask(sig)	(1UL << ((sig) - 1))
>@@ -125,14 +123,14 @@ static inline void name(sigset_t *r, const
>sigset_t *a, const sigset_t *b) \
> 									\
> 	switch (_NSIG_WORDS) {						\
> 	case 4:								\
>-		a3 =3D a->sig[3]; a2 =3D a->sig[2];				\
>-		b3 =3D b->sig[3]; b2 =3D b->sig[2];				\
>-		r->sig[3] =3D op(a3, b3);					\
>-		r->sig[2] =3D op(a2, b2);					\
>+		a3 =3D a->sig[3%_NSIG_WORDS]; a2 =3D a->sig[2%_NSIG_WORDS];	\
>+		b3 =3D b->sig[3%_NSIG_WORDS]; b2 =3D b->sig[2%_NSIG_WORDS];	\
>+		r->sig[3%_NSIG_WORDS] =3D op(a3, b3);			\
>+		r->sig[2%_NSIG_WORDS] =3D op(a2, b2);			\
> 		/* fall through */					\
> 	case 2:								\
>-		a1 =3D a->sig[1]; b1 =3D b->sig[1];				\
>-		r->sig[1] =3D op(a1, b1);					\
>+		a1 =3D a->sig[1%_NSIG_WORDS]; b1 =3D b->sig[1%_NSIG_WORDS];	\
>+		r->sig[1%_NSIG_WORDS] =3D op(a1, b1);			\
> 		/* fall through */					\
> 	case 1:								\
> 		a0 =3D a->sig[0]; b0 =3D b->sig[0];				\
>@@ -161,10 +159,10 @@ _SIG_SET_BINOP(sigandnsets, _sig_andn)
> static inline void name(sigset_t *set)					\
> {									\
> 	switch (_NSIG_WORDS) {						\
>-	case 4:	set->sig[3] =3D op(set->sig[3]);				\
>-		set->sig[2] =3D op(set->sig[2]);				\
>+	case 4:	set->sig[3%_NSIG_WORDS] =3D op(set->sig[3%_NSIG_WORDS]);	\
>+		set->sig[2%_NSIG_WORDS] =3D op(set->sig[2%_NSIG_WORDS]);	\
> 		/* fall through */					\
>-	case 2:	set->sig[1] =3D op(set->sig[1]);				\
>+	case 2:	set->sig[1%_NSIG_WORDS] =3D op(set->sig[1%_NSIG_WORDS]);	\
> 		/* fall through */					\
> 	case 1:	set->sig[0] =3D op(set->sig[0]);				\
> 		    break;						\
>@@ -185,7 +183,7 @@ static inline void sigemptyset(sigset_t *set)
> 	default:
> 		memset(set, 0, sizeof(sigset_t));
> 		break;
>-	case 2: set->sig[1] =3D 0;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D 0;
> 		/* fall through */
> 	case 1:	set->sig[0] =3D 0;
> 		break;
>@@ -198,7 +196,7 @@ static inline void sigfillset(sigset_t *set)
> 	default:
> 		memset(set, -1, sizeof(sigset_t));
> 		break;
>-	case 2: set->sig[1] =3D -1;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D -1;
> 		/* fall through */
> 	case 1:	set->sig[0] =3D -1;
> 		break;
>@@ -229,7 +227,7 @@ static inline void siginitset(sigset_t *set,
>unsigned long mask)
> 	default:
> 		memset(&set->sig[1], 0, sizeof(long)*(_NSIG_WORDS-1));
> 		break;
>-	case 2: set->sig[1] =3D 0;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D 0;
> 	case 1: ;
> 	}
> }
>@@ -241,7 +239,7 @@ static inline void siginitsetinv(sigset_t *set,
>unsigned long mask)
> 	default:
> 		memset(&set->sig[1], -1, sizeof(long)*(_NSIG_WORDS-1));
> 		break;
>-	case 2: set->sig[1] =3D -1;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D -1;
> 	case 1: ;
> 	}
> }

Ugh, it's not pretty but I don't have any objections=2E :)

Acked-by: Christian Brauner <christian@brauner=2Eio>
