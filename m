Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Dec 2016 02:37:04 +0100 (CET)
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36434 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992196AbcLaBg5XENcH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Dec 2016 02:36:57 +0100
Received: by mail-ua0-f178.google.com with SMTP id 88so259203119uaq.3
        for <linux-mips@linux-mips.org>; Fri, 30 Dec 2016 17:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nQN2sAznDhR3o/sNczZVSRotGfXbQY61Nz9XWvVQwL4=;
        b=Cpk0+O3UGUh3byFzBZWZtONQmcjjMTFbqwaP3pqlFX361BMq+n4FedSIdnh7SQ1Gka
         3+KUR9SWFK2llT7KPJSKTTv5I5epDlHmY91py1rPRbNZMskbKVFHtM9xTQ5BnLd+/tYT
         WKe4DC8Yfrtf/tIItx8OQHm5liUMGc4SU8iBAVmu/irPw4+1IkX+ehFQ94dwX08fx41j
         +oedeYIYX+xOKQ3ZcOc33KC5Z0qd5aJPoMfwaa9PSrukVzj11glqjh6mtrLTFO7Q+Hhm
         qZ1CPCZgrX5/YAY7FkliJjC29XSF0teg/RIPWeGWx2vH6thxL0MhCbTC50D5GNHapuaN
         B//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nQN2sAznDhR3o/sNczZVSRotGfXbQY61Nz9XWvVQwL4=;
        b=gWUphJpbCUxNlRKmfkf192tXKUl0a9uWAQtpKuMsf9Quxa4A8oMXt2TDR1YCrhcq2q
         VLyVcTrowChUk/TqhdgNb4NVsUUSnGsw71lePng4GQPLzOvNItOqzACyzmnsTr4OiTHO
         TJq0LHfHCTbaabGDTyfb4AWL4GNS0s04/illC8lgcnK9jG0LUgqvS8rHKftwhOuO2Yik
         2bUiEQDzuKseBCM4DkPgyfrEK4dIIqjOYUJehVlK4ZmwUWTZybdylcmJ+pImSiG7YA2U
         9E1G9o7rSvEB0d4e99rRAv9hxM4itzft92H/hCrVMRiSddby1s4CB8dIWrd8yIl+Zhpf
         D7og==
X-Gm-Message-State: AIkVDXJwVY5zqLNEUZku5Wr7nhCzrejS9S9jgeHab0i//6eYsXyIwnZWb45wSd0PHDRYEE3aIoLUqz07w9IsRqCU
X-Received: by 10.176.6.74 with SMTP id f68mr37935241uaf.37.1483148211546;
 Fri, 30 Dec 2016 17:36:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.139.66 with HTTP; Fri, 30 Dec 2016 17:36:31 -0800 (PST)
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com> <20161230155634.8692-2-dsafonov@virtuozzo.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 30 Dec 2016 17:36:31 -0800
Message-ID: <CALCETrVsjDqWpF2E4gZKMx4EEFHLYSR+AOX_3BcV3FNPe13pkg@mail.gmail.com>
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
To:     Dmitry Safonov <dsafonov@virtuozzo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Fri, Dec 30, 2016 at 7:56 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),

I like this.

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
