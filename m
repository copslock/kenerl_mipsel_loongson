Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2016 00:45:34 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34770 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042251AbcFFWpcy0Yx0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2016 00:45:32 +0200
Received: by mail-wm0-f65.google.com with SMTP id n184so19897539wmn.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2016 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MbSwo6YT5SltF1mYJhnYj/VudjchQKRLSBN1Q/LeV+U=;
        b=u95mEANrSlnJ/i2eDl/+cno4nfRY6rtiJDM8ZK9auHJl+oEBzcBL3idFSJkwrnnPxY
         m/XU5mGXvXakou8d3Mh3+T805LrGoXVv5QGeKzOCtMfc/a1WKtSzWDVHZVLJ26OPEt2P
         VFXFFCTk1SYYh69pa5v+8Oc38LXnkSzUqhHRmRJn3l1XgRYYCeFfn7WfITHDmB1stk7U
         WauUDBAJgC2Pay6mImKv+q9Y5QSXAUn6mHZ4w1kmY9sVzXmtnAeeql6WPgCsDu9FfNeA
         eL//0g2gdRrsxY6dBXER/wfzXs32YkfYrao/LgG7EFNF+NP0DMoc6gwDn/zN0TLeljUK
         y63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MbSwo6YT5SltF1mYJhnYj/VudjchQKRLSBN1Q/LeV+U=;
        b=EFjgOJyzbTPkr+TFkBUCKf5YQB/i9wU9XuKJdsfoPDcR/Jj/gERMeBvscKP5sCBWYM
         7JpQVki6SjzdFp2noSaFC0zAeptaGMQdfA2zm+jtiFhYHwTE2y1WQkrWTdyuej4vND2a
         0PJ8n2EEsmY3UKlt5QcbE3NfXUiw9OpYkgHQS7ftPKdW7sNHX+KVkWQdOlsO5AlYRkH8
         CXtJcPQ9+mVnCEFxYDU4Wq3AEgh7kG+dar87NNlPO02wWDXm2rNY2jvDJz2LheIggjSH
         Z8gu0y7NGp/hICqzl/hgP5weH4uyqm2RFWB8mPgeOcXirO8pcQUf1bX1KCrXCpJd6oTQ
         F0/g==
X-Gm-Message-State: ALyK8tJG/I+HBooAiYpfn4aOuDz1UMaqXdaT6I1bQbMz8l/FRqPMSB50UUDQEj5oEVk5U+KR/SbRgXIlnMmjmQ==
X-Received: by 10.28.165.66 with SMTP id o63mr14777456wme.102.1465253127640;
 Mon, 06 Jun 2016 15:45:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.52.141 with HTTP; Mon, 6 Jun 2016 15:45:26 -0700 (PDT)
In-Reply-To: <feba34c6ee8ddc639507f569b737c1b525c7f139.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org> <feba34c6ee8ddc639507f569b737c1b525c7f139.1464960877.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jun 2016 00:45:26 +0200
X-Google-Sender-Auth: XeSf_K956V9vwji8bAMLPjnqrEU
Message-ID: <CAJZ5v0jFQmK77DB3w0KhM3JLPKbLsJhGqhcUmF7Bc3wuY_ANTQ@mail.gmail.com>
Subject: Re: [PATCH V3 9/9] cpufreq: drivers: Free frequency tables after
 being used
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Muckle <steve.muckle@linaro.org>,
        linux-mips@linux-mips.org,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Shawn Guo <shawn.guo@freescale.com>,
        Steven Miao <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <rjwysocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafael@kernel.org
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

On Fri, Jun 3, 2016 at 3:35 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The cpufreq core doesn't use these tables anymore after
> cpufreq_table_validate_and_show() has returned.  And so these can be
> freed early.

That doesn't look particularly efficient.

The driver has to allocate memory first and populate it and then the
core needs to allocate more memory again to store the same information
in it, but perhaps in a different order and then the driver can free
the memory allocated before right away.  It looks like there's one
excessive memory allocation here, so maybe the core can simply sort
the frequency table in place and overwrite the invalid entries in the
process?
