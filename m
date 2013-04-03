Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Apr 2013 11:29:07 +0200 (CEST)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:56389 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825906Ab3DCJ3ButMr8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Apr 2013 11:29:01 +0200
Received: by mail-oa0-f50.google.com with SMTP id n1so1275920oag.37
        for <linux-mips@linux-mips.org>; Wed, 03 Apr 2013 02:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type:x-gm-message-state;
        bh=EqvBBhv/o8nNSXsb2rQ4vBvlKPRIuKKWAaUiaJzWG4U=;
        b=E55iGaxoWRzFXtwmMwoQq0QpemfyBB5jIDGIFZ/pO7CpY4jAVSCq8QRzAZ4rVGLytt
         vMrD87g7xTMX+Oe1gqtomBuDsZhygTlluWDpxlgNfY/E3pV+/ow4CtUw2fHafuZHbwIL
         eZE2Oe8qggrrMNOA10WTIg+HoFToJfBgegBf0qMqesS/AkWeoT82mP52e0JRnFfO2ajy
         NBhxYsiESxDAr7qdnmV3vXsVylHbg5rWOtv45+mmWSpmL3v49SNSI1dOMeJewUb/cBDB
         v6PNnECIN92YAcE4Xz92WNGTxvXgCxWMZakonDPyR7cljUf5EAiDYy5/cDgSXIAcSMx1
         Cnqw==
MIME-Version: 1.0
X-Received: by 10.60.60.227 with SMTP id k3mr540309oer.97.1364981335439; Wed,
 03 Apr 2013 02:28:55 -0700 (PDT)
Received: by 10.182.52.198 with HTTP; Wed, 3 Apr 2013 02:28:55 -0700 (PDT)
In-Reply-To: <CAKohpom4sckvmB12=KRX4aMJDJjpT=nN++_xyL=p_0ZY7v6oMQ@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
        <199e0d0a282290544ff562b904a0028a104aad45.1364229828.git.viresh.kumar@linaro.org>
        <CAKohpom4sckvmB12=KRX4aMJDJjpT=nN++_xyL=p_0ZY7v6oMQ@mail.gmail.com>
Date:   Wed, 3 Apr 2013 14:58:55 +0530
Message-ID: <CAKohpome32G=Nn4Uy3kHJyeJ2cTUOBTwHy9nKo2r6Cb1=KVS7A@mail.gmail.com>
Subject: Re: [PATCH 5/9] mips: cpufreq: move cpufreq driver to drivers/cpufreq
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQleVFCEoIBsy9I+rMvjNBFumfFihdNI1HGDTgk9o+D4IAHLSFupV1YWYw7FnSi9tDztb8RF
X-archive-position: 36006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 31 March 2013 09:31, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25 March 2013 22:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> This patch moves cpufreq driver of MIPS architecture to drivers/cpufreq.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/mips/Kconfig                                  |  9 ++++-
>>  arch/mips/kernel/Makefile                          |  2 --
>>  arch/mips/kernel/cpufreq/Kconfig                   | 41 ----------------------
>>  arch/mips/kernel/cpufreq/Makefile                  |  5 ---
>>  drivers/cpufreq/Kconfig                            | 18 ++++++++++
>>  drivers/cpufreq/Makefile                           |  1 +
>>  .../kernel => drivers}/cpufreq/loongson2_cpufreq.c |  0
>>  7 files changed, 27 insertions(+), 49 deletions(-)
>>  delete mode 100644 arch/mips/kernel/cpufreq/Kconfig
>>  delete mode 100644 arch/mips/kernel/cpufreq/Makefile
>>  rename {arch/mips/kernel => drivers}/cpufreq/loongson2_cpufreq.c (100%)
>
> Ralf or any other mips guy,
>
> Can i have your ack or comments for this patch?

Ping!!
