Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Apr 2018 22:17:32 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:33797
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991534AbeDVURZjDGAp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Apr 2018 22:17:25 +0200
Received: by mail-qk0-x241.google.com with SMTP id p186so11397471qkd.1;
        Sun, 22 Apr 2018 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yuVRF9qkSzb1K/ULzAFo8OAgna4w5IsHqAaDsAjc0cQ=;
        b=Z34Q7+XxEMQpIMPs8BLgz2Ycg/1UwY6T2aLzIztECjrA2SWRGyJo2T3mqU6liyojuf
         /MJbT0yHV962xjqBf/5wm1JYlvSBGu9L71cK4doCRySPCzy+rJdm32ecMoHylvBcS5JI
         jNc1sXYU7UrYuvAlUDYhalOVgjZ3Jnoc1wVNBuP+yL7oXxo0j43iU+r0ZCfbKZwEOBQO
         ofauod9Vs8slgczUY30G8I9TF2l+z0fmWlmXmsyH8r26ZI8MdoIw6yQcnNB29v6Rd2pC
         YO8+0tKWzEpGg4QLO+QaF8QAdOze4O6f3/R/xlUaHOT3nS8RZ1AbxQGWLtjkJzZtejRn
         LD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yuVRF9qkSzb1K/ULzAFo8OAgna4w5IsHqAaDsAjc0cQ=;
        b=Uo2awxd5szmkFNTQeKsE/TrrTBCDb/tIiTdBPYUTerX2VibJn0/DM9e/Ms2xLXphTZ
         Pyl4WqQdxPCztvM65LsH/rxOpLKv+fVavctHudDoOMHGG8CTerkFTaO1UtvpfalsAegc
         tmZy/lYwf3igl3Yqu1kGoLJytzj/DPN0G+6wdXxKfJ30k+ftbRrSt73uarjw4TfeFOiN
         qRSL64WBI6v/ESxymDEXv+FeWR0cCzj0cmXcQkHEsqTyjWcBk/WjnsMxOsJIQVcoByJs
         HUi2UdvQN2jWsRuZhk4JazIPTvqzYHiiHOc9egVTLhSVgddJWWXoXD4yPn9K7v0te3kR
         yz/Q==
X-Gm-Message-State: ALQs6tCNgIInuB7B6bWO5p2mC2pq97hL9DSzeU78xWa2TRhM27Tp5vzE
        pQ9yjEC+77RuQvhIQmHAAatzop2vzcwZufWMXVQ=
X-Google-Smtp-Source: AB8JxZrMTSFoS+FuhqmEh/VcyJJZbgHPDVmpcebPUO/P3VyspvSKJEv6Mzy+PvKFatkiB1La3sRynJf36WmMc4TxEfo=
X-Received: by 10.55.76.146 with SMTP id z140mr20804120qka.224.1524428239312;
 Sun, 22 Apr 2018 13:17:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Sun, 22 Apr 2018 13:17:18 -0700 (PDT)
In-Reply-To: <CAMe9rOrTzgDmCF+A7nYdGR6BHZBuK5SMnJxeRxBFQW00VmdXvg@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de> <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
 <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com> <CAMe9rOrTzgDmCF+A7nYdGR6BHZBuK5SMnJxeRxBFQW00VmdXvg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 22 Apr 2018 22:17:18 +0200
X-Google-Sender-Auth: B6d4cgFTHaZiRsNw6qgLg5lSQCk
Message-ID: <CAK8P3a2=nfW1YSJoTf_cj5DVSMVfzWYaYqG486FHD3vPw3YZfQ@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Schepler <dschepler@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63691
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

On Sun, Apr 22, 2018 at 2:38 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Fri, Apr 20, 2018 at 7:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>
> Glibc has correct header files for system calls.  I have a very old
> program to check if Linux kernel header files are correct for user
> space:
>
> https://github.com/hjl-tools/linux-header
>
> It needs update to check uapi.

Simply running 'make' on a regular distro shows this output:

--- kernel.x32.out 2018-04-22 22:10:16.053432423 +0200
+++ glibc.x32.out 2018-04-22 22:10:16.073432838 +0200
@@ -10,9 +10,9 @@ size of daddr_t: 4
 size of __ipc_pid_t: 4
 size of struct ipc_perm: 48
 size of mqd_t: 4
-size of struct msqid_ds: 144
+size of struct msqid_ds: 120
 size of struct semid_ds: 104
-size of struct shmid_ds: 136
+size of struct shmid_ds: 112
 size of struct shminfo: 72
 size of struct timeval: 16
 size of struct timespec: 16
@@ -22,8 +22,8 @@ size of struct mq_attr: 64
 size of struct rlimit: 16
 size of struct rusage: 144
 size of struct stat: 144
-size of struct statfs: 64
-size of struct statfs64: 88
+size of struct statfs: 120
+size of struct statfs64: 120
 size of struct timex: 208
 size of struct msginfo: 32
 size of struct msgbuf: 16

This seems plausible, the statfs structure clearly has the same problem
as msqid_ds/shmid_ds based on its usage of '__statfs_word' which is
now defined as '__u32' rather than '__kernel_long_t'.

It should be trivial to override __statfs_word from
arch/x86/include/uapi/asm/statfs.h

I've checked the other uses of __BITS_PER_LONG in the uapi
headers now, and all the others are either not relevant for x32
(either definition is fine) or it has to be __BITS_PER_LONG=32.

        Arnd
