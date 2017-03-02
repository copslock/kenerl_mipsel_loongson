Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 14:15:12 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:34564
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdCBNPFV0siU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 14:15:05 +0100
Received: by mail-oi0-x242.google.com with SMTP id m124so5312953oig.1;
        Thu, 02 Mar 2017 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LGfk9URCUF7TqADcIIjBxyusxwSZ+LkpE/A906F6xpQ=;
        b=ROO0SiMmHHG1uQaQg1H/NzmERr796ok6eDblG8NgPOLkgkD+MOyDEab9tBPv2vo8v7
         hS421i9A1KbIiM57uLE4qieZFymH9iXMqSonHJke9DDhCk39L4VpJ2bWtwgYWffWoTW+
         k0j7CK2UBW1j8XuPWMH4V1jzOdf7p34knlMO+o1WHjteIHcddWuU2vYILRIKPHjbiyX7
         1YqIV4Mf6EPN79m4/9X/NaPqq4ExzsJMM3/PpN9YtlnKxq71N1wGldYimB7avDjJq7Cg
         c7JN4qFpPAh8ytVgXI2LBK257sSF0lVRsHcIDyu7/gzZdw30deybBj+dW4t7FpYRKMyg
         ttGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LGfk9URCUF7TqADcIIjBxyusxwSZ+LkpE/A906F6xpQ=;
        b=i291xbOgBPoDIMwgT47WGe1O4IUklXMpLb3uqDKIjfNQWuBWWPZPWA35sWAatmE6wk
         j20dgpFLgphPGFna9YQWpKCtZxkyUiUkcF2ma8c/ImRXe6+vEceZQs4ZWIzshke5L5RZ
         BWfU9BLcJR6cIxVQmjhwDkt2dpMd96NYXERgSp2xubgjJzoZmomRLBJ9SOzFYxlVkY+t
         94lvj3J3F+KY65TgWiN9PGRxjReJxJxqbTgxjrfiW+Meu5ikTnyNzFLs3+/MlJoLcWJZ
         yPR+SZrg+UVcREnYqfAXu5jG8YaHL19kuWeJJA3h5+qAKmQnk893wNb17g/47WMQm61q
         6CxA==
X-Gm-Message-State: AMke39k750zS0KVPEGQvo3Q4cjAKqZ8yMHtzKy8fdHZRl0KzNcsJULTMwNctAdhLwHAYs5iEoiSYe4aiQsJknA==
X-Received: by 10.202.199.68 with SMTP id x65mr6791447oif.113.1488460499687;
 Thu, 02 Mar 2017 05:14:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Thu, 2 Mar 2017 05:14:59 -0800 (PST)
In-Reply-To: <20170302002253.GC27132@altlinux.org>
References: <CAK8P3a3Ptm68i43BT5+kWptDw1koPwexpuFwH3-1naj_xi+arQ@mail.gmail.com>
 <20170302002253.GC27132@altlinux.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Mar 2017 14:14:59 +0100
X-Google-Sender-Auth: 9AJt-q_goxW2p1xxqQU5Ji0Qc0s
Message-ID: <CAK8P3a1_QLguZ6XEGC9TdGUmF0R3bKaU2EiJ6m+Gf=KpYnmqqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] uapi: fix asm/shmbuf.h userspace compilation errors
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56999
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

On Thu, Mar 2, 2017 at 1:22 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Include <asm/ipcbuf.h> to fix asm/shmbuf.h userspace compilation errors
> like this:
>
> /usr/include/asm-generic/shmbuf.h:26:20: error: field 'shm_perm' has incomplete type
>   struct ipc64_perm shm_perm; /* operation perms */
> /usr/include/asm-generic/shmbuf.h:28:2: error: unknown type name '__kernel_time_t'
>   __kernel_time_t  shm_atime; /* last attach time */
> /usr/include/asm-generic/shmbuf.h:32:2: error: unknown type name '__kernel_time_t'
>   __kernel_time_t  shm_dtime; /* last detach time */
> /usr/include/asm-generic/shmbuf.h:36:2: error: unknown type name '__kernel_time_t'
>   __kernel_time_t  shm_ctime; /* last change time */
> /usr/include/asm-generic/shmbuf.h:40:2: error: unknown type name '__kernel_pid_t'
>   __kernel_pid_t  shm_cpid; /* pid of creator */
> /usr/include/asm-generic/shmbuf.h:41:2: error: unknown type name '__kernel_pid_t'
>   __kernel_pid_t  shm_lpid; /* pid of last operator */
> /usr/include/asm-generic/shmbuf.h:42:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shm_nattch; /* no. of current attaches */
> /usr/include/asm-generic/shmbuf.h:43:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused4;
> /usr/include/asm-generic/shmbuf.h:44:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused5;
> /usr/include/asm-generic/shmbuf.h:48:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmmax;
> /usr/include/asm-generic/shmbuf.h:49:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmmin;
> /usr/include/asm-generic/shmbuf.h:50:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmmni;
> /usr/include/asm-generic/shmbuf.h:51:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmseg;
> /usr/include/asm-generic/shmbuf.h:52:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmall;
> /usr/include/asm-generic/shmbuf.h:53:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused1;
> /usr/include/asm-generic/shmbuf.h:54:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused2;
> /usr/include/asm-generic/shmbuf.h:55:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused3;
> /usr/include/asm-generic/shmbuf.h:56:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused4;
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
