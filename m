Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 18:27:10 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.176]:49535 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024080AbZDXR1B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 18:27:01 +0100
Received: by wa-out-1112.google.com with SMTP id n4so523176wag.0
        for <linux-mips@linux-mips.org>; Fri, 24 Apr 2009 10:26:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=CzUzNAbiSz8mvIU8081NTYIuVGdNMIrz/pjNKe64mG0=;
        b=S402tRPY11RWZunAv6bc+gEn1TsgqZkAOc5HnnwgP3VuIIDOJ4duj2fsNaaq2FiO/C
         rzWdiwuTI7y7B8lxFFNde/3ME9BI01RzQkXpPCumZUX/Xr9xpNpqEYjkD2c9KGMmMyii
         PeE2zm+fBDEdu1WNqB6Wi5RW/yltHUopJgzzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=oNlpK/7EfnpHvzVCf/5kYIDxJvQu7uoZplnFcRoIRTuKbrJGwQTIr449wFH+RPcw1T
         sAivzJMAJj2zyu4bE6+xJwN1v5gyAm6A3iT6WuaFyiWRJQxGppAsQhe6/6fIdPfXet7N
         XuCRRSwDtQZ/sA/LSbfWUhZsdDDtJzOZFNI3I=
Received: by 10.114.79.18 with SMTP id c18mr1452979wab.215.1240594019459;
        Fri, 24 Apr 2009 10:26:59 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id l27sm1989321waf.20.2009.04.24.10.26.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 10:26:58 -0700 (PDT)
Subject: [GIT] kernel function tracing support for linux-mips
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org
Cc:	dslab-programming@dslab.lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sat, 25 Apr 2009 01:26:39 +0800
Message-Id: <1240593999.7456.63.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

hi, all

two different patches have been ported to linux-mips/loongson for kernel
function tracing, they are KFT and ftrace.

both of them can be used to trace kernel functions, but they are based
on different implementations(will be introduced later).

KFT is released as a kernel patch, and maintained by DSLab currently,
the latest versions can be found at ftp://dslab.lzu.edu.cn/pub/kft

ftrace is originally from the real time linux extension(RT_PREEMPT,
rt.wiki.kernel.org), and have been merged to the mainline kernel, but
there is no mips implementation in the official kernel. I have ported it
to mips platform, and trying to push it into the mainline kernel.

  * KFT for linux-mips/loongson git tree:

    git://dev.lemote.com/rt4ls.git linux-2.6.29-stable-loongson-kft

  * ftrace for linux-mips/loongson git tree:

    git://dev.lemote.com/rt4ls.git linux-2.6.29-stable-loongson-ftrace

both of them have been tested on yeeloong2f notebook, works well when
compiled kernel in 32bit or 64bit.  

if you want to use them, try to read the documentations for them:

      Documentation/kft.txt       Documentation/kft_kickstart.txt
      Documentation/ftrace.txt

+ more information about KFT & ftrace: 

"Kernel Function Trace (KFT) is a kernel function tracing system, which
uses the "-finstrument-functions" capability of the gcc compiler to add
instrumentation callouts to every function entry and exit. The KFT
system provides for capturing these callouts and generating a trace of
events, with timing details. KFT is excellent at providing a good timing
overview of kernel procedures, allowing you to see where time is spent
in functions and sub-routines in the kernel."
(http://elinux.org/Kernel_Function_Trace)

"ftrace is originally came from work on realtime Linux, it is a
self-contained solution, requiring no user-space tools or support, that
is useful for tracking down problems—not only in the kernel, but in its
interactions with user space as well. 

The name ftrace comes from "function tracer", which was its original
purpose, but it can do more than that. Various additional tracers have
been added to look at things like context switches, how long interrupts
are disabled, how long it takes for high-priority tasks to run after
they have been woken up, and so on. Its genesis in the realtime tree is
evident in the tracers so far available, but ftrace also includes a
plugin framework that allows new tracers to be added easily."
(http://lwn.net/Articles/322666/)


BTW: a "kgcov for linux-mips/loongson" git tree can also be found here, 
     
      git://dev.lemote.com/rt4ls.git linux-2.6.29-stable-loongson-kgcov

    kgcov can be used to kernel profiling, which is originally from
         http://ltp.sourceforge.net/coverage/gcov.php

Best Regards,
Wu Zhangjin

-- 
Wu Zhangjin
DSLab, Lanzhou University, China
www.lemote.com, Jiangsu Province, China
