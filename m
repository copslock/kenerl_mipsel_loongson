Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2015 16:24:00 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:35181 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011358AbbG3OX6CzoHc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jul 2015 16:23:58 +0200
Received: by lahh5 with SMTP id h5so26098576lah.2
        for <linux-mips@linux-mips.org>; Thu, 30 Jul 2015 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LL6TTA2th9y4HKdvu0rfNuPOP8Jsuf7zJbcrD98qF4g=;
        b=TeUHhJHvusqFOeK+hVzv/NFgdJxlRnM2wE2Sfn62xDhJRpd56h5JBPg3GvjhR8fqez
         E5slKFDPbBDC+epcogMXR78hcRelrK6w0HNcrarB1QYOUa78gusqG2PtW9FVLXg8HGYQ
         GbKhrx3Z2IRjeokQdwoQiQDnx6x/UUv9VHYY2PjBmY1OPr+TnD0pdvoHSIXrHkA5/mj0
         3F9PXHJKmVF/GoH1l/dSiwjY25wJ2bRf3kfecB59nUYlQWZCHlSO9/wqGzFerR6f4OPL
         dspMfZXFBT7kw+/qX4Pg+Xrh61r6agU0/7AMwMabMIl7ktZki4+iu7vlxkpP9aMuKyIP
         zbuQ==
MIME-Version: 1.0
X-Received: by 10.112.145.169 with SMTP id sv9mr31402080lbb.73.1438266232461;
 Thu, 30 Jul 2015 07:23:52 -0700 (PDT)
Received: by 10.112.161.233 with HTTP; Thu, 30 Jul 2015 07:23:52 -0700 (PDT)
In-Reply-To: <55BA2B91.5070107@windriver.com>
References: <20150729161912.GF18685@windriver.com>
        <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>
        <55BA2B91.5070107@windriver.com>
Date:   Thu, 30 Jul 2015 16:23:52 +0200
Message-ID: <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
From:   David Herrmann <dh.herrmann@gmail.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     David Herrmann <dh.herrmann@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>, linux-mips@linux-mips.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <dh.herrmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dh.herrmann@gmail.com
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

Hi

On Thu, Jul 30, 2015 at 3:50 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On 2015-07-29 12:31 PM, David Herrmann wrote:
>> Hi
>>
>> On Wed, Jul 29, 2015 at 6:19 PM, Paul Gortmaker
>> <paul.gortmaker@windriver.com> wrote:
>>> Hi David,
>>>
>>> Does it make sense to build this sample when cross compiling?
>>>
>>> The reason I ask is that it has been breaking the linux-next build of
>>> allmodconfig for a while now, with:
>>>
>>>   HOSTCC  samples/kdbus/kdbus-workers
>>> samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
>>> samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
>>>   p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
>>>                   ^
>>> samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
>>> scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
>>> make[2]: *** [samples/kdbus/kdbus-workers] Error 1
>>
>> mips does have this syscall, so I assume the problem is out-of-date
>> kernel headers. You can fix this by running:
>>
>>     $ make headers_install
>
> No, let me try and clarify. Please note the emphasis on cross compiling
> and automated build coverage, i.e. there is no place for manual steps.

User-space samples in ./samples/ are compiled with HOSTCC, which is
the compiler for the _local_ machine. Regardless of cross-compiling
the same local compiler is used. So I cannot understand why this is
even remotely related to cross compiling. Please elaborate.
Please note that this is HOSTCC running, so it does *NOT* require the
toolchain for your cross-compiled architecture.

Also, please tell me why your system has "linux/memfd.h" available,
but __NR_memfd_create is undefined?

Anyway, patch is attached. Can you verify it works?
David

diff --git a/samples/kdbus/Makefile b/samples/kdbus/Makefile
index 137f842..dbd9de8 100644
--- a/samples/kdbus/Makefile
+++ b/samples/kdbus/Makefile
@@ -1,9 +1,13 @@
 # kbuild trick to avoid linker error. Can be omitted if a module is built.
 obj- := dummy.o

+ifndef CROSS_COMPILE
+
 hostprogs-$(CONFIG_SAMPLE_KDBUS) += kdbus-workers

 always := $(hostprogs-y)

 HOSTCFLAGS_kdbus-workers.o += -I$(objtree)/usr/include
 HOSTLOADLIBES_kdbus-workers := -lrt
+
+endif
