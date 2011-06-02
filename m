Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2011 01:01:06 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:61021 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491867Ab1FBXA5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Jun 2011 01:00:57 +0200
Received: by iwn36 with SMTP id 36so1419903iwn.36
        for <multiple recipients>; Thu, 02 Jun 2011 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y5gbTW+l14Gg1niFywqtkqgOMdZ+1xv/DA3SWnbzdW0=;
        b=TgfrNYMK8HN9+bYm0V4aOFSrFPJW1Tjq0oHM4spW0qgzN4tNp9ckOndvWPK5IVv/pl
         LHNsOYt+63qPNZyULniU2yqqYp6kCw+bi74e+mlHBKbNdvYiFJkyjjJl5H+HwI1WBnbS
         O8U+0VbJrdOpAA00igosCCADUPtm23y8uCBPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VcBtJ9WPduOZDHMyAqr32JjmAv1OlOTIgklMh3h9hJlbkooPxhNm9qDR5muEl3q+OM
         FegCtQ6BWGDmfFQTfgEGmuOpiQvrUXp0+frScdMhiQaTfFHy16nahjS7WeKBLDLrOpdE
         J6//BQ2AjL5PlvbxxpWBnJPFxdcPfr+eFs7N4=
MIME-Version: 1.0
Received: by 10.42.132.134 with SMTP id d6mr2412238ict.38.1307055651438; Thu,
 02 Jun 2011 16:00:51 -0700 (PDT)
Received: by 10.42.226.67 with HTTP; Thu, 2 Jun 2011 16:00:51 -0700 (PDT)
In-Reply-To: <201106030032.17398.richard@nod.at>
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>
        <201106030032.17398.richard@nod.at>
Date:   Thu, 2 Jun 2011 16:00:51 -0700
X-Google-Sender-Auth: QgFvRW1CC8YA0kXbdN8JonScQAY
Message-ID: <BANLkTik9kCs_06=7HKo44cWqpS0zB9fr+A@mail.gmail.com>
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
From:   Tony Luck <tony.luck@intel.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, viro@zeniv.linux.org.uk, oleg@redhat.com,
        akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
X-archive-position: 30200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2192

> But there seems to be another problem.
> Why is pt_regs of type void *?
>
> gcc complains:
> In file included from include/linux/fsnotify.h:15:0,
>                 from include/linux/security.h:26,
>                 from init/main.c:32:
> include/linux/audit.h: In function ‘audit_syscall_exit’:
> include/linux/audit.h:440:17: warning: dereferencing ‘void *’ pointer
> include/linux/audit.h:440:3: error: invalid use of void expression
> include/linux/audit.h:441:21: warning: dereferencing ‘void *’ pointer
> include/linux/audit.h:441:21: error: void value not ignored as it ought to be

Perhaps same issue on ia64 - but symptoms are different:

  CC      crypto/cipher.o
In file included from include/linux/fsnotify.h:15,
                 from include/linux/security.h:26,
                 from init/do_mounts.c:8:
include/linux/audit.h: In function ‘audit_syscall_exit’:
include/linux/audit.h:440: warning: dereferencing ‘void *’ pointer
include/linux/audit.h:440: error: request for member ‘r10’ in
something not a structure or union
include/linux/audit.h:441: error: request for member ‘r10’ in
something not a structure or union
include/linux/audit.h:441: error: request for member ‘r8’ in something
not a structure or union
include/linux/audit.h:441: error: request for member ‘r8’ in something
not a structure or union
include/linux/audit.h:441: error: expected ‘;’ before ‘}’ token
include/linux/audit.h:441: error: void value not ignored as it ought to be

-Tony
