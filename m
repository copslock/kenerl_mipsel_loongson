Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 13:10:34 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38069 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010687AbbDWLKdGhOPY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 13:10:33 +0200
Received: by wiun10 with SMTP id n10so88313681wiu.1
        for <linux-mips@linux-mips.org>; Thu, 23 Apr 2015 04:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bl41oXh1uVrhRPcyyiWAJdTUKiYoMMMCAbm9uqNKfaE=;
        b=iH1UOI+wzLkC1jE8RzSNDWG9GgreTDnyKt2YDYHvVvKZizSXWHmNJTuzEsBDm4yzp+
         5KMH7iKRrmQgLW3S/PZ2YYwx/gFr48klCXdOkLmOAiyFiPCMqQXv4GGwYwQkfI+c1V9C
         tG+OTcJGPDyUHkfYE5nh+HnhLwUDWuyvQVmdnoJipG6SAYpXZVuvDjJGD2MJxPRrWvj9
         s+qCsBHkZBkeLs19jLVX8nmjed4/mwkFrTybB+gZrJK+kWW5oX3ZFUs3YTZaI6bICgvm
         a9WiYz1ulax7fKB/rMUo2M7HGBLqgJ39sF7KqqBotW07tIzcHskSzfJSf0TuMdFxC3Wd
         z36g==
X-Gm-Message-State: ALoCoQlAm4lGjqkuYrTLF+qTHpfpgGSfEo++W6UAo7hOCwcMth6xD6MzkColz2+jd7q5Ps/3JpDC
X-Received: by 10.194.23.66 with SMTP id k2mr4321211wjf.18.1429787429461;
        Thu, 23 Apr 2015 04:10:29 -0700 (PDT)
Received: from bordel.klfree.net (bordel.klfree.cz. [81.201.48.42])
        by mx.google.com with ESMTPSA id hy7sm11624680wjb.1.2015.04.23.04.10.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Apr 2015 04:10:28 -0700 (PDT)
Date:   Thu, 23 Apr 2015 13:10:22 +0200
From:   Petr Malat <oss@malat.biz>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH] Revert "MIPS: Provide correct siginfo_t.si_stime"
Message-ID: <20150423111021.GA32635@bordel.klfree.net>
References: <1429641183-15873-1-git-send-email-vapier@gentoo.org>
 <20150422123045.GA5428@bordel.klfree.net>
 <20150423013606.GQ12496@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150423013606.GQ12496@vapier>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <oss@malat.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oss@malat.biz
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

So the whole include dependency is a mess.

arch/mips/include/uapi/asm/siginfo.h defines siginfo_t structure, which
requires ./include/uapi/asm-generic/siginfo.h for definition of SI_MAX_SIZE
and others, but it can't include ./include/asm-generic/siginfo.h, because
that one contains inline function copy_siginfo, which dereferences
siginfo_t structure.

It can be solved by
 - Modifying generic siginfo definition to allow swapping si_code and
   si_errno either by changing the definition to
     typedef struct siginfo {
        int si_signo;
        int __ARCH_SI_SECOND_MEMBER;
        int __ARCH_SI_THIRD_MEMBER;
   or by providing swapping define
     typedef struct siginfo {
        int si_signo;
     #ifdef    __ARCH_SI_SWAP_ERRNO_CODE
        int si_code;
        int si_errno;
     #else
        int si_errno;
        int si_code;
     #endif
   then the generic definition can be used.

 - Coping copy_siginfo into arch specific include file also solves the problem

 - Use #ifdef __KERNEL__

Comments, please.
  P.
