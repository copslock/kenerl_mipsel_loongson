Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 20:12:53 +0200 (CEST)
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37573 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994757AbeHISMtvHhim (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 20:12:49 +0200
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so7561862qtl.4;
        Thu, 09 Aug 2018 11:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVAZCveegyvbQLprEW6lQuugEM1soGlvijMmklPHUws=;
        b=PzWUuX1f/9jjSITUDEOY8VdT2fRAyF9CQTCLZmOAZszCg9h5/TgUqkrocyjuB917W5
         LpeM5JPmY/5jLeYEZmcHkAVt6jA6il776v/Dhwnbk3YRd7oJPL7+PGk7HtOEay6kdXn/
         82VXSRrCSzMUmjnOUA7nHbaDSKZKCIabYT+danHqfOWUSqYtOOVfBxT1ytuVhi0UHhMI
         +0aOD4PRDtRo/WktMnqgt4MMl4hbF7CbkeDdmwb/wAKh0RTVcndo/YhSZvoIUjWdSi95
         16jKCDeQXOeuSK9NQMZ7Kv1xpNYxlWpDJrwWMLZ8Lg9CUsnxG4RDSMr95MfEEhYJkdIk
         0/rw==
X-Gm-Message-State: AOUpUlEaO3nKEmpuD0+4ek1Dw4OZWmjVD5QACEmMxF2aqaPUqNvs4WEh
        WFQoIQUngOoMh69yJ+39OQKDdMfGPwh0HGAVN0E=
X-Google-Smtp-Source: AA+uWPyOO6QGlVLz/+EgrcZ9CfT+q/A2R9sYCo7f3fdq4A9KYUQfH7mVraII1nhhoawSOuuhZDKAWEzWL8a/qdAKjfQ=
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr3288108qta.178.1533838364046;
 Thu, 09 Aug 2018 11:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180809174444.31705-1-paul.burton@mips.com> <20180809174444.31705-5-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-5-paul.burton@mips.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Aug 2018 20:12:27 +0200
Message-ID: <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] MIPS: Workaround GCC __builtin_unreachable
 reordering bug
To:     Paul Burton <paul.burton@mips.com>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65505
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

On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:

> +/*
> + * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
> + * compiler that a particular code path will never be hit. This allows it to be
> + * optimised out of the generated binary.
> + *
> + * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
> + * 2016 suffer from a bug that can lead to instructions from beyond an

Has anything happened to address this in gcc in the meantime?
Could you update this text to reflect whatever is in current gcc-9?

      Arnd
